#!/usr/bin/env ruby

# This script is used to fetch the rubocop default files at
# "https://github.com/bbatsov/rubocop/tree/master/config", and merge them into a
# `.rubocop.yml` file

require 'net/https'
require 'yaml'
require 'FileUtils'

def write_file(filename, contents)
  open(filename, 'wb') { |file| file.write contents }
end

def fetch_file(host, *path_components)
  file_path = File.join path_components
  print "=== Fetching #{file_path} from github... "
  file_name = path_components.last

  Net::HTTP.start(host, use_ssl: true) do |https|
    response = https.get file_path
    write_file file_name, response.body
  end

  puts "Done."
end

def parse_yaml_file(filename)
  YAML.load_file filename
end

def write_yaml_file(filename, data)
  print "=== Writing file #{filename}..."
  write_file filename, YAML.dump(data)
  puts "Done!"
end

rubocop_content_host = 'raw.githubusercontent.com'
rubocop_config_base_path = '/bbatsov/rubocop'
rubocop_config_ref = ENV.fetch 'RUBOCOP_REF', 'master'
rubocop_config_dir = 'config'
rubocop_config_files = %w(default.yml enabled.yml disabled.yml)

rubocop_config_files.each do |filename|
  fetch_file rubocop_content_host,
             rubocop_config_base_path,
             rubocop_config_ref,
             rubocop_config_dir,
             filename
end

# Parse the default file:
ruleset = parse_yaml_file 'default.yml'

# Merge the enabled/disabled rulesets into the main ruleset:
if (inherit_list = ruleset.delete 'inherit_from').any?
  inherit_list.each do |inherited_ruleset_file|
    puts "inheriting from #{inherited_ruleset_file}..."
    parse_yaml_file(inherited_ruleset_file).each do |rule_name, rule_config|
      ruleset[rule_name] ||= {}
      ruleset[rule_name].merge! rule_config
    end
  end
end

# Write the merged ruleset:
write_yaml_file '.rubocop.yml', ruleset

# Remove fetched files:
rubocop_config_files.each { |filename| FileUtils.rm filename }

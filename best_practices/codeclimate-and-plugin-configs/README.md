# Codeclimate + Plugins Configuration


## Example Codeclimate configuration files

### Rails projects:

The [`rails.codeclimate.yml`](https://github.com/IcaliaLabs/guides/blob/master/best_practices/codeclimate-and-plugin-configs/rails.codeclimate.yml)
configuration file is our example codeclimate config file for rails projects.
This configuration enables codeclimate CLI to fetch our rules for "Rubocop" and
"Reek" checks, among others, using the `codeclimate prepare` command.

Be sure to copy this file as `.codeclimate.yml` inside the root of your rails
application:

```
# Go to the root of your rails project:
cd my-rails-app

# Fetch the example rails codeclimate config:
wget -O .codeclimate.yml "https://raw.githubusercontent.com/IcaliaLabs/guides/master/best_practices/codeclimate-and-plugin-configs/rails.codeclimate.yml"

# Fetch the plugin configuration files:
codeclimate prepare

# Analyze your code:
codeclimate analyze
```

### Python projects:

The [`python.codeclimate.yml`](https://github.com/IcaliaLabs/guides/blob/master/best_practices/codeclimate-and-plugin-configs/python.codeclimate.yml)
configuration file is our example codeclimate config file for typical python
projects. This configuration enables codeclimate CLI to fetch our rules for
"PEP8" and "Sonar Python" plugins, among others, using the `codeclimate prepare`
command.

Be sure to copy this file as `.codeclimate.yml` inside the root of your rails
application:

```
# Go to the root of your python project:
cd my-python-app

# Fetch the example rails codeclimate config:
wget -O .codeclimate.yml "https://raw.githubusercontent.com/IcaliaLabs/guides/master/best_practices/codeclimate-and-plugin-configs/python.codeclimate.yml"

# Fetch the plugin configuration files:
codeclimate prepare

# Analyze your code:
codeclimate analyze
```

### Javascript + Node projects:

The [`javascript.codeclimate.yml`](https://github.com/IcaliaLabs/guides/blob/master/best_practices/codeclimate-and-plugin-configs/python.codeclimate.yml)
configuration file is our example codeclimate config file for javascript
projects, either frontend or backend, which typically uses node.js for
compilation and/or runtime. This configuration enables codeclimate CLI to fetch
our rules for "ESLint", "Node Security Project (nsp)" and "SCSS Lint" plugins,
using the `codeclimate prepare` command.

Be sure to copy this file as `.codeclimate.yml` inside the root of your node
application:

```
# Go to the root of your python project:
cd my-node-app

# Fetch the example rails codeclimate config:
wget -O .codeclimate.yml "https://raw.githubusercontent.com/IcaliaLabs/guides/master/best_practices/codeclimate-and-plugin-configs/javascript.codeclimate.yml"

# Fetch the plugin configuration files:
codeclimate prepare

# Analyze your code:
codeclimate analyze
```

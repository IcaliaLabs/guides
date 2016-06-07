# Auto resolve db/schema.rb merge conflicts

It is very common to have a conflict on db/schema.rb when we are merging another branch to ours, and this conflict always get resolved taking the latter version of this file.

This is annoying and could be automated using `~/.gitattributes` which allows you to specify certain attributes for a given path.

First we will add a new merge strategy to `~/.gitconfig`

```
[merge "railsschema"]
        name = newer Rails schema version
        driver = "ruby -e '\n\
                system %(git), %(merge-file), %(--marker-size=%L), %(%A), %(%O), %(%B)\n\
                b = File.read(%(%A))\n\
                b.sub!(/^<+ .*\\nActiveRecord::Schema\\.define.:version => (\\d+). do\\n=+\\nActiveRecord::Schema\\.define.:version => (\\d+). do\\n>+ .*/) do\n\
                  %(ActiveRecord::Schema.define(:version => #{[$1, $2].max}) do)\n\
                end\n\
                File.open(%(%A), %(w)) {|f| f.write(b)}\n\
                exit 1 if b.include?(%(<)*%L)'"
```

Then we will tell git to use this merge strategy whenever it has a conflict with `db/schema.rb`. Just open up `~/.gitattributes` and add this line:  `db/schema.rb merge=railsschema`

This trick is taken from [http://nuclearsquid.com/writings/git-tricks-tips-workflows/](http://nuclearsquid.com/writings/git-tricks-tips-workflows/)
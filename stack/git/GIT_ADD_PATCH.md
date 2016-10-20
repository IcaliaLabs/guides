# Git add --patch

Normally when we're ready to commit all of our changes, we'll run `git add .` or `git add --all`, or we could also use `git add <file_name>` if we want a more focused form to target individual files. Both of this approaches can quickly become coarse if we have distinct changes within a single line.  

`git add` command has a flag that can help us with that: `--patch`. By using this flag we tell Git that we would like to review each group of changed lines individually, and choose whether or not to stage them. The full command is run as:

```bash
$ git add --patch
```

Then Git will split the changes in each file into small portions and present them one at a time, prompting how to proceed (just like `git rebase --interactive` does). The primary operations are to stage the piece of code, skip it, split it into several pieces, below is a collection of some of the more common operations:

- `h` - Display help for this command
- `n` - Skip this portion
- `s` - Split this portion 	

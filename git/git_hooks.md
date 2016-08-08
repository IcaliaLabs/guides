# Git Hooks

Git hooks are scripts that Git executes before or after events such as: commit, push, receive, etc. This let you automate tasks in your own unique environment. There is no need to spend time on tasks that git could do on it's own.

## Pre-commits
* [Prevent debugging lines from sneaking to your commit](###prevent-debugging-lines-from-sneaking-to-your-commit)
* [Let `rubocop` autofix your indentation before you commit](###let-rubocop-fix-your-indentation)

### Prevent `debugging` lines from sneaking to your commit

This hook will alert you if there is any binding.pry in your ruby files or any debugger or console.log in your javascript files before you try to commit. 

It is quite easy to set up a hook. Pre-commit hooks live in `.git/hooks/pre-commit`

You just have to copy the following code inside `.git/hooks/pre-commit`, make it executable `chmod +x .git/hooks/pre-commit` and you are good to go!

```
FILES_PATTERN='\.(rb|js|coffee|css)(\..+)?$'
FORBIDDEN='binding.pry\|debugger\|console.log'

git diff --cached --name-only | \
    grep -E $FILES_PATTERN | \
    GREP_COLOR='4;5;37;41' xargs grep --color --with-filename -n $FORBIDDEN && \
    echo 'COMMIT REJECTED' && \
    echo "Watch out! Looks like you are trying to commit something you shouldn't.  Please fix it, or run 'git commit --no-verify' to skip this check" && \

    exit 1

exit 0
```

This will prevent debugging lines from sneaking to your commit.

### Let `rubocop` fix indentation for you
You commit, push to github... and then realize your code was not properly indented :(

This could have been prevented if you'd have let rubocop fix the indentation for you before you commit.

Just add the following two lines at the beginning of `.git/hooks/pre-commit`

```
git diff --cached --name-only | if  grep '\.rb'
then
   rubocop -a `git diff --cached --name-only | grep '\.rb'` && \
   git add `git diff --cached --name-only | grep '\.rb'`
fi
```

This will tell rubocop to autofix the indentation on your staged files before every commit. 

And don't forget to make `.git/hooks/pre-commit` executable with `chmod +x .git/hooks/pre-commit`!
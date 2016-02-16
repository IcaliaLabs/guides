# Git aliases

Git is a tool that we use constantly throughout the day, so it is a good idea to make our experience with git as smooth as possible. Thankfully, Git is very amenable to our needs and it can be customized to make our interactions more intuitive. Git aliases can help us with this since they can serve a few different purposes like the use of shorter commands that are easir to memoryze and collect options and flags into one command. 

##  Create & display an alias 

All you have to do is: 

```bash
$ git config --global alias.car "commit --amend --no-edit"

```

The former creates an alias called `car` that can be used in place of the more verbose command. 


We can always display the meaning of an alias with `help`:

```bash
$ git help car
`git car' is aliased to `commit --amend --no-edit'
```

# List of aliases

Here is a list of aliases that you can use in your day-to-day workflow

* `git config --global alias.unstage "reset"`

This maps the operation of reseting a file to a more familiar and intuitive name. Now you can use `git unstage README.md`

* `git config --global alias.uncommit "reset --soft HEAD^"`

Has the effect of undoing the last commit, tacking us back to just before we made it.

* `git config --global alias.sla "log --oneline --decorate --graph --all"`

Thils will give you a nicely organized and concised view of your local and remote branches 

* `git config --global alias.glog "log -E -i --grep /pattern/"`

This search commit logs insensitively for all commits with the given pattern, it also uses extended regular expressions, so `git glog dashboard(s)` will search dashboard or dashboards throughout the commit history

If you want to see the current aliases in your computer you can run the following command:

```bash
$ git config --get-regexp alias
alias.sla=log --oneline --decorate --graph --all
alias.glog=log -E -i --grep
alias.uncommit=reset --soft HEAD^
alias.unstage=reset
alias.car=commit --amend --no-edit
```

Although it'd be a better idea to add an alias for that :) 


```bash
$ git config --global alias.aliases "git config --get-regexp alias"
$ git aliases
alias.sla=log --oneline --decorate --graph --all
alias.glog=log -E -i --grep
alias.uncommit=reset --soft HEAD^
alias.unstage=reset
alias.car=commit --amend --no-edit
```



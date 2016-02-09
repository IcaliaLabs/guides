# Stashing

There are times when you want to work on a project but you've made changes which are not ready to be committed, there's a powerful tool to help us with that: git stash.

Basically this command saves modified files and puts them in a stack where they can be later accessed if needed.

To stash modified files and staged changes:

```console
$ git stash
```

This will clean your working directory, you can confirm that by using:

```console
$ git status
```

To see a list of stored stashes use:

```console
$ git stash list
```

Then if you want to apply the most recent stash run:

```console
$ git stash apply
```

You can also call to a specific stash by using:

```console
$ git stash apply stash@{1}
```

You can also delete a stash from your stash list by using:

```console
$ git stash drop stash@{0}
``` 

To stash and drop current changes use:

```console
$ git stash pop
```

It's also possible to create a branch from a stash by using:

```console
$ git stash branch {NameOfBranch}
```



# Git Templates

Meaningful commit messages are important when we try to look back on our git history and git templates are very useful to help us achieve this.

A template can assist you with a structure that guides you to split your commit message into different parts, each one with it's own meaning.

To set up a template you just have to set `commit.template` in `~/.gitconfig`

```
[commit]
  template = ~/.gitmessage
```

Then create `~/.gitmessage`

```
#Title

#Why is this change necessary?


#How does this address the issue?


#What sides efects does this change have?


#References
```

This is only an example of what you template could be, but you can write the one that meets your needs.
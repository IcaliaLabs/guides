***
[[TOC]]
***

## 1.1. Setup
You can make a clean installation of git using the installation instructions from the [official website](https://git-scm.com/downloads).

You will need a [GitHub Account](https://github.com/join?source=header-home) and configure your  [ssh key with github](https://medium.com/codebase/configuring-ssh-key-for-github-9d2416a377ae) to collaborate with the IcaliaLabs git repositories.


## 1.2. Basics
If you never use git version control before you can  continue with this guide you should check this awesome resources to learn git:

- [Git - the simple guide](http://rogerdudler.github.io/git-guide/)
- [Learn Git Version Control using Interactive Browser-Based Scenarios](https://www.katacoda.com/courses/git)

## 1.3. Icalia code flow
We at Icalia Labs never work directly on the master branch to build software, we use a git workflow to keep things isolated.

Lets take a look to this workflow: 

![](/stack/git/img/step_1.png)

### 1.3.1. Create a Branch from Master

You’ll develop your new feature, knowing that when finished, your feature will be ready to be deployed, instead of waiting in “inventory”.

- Keep small code features.
- **You must keep track of changes coming from “master” while your code is still in development.**
***
![](/stack/git/img/step_2.png)

### 1.3.2. Create Code, add Commits, Push to Github
Automated CI tools (Drone, Foresight) will start giving you feedback throughout the process.

***

![](/stack/git/img/step_3.png)

### 1.3.3. Create a Pull Request at Github
Lets your team know:

 - Your feature is ready
 - You’re stuck and need help
 - You’re sharing code and/or general ideas
 - The rest of the team may need to adapt to changes in code
***

![](/stack/git/img/step_4.png)
### 1.3.4. Discuss your code and get it reviewed at github
- Lets you receive feedback from your team mates:
	- Questions about how to use your new code feature, or how your code will impact their current work.
	- Quick tips from your team mates.
- Lets you receive feedback from Icalia Labs’ Tech Leads:
	- Learn how to improve your code.
	- Learn development platform / framework features you might be missing.
- Lets you add changes to the code upon received feedback:
	- Improve the quality of the code.
	- Add missing code features (i.e. tests, etc).

***

![](/stack/git/img/step_5.png)

### 1.3.5. Deploy your feature branch to staging/demo servers
An opportunity to detect deployment issues with your code without causing trouble on live / production servers. 

***

![](/stack/git/img/step_6.png)

### 1.3.6. Your feature gets merged back to master at Github
  By this point, your code has been reviewed, accepted, and validated on staging/demo servers, and ready to be merged back to master.

Your feature will automatically be deployed if continuous deployment is enabled, and your work is no longer in “Code Inventory”.

- Changes merged to master via “*Squash & Merge”*.
***
## 1.4. Git Features you must master
 ### Add
 Selects code changes to add to an upcoming commit.
 
 You can practice this command in the [katacoda scenario 1](https://www.katacoda.com/courses/git/1).
 
### 1.4.1. Commit
 Commit related code changes.

 Recomendations:
 
- Commit messages reflect intent.
- Write [meaningful commit messages](https://about.futurelearn.com/blog/telling-stories-with-your-git-history/), don't just go simple and short.
- Start your commit message with a present verb such as `Adds`, `Removes`, `Updates`.
- Never track files specific to your local development machine.Some examples of this files are `.env`, `.DS_Store`, `.log`, etc.

You can practice this command in  the [katacoda scenario 1](https://www.katacoda.com/courses/git/1) and [katacoda scenario 2](https://www.katacoda.com/courses/git/2).

### Git branchs
Branches are created based on another branch, generally master. The command git branch <new branch name> <starting branch> takes an existing branch and creates a separate branch to work in. At this point both branches are identical.

You can practice this command in the [katacoda scenario 6](https://www.katacoda.com/courses/git/6)
### 1.4.2. Push
Used to publish new local commits on a remote server.

You can practice this command in the [katacoda scenario 3](https://www.katacoda.com/courses/git/3)

### 1.4.3. Pull
 Used to bring changes from our branch at origin.

Recomendations:
- Change into the branch you want to update.
- Don’t use “git pull” to merge code from other branches.
- If you’re forced to specify the branch name with pull your’e doing it wrong - ask for help.

### 1.4.4. Merge and  how to manage conflicts 
 Use it to bring up changes from other branches(most commonly, from “master”).

#### 1.4.4.1. Merge Conflicts
Recomendations:
 - Solving code conflicts is not a code reviewer’s responsibility!
 - However, you might ask for help when you get stuck.
 - VS Code is a great tool to resolve merge conflicts [VS Code git guide](https://code.visualstudio.com/Docs/editor/versioncontrol#_merge-conflicts).

 You can practice this command in the [katacoda scenario 5](https://www.katacoda.com/courses/git/5).
### 1.4.5. Stash
 Saves uncommitted changes into a “drawer”, from which you can retrieve those later.

- Used when you can’t pull from upstream because of conflicting uncommitted changes.
- Also used when you can’t switch between branches because of conflicting uncommitted changes.

You can learn git stash with the [Git stash guide](GIT_STASH.md).
### 1.4.6. Cherry-Pick
Picks one or several commits from another branch into yours(useful when back-porting fixes from another branch).

You can practice this command in the [katacoda scenario 8](https://www.katacoda.com/courses/git/10).
## Resources
Here are some git advanced guides that can help you in your everyday workflow

- [Git stash](GIT_STASH.md)
- [Git add --patch](GIT_ADD_PATCH.md)
- [Git aliases](GIT_ALIASES.md)
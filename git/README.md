# Git

This is the guide to rule every project with version control.

# Table of Contents
* [Set up your laptop](##set-up-your-laptop)
* [Git Workflow](#git-workflow)
* [Multiple environments](##multiple-environments)
* [Git hooks and tricks to boost productivity](##git-hooks-and-tricks-to-boost-productivity)
* [Git tips](##git-tips)
* [Mantaining a project? Follow in case of deployment explosion](##mantaining-a-project?-follow-in-case-of-deployment-explosion)

## Set up your laptop

You can easily set up your laptop by running [kaishi](https://github.com/IcaliaLabs/kaishi), a shell script to convert any Mac OS X or Linux computer into a real development machine. This will install the latest version of git.

# Git Workflow

## Branch structure

We at [Icalia Labs](http://icalialabs.com) never work directly on the `master` branch to build software, we like to keep things isolated. And although we make a branch per feature, hotfix and release, we consider an extra branch called `dev` where we mantain all of the source code HEAD, so `dev` always reflect the most recent changes to be released.

Once the `dev` branch is stable enough we then merge with `master` and tagged with a version number. This way we keep things sane, and the CI server can easily push to production or rollback to the last stable version on production.

An image is presented below to demostrate this:

![http://nvie.com/posts/a-successful-git-branching-model](http://nvie.com/img/main-branches@2x.png)

##Supporting Branches

Next to the main branches `master` and `dev`, we use two supporting branches to ease tracking of features and to assist in quickly fixing live production problems. These branches have a limited life time, since they will be removed once they are merged to `master` and/or `dev`.

The different types of branches we may use are:

Feature branches
Hotfix branches

Each of these two branches have a specific purpose and are bound to strict rules as to which branches may be their originating branch and which branches must be their merge targets.

## Feature branches

Now that we understand how the `dev/master` flow works, it is time to get to know how to start a new feature.

First create a local feature branch off `dev`:

```console
$ git pull origin dev
$ git checkout -b feature/<feature-name>
```

In the branch creation it is important that you prefix the name of it with `feature/<feature-name>`

Once you are done with the feature it is time to merge it with `dev`, but first we need to fetch for changes

```console
$ git fetch origin
```

If there are changes in the upstream you should rebase them and squash them to make them more atomic:

```console
$ git rebase -i origin/dev
```

Resolve every conflict and make sure the tests are passing:

```console
$ git add --all
```

Once the `dev` branch is up to date, it is time to merge your feature branch.

```console
$ git checkout dev
$ git merge  feature/<feature-name>
```

Share and delete your branch:

```console
$ git push origin feature/<feature-name>
$ git branch --delete feature/<feature-name>
```

**If you would like a code review from another developer, you can ask him/her kindly, and place a pull request assigned to him/her**

## Hotfix Branches

Hotfix branches always prepare master for a new unplanned production release. They arise from the necessity of act inmediately upon an undesired state of a live production version (something went wrong on production).

When a critical bug in production must be resolved inmediately, a `hotfix` branch may be branched off from `master`. The purpose of this is that work of team members(on `dev`) can continue, while another person is preparing a quick fix on production.

First create a local hotfix branch off `master`:

```console
$ git checkout -b hotfix/<hotfix-name> master
```

Then, fix the bug and commit the fix in one or more separate commits.

```console
$ git commit -m "Fix big nasty bug"
```

When finished, the bugfix needs to be merged back into `master`, but also needs to be merged back into `develop`

```console
$ git checkout master
$ git merge hotfix/<hotfix-name>
$ git checkout dev
$ git merge hotfix/<hotfix-name>
```
Finally share and delete your branch:

```console
$ git push origin hotfix/<hotfix-name>
$ git branch --delete hotfix/<hotfix-name>
```
## Releases Branches

When `dev` includes all features that reflects a desired state for a new release we may branch off a release branch to support the new preoduction release.

Release branches allow for minor bug fixes and preparing the version number. It may be deployed to staging so the product owner can test the new release and 

Let's create a local release branch off `dev`:

```console
$ git checkout -b release/<release-name> dev
```

Then let's fix some minor bugs

```console
$ git commit -m "Solves minor nasty bug"
```

When a release branch is ready to be deployed to production a corresponding tag of the version should be created and pushed to remote to be able to easily get a copy of the code as it was in that release in case needed for the future. This will allow us to act quickly if we need to rollback the last deployment.

Let's merge into `master`

```console 
$ git checkout master
$ git merge release/<release-name>
$ git tag -a 1.0.0 -m "App versión 1.0.0 Released in appstore"
```

Then we should tag the new release, where the number followed by the annotation flag `-a 1.0.0` should be written following the [semantic versioning rules](http://semver.org)

```console 
$ git tag -a 1.0.0 -m "App versión 1.0.0 Released in appstore"
```

Then you can push your tag to remote by using:

```console
$ git push origin [tagname]
```

Or if you have many tags you can push them by using:

```console
$ git push origin —-tags
```

Then let's merge into `dev` so we can get the bug fixes

```console 
$ git checkout master
$ git merge release/<release-name>
```

Finally, we may delete the release branch.

```console 
$ git branch --delete release/<release-name>
```

After creating the tag you can view the created tag by using:

```console
$ git tag -l
```

## Multiple environments

At Icalia Labs we like to be sure that everything will work whenever we deploy a feature or set of features to production. Automated testing alone is not enough. All features should be validated by the product owner (commonly the client or the project lead).

In order to review changes in a real environment we deploy to two different heroku apps: **staging** and **production**.

The **staging** environment is basically a mirror app of the production app, and this is were the features get approved by the `product owner` together with the project lead.

### Setting up the staging environment
In order to create these two environments, there is an excellent [article](https://devcenter.heroku.com/articles/multiple-environments) on heroku on how to achieve this.

### Syncing staging and production databases
To keep things seamless, whenever a deployment to staging is going to be performed, we sync the production database to the staging app. Check out the [guide](https://github.com/IcaliaLabs/icalia_guides/blob/master/git/DATABASE_SYNC.md) for more information.


## .gitignore samples

* [Rails](https://github.com/IcaliaLabs/icalia_guides/blob/master/git/gitignore_rails)
* [iOS](https://github.com/IcaliaLabs/icalia_guides/blob/master/git/gitignore_ios)

## Git hooks and tricks to boost productivity

Here are some git advanced guides that can help you in your everyday workflow

- [Pre commit hooks](https://github.com/IcaliaLabs/icalia_guides/blob/master/git/git_hooks.md)
- [Git stash](https://github.com/IcaliaLabs/icalia_guides/blob/master/git/git_stash.md)
- [Git add --patch](https://github.com/IcaliaLabs/icalia_guides/blob/master/git/git_add_patch.md)
- [Git aliases](https://github.com/IcaliaLabs/icalia_guides/blob/master/git/git_aliases.md)
- [Auto resolve db/schema.rb merge conflicts](https://github.com/IcaliaLabs/icalia_guides/blob/master/git/db_schema_merge.md)

## Git tips

* Write [meaningful commit messages](https://about.futurelearn.com/blog/telling-stories-with-your-git-history/), don't just go simple and short. You can use [git templates to assist your messages](https://github.com/IcaliaLabs/icalia_guides/blob/master/git/git_templates.md)!
* Start your commit message with a present verb such as `Adds`, `Removes`, `Updates`
* Squash multiple commits.
* Avoid merge commits. Use a rebase workflow.
* Delete local and remote branches after merge has been done.
* Every new feature should be build on a separate branch.
* Never track files specific to your local development machine.

## Mantaining a project? Follow in case of deployment explosion

You deployed to production, sat back and relax... then you get a call telling you that everything exploded.

Now what you might want to do is undo the changes the last release made but keep history so you are able to fix whatever went wrong.

This is what you could do:

```console
$ git checkout master
$ git revert HEAD
```

`git revert` will create a new commit that reverts everything the last commit did, which is the one that went to production.
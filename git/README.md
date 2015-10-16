# Git

This is the guide to rule every project with version control.

* Write [meaningful commit messages](https://about.futurelearn.com/blog/telling-stories-with-your-git-history/), don't just go simple and short.
* Start your commit message with a present verb such as `Adds`, `Removes`, `Updates`
* Squash multiple commits.
* Avoid merge commits. Use a rebase workflow.
* Delete local and remote branches after merge has been done.
* Every new feature should be build on a separate branch.
* Never track files specific to your local development machine.

## Set up your laptop

You can easily set up your laptop by running [kaishi](https://github.com/IcaliaLabs/kaishi), a shell script to convert any Mac OS X or Linux computer into a real development machine. This will install the latest version of git.

## Branch structure

We at [Icalia Labs](http://icalialabs.com) never work directly on the `master` branch to build software, we like to keep things isolated. And although we make a branch per feature, but we consider an extra branch called `dev` where we mantain all of the source code HEAD, so `dev` always reflect the most recent changes to be released.

Once the `dev` branch is stable enough we then merge with `master` and tagged with a version number. This way we keep things sane, and the CI server can easily push to production or rollback to the last stable version on production.

An image is presented below to demostrate this:

![http://nvie.com/posts/a-successful-git-branching-model](http://nvie.com/img/main-branches@2x.png)


## Write a new feature

Now that we understand how the `dev/master` flow works, it is time to get to know how to start a new feature.

First create a local feature branch off `dev`:

```console
$ git pull origin dev
$ git checkout -b <feature-branch>
```

In the branch creation it is important that you prefix the name of it with your initials.

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
$ git merge <feature-branch>
```

Share and delete your branch:

```console
$ git push origin <feature-branch>
$ git branch --delete <feature-branch>
```

**If you would like a code review from another developer, you can ask him/her kindly, and place a pull request assigned to him/her**


## Multiple environments

At Icalia Labs we like to be sure that everything will work whenever we deploy a feature or set of features to production. Automated testing alone is not enough. All features should be validated by the product owner (commonly the client or the project lead).

In order to review changes in a real environment we deploy to two different heroku apps: **staging** and **production**.

The **staging** environment is basically a mirror app of the production app, and this is were the features get approved by the `product owner` together with the project lead.

### Setting up the staging environment
In order to create these two environments, there is an excellent [article](https://devcenter.heroku.com/articles/multiple-environments) on heroku on how to achieve this.

### Syncing staging and production databases
To keep things seamless, whenever a deployment to staging is going to be performed, we sync the production database to the staging app. Check out the [guide](https://github.com/IcaliaLabs/icalia_guides/blob/master/git/DATABASE_SYNC.md) for more information.


## Releases

Every time a new version is going to be deployed to production, a corresponding tag of the version should be created and pushed to remote to be able to easily get a copy of the code as it was in that release in case needed for the future.

To create a tag use the command:

````
 git tag -a 1.0.0 -m "App versión 1.0.0 Released in appstore"
````

Where the number followed by the annotation flag `-a 1.0.0` should be written following the [semantic versioning rules](http://semver.org)

After creating the tag you can view the created tag by using:

````
 git tag -l
`````

Then you can push your tag to remote by using:

````
 git push origin [tagname]
````

Or if you have many tags you can push them by using:

````
 git push origin —-tags
`````

## .gitignore samples

* [Rails](https://github.com/IcaliaLabs/icalia_guides/blob/master/git/gitignore_rails)
* [iOS](https://github.com/IcaliaLabs/icalia_guides/blob/master/git/gitignore_ios)

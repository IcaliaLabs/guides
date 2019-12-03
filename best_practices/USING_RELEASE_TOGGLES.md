# Using Release Toggles to plan, work and release our work

This guide will definitely change once we start implementing "canary" releases (i.e. Beta users, etc)

For this guide, we will consider "Release Toggles" as a specific kind of "Feature Flags". The name "Toggle" and "Flag" are synonymous.

## Project preparation

The application project should already have some library to operate feature flags:

- For rails apps, we'll be using the [`flipper`](https://github.com/jnunemaker/flipper) gem - with activerecord backing, when possible.
- For ember apps, we'll be using the [`ember-feature-flags`](https://github.com/kategengler/ember-feature-flags) npm package - However we should figure out how to store those flags in the server. Maybe [`flipper`](https://github.com/jnunemaker/flipper) has a REST API to show the flags?

The same considerations should apply for other frontend tech (ReactJS, Vue, etc):
- Somehow find out how to read flags from the backend service, which should be using [`flipper`](https://github.com/jnunemaker/flipper).

In the future, we might move to a provider such as [LaunchDarkly](https://launchdarkly.com).

## Step 1: Planning

### Break out big stories into smaller stories

Each story on Pivotal should have a Task List. 

For stories over 3 points, several of the tasks in the list may actually be smaller stories, so be sure to analyze these stories during the weekly planning session!

When a story needs a release toggle, consider a final "Cleanup" chore to remove the "release toggle" from the app code - see step 4.

** PLEASE DO NOT START WORKING ON STORIES WORTH MORE THAN 3 POINTS **

### Find out which parts are dependant, and which are not

- Dependant parts should be placed behind a feature flag.
- Work that has no dependencies, and doesn't create dependencies may be released without a feature flag.

- Make sure the feature flag your'e using does not already exist.

## Step 2: Registering the feature flag

- Clear naming!!!

You should register the feature flag in the application. The name should be concise. Do not re-use names!

## Step 3: Implement each of your changes

This is where you will do most of the work.

For the changes required to be hidden beneath a feature flag, include tests for the new functionality - feature flags in [`flipper`](https://github.com/jnunemaker/flipper) can be mocked on tests!

Be sure to deliver your work (i.e. being it accepted via a PR to `master`) before continuing on the next part of the feature.

## Step 4: Cleanup PR

** The feature is not considered to be ready for release until a cleanup PR is accepted and ready to be merged! **

Once all the parts of the feature are deployed, and the feature is to be considered to be "ready for release"... we will need to have a "Cleanup PR" to release our feature to production.

In this "cleanup PR", all the "gates" associated to the particular "release toggle" should be removed.

There is still some internal discussion on whether we should wait to merge this PR to `master` after the toggle is switched on @ production... merging and deploying this "cleanup" PR will in fact make the feature visible.

The most important idea about the "Cleanup PR" is that there is no leftover code that [might create problems later on](https://medium.com/dataseries/the-rise-and-fall-of-knight-capital-buy-high-sell-low-rinse-and-repeat-ae17fae780f6)

## Step 5: Release or Archive the feature

### The good outcome: Releasing the feature

Once the **"Cleanup PR"** is ready, we might proceed to release the feature by switching the "toggle" ON at production servers.

Right after the feature is "released" on production, we'll need to have the "Cleanup PR" merged to master - this causing a deploy is actually good, as the "old" code will no longer be deployed.

### The alternate outcome: "Archiving" the feature

Sometimes features should not be released at all. Maybe because the project is "pivoting away" from the feature, maybe the feature has to be extensively re-worked for release, etc. On either case, we need to "take out" the code that's already deployed in this scheme, so the **"Cleanup PR"** should instead include the removal of the new code.

The "Cleanup PR" commit over `master` will work as a reference - actually the parent commit of it - of the code prior to the cleanup. So, the "Cleanup PR" commit can be "reverted" with Git in case we need the new code back.

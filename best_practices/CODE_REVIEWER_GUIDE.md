# Code Reviewer Guide

## Pre-flight Checklist

Whenever any of these fails, stop the review and ask the developer to fix the issue.

- The PR base must be `master` or any `epic` branch. *We shouldn't even spend time on PR's not based on any of these two.*

  - If it is an `epic` branch, there must be a pending PR on it. *We might end up accepting changes without visibility to the team if the epic's PR is missing*

- The size of the changes in the PR must not exceed:
  - ~ 200 added/changed LOCs for "fix" PR's
  - ~ 400 added/changed LOC's for "feature" PR's

- The PR should only include 1 feature to add, or 1 bug to fix. *Check the description to see which feature the PR is adding to base*

- The description should match the changes you see in the diff.

- Code is up-to-date with the base branch? *We might end up reviewing & accepting code that is not yet finished (because it's still subject to change*

- Tests & other build processes are all passing?

## Code Review Guidelines

We will start automating some of these, either via HoundCI or Foresight

* When there is a coding style issue, have a link to the guideline detail. For example:
   "[Avoid outer braces and parentheses for DSL methods](https://github.com/bbatsov/ruby-style-guide#no-dsl-decorating)"

* When there is a coding bad practice, be sure to refer exactly which lines are bad, and include an example of the "good" way.

* When there is room for improving, indicate what the current code is lacking of, what the problems are, and give ideas on how to improve.

* When requesting changes, enumerate the main TODOs in the final comment.

## Accept PR checklist

When a PR is finally ready to be accepted:

* Include a cool, encouraging final comment. Maybe also further reading/actions.
* **Use squash & merge**
* Delete the branch **ONLY** if the accepted PR screen on Github allows you to do it. Never nuke it directly from Git (i.e. using `git push --delete origin the-branch`)

## What if as a reviewer...?

##### I don't see all the PR checklist checked

​	The pull request is not a candidate to be reviewed, just let the person know what is missing so he/she make sure the minimum requirements are met.

##### I'm asked to merge a hot fix

​	By all means do it, but make sure you create an issue describing what was the problem, so collaborator can fix it later. Make sure to communicate how important the resolution of the issue is so we don't forget.

##### I start to accumulate a lot of pull requests

 	1. Ask another reviewer for help, maybe someone else is more available.
	2. Maybe what you need to do is some pair programming tackling some of the pending pull requests with the team members.

##### The PR I'm reviewing has [WIP] or a work-in-progress label

​	You can ask the team member if the PR is actually ready for review, and if it is remove the label or text chunk to avoid confusions.

##### A PR depends on other

 	1. Make sure the PR is pointing to the depending branch and not `master`
	2. Make sure you go in order when reviewing this type of PR, so you don't review the same code

##### Multiple pull requests depend on each other

1. Make sure you follow the correct order of reviewing, so review the first PR and so on
2. Don't review a PR if the dependant is not already merged


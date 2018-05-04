# Code Reviewer Guide

## Pre-flight Checklist

Whenever any of these fails, stop the review and ask the developer to fix the issue.

- The PR base must be `master` or any `epic` branch. *We shouldn't even spend time on PR's not based on any of these two.*

  - If it is an `epic` branch, there must be a pending PR on it. *We might end up accepting changes without visibility to the team if the epic's PR is missing*

- The size of the changes in the PR must not exceed:

  - ~ 200 added/changed LOCs for "fix" PR's

  - ~ 400 added/changed LOC's for "feature" PR's

- The PR should only include 1 feature to add, or 1 bug to fix. *Check the description to see which feature the PR is adding**

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

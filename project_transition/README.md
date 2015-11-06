#Transfering ownership of one project

Sometimes, just sometimes, it happens that we have to transfer ownership to the client. This guide is intended to help you do it effectively!

### Table of contents
- [About the company culture](#about-the-company-culture)
- [About communication](#about-communication)
- [The process](#the-process)
  - [Finishing Features](#finishing-features)
  - [Clear pending bugfixes](#clear-pending-bugfixes)
  - [All tests passing](#all-specs-passing)
  - [README](#check-readme)
  - [Schedule a revision meeting](#schedule-a-revision-meeting)
  - [Prepare a brief report of technical debt](#prepare-a-brief-report-of-technical-debt)
  - [Transfer the git repository to the client](#transfer-the-git-repository-to-the-client)

####About company culture

Here in IcaliaLabs, our culture is very important, and that means our clients are very important, as well as our work, process, the team, etc. We are always looking to maintain long-term relationships with clients, but sometimes, for different reasons this relationship ends, and we need to transfer the project's ownership to the client. If this happens, we always keep in mind these rules:
- Mutual Respect and Trust: Our main goal is mutual happiness. We love what we do and the impact it has. And, of course, we also value the client's happiness, so we do not want dissatisfaction from either side under any circumstance.
- Mutual Benefit: According to the first point, we think every project's experience is invaluable and because of this deserves respect. We want the project to be successful, whether being developed by us or by anyone else, and that's why we are committed to helping clients with all the arrangements to transfer the ownership properly. _We believe the transition should not be painful_

####About communication

In order to maintain everything organized, we encourage you to streamline communication. Basecamp, for example, works well for us. It is a simple communication channel where all information is in one place, rather than spread out in emails and chat messages. Chat applications must be used cautiously because chat messages can be lost in the the chat history. Any communication over chat should be copied into Basecamp or Pivotal Tracker at the time of receipt to ensure that all issues are tracked consistently.

Here in Mexico we have a saying: _**Cuentas claras, amistades largas**_ (English: **"settled accounts keep old friends"**), meaning we need to log every decision taken and document every agreement. This needs to be documented in electronic format, not just by verbal agreement-- the reason: It will help you to avoid misunderstandings and keep the relationship healthy.

Do not forget to add every meeting's minutes to the communication channel.

####The process

The process we intend to explain should take no more than 1 week and is based upon our prior experiences.

#####Finishing features

The team member or members who are in charge of business development and communication with the client should let the development and design teams know as soon as possible when a contract is ending. This will help guarantee that there will be enough time to finish the last features or redefine the last sprints before the closing.

#####Clear pending bugfixes

Critical bugs should be given highest priority, unless the client determines that something else is more important.

#####All specs passing

If the project has TDD/BDD specs, all the specs should pass.

######Check README

Ensure that the project's README.md file in the git repository has all the instructions needed to setup the project in local environment.

#####Prepare a brief report of technical debt

Write a brief report of at least these points:
- Project's code health.
- Main features pending to development.
- Be sure to include all the project assets.
- Technical debt: Be sure to explain what areas are able to improve, code to refactor, etc.
- Describe what services are we using, take Sendgrid for instance, we use them to transactional email, and especify the client they need to open an account
  - Do the project use heroku?
  - Are we using Sendgrid/Mandrill?
  - Newrelic?
  - Amazon Web Services (S3, glacier, EC2)?
  - Codeship?
  - Apple IDS?
  - Google Services?


#####Schedule a revision meeting

Schedule a meeting with the client (and their technical team if they have) in order to review the last features and fixes.

#####Insurance

TODO: What time do we have for insurance

#####Transfer the git repository & every service to the client

Here in Icalia we use github as our main repository of code, please follow the [Github guides to transfer ownership](https://help.github.com/articles/transferring-a-repository/).

#####Revoke privileges for our organization

If the application resides in Heroku, ideally, it should be owned by the client from the get-go. If for whatever reason, Icalia is listed as the project owner, it should be transferred to the client.

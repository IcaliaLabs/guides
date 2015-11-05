#Transfering ownership of one project

Sometimes, just sometimes, it happens that we have to transfer ownership to the client, this is an intended guide to do it.

### Table of contents
- [About the company culture](#about-the-company-culture)
- [About communication](#about-communication)
- [The process](#the-process)
  - [Finishing Features](#finishing-features)
  - [Clear pending bugfixes](#clear-pending-bugfixes)
  - [Schedule a revision meeting](#schedule-a-revision-meeting)
  - [Prepare a brief report of technical debt](#prepare-a-brief-report-of-technical-debt)
  - [Transfer the git repository to the client](#transfer-the-git-repository-to-the-client)

####About company culture

Here in IcaliaLabs, our culture is very important, and that means our clients are very important, as well as our work, process, the team, etc. We are always looking for long term relationships but sometimes, for different reasons this relationship ends and we need to transfer the project's ownership to the client, but always keeping in mind this rules:
- Mutual respect and trust: Our main goal is mutual happiness, we love what we do and the impact of it, we also love the client's happiness, so, we do not want unsatisfaction from both sides under any circumstance.
- Mutual Benefit: According to the first point, we think every project's experience is invaluable and because of this deserves respect, we want the project's success, that's why we have the willing to help clients with all the arrangements to transfer the ownership properly. _We believe the transition should not be painful_

####About communication

In order to maintain everything organized and concentrated, we encourage you to maintain as few open communication channels as possible, Basecamp for example worked well for us, it is a simple communication channel where every information, is concentrated, avoid chat applications to take decisions, that is because chat messages will be lost in time.

Here in mexico have a saying: _**Cuentas claras, amistades largas**_ (English: **"settled accounts keep old friends"**) this saying means we need to log every taken decision, every agreement documented and cleared and not just by word, the reason: It will help you to avoid misunderstandings and keep the relationship healthy.

Do not forget to add every meeting minute to the comunication channel.

####The process

The process we intend to explain should take no more than 1 week and it is created from previous experiences.

#####Finishing features

The team member or members who are in charge of business development and communication with the client should inform the decision with development and design teams with enough time to finish the last features or redefine the current or latest sprints before the closing.

#####Clear pending bugfixes

Critical bugs deserve more attention unless the client's decision and what they want to achieve.

#####Prepare a brief report of technical debt

Write a brief report of at least this five points:

- Project's code health.
- Main features pending to development.
- If the project's have TDD/BDD specs, all the specs should pass.
- Be sure to include all the project assets.
- Be sure your to include a README.md file into the git repository with all the instructions to setup the project in local environment.
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

If the application reside in heroku
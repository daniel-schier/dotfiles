# Contributing guide

First off, thank you for considering contributing to this project. This
document assumes that you read it to understand how to contribute, raise issues,
and submit pull requests.

Therefore, it will address these topics, but will not cover every detail.

## Code of Conduct

Before contributing, please read our [Code of Conduct](CODE_OF_CONDUCT.md).

## Raising issues

In general, we welcome every issue, since it helps us improve the project and
understand what users desire. Therefore, please don't hesitate to let us know
what bugs you, where you see improvements, or any other feedback you have.

### Issue categories

We differentiate between `bug`, `enhancement`, and `question`/`support` issues.

- `bug`: A bug is a problem or unexpected behavior that occurs in the project.
- `enhancement`: An enhancement is a feature or improvement that would make the
  project better.
- `question`/`support`: A question or support issue is a request for help or
  information from the project maintainers.

To open each of them, we provide issue templates, that can be chosen in the
project's issue tracker.

### Following up

After submitting an issue, we will follow up with you to understand the problem
and provide a solution. We do expect you to be responsive and provide any
additional information needed. We may ask for more details or clarification if
needed. Please don't fire-and-forget issues - we will close them if no response
is received.

## Submitting pull requests

Pull requests are welcome and encouraged. Yet, each pull request should be
addressed in an issue, first. Therefore, we recommend the following workflow:

1. Open an issue describing the problem or enhancement you want to address.
2. Once the issue is open, fork the repository and create a branch for your
   changes.
3. Once you have made your changes, rebase your branch against the latest
   `trunk`/`main` branch.
4. Finally, submit a pull request against the issue's branch.

Your commit messages should follow the
[Conventional Commits](https://www.conventionalcommits.org/) specification.

## Code review

Sometimes, you might see multiple open pull requests. These might be open for
various reasons. One of them is, that there is no tracking issue, or nobody
was able to do a proper code review. In such cases, we encourage you to support
with a review, even if you are not the author of the code.

A code review should tackle the following aspects:

- Does the code solve the problem described in the issue?
- Is the code readable and maintainable?
- Does the code follow the project's coding standards?
- Does the code have tests?
- Does the code have documentation?
- Is it correctly categorized, according to Semantic Versioning?

Not all of these aspects need to be addressed in a single pull request/code
review. And if you don't feel comfortable addressing them, please skip them
deliberately.

## Usage of AI

Please note that AI tools, such as Claude, are used to generate code snippets
and documentation or tests. While we strive to provide high-quality code, these
tools help to code faster and more efficiently.

In case you use AI tools on your own, please make sure that you consume our
conventions as described in the project's AI-files (e.g. `CLAUDE.md`).

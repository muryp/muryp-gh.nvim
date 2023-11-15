# Contributing Guidelines

Thank you for your interest in contributing to our project! We greatly appreciate any contributions that can help improve our project.

## Reporting Bugs
1. Before opening a new issue, first search for existing issues to avoid duplications.
2. Provide detailed reports to make things easier for maintainers.
3. use video if you cant explain detailed report

## Guideline for commit msg
1. Make a clear commit message using the format:
   * `feat: [feature name]`: for adding new features
   * `fix: [bug name]`: for fixing bugs
   * `docs: [description of changes made to documentation]`: for changes made to documentation
   * `chore: [description hole change]` : for administratif work
   * `revert: description what refert]` : undoing or rolling back previous changes that have been committed to a repository or source code
2. example if you want delete something :
  * `refactor: Remove [feature_name]`
  * `chore: Delete [feature_name]`
  * `revert: Remove [feature_name]`
  * `docs: Update docs after delete [feature_name]`

## Sending Pull Requests
If you would like to contribute to our project by sending fixes or adding new features, please follow these steps:
1. Fork our repository to your GitHub account.
2. Create a new branch for the feature or fix you are working on.
3. Make changes in that branch.
4. Push your branch to your GitHub repository.
5. Create a Pull Request from your branch to the master branch in our repository.
6. Wait for the reviewer to review your Pull Request.

## Fixing existing issues
1. You can help by fixing existing issues
2. Don't work on issues assigned to others (to avoid duplicate efforts)
3. Before starting to work on an issue, please first add a comment and ask to get assigned to that issue. This way everyone will know you're working on that and it avoids duplicate efforts.
4. Commit messages must start with: fix: #1 [description] which 1 is the number of issue, so the issue will close automatically and it gets added to changelog file on a release.
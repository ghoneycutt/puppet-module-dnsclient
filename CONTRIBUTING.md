# Contribution Guidelines

## Tests

  - Pull requests that add any additional functionality should have tests which cover the new feature to ensure it does what is expected
  - Pull requests with failing tests will not be merged

## Features

  - Keep feature based PRs as small as possible, with as few commits as necessary. These are easier to review and will be merged quicker

## Bug Fixes

  - Make sure you reference the issue you're closing with `Fixes #<issue number>`

## Commits

  - Squash/rebase any commits where possible to reduce the noise in the PR

## Git commits

Reference the issue number, in the format `(GH-###)`.

```
(GH-123) Add support for XYZ
```

# Release process

1. Update version in `metadata.json`
1. Run Rake task to release module: `bundle exec rake release`
1. Update GitHub pages: `bundle exec rake strings:gh_pages:update`
1. Tag the release, such as `git tag -a 'v4.0.0' -m 'v4.0.0'`
1. Push release to upstream master: `git push upstream master`
1. Push tags upstream master: `git push upstream --tags`

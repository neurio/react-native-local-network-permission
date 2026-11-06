# Publishing Guide

This package is published to **npmjs.com** as `@generac/react-native-local-network-permission`.

## Publishing a New Version

Releases are automatic. Each merge to `main` can publish a new version, and the title of the pull
request sets the type of release. Use this format:

```text
<type>[(<scope>)][!]: <subject with a ticket key>
```

For example: `fix: handle denied permission (IA-7000)`. Put the ticket key anywhere in the subject.
Add `!` after the type for a breaking change. The `Validate PR title` check fails when the title does
not match. It blocks the merge only when a ruleset on `main` makes it a required check.
The GitHub Revert button gives the title `Revert "fix: ..."`, which has no type. Change it to
`revert: fix: ... (IA-1234)` before you merge.

| Type | Release |
|---|---|
| `feat` | minor |
| `fix`, `perf`, `revert` | patch |
| any type with `!` | major |
| `docs`, `chore`, `refactor`, `build`, `ci`, `test`, `style` | none |

When you squash and merge, the release workflow (`.github/workflows/release.yml`) runs
`yarn release:check`. It then bumps the version in `package.json`, adds an entry to `CHANGELOG.md`,
creates the tag and the GitHub Release, and publishes the package to npmjs.com. Do not change
the version or `CHANGELOG.md` by hand.

This repository has no dev builds. Only a merge to `main` publishes a package.

## Trusted Publishing

The release workflow publishes with npm trusted publishing (OIDC). No npm token is needed.

The trusted publisher on npmjs.com is bound to this repository and to the workflow file
`.github/workflows/release.yml`. If you rename or move that file, publishing fails. To change the
file name, first update the trusted publisher settings of the package on npmjs.com.

## Consuming This Package

Run `yarn add @generac/react-native-local-network-permission`. You do not need an `.npmrc` file.

### Scope collision with GitHub Packages

Some apps send the `@generac` scope to GitHub Packages in their `.npmrc`, for example
installer-app. This package is not on GitHub Packages, so with that `.npmrc`, `yarn add` and
`yarn upgrade` fail with `E404`. installer-app documents a work-around in
[docs/development.md](https://github.com/neurio/installer-app/blob/main/docs/development.md#work-around-for-mix-of-public-and-private-generac-scoped-npm-packages).

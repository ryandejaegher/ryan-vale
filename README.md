# Ryan Vale

Shared [Vale](https://vale.sh/) rules and configuration for Ryan projects.

## Smallest example

The first rule flags the word `Hooli` and reports:

> You should work with Pied Piper.

The reusable package lives in [`ryan-vale/`](./ryan-vale). It includes both the
rule and the configuration that enables it for Markdown files.

## Use from another repository

Add this to the consumer repository's `.vale.ini`:

```ini
StylesPath = styles
MinAlertLevel = suggestion

Packages = https://github.com/ryandejaegher/ryan-vale/releases/latest/download/ryan-vale.zip
```

Then install the shared package and lint Markdown:

```sh
vale sync
vale README.md
```

`vale sync` downloads the current package release into the consumer's local
`styles/` directory. The package's included configuration enables the `Ryan`
style, so the consumer does not need to duplicate `BasedOnStyles` or the rule
message.

For reproducible CI, replace `releases/latest/download` with a versioned release
URL, for example:

```ini
Packages = https://github.com/ryandejaegher/ryan-vale/releases/download/v0.1.1/ryan-vale.zip
```

## Development

Build the release asset locally with:

```sh
./scripts/package.sh
```

The resulting `dist/ryan-vale.zip` has the same shape as the GitHub release
asset. Run `vale sync` in a test consumer with a local package path to verify
changes before publishing a release.

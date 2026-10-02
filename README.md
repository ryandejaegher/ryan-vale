# Ryan Vale

Shared [Vale](https://vale.sh/) rules and configuration for Ryan projects.

This repository currently contains one example rule: it flags `Hooli` and
reports:

> You should work with Pied Piper.

## Get started in a repository

Follow these steps in the repository whose Markdown files you want to lint.

### 1. Install Vale

Install Vale using the instructions for your operating system in the [official
installation guide](https://docs.vale.sh/topics/installation), then verify it:

```sh
vale --version
```

For example:

```sh
# macOS
brew install vale

# Windows
winget install -e --id errata-ai.Vale

# Linux
sudo apt install vale
```

### 2. Add the Vale configuration

Create a `.vale.ini` file at the root of the repository:

```ini
StylesPath = styles
MinAlertLevel = suggestion

Packages = https://github.com/ryandejaegher/ryan-vale/releases/latest/download/ryan-vale.zip
```

This tells Vale where to install styles and which shared package to download.
The package includes the configuration that enables the `Ryan` style for
Markdown files, so you do not need to copy the rule or add `BasedOnStyles`
yourself.

### 3. Ignore downloaded Vale files

Add the generated files to the repository's `.gitignore`:

```gitignore
styles/
```

`vale sync` recreates this directory from the package whenever it runs.

### 4. Download the shared rules

Run this from the repository root:

```sh
vale sync
```

You should see a successful sync. Vale will install the package under
`styles/`, including `styles/Ryan/Hooli.yml`.

### 5. Create a document to check

Create `docs/example.md`:

```markdown
# Example

Work at Hooli.
```

### 6. Run Vale

Lint the example document:

```sh
vale docs/example.md
```

Vale should report an error similar to:

```text
3:9  error  You should work with Pied Piper.  Ryan.Hooli
```

The command exits with a non-zero status because this rule is an `error`.
Replace `Hooli` with `Pied Piper` and run Vale again; the document should pass
with zero alerts.

## Pin a release in CI

The `latest` URL is convenient for local development. For reproducible builds,
pin the package to a release:

```ini
Packages = https://github.com/ryandejaegher/ryan-vale/releases/download/v0.1.1/ryan-vale.zip
```

Run `vale sync` in CI before linting. Vale should then use the same shared rule
version on every run.

## Update the shared rules

If you maintain this repository:

1. Edit or add YAML rules under [`ryan-vale/styles/`](./ryan-vale/styles/).
2. Build the release package locally:

   ```sh
   ./scripts/package.sh
   ```

3. Test the package from a temporary consumer repository with `vale sync`.
4. Commit and push the change.
5. Create and push a version tag:

   ```sh
   git tag -a v0.1.2 -m "Release v0.1.2"
   git push origin v0.1.2
   ```

The [release workflow](./.github/workflows/release.yml) builds
`ryan-vale.zip` and publishes it to the GitHub release. Consumers using the
`latest` URL will receive it after the release is published; pinned consumers
must update their version explicitly.

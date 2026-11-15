# dotfiles

My personal configuration files for macOS, managed with
[GNU Stow](https://www.gnu.org/software/stow/).

## Packages

Each package directory mirrors `$HOME`. Stow links its files into the home
directory.

| Package    | Installs                                                     |
|------------|--------------------------------------------------------------|
| `agents`   | `~/.agents/`: instructions, agents, skills, and templates |
| `ghostty`  | `~/.config/ghostty/config`                                  |
| `git`      | `~/.gitconfig`, `~/.gitconfig-cozybadger`, `~/.gitmessage` |
| `mise`     | `~/.config/mise/config.toml`                                |
| `peek`     | `~/.config/peek/config.toml`                                 |
| `peep`     | `~/.config/peep/peep.toml`                                  |
| `ssh`      | `~/.ssh/config`                                             |
| `starship` | `~/.config/starship.toml`                                   |
| `zed`      | `~/.config/zed/settings.json`                               |
| `zsh`      | `~/.zshrc`, `~/.zprofile`                                   |

## Bootstrap

Install mise and Stow with [Homebrew](https://brew.sh):

```bash
brew install mise stow
```

Clone the repository and install the packages:

```bash
git clone git@github.com:daniel-schier/dotfiles.git \
  ~/Projects/github.com/daniel-schier/dotfiles
cd ~/Projects/github.com/daniel-schier/dotfiles
mise trust
mise run setup
mise run stow
```

Stow reports conflicts with existing files rather than overwriting them.
Resolve those conflicts before retrying.

Install the applications used by the packages separately. The shell
configuration uses Homebrew on Apple Silicon and starts without optional tools
such as Starship and `peep`.

Mise pins repository check tools and runs tasks. The `mise` package provides
your global Node.js and npm environment.

## Node.js and npm

After stowing the `mise` package, install its tools and open a new terminal:

```bash
mise install
```

The global config selects the current Node.js LTS line, including npm and npx.
Projects can override this default in their mise configuration, `.nvmrc`, or
`.node-version`. Zsh activates mise instead of fnm.

Corepack and Defuddle are separate mise-managed npm tools, so they stay
available when switching Node.js versions. To add another global CLI, use
`mise use -g npm:<package>`.

Update the installed global Node.js LTS version with:

```bash
mise upgrade node
```

## Stow

`.stowrc` sets `--target=~`.

| Command                   | Description                            |
|---------------------------|----------------------------------------|
| `mise run stow`           | Install every package.                 |
| `mise run restow`         | Re-stow after adding or moving a file. |
| `mise run unstow`         | Remove every symlink.                  |

The tasks use explicit package names and `--no-folding`. Otherwise Stow may
link a whole directory, causing application-created files to land in this
repository. Re-stow after adding files to a package. Update `vars.packages` in
`mise.toml` when adding a package.

## Checks

Run `mise run check` to validate TOML, shell syntax, GitHub Actions workflows,
and working files for secrets. Mise supplies the pinned tools; Zsh comes with
macOS. Shell activation is not required for these tasks.

## Secrets

Do not commit secrets or SSH private keys. Keep private keys as local files in
`~/.ssh/`. The shell sources `~/.config/zsh/secrets.zsh` if it exists; manage
that file outside this repository.

`mise run setup` sets this clone's `core.hooksPath` to `.githooks`. The
pre-commit hook runs Gitleaks against staged changes and blocks the commit if
it detects a secret or the scanner fails. Run setup in each new clone; this
setting does not affect other repositories.

Scan working files or staged changes manually:

```bash
mise run secrets
mise run secrets:staged
```

The Gitleaks workflow uses the same pinned tool to scan Git history on pushes
and pull requests. Local hooks can be bypassed, so the CI check remains
necessary.

## License

This project is licensed under the
[BSD 3-Clause License](https://opensource.org/licenses/BSD-3-Clause).

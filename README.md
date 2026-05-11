# chrc

`chrc` (change runcom) is a small shell function for quickly switching shell runcom snippets such as zshrc-like profiles.

## Install

### One-liner (recommended)

```sh
curl -fsSL https://raw.githubusercontent.com/OrcaxNet/chrc/main/install.sh | sh
```

This downloads the `chrc` script, installs it to `~/.chrc/chrc`, and adds the necessary sourcing line to your shell rc file (`.zshrc` / `.bashrc`).

<details>
<summary>Or clone the repo manually</summary>

```sh
git clone git@github.com:OrcaxNet/chrc.git ~/.chrc/chrc
```

Then add this to `~/.zshrc` or `~/.bashrc`:

```sh
export CHRC_HOME="$HOME/.chrc"
[ -s "$HOME/.chrc/chrc" ] && . "$HOME/.chrc/chrc"
```
</details>

### Uninstall

```sh
curl -fsSL https://raw.githubusercontent.com/OrcaxNet/chrc/main/uninstall.sh | sh
```

Or run the local uninstaller: `~/.chrc/chrc/uninstall.sh`.

In both cases, installing/uninstalling only registers the `chrc` shell function. Profiles are loaded only when you run `chrc <identifier>`, and profile metadata is scanned only when you run `chrc list`. Your existing profiles in `~/.chrc/*.sh` are never touched unless you explicitly confirm removal.

## Usage

```sh
chrc <identifier>        # source ~/.chrc/<identifier>.sh in the current shell
chrc new <identifier>    # create a new template (with optional description)
chrc default <identifier> # load this profile automatically on shell startup
chrc list                # list ID, desc, and file location
chrc cp <source> <dest>  # copy a profile
chrc edit <identifier>   # edit profile with $EDITOR
chrc show <identifier>   # print profile content
chrc path <identifier>   # print profile path
chrc rm <identifier>     # remove profile after confirmation
chrc help                # show help
```

## Profile template

`chrc new work` creates `~/.chrc/work.sh`:

```sh
#desc Describe this runcom profile here.

# Add shell configuration below.
```

`chrc default work` writes `work` to `~/.chrc/.default`. The next shell startup sources `~/.chrc/work.sh` automatically after registering the `chrc` function.

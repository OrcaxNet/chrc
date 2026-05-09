# chrc

`chrc` (change runcom) is a small shell function for quickly switching shell runcom snippets such as zshrc-like profiles.

## Install

Clone this repository under `~/.chrc`:

```sh
git clone git@github.com:OrcaxNet/chrc.git ~/.chrc/chrc
```

Add this to `~/.zshrc` or `~/.bashrc`:

```sh
export CHRC_HOME="$HOME/.chrc"
[ -s "$HOME/.chrc/chrc/chrc" ] && . "$HOME/.chrc/chrc/chrc"
```

This only registers the `chrc` shell function during shell startup. Profiles are loaded only when you run `chrc <identifier>`, and profile metadata is scanned only when you run `chrc list`.

## Usage

```sh
chrc <identifier>        # source ~/.chrc/<identifier>.sh in the current shell
chrc new <identifier>    # create a new template
chrc default <identifier> # load this profile automatically on shell startup
chrc list                # list ID, desc, and file location
chrc cp <identifier>     # copy profile content to clipboard on macOS
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

# --- chrc loader ------------------------------------------------------
export CHRC_HOME="$HOME/.chrc"
[ -s "$HOME/.chrc/chrc/chrc" ] && . "$HOME/.chrc/chrc/chrc"

# --- Runcom -----------------------------------------------------------
# Add shell configuration below.
```

`chrc default work` writes `work` to `~/.chrc/.default`. The next shell startup sources `~/.chrc/work.sh` automatically after registering the `chrc` function.

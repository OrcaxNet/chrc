# chrc

`chrc` (change runcom) is a small shell command for quickly switching shell runcom snippets such as zshrc-like profiles.

## Install

```sh
chmod +x chrc
mkdir -p ~/bin
cp chrc ~/bin/chrc
```

Make sure `~/bin` is in your `PATH`.

For current-shell switching, add this to `~/.zshrc` or `~/.bashrc`:

```sh
eval "$(chrc init)"
```

## Usage

```sh
chrc <identifier>        # switch to ~/.chrc/<identifier>.sh after init setup
chrc new <identifier>    # create a new template
chrc list                # list ID, desc, and file location
chrc cp <identifier>     # copy profile content to clipboard on macOS
chrc edit <identifier>   # edit profile with $EDITOR
chrc show <identifier>   # print profile content
chrc path <identifier>   # print profile path
chrc rm <identifier>     # remove profile after confirmation
chrc help                # show help
```

Without `eval "$(chrc init)"`, use:

```sh
eval "$(chrc <identifier>)"
```

## Profile template

`chrc new work` creates `~/.chrc/work.sh`:

```sh
#ID work
#desc Describe this runcom profile here

# Add shell configuration below.
```

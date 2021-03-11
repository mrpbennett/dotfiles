# @[._.]@ - ~./dotfiles

Before doing anything, make sure you know what are you doing! Settings applied by this repository are very personal, and definitely not suite everyones needs. I suggest to create your own set of dotfiles based on this repo.

Many of the included macOS Terminal customizations are taken from <https://github.com/pawelgrzybek/dotfiles> and <https://github.com/mathiasbynens/dotfiles>.

#### 1. Prep OS X

-   Download and install latest version of [Command Line Tools](https://idmsa.apple.com/IDMSWebAuth/signin?appIdKey=891bd3417a7776362562d2197f89480a8547b108fd934911bcbea0110d07f757&path=%2Fdownload%2Fmore%2F&rv=1), you will need an account though.

#### 2. Install Homebrew

To install Homebrew, open Terminal or your favorite OS X terminal emulator and run

```/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"```

#### 3. Install oh-my-zsh

Check zsh version just to be safe `zsh --version`

```sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"```

#### 3a. Install Spaceship via oh-my-zsh

Clone this repo:

```zsh
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
```

Symlink `spaceship.zsh-theme` to your oh-my-zsh custom themes directory:

```zsh
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```

Set `ZSH_THEME="spaceship"` in your `.zshrc`.

#### 4. Install asdf

First install asdf dependancies

```
brew install coreutils curl git
```

Then install asdf via Homebrew

```
brew install asdf
```

Add `asdf.sh` to your `~/.zshrc` with: 

```
echo -e "\n. $(brew --prefix asdf)/asdf.sh" >> ${ZDOTDIR:-~}/.zshrc
```
Now add Python as an asdf plugin

```
asdf plugin add <name>
# asdf plugin add python
```

#### 5. Installing Python.

Now simply install the latest version of Python using

```
asdf install <name> latest
# asdf install python latest
```

Now we have to tell asdf which version to use

```
asdf global <name> <version>
asdf shell <name> <version>
asdf local <name> <version>
# asdf global python 3.9.2
```

### FYI

If installing packages via pip after installing python via asdf. Sometimes you could run into the package name not being found when running

```
> which <package name>
```

To resolve this you have to place a shim into the shims dir:

```
> asdf reshim python
```

#### 6. Install Fira Code Fonts

In the [downloaded TTF folder](https://github.com/tonsky/FiraCode/tree/master/distr/ttf):

Select all font files
Right click and select Open (alternatively Open With Font Book)
Select "Install Font"

#### 7. Clone this repo to hidden .dotfile directory in your home directory

```git clone https://github.com/mrpbennett/dotfiles.git ~/.dotfiles```

#### 8. Run setup.

```source ~/.dotfiles/setup-symlinks.sh```

```source ~/.dotfiles/setup-brew.sh```

```source ~/.dotfiles/npm-packages.sh```

```source ~/.dotfiles/setup-osx.sh```


#### 9. SSH setup

Using the [Github](https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) tutorials.


Yup, it does. @[._.]@
Hopefully it does on yours as well, but please don't hate me if it doesn't.

:heart:

# shell-secrets

This is a small tool to set environment variables from encrypted (with GPG) files

![shell-secrets](https://user-images.githubusercontent.com/22697/74163644-6e741100-4c01-11ea-8c10-41c53d21eba0.gif)

There are many command line tools that require environment variables with secret values to work.
These values are often saved in unencrypted shell files. I created this simple but useful script
to read secret values from encrypted files and at the same time make it easy to login in and out
from diferent accounts.

## Installation

**NOTICE**: GPG is assumed to be installed and configured for the current user.

Copy the `shell-secrets.sh` file anywhere in your disk. Add the following line in your profile shell script:

```
source /path/to/shell-secrets.sh
```

Also is recommended to modify the shell prompt to display the current login. For example this
can be inserted in your `PS1` variable:

```
export PS1='... \e[31m$SECRET_LOGIN\e[0m ...'
```

The variable `$SECRET_LOGIN` keeps the list of account names being used in the current shell.

## Usage

### Create secret files

First, make sure the `~/.shell-secrets/` directory exists. This is where encrypted files will be stored:

```
mkdir -p ~/.shell-secrets
```

Now create new encrypted files using GPG:

```
$ gpg --encrypt -r yourself@some.email.com --armor --output ~/.shell-secrets/foo.gpg
export FOO=E9yyQ7MApwoQHXBCIs7or5aQ9W
export BAR=lLvxSCbY4j+Kdn
...
^D
```

Done!

### Login

To login using any of the encrypted files, just call the `login` function with the file name (without the `.gpg` extension)

```
$ login foo
foo $ env
...
FOO=E9yyQ7MApwoQHXBCIs7or5aQ9W
BAR=lLvxSCbY4j+Kdn
...
```

The enviroment variables are set and ready to be used and the `SECRET_LOGIN` environment variable is updated to be used by the prompt. The script also includes autocomplete for the
available file names in the `.shell-secrets` directory.

Several logins can also be nested:

```
$ login foo
foo $ login bar
foo bar $
```

### Logout

Every time the `login` function is used, a new sub-shell process is created. To logout from the current
account, call `logout` or just press `Ctrl+D`.

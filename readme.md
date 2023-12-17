# Dot

My configuration files for UNIX Systems with a script that checks if running on Android Termux, Debian, Arch or macOS and then installs packages with the correct package manager and clones configuration files.

## Why?

These configuration files help me reproduce my preferred development tools and environments on a variety of UNIX based operating systems, this means if I get a new machine or need to develop in a container/on a server I don't have to reconfigure my system, I just run [the script](#Usage) below and my environment will be configured automatically.

## Usage

```
curl -sSl https://raw.githubusercontent.com/mac-codes9/dot/master/install.sh | sh
```

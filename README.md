---
header-includes: |
    \usepackage{bickham}
---

# Docker container with Bickham

Ever wanted to write these fancy `\mathcal{C}` ($\mathcal{C}$) letters?
Well, now you can.

This also provides a simple command which makes building your `.tex` or `.md` files even easier.

## Try it

```bash
make image # generate the docker image and tag it: pandoc-bickham:latest
make # build this readme
```

## Installation

Just build the image and install it:

```bash
make image
sudo make install
```

This will install the following files:

- `/usr/local/bin/pandoc-make`: an alias for the makefile, navigate to a directory with `.md` or `.tex` files and type `pandoc-make`
- `/usr/local/bin/pdmake`: symbolic link to `/usr/local/bin/pandoc-make`
- `/usr/local/etc/pandoc-bickham-makefile`: the make file which calls the docker container

## Usage

Navigate to a folder containing `.tex` or `.md` files and run `pdmake` or `pandoc-make`.

# Packer.io Templates For Storyplayer Test Environments

This project contains the build instructions for Storyplayer's own test environments. They are built using [Packer.io](http://packer.io), and are based on [Shiguredo's Packer Templates](https://github.com/shiguredo/packer-templates).

## How To Build

I'm assuming that you already have [Packer.io](http://packer.io) downloaded and installed in your PATH. If not, go and do that first, and then come back.

To build the templates, run:

    packer build centos-6.7/template.json
    packer build centos-7.1/template.json

Completed boxes will appear in the `boxes/` folder.
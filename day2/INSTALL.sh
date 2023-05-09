#!/bin/bash
# Singularity version

# Client: Docker Engine - Community
# Version:           20.10.2
# API version:       1.41
# Go version:        go1.13.15
# Git commit:        2291f61
# Built:             Mon Dec 28 16:18:32 2020
# OS/Arch:           linux/amd64
# Context:           default
# Experimental:      true

# Server: Docker Engine - Community
# Engine:
#  Version:          20.10.2
#  API version:      1.41 (minimum version 1.12)
#  Go version:       go1.13.15
#  Git commit:       8891c58
#  Built:            Mon Dec 28 16:16:14 2020
#  OS/Arch:          linux/amd64
#  Experimental:     false
# containerd:
#  Version:          1.4.3
#  GitCommit:        269548fa27e0089a8b8278fc4fc781d7f65a939b
# runc:
#  Version:          1.0.0-rc92
#  GitCommit:        ff819c7e9184c13b7c2607fe6c30ae19403a7aff
# docker-init:
#  Version:          0.19.0
#  GitCommit:        de40ad0

## Singularity version

# 3.7.0

# Build Singularity images

mkdir -p /usr/share/course-images
cd /usr/share/course-images

[[ -f nanopolish.simg ]] || singularity build nanopolish.simg docker://tleonardi/nanopolish:ab9722b
[[ -f minimap2.simg ]] || singularity build minimap2.simg docker://tleonardi/minimap2:2.17
[[ -f ont-api.simg ]] || singularity build ont-api.simg docker://tleonardi/ont-fast5-api:3.1.6
[[ -f squigglekit.simg ]] || singularity build squigglekit.simg docker://tleonardi/squigglekit:f446aba
[[ -f pycoqc.simg ]] || singularity build pycoqc.simg docker://tleonardi/pycoqc:2.5.2
[[ -f nanoqc.simg ]] || singularity build nanoqc.simg docker://tleonardi/nanoqc:0.9.4
[[ -f bedparse.simg ]] || singularity build bedparse.simg docker://tleonardi/bedparse:0.2.3
[[ -f bedtools.simg ]] || singularity build bedtools.simg docker://tleonardi/bedtools:2.27.1
[[ -f nanocount.simg ]] || singularity build nanocount.simg docker://tleonardi/nanocount:0.2.1
[[ -f r-tidyverse.simg ]] || singularity build r-tidyverse.simg docker://rocker/tidyverse
[[ -f nanocompore.simg ]] || singularity build nanocompore.simg docker://tleonardi/nanocompore:1.0.3

# Copy practical folders

for homedir in /home/* ; do 
    if [ -d "$homedir" ] ; then
         cp -r /usr/share/practicals/* "$homedir"
         user=$(stat -c "%U" "$homedir")
         chown -R $user:$user "$homedir/"
	 [[ -h "$homedir/solutions" ]] || ln -s /usr/share/solutions "$homedir/solutions"
         [[ -h "$homedir/data" ]] || ln -s /usr/share/course-data "$homedir/data"
         cp /home/ubuntu/aliases.sh "$homedir/.aliases.sh"
         grep -qxF 'source $HOME/.aliases.sh' "$homedir/.bashrc" || echo 'source $HOME/.aliases.sh' >> "$homedir/.bashrc"
    fi
done


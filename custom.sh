#!/bin/bash

read -p 'Name of the module: '       name
read -p 'Module short description: ' descr
read -p 'URL of repository: '        url
read -p 'Author(s): '                authors
read -p 'Corresponding author(s): '  corr_authors


# README.md
sed -i "" "s/# TO_FILL/# $name/" README.md
sed -i "" "s/brsynth\/TO_FILL/brsynth\/test/g" README.md
sed -i "" "s/DESCR: TO_FILL/$descr/" README.md
sed -i "" "s/python -m pip install TO_FILL/python -m pip install $name/" README.md
sed -i "" "s/conda install -c brsynth TO_FILL/conda install -c brsynth $name/" README.md
sed -i "" "s/from TO_FILL import TO_FILL/from $name import $name/" README.md
sed -i "" "s/python -m TO_FILL/python -m $name/" README.md
sed -i "" "s/* \*\*TO_FILL\*\*$/* **$corr_authors**/" README.md
sed -i "" "s/* TO_FILL$/* $authors/" README.md

# src
mv TO_FILL $name
touch $name/$name.py
sed -i "" "s/from TO_FILL.TO_FILL import TO_FILL/from $name.$name import $name/" $name/__init__.py
sed -i "" "s/\"TO_FILL\"/\"$name\"/" $name/__init__.py
sed -i "" "s/from TO_FILL import TO_FILL/from $name import $name/" $name/__main__.py

# extras
sed -i "" "s/PACKAGE=TO_FILL/PACKAGE=$name/" extras/.env
sed -i "" "s/URL=TO_FILL/URL=$url/" extras/.env
sed -i "" "s/AUTHORS=TO_FILL/AUTHORS=$authors/" extras/.env
sed -i "" "s/CORR_AUTHOR=TO_FILL/CORR_AUTHOR=$corr_authors/" extras/.env
sed -i "" "s/DESCR=TO_FILL/DESCR=$descr/" extras/.env

# tests
sed -i "" "s/mod_name = 'TO_FILL'/mod_name = '$name'/" tests/module.py

# github
sed -i "" "s/TO_FILL/$name/" .github/publish.yml

echo
echo Customisation is completed!
echo
echo There is still some missing fields to replace:
grep -rnw '.' --exclude='custom.sh' --exclude='./.git/*' -e 'TO_FILL'

echo
echo
echo "This file (custom.sh) can be removed."

#!/bin/bash
git checkout developpment
rake assets:clobber assets:clean assets:precompile
#remove all removed git files
git ls-files --deleted -z | xargs -0 git rm
git add .
git commit -am $1
git merge master
git checkout master
git push github master
git push github developpment

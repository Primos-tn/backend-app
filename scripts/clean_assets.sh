rake assets:clobber assets:clean assets:precompile
#remove all removed git files
git ls-files --deleted -z | xargs -0 git rm
gem list --no-version > tmp/mygems
cat tmp/mygems
rvm gemset create gemSetName
rvm gemset use gemSetName
cat tmp/mygems | while read line; do gem install $line; done
cat tmp/mygems | while read line; do gem uninstall $line; done
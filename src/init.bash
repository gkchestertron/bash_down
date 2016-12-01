echo creating bash_down folder...
mkdir bash_down
mkdir bash_down/tests
mkdir bash_down/scripts
cp -r "$bin_dir/../src/runners/" bash_down/runners
cp -r "$bin_dir/../src/parsers" bash_down/parsers
exit

echo creating bash_down folder...

# user folders
mkdir bash_down
mkdir bash_down/tests
mkdir bash_down/scripts

# example files
cp -r "$bin_dir/../src/runners/" bash_down/runners
cp -r "$bin_dir/../src/parsers" bash_down/parsers
cp "$bin_dir/../src/spec.bd" bash_down/

# build folders
mkdir bash_down/build
mkdir bash_down/build/tests
mkdir bash_down/build/scripts
exit

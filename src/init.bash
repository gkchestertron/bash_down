echo creating __bd__ folder...

# user folders
mkdir __bd__
mkdir __bd__/tests
mkdir __bd__/scripts

# example files
cp -r "$bin_dir/../src/runners/" __bd__/runners
cp -r "$bin_dir/../src/parsers" __bd__/parsers
cp "$bin_dir/../src/spec.bd" __bd__/

# build folders
mkdir __bd__/build
mkdir __bd__/build/tests
mkdir __bd__/build/scripts
exit

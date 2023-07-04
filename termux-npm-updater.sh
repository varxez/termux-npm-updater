rm -Rf tmp_npm
mkdir tmp_npm
if [ ! -s "$PATH/npm" ]; then
    echo "Node Package Manager(npm) not found."
    exit 1
fi
echo -n "Current version of npm: " && npm -v
echo "Downloading last version of npm..."
npm install --prefix tmp_npm npm
if [ ! -d "tmp_npm/node_modules/npm" ]; then
    echo "An error occurred. Please, try again."
    exit 1
fi
echo -n "Downloaded version of npm: " && grep -Po '(?<=version": ")[^"]*' tmp_npm/node_modules/npm/package.json | awk 'NR==1{print $1}'
echo "Deleting old npm to execute directory..."
rm -Rf $PATH/../lib/node_modules/npm/
echo "Deleted successfully."
echo "Moving new npm to execute directory..."
mv tmp_npm/node_modules/npm $PATH/../lib/node_modules/
echo "Moved successfully."
sleep 1
rm -Rf tmp_npm
echo "Node Package Manager updated to last version successfully. Check it by executing: npm -v"
exit 0
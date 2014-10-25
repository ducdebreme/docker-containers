
# Build
    docker build -t ducdebreme/solr4_slim .

# Run
    docker run \
        --name my_name \
        -v $(pwd)/conf:/etc/conf/solr-index \
        -P -d ducdebreme/solr4_slim 

# Directories

## Custom config files
The index comes with a standard solr + drupal apachesolr patched index.
You may pass custom config files to solr index by mounting a folder to **/etc/conf/solr-index**.


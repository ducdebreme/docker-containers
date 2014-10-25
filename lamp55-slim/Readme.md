

# BUILD
    docker build -t ducdebreme/lamp55_slim .

# RUN
    docker run \
        --name my_name \
        -v $(pwd)/conf:/etc/conf \
        -v webroot:/var/www \
        -P -d ducdebreme/lamp55_slim 


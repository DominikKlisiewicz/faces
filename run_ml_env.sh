#!/bin/bash
# =====================================================
# Resume ML Docker Environment Script with Jupyter
# =====================================================

IMAGE_NAME="ml:fixed"
CONTAINER_NAME="ml-container"
HOST_PORT=8888
WORKSPACE_DIR="$HOME/ml/faces"  

launch_jupyter() {
    echo "Launching Jupyter Notebook..."
    docker exec -it $CONTAINER_NAME bash -c "cd /workspace && jupyter notebook --ip=0.0.0.0 --port=$HOST_PORT --allow-root --no-browser"
}

if [ "$(docker ps -a -q -f name=$CONTAINER_NAME)" ]; then
    echo "Container $CONTAINER_NAME exists."

    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
        echo "Container $CONTAINER_NAME is already running."
    else
        echo "Starting container $CONTAINER_NAME..."
        docker start $CONTAINER_NAME
    fi

    launch_jupyter
else
    echo "Creating new container $CONTAINER_NAME from $IMAGE_NAME..."
    docker run --gpus all -dit -p $HOST_PORT:8888 \
        --name $CONTAINER_NAME \
        -v $WORKSPACE_DIR:/workspace \
        $IMAGE_NAME bash

    launch_jupyter
fi

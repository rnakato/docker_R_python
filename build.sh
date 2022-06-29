for tag in #11.3.1-cudnn8-runtime-ubuntu20.04 latest
do
    docker build -f Dockerfile.GPU -t rnakato/r_python_gpu:$tag . #--no-cache
    docker push rnakato/r_python_gpu:$tag
done

for tag in 20.04 latest
do
    docker build -f Dockerfile.20.04 -t rnakato/r_python:$tag .
    docker push rnakato/r_python:$tag
done

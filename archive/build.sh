for tag in #2022.12 latest #11.4.2-cudnn8-runtime-ubuntu20.04 #2022.08 latest #11.3.1-cudnn8-runtime-ubuntu20.04
do
    docker build -f Dockerfile.GPU -t rnakato/r_python_gpu:$tag . #--no-cache
    docker push rnakato/r_python_gpu:$tag
done

for tag in 2023.03 #latest #2022.12 2022.08.2
do
    docker build -f Dockerfile.22.04 -t rnakato/r_python:$tag . --no-cache
#    docker push rnakato/r_python:$tag
done

for tag in 2023.11 latest
do
    docker build -t rnakato/r_python:$tag --target normal .
    docker push     rnakato/r_python:$tag
    docker build -t rnakato/r_python_gpu:$tag --target gpu .
    docker push     rnakato/r_python_gpu:$tag
done

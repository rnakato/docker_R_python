for tag in 2026.06 latest
do
    docker build -t rnakato/r_python:$tag -f Dockerfile --target normal . #--no-cache
    docker push     rnakato/r_python:$tag
    docker build -t rnakato/r_python_gpu:$tag -f Dockerfile --target gpu .
    docker push     rnakato/r_python_gpu:$tag
done

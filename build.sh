for tag in 2024.02 latest
do
    docker build -t rnakato/r_python:$tag --target normal .
#    docker save -o r_python-$tag.tar rnakato/r_python:$tag
#    singularity build -F r_python.$tag.sif docker-archive://r_python-$tag.tar
#    exit
    docker push     rnakato/r_python:$tag
    docker build -t rnakato/r_python_gpu:$tag --target gpu .
    docker push     rnakato/r_python_gpu:$tag
done

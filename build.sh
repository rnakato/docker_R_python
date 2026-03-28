for tag in 2026.03.2 latest
do
    docker build -t rnakato/r_python:$tag -f Dockerfile --target normal .
#exit
#    docker save -o r_python-$tag.tar rnakato/r_python:$tag
#    singularity build -F r_python.$tag.sif docker-archive://r_python-$tag.tar
#    exit
    docker push     rnakato/r_python:$tag
    docker build -t rnakato/r_python_gpu:$tag -f Dockerfile --target gpu .
    docker push     rnakato/r_python_gpu:$tag
done

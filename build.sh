for version in 22.04 24.04
do
    for tag in 2026.09 latest
    do
        docker build -f Dockerfile.$version -t rnakato/r_python_$version:$tag --target normal . #--no-cache
        docker push     rnakato/r_python_$version:$tag
        docker build -f Dockerfile.$version -t rnakato/r_python_gpu_$version:$tag --target gpu .
        docker push     rnakato/r_python_gpu_$version:$tag
    done
done

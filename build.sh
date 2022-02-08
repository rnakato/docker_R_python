for tag in 2022.02  latest #2021.11 #2020.12 #pytorch-1.5-cuda10.1-cudnn7-devel
do
    docker build -f Dockerfile.GPU -t rnakato/r_python_gpu:$tag . #--no-cache
    docker push rnakato/r_python_gpu:$tag
done



#for tag in #r40u18 latest
#do
#    docker build -f Dockerfile.R4.0.Ubuntu18.04 -t rnakato/r_python:$tag . #--no-cache
#    docker push rnakato/r_python:$tag
#done

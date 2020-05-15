for tag in #r40u20 latest
do
   docker build -f Dockerfile.R4.0.Ubuntu20.04 -t rnakato/r_python:$tag .
   docker push rnakato/r_python:$tag
done

tag=r40u18
docker build -f Dockerfile.R4.0.Ubuntu18.04 -t rnakato/r_python:$tag . #--no-cache
docker push rnakato/r_python:$tag

exit
tag=r35u18
docker build -f Dockerfile.R3.5.Ubuntu18.04 -t rnakato/r_python:$tag .
docker push rnakato/r_python:$tag

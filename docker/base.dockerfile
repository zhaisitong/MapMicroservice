FROM ubuntu:23.04

RUN apt update && apt upgrade -y

RUN apt install -y      \
    protobuf-compiler   \
    python3             \
    python3-boto3       \
    python3-flask       \
    python3-flask-cors  \
    python3-protobuf    \
    python3-psycopg2    \
    python3-pip         \
    python3-numpy       \
    wget                \
    zip

WORKDIR /home

# Downloads the codebase.
ADD https://api.github.com/repos/zhaisitong/MapMicroservice/commits?per_page=1 latest_commit
RUN wget https://codeload.github.com/zhaisitong/MapMicroservice/zip/refs/heads/main
RUN unzip main && rm main

WORKDIR /home/MapMicroservice-main/src/mutation
RUN protoc --python_out=proto_py --proto_path=proto  `find proto -name *.proto`

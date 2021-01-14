FROM nvidia/cuda
RUN apt update && apt upgrade -y && apt dist-upgrade -y
RUN apt install nano git -y
ENTRYPOINT ["bash"]

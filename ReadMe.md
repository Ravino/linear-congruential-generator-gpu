Step 1
Build runtime cuda for nvidia
bash buildImage.sh

Step 2
Running runtime cuda in interactive tty and shell bash for working and compiling, mounting current dir to /mnt work dir in container.
docker run -it --name cuda-runtime -v (pwd):/mnt cuda-runtime bash

Step 3
Connected interactive tty container, change dir on work
cd /mnt
Compiling your src code for cuda
For example
nvcc index.cu


Step 4 
Building project on local machine if installed nvcc
bash  builder.sh
This is builder created file with name @build@ in root dir

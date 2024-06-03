FROM ubuntu:noble

ENV TZ=America/Sao_Paulo

RUN apt-get update -y \
    && apt-get install -y sudo curl git software-properties-common ansible \
    && apt-get clean \
    && useradd -m -s /bin/bash andre \ 
    && echo "andre:asdf" | chpasswd \
    && echo "andre ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers 

WORKDIR /home/andre

COPY . .

#RUN ansible-pull -U https://github.com/andreferrazz/ansible.git

USER andre

CMD ["bash"]


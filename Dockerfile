FROM ubuntu:noble

# Set timezone
ENV TZ=America/Sao_Paulo

# Install base packages
RUN apt-get update -y \
    && apt-get install -y \
        socat \
        sudo \
        curl \
        git \
        vim \
        ansible \
    && apt-get clean

# Create user
RUN useradd -m -s /bin/bash andre \ 
    && echo "andre:asdf" | chpasswd \
    && echo "andre ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers 

# Forward clipboard
RUN mkdir /clipboard
COPY ./wsl-utils/clip.sh /clipboard/
RUN ln -s /clipboard/clip.sh /clipboard/xsel 
RUN ln -s /clipboard/clip.sh /clipboard/xclip 
ENV PATH="/clipboard:${PATH}"

# Run ansible playbook
WORKDIR /home/andre
COPY ./local.yml ./
RUN chown andre:andre ./local.yml
RUN ansible-playbook local.yml
USER andre

CMD ["zsh"]

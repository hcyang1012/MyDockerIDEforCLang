FROM       ubuntu:latest
MAINTAINER heecheol.yang@outlook.com

RUN apt-get update && apt-get install -y locales apt-utils
RUN locale-gen ko_KR.UTF-8
ENV LC_ALL ko_KR.UTF-8

RUN apt-get -y install vim git build-essential zsh wget curl

RUN git config --global http.sslVerify false
RUN mkdir -p ~/work/

# ohmyzsh!
RUN apt-get -y install fonts-powerline
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN echo "\nZSH_THEME=\"agnoster\"" >> ~/.zshrc

# YCM
RUN apt -y install build-essential cmake python3-dev python3-pip clang
RUN pip3 install compiledb
RUN git clone https://github.com/ycm-core/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
RUN cd ~/.vim/bundle/YouCompleteMe && git submodule update --init --recursive && python3 install.py --clang-completer

# VUNDLE
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
COPY myvimrc /root/.vimrc
RUN vim +PluginInstall +qall


CMD "/bin/zsh"

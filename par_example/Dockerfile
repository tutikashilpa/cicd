FROM gitpod/workspace-full:latest

USER root

RUN apt-get update \
    && apt-get install -y openjdk-8-jdk \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y zsh \
    && rm -rf /var/lib/apt/lists/*

USER gitpod

# Disable central PIP_USER
# otherwise bazel python do not work
# RUN echo 'export PIP_USER=no' >> ~/.bashrc

# Install Oh-My-Zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh \
    && git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting \
    && echo 'POWERLEVEL9K_PROMPT_ON_NEWLINE=true' >> ~/.zshrc \
    && echo 'POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)' >> ~/.zshrc \
    && echo 'source ~/.oh-my-zsh/custom/themes/powerlevel9k/powerlevel9k.zsh-theme' >> ~/.zshrc \
    && echo 'source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting' >> ~/.zshrc \
    && echo 'export TERM="xterm-256color"' | cat - ~/.zshrc > ~/.zshrc.new && mv ~/.zshrc.new ~/.zshrc \
    && echo '`which zsh`' >> ~/.bashrc

RUN wget -q https://github.com/bazelbuild/bazel/releases/download/2.0.0/bazel-2.0.0-installer-linux-x86_64.sh \
    && chmod +x bazel-2.0.0-installer-linux-x86_64.sh \
    && ./bazel-2.0.0-installer-linux-x86_64.sh --user \
    && echo 'export PATH="$PATH:$HOME/bin"' >> ~/.bashrc \
    && echo 'fpath[1,0]=~/.zsh/completion/' >> ~/.zshrc \
    && echo 'compinit' >> ~/.zshrc \
    && echo "zstyle ':completion:*' use-cache on" >> ~/.zshrc \
    && echo "zstyle ':completion:*' cache-path ~/.zsh/cache" >> ~/.zshrc


FROM mcr.microsoft.com/devcontainers/ruby:1-3.3-bookworm

# Install Rails
RUN su vscode -c "gem install rails webdrivers"
RUN su vscode -c "/usr/local/rvm/bin/rvm fix-permissions"

# Default value to allow debug server to serve content over GitHub Codespace's port forwarding service
# The value is a comma-separated list of allowed domains
ENV RAILS_DEVELOPMENT_HOSTS=".githubpreview.dev,.preview.app.github.dev,.app.github.dev"

# Delta - A syntax-highlighting pager for git, diff, grep, and blame output をインストール
RUN ARCH=$(uname -m) \
    && DELTA_ARCH=$(if [ "$ARCH" = "arm64" ] || [ "$ARCH" = "aarch64" ]; then echo "arm64"; else echo "amd64"; fi) \
    && DELTA_VERSION=$(curl -sL "https://api.github.com/repos/dandavison/delta/releases/latest" | jq -r '.name') \
    && curl -o /tmp/git-delta_latest_${DELTA_ARCH}.deb -L https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_${DELTA_ARCH}.deb \
    && apt-get install -y /tmp/git-delta_latest_${DELTA_ARCH}.deb \
    && rm -f /tmp/git-delta_latest_${DELTA_ARCH}.deb

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# [Optional] Uncomment this line to install additional gems.
# RUN su vscode -c "gem install <your-gem-names-here>"

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1

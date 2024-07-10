FROM ruby:2.7.3
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    apt-get install -y cron

RUN if ! command -v yarn > /dev/null 2>&1; then npm install -g yarn; fi

RUN mkdir /app
WORKDIR /app

# このDockerfileでgemのインストールやyarnによるパッケージのインストールをしていないのは、
# ログインなどの処理を挟む必要があるため。
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

FROM wsng911/hermes-agent:latest

WORKDIR /app

COPY . .

RUN git init && git config user.email "dev@example.com" && \
    git config user.name "dev" && git add -A && git commit -m "init"

CMD ["gateway", "run"]

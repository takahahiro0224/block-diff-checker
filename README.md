# block-diff-checker

## Settings

### Install library
```shell
bundle install
```

### Prepare bitcoind (v22.0)

#### By docker

```shell
docker volume create --name=bitcoind-data
```
```shell
docker run -v bitcoind-data:/bitcoin/.bitcoin --name=bitcoind-node -d \
    -p 8333:8333 \
    -p 127.0.0.1:8332:8332 \
    -e DISABLEWALLET=1 \
    -e PRINTTOCONSOLE=1 \
    -e RPCUSER=myuser \
    -e RPCPASSWORD=mypassword \
    kylemanna/bitcoind
```

```shell
docker logs -f bitcoind-node
```

#### Other
see https://github.com/bitcoin/bitcoin/tree/v22.0/doc

### create .env file
```shell
touch .env
vi .env
```


## cron 

### edit crontab
```shell
crontab -e
```

```shell
* * * * * <YOUR PATH>/block-diff-checker/task.sh > log/cron_log.log 2>&1'
```

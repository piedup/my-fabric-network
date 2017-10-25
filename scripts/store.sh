cd $GOPATH/src/github.com/stratumn/sdk/cmd/fabricstore
go build
sleep 9
./fabricstore -configFile=/home/client-config.yaml
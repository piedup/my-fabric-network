MAX_RETRY=10
DELAY=1
COUNTER=1

verifyResult () {
	if [ $1 -ne 0 ] ; then
		echo "!!!!!!!!!!!!!!! "$2" !!!!!!!!!!!!!!!!"
		echo
   		exit 1
	fi
}

startWithRetry() {
    ./fabricstore -configFile=/home/client-config.yaml
    res=$?
    if [ $res -ne 0 -a $COUNTER -lt $MAX_RETRY ]; then
        COUNTER=` expr $COUNTER + 1`
        echo "Could not connect fabricstore to fabric network, retrying in $DELAY seconds"
        sleep $DELAY
        startWithRetry
    else
        COUNTER=1
    fi
    verifyResult $res "After $MAX_RETRY attemps, fabricstore has failed to connect to fabric network"
}

cd $GOPATH/src/github.com/stratumn/sdk/cmd/fabricstore
go build

echo "Connecting to fabric network..."
startWithRetry
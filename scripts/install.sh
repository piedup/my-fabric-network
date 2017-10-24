verifyResult () {
	if [ $1 -ne 0 ] ; then
		echo "!!!!!!!!!!!!!!! "$2" !!!!!!!!!!!!!!!!"
    echo "========= ERROR !!! FAILED to initialize network ==========="
		echo
   		exit 1
	fi
}

# Wait for network
sleep 10

echo "Creating channel..."
peer channel create -o orderer.example.com:7050 -c $CHANNEL_NAME -f $CONFIG_PATH/channel.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
res=$?
verifyResult $res "Channel creation failed"
echo "===================== Channel \"$CHANNEL_NAME\" is created successfully ===================== "

echo "Joining peer to channel..."
peer channel join -b mychannel.block
res=$?
verifyResult $res "Couldn't join peer to channel"
echo "===================== PEER joined on the channel \"$CHANNEL_NAME\" ===================== "

echo "Updating anchor peer for org1..."
peer channel update -o orderer.example.com:7050 -c $CHANNEL_NAME -f $CONFIG_PATH/Org1MSPanchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
res=$?
verifyResult $res  "Anchor peer update failed"
echo "===================== Anchor peers for org \"$CORE_PEER_LOCALMSPID\" on \"$CHANNEL_NAME\" is updated successfully ===================== "

echo "Installing chaincode on peer0.org1.example.com..."
peer chaincode install -n pop -v 1.0 -p github.com/pop
res=$?
verifyResult $res "Chaincode installation on remote peer has Failed"
echo "===================== Chaincode is installed on remote peer ===================== "

echo "Instantiate chaincode..."
peer chaincode instantiate -o orderer.example.com:7050 --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C $CHANNEL_NAME -n pop -v 1.0 -c '{"Args":[]}' -P "AND ('Org1MSP.member')"
res=$?
verifyResult $res "Chaincode instantiation on peer on channel '$CHANNEL_NAME' failed"
echo "===================== Chaincode Instantiation on peer on channel '$CHANNEL_NAME' is successful ===================== "

echo ""
echo "===================== Network ready and initialized ======================== "
echo ""

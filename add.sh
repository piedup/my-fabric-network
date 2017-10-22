export CHANNEL_NAME=mychannel
docker exec -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/users/Admin@org1.example.com/msp" peer0.org1.example.com peer channel create -o orderer.example.com:7050 -c $CHANNEL_NAME -f /etc/hyperledger/fabric/config/channel.tx --tls $CORE_PEER_TLS_ENABLED --cafile /etc/hyperledger/fabric/tlsca/tlsca.example.com-cert.pem
docker exec -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/users/Admin@org1.example.com/msp" peer0.org1.example.com peer channel join -b mychannel.block

Generate crypto material

`cryptogen generate --config=./crypto-config.yaml`

Generate orderer genesis block

`configtxgen -profile OneOrgOrdererGenesis -outputBlock ./network-artifacts/genesis.block`

Inspect orderer genesis block

`configtxgen -inspectBlock ./network-artifacts/genesis.block -profile OneOrgOrdererGenesis`

Create a channel configuration transaction

`export CHANNEL_NAME=mychannel`
`configtxgen -profile OneOrgChannel -outputCreateChannelTx ./network-artifacts/channel.tx -channelID $CHANNEL_NAME`

Inspect channel configuration transaction

`configtxgen -inspectChannelCreateTx ./network-artifacts/channel.tx -profile OneOrgChannel`

Define Org1 anchor peer for channel

`configtxgen -profile OneOrgChannel -outputAnchorPeersUpdate ./network-artifacts/Org1MSPanchors.tx -channelID=$CHANNEL_NAME -asOrg Org1MSP`

Start the network (add-d to run in the background)

`docker-compose -f docker-compose.yml up`

Stop running containers

`docker rm -f $(docker ps -aq)`

Boostrap the orderer

`peer channel create -o orderer.example.com:7050 -c mychannel -f ./network-artifacts/channel.tx --tls $CORE_PEER_TLS_ENABLED --cafile ./crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem`

Join peer to channel

Anchor peer

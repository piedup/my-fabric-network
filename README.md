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

Start the network

`docker-compose -f docker-compose.yml up -d; docker logs -f cli`

Stop running containers

`docker rm -f $(docker ps -aq)`

Remove chaincode image

`docker rmi $(docker images | grep dev-peer0.org1.example.com-pop-1.0 | awk "{print \$3}")`
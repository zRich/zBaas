# package id

## org1:

basic:6e007c5262903d1eb4f5c1a5ce1c47768ac7c12f33deca8edd2cf17c3b88f048

## org2

basic:94363004771a02d368064c34eea4c57d0149aa51b20a7ed429d8ebf0e14b7bb4

## org3

basic:c65e36828d68c19370cc359a0f732dcc0156b64deb804311aefea26422a3432e

# Approve chaincode

## approve chaincode peer0-org1
peer lifecycle chaincode approveformyorg --channelID mychannel --name basic --version 1.0 --init-required --package-id basic:6e007c5262903d1eb4f5c1a5ce1c47768ac7c12f33deca8edd2cf17c3b88f048 --sequence 1 -o orderer:7050 --tls --cafile $ORDERER_CA 


## approve chaincode peer0-org2
peer lifecycle chaincode approveformyorg --channelID mychannel --name basic --version 1.0 --init-required --package-id basic:94363004771a02d368064c34eea4c57d0149aa51b20a7ed429d8ebf0e14b7bb4 --sequence 1 -o orderer:7050 --tls --cafile $ORDERER_CA 


## approve chaincode peer0-org3
peer lifecycle chaincode approveformyorg --channelID mychannel --name basic --version 1.0 --init-required --package-id basic:c65e36828d68c19370cc359a0f732dcc0156b64deb804311aefea26422a3432e --sequence 1 -o orderer:7050 --tls --cafile $ORDERER_CA 

# Commit Chaincode

## checkcommitreadiness

peer lifecycle chaincode checkcommitreadiness --channelID mychannel --name basic --version 1.0 --init-required --sequence 1 -o -orderer:7050 --tls --cafile $ORDERER_CA


## commit chaincode

peer lifecycle chaincode commit -o orderer:7050 --channelID mychannel --name basic --version 1.0 --sequence 1 --init-required --tls true --cafile $ORDERER_CA --peerAddresses peer0-org1:7051 --tlsRootCertFiles /organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses peer0-org2:7051 --tlsRootCertFiles /organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt --peerAddresses peer0-org3:7051 --tlsRootCertFiles /organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt



## InitLedger command

peer chaincode invoke -o orderer:7050 --isInit --tls true --cafile $ORDERER_CA -C mychannel -n basic --peerAddresses peer0-org1:7051 --tlsRootCertFiles /organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses peer0-org2:7051 --tlsRootCertFiles /organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt --peerAddresses peer0-org3:7051 --tlsRootCertFiles /organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt -c '{"Args":["InitLedger"]}' --waitForEvent


## invoke command
peer chaincode invoke -o orderer:7050 --tls true --cafile $ORDERER_CA -C mychannel -n basic --peerAddresses peer0-org1:7051 --tlsRootCertFiles /organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses peer0-org2:7051 --tlsRootCertFiles /organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt --peerAddresses peer0-org3:7051 --tlsRootCertFiles /organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt -c '{"Args":["CreateAsset","asset100","red","50","tom","300"]}' --waitForEvent


## query command
peer chaincode query -C mychannel -n basic -c '{"Args":["GetAllAssets"]}'
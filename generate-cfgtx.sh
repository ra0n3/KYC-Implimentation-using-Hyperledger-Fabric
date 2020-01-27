#!/bin/sh

CHANNEL_NAME="default"
PROJPATH=$(pwd)
CLIPATH=$PROJPATH/cli/peers

chmod +x $PROJPATH/configtxgen

echo
echo "##########################################################"
echo "#########  Generating Orderer Genesis block ##############"
echo "##########################################################"
$PROJPATH/configtxgen -profile FourOrgsGenesis -outputBlock $CLIPATH/genesis.block

echo
echo "#################################################################"
echo "### Generating channel configuration transaction 'channel.tx' ###"
echo "#################################################################"
$PROJPATH/configtxgen -profile FourOrgsChannel -outputCreateChannelTx $CLIPATH/channel.tx -channelID $CHANNEL_NAME
cp $CLIPATH/channel.tx $PROJPATH/web
echo
echo "#################################################################"
echo "####### Generating anchor peer update for BankOrg ##########"
echo "#################################################################"
$PROJPATH/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate $CLIPATH/BankOrgMSPAnchors.tx -channelID $CHANNEL_NAME -asOrg BankOrgMSP

echo
echo "#################################################################"
echo "#######    Generating anchor peer update for UserOrg   ##########"
echo "#################################################################"
$PROJPATH/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate $CLIPATH/UserOrgMSPAnchors.tx -channelID $CHANNEL_NAME -asOrg UserOrgMSP

echo
echo "##################################################################"
echo "####### Generating anchor peer update for PassportOrg ##########"
echo "##################################################################"
$PROJPATH/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate $CLIPATH/PassportOrgMSPAnchors.tx -channelID $CHANNEL_NAME -asOrg PassportOrgMSP

echo
echo "##################################################################"
echo "#######   Generating anchor peer update for GovtOrg   ##########"
echo "##################################################################"
$PROJPATH/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate $CLIPATH/GovtOrgMSPAnchors.tx -channelID $CHANNEL_NAME -asOrg GovtOrgMSP

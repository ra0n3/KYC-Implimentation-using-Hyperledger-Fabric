#!/bin/sh
set -e

echo
echo "#################################################################"
echo "#######        Generating cryptographic material       ##########"
echo "#################################################################"
PROJPATH=$(pwd)
CLIPATH=$PROJPATH/cli/peers
ORDERERS=$CLIPATH/ordererOrganizations
PEERS=$CLIPATH/peerOrganizations

chmod +x $PROJPATH/cryptogen

rm -rf $CLIPATH
$PROJPATH/cryptogen generate --config=$PROJPATH/crypto-config.yaml --output=$CLIPATH

sh generate-cfgtx.sh

rm -rf $PROJPATH/{orderer,bankPeer,govtPeer,passportPeer,userPeer}/crypto
mkdir $PROJPATH/{orderer,bankPeer,govtPeer,passportPeer,userPeer}/crypto
cp -r $ORDERERS/orderer-org/orderers/orderer0/{msp,tls} $PROJPATH/orderer/crypto
cp -r $PEERS/bank-org/peers/bank-peer/{msp,tls} $PROJPATH/bankPeer/crypto
cp -r $PEERS/govt-org/peers/govt-peer/{msp,tls} $PROJPATH/govtPeer/crypto
cp -r $PEERS/passport-org/peers/passport-peer/{msp,tls} $PROJPATH/passportPeer/crypto
cp -r $PEERS/user-org/peers/user-peer/{msp,tls} $PROJPATH/userPeer/crypto
cp $CLIPATH/genesis.block $PROJPATH/orderer/crypto/

BANKCAPATH=$PROJPATH/bankCA
GOVTCAPATH=$PROJPATH/govtCA
PASSPORTCAPATH=$PROJPATH/passportCA
USERCAPATH=$PROJPATH/userCA

rm -rf {$BANKCAPATH,$GOVTCAPATH,$PASSPORTCAPATH,$USERCAPATH}/{ca,tls}
mkdir -p {$BANKCAPATH,$GOVTCAPATH,$PASSPORTCAPATH,$USERCAPATH}/{ca,tls}
cp $PEERS/bank-org/ca/* $BANKCAPATH/ca
cp $PEERS/bank-org/tlsca/* $BANKCAPATH/tls
mv $BANKCAPATH/ca/*_sk $BANKCAPATH/ca/key.pem
mv $BANKCAPATH/ca/*-cert.pem $BANKCAPATH/ca/cert.pem
mv $BANKCAPATH/tls/*_sk $BANKCAPATH/tls/key.pem
mv $BANKCAPATH/tls/*-cert.pem $BANKCAPATH/tls/cert.pem

cp $PEERS/govt-org/ca/* $GOVTCAPATH/ca
cp $PEERS/govt-org/tlsca/* $GOVTCAPATH/tls
mv $GOVTCAPATH/ca/*_sk $GOVTCAPATH/ca/key.pem
mv $GOVTCAPATH/ca/*-cert.pem $GOVTCAPATH/ca/cert.pem
mv $GOVTCAPATH/tls/*_sk $GOVTCAPATH/tls/key.pem
mv $GOVTCAPATH/tls/*-cert.pem $GOVTCAPATH/tls/cert.pem

cp $PEERS/passport-org/ca/* $PASSPORTCAPATH/ca
cp $PEERS/passport-org/tlsca/* $PASSPORTCAPATH/tls
mv $PASSPORTCAPATH/ca/*_sk $PASSPORTCAPATH/ca/key.pem
mv $PASSPORTCAPATH/ca/*-cert.pem $PASSPORTCAPATH/ca/cert.pem
mv $PASSPORTCAPATH/tls/*_sk $PASSPORTCAPATH/tls/key.pem
mv $PASSPORTCAPATH/tls/*-cert.pem $PASSPORTCAPATH/tls/cert.pem

cp $PEERS/user-org/ca/* $USERCAPATH/ca
cp $PEERS/user-org/tlsca/* $USERCAPATH/tls
mv $USERCAPATH/ca/*_sk $USERCAPATH/ca/key.pem
mv $USERCAPATH/ca/*-cert.pem $USERCAPATH/ca/cert.pem
mv $USERCAPATH/tls/*_sk $USERCAPATH/tls/key.pem
mv $USERCAPATH/tls/*-cert.pem $USERCAPATH/tls/cert.pem

WEBCERTS=$PROJPATH/web/certs
rm -rf $WEBCERTS
mkdir -p $WEBCERTS
cp $PROJPATH/orderer/crypto/tls/ca.crt $WEBCERTS/ordererOrg.pem
cp $PROJPATH/bankPeer/crypto/tls/ca.crt $WEBCERTS/bankOrg.pem
cp $PROJPATH/govtPeer/crypto/tls/ca.crt $WEBCERTS/govtOrg.pem
cp $PROJPATH/passportPeer/crypto/tls/ca.crt $WEBCERTS/passportOrg.pem
cp $PROJPATH/userPeer/crypto/tls/ca.crt $WEBCERTS/userOrg.pem
cp $PEERS/bank-org/users/Admin@bank-org/msp/keystore/* $WEBCERTS/Admin@bank-org-key.pem
cp $PEERS/bank-org/users/Admin@bank-org/msp/signcerts/* $WEBCERTS/
cp $PEERS/user-org/users/Admin@user-org/msp/keystore/* $WEBCERTS/Admin@user-org-key.pem
cp $PEERS/user-org/users/Admin@user-org/msp/signcerts/* $WEBCERTS/
cp $PEERS/govt-org/users/Admin@govt-org/msp/keystore/* $WEBCERTS/Admin@govt-org-key.pem
cp $PEERS/govt-org/users/Admin@govt-org/msp/signcerts/* $WEBCERTS/
cp $PEERS/passport-org/users/Admin@passport-org/msp/keystore/* $WEBCERTS/Admin@passport-org-key.pem
cp $PEERS/passport-org/users/Admin@passport-org/msp/signcerts/* $WEBCERTS/

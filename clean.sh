#!/bin/bash

docker rm -f $(docker ps -aq)
images=( web bank-peer orderer govt-peer passport-ca user-ca police-ca bank-ca passport-peer user-peer )
for i in "${images[@]}"
do
	echo Removing image : $i
  docker rmi -f $i
done

#docker rmi -f $(docker images | grep none)
images=( dev-repairuser-peer dev-govt-peer dev-bank-peer dev-shop-peer)
for i in "${images[@]}"
do
	echo Removing image : $i
  docker rmi -f $(docker images | grep $i )
done

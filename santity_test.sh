#! /usr/bin/env sh
echo on
set -e
echo "How much memory Erlang VM is using"
curl http://localhost:5565/_memory
sleep 1
clear
echo "Dump system stats of Erlang VM"
curl http://localhost:5565/_statistics
sleep 1
clear
echo "Dump the entire system statistics of the environment"
curl http://localhost:5565/_system
sleep 1

#! /usr/bin/env sh
echo on
set -e
echo "How much memory Erlang VM is using"
curl http://localhost:5565/_memory
sleep 1
clear
echo "Dump stats of Erlang VM"
curl http://localhost:5565/_statistics
sleep 1
clear
echo "Dump the entire system informatio of Erlang VM"
curl http://localhost:5565/_system
sleep 1

echo "REACHABLLE ERLANG NODE TEST: How much memory Erlang VM is using"
curl http://localhost:5565/_memory?node=folsom_webmachine@127.0.0.1
sleep 1
clear
echo "REACHABLLE ERLANG NODE TEST: Dump stats of Erlang VM"
curl http://localhost:5565/_statistics?node=folsom_webmachine@127.0.0.1
sleep 1
clear
echo "REACHABLLE ERLANG NODE TEST: Dump the entire system informatio of Erlang VM"
curl http://localhost:5565/_system?node=folsom_webmachine@127.0.0.1
sleep 1

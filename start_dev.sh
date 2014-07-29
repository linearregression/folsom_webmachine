#! /usr/bin/env sh
echo on
set -e 
# Added querying a reachable erlang node now. Erlang node named using longname format
export ERLANG_NODE=folsom_webmachine@127.0.0.1 

# make sure node not already running and node name unregistered
check_start()
{
    epmd -names 2>/dev/null | grep -q " ${ERLANG_NODE%@*} " && {
        ps ux | grep -v grep | grep -q " $ERLANG_NODE " && {
            echo "ERROR: The  node '$ERLANG_NODE' is already running."
            exit 4
        } || {
            ps ux | grep -v grep | grep -q beam && {
                echo "ERROR: The node '$ERLANG_NODE' is registered,"
                echo " but no related beam process has been found."
                echo "Shutdown all other erlang nodes, and call 'epmd -kill'."
                exit 5
            } || {
                epmd -kill >/dev/null
            }
        }
    }
    echo "There is no erlang node with name ${ERLANG_NODE} running"
}

check_start()
sleep 1
erl -pa ebin deps/*/ebin -name ${ERLANG_NODE} -s folsom_webmachine

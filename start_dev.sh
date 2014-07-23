#! /usr/bin/env sh
echo on
set -e


erl -pa ebin deps/*/ebin -sname folsom_webmachine -s folsom_webmachine

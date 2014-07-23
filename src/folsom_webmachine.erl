%%%
%%% Copyright 2014, y
%%%
%%% Licensed under the Apache License, Version 2.0 (the "License");
%%% you may not use this file except in compliance with the License.
%%% You may obtain a copy of the License at
%%%
%%%     http://www.apache.org/licenses/LICENSE-2.0
%%%
%%% Unless required by applicable law or agreed to in writing, software
%%% distributed under the License is distributed on an "AS IS" BASIS,
%%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%%% See the License for the specific language governing permissions and
%%% limitations under the License.
%%%

%%%-------------------------------------------------------------------
%%% File:      folsom_webmachine.erl
%%% @author    ed tsang 
%%% @doc       This is a wrapper module for folsom_webmaching so that 
%%%            it is easier for dev/ops/qa to start/stop server
%%%            especially when they are not familar with Erlang OTP framework
%%% @end
%%%------------------------------------------------------------------
-module (folsom_webmachine).
-export([start/0, stop/0]).

start() ->
    application:start(sasl),
    ssl:start(),
    inets:start(),
    application:start(crypto),
    application:start(inet),
    application:start(mochiweb),
    application:start(webmachine),
    ok = application:start(folsom),
    ok = application:start(folsom_webmachine).

stop()->
    application:stop(folsom_webmachine).


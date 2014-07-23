%%%
%%% Copyright 2011, Boundary
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
%%% File:      folsom_webmachine_app.erl
%%% @author    joe williams <j@boundary.com>
%%% @doc
%%% @end
%%%------------------------------------------------------------------

-module(folsom_webmachine_app).

-behaviour(application).

%% Application callbacks
-export([start/0, start/2, stop/1]).
-export([start_phase/3]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

% For erl listener
start()->
    start([], []).

% For boot
start(_StartType, _StartArgs) ->
    folsom_webmachine_sup:start_link().

start_phase(webmachine, _StartType, _PhaseArgs)->
    application:start(sasl),
    ssl:start(),
    inets:start(),
    application:start(crypto),
    application:start(inet),
    application:start(mochiweb),
    application:start(webmachine);

start_phase(folsom, _StartType, _PhaseArgs)->
    application:start(folsom).
    
stop(_State) ->
    ok.

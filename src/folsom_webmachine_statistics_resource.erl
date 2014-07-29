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
%%% File:      folsom_webmachine_statistics_resource.erl
%%% @author    joe williams <j@boundary.com>
%%% @doc
%%% http end point that converts erlang:statistics/1 to json
%%% @end
%%%------------------------------------------------------------------

-module(folsom_webmachine_statistics_resource).

-export([init/1, content_types_provided/2, to_json/2, allowed_methods/2]).

-include_lib("webmachine/include/webmachine.hrl").

init(_) -> {ok, undefined}.

content_types_provided(ReqData, Context) ->
    {[{"application/json", to_json}], ReqData, Context}.

allowed_methods(ReqData, Context) ->
    {['GET'], ReqData, Context}.

to_json(ReqData, Context) ->
    Node = get_node(ReqData), 
    Ret = folsom_vm_metrics:get_statistics(Node),
    {mochijson2:encode(folsom_vm_metrics:get_statistics(Node)), ReqData, Context}.

get_node(ReqData)->
    %This function contains newer OTP-R17 function   
    Node = wrq:get_qs_value("node", atom_to_list(node()),ReqData), 
    list_to_atom(Node).

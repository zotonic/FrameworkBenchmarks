%% @author Arjan Scherpenisse
%% @copyright 2013 Arjan Scherpenisse

%% @doc Webmachine controller implementing test 6: plain text

%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%% 
%%     http://www.apache.org/licenses/LICENSE-2.0
%% 
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(controller_techempower_test6).
-author("Arjan Scherpenisse").

-export([
    init/1,
    service_available/2,
    charsets_provided/2,
    content_types_provided/2,
    provide_content/2
]).

-include_lib("controller_webmachine_helper.hrl").
-include_lib("include/zotonic.hrl").


init(DispatchArgs) -> {ok, DispatchArgs}.

service_available(ReqData, DispatchArgs) when is_list(DispatchArgs) ->
    Context  = z_context:new(ReqData, ?MODULE),
    Context1 = z_context:set(DispatchArgs, Context),
    ?WM_REPLY(true, Context1).

charsets_provided(ReqData, Context) ->
    {[{"utf-8", fun(X) -> X end}], ReqData, Context}.

content_types_provided(ReqData, Context) ->
    {[{"text/plain", provide_content}], ReqData, Context}.


provide_content(ReqData, Context) ->
    Context1 = ?WM_REQ(ReqData, Context),
    {Output, OutputContext} = z_context:output(<<"Hello, World!">>, Context1),
    ?WM_REPLY(Output, OutputContext).

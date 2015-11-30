%% @author Arjan Scherpenisse
%% @copyright 2013 Arjan Scherpenisse

%% @doc Service call implementing test 3: Multiple database queries

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

-module(service_techempower_queries).
-author("Arjan Scherpenisse <arjan@scherpenisse.net>").

-svc_title("Test 3: Multiple database queries.").
-svc_needauth(false).

-export([process_get/2, get_n_queries/1]).

process_get(_ReqData, Context) ->
    %% We need to seed the random number generator in the request process
    random:seed(erlang:now()),

    NQueries = get_n_queries(Context),

    %% do N queries, get the results
    Rows = lists:map(
             fun(_) ->
                     {ok, Row} = m_techempower_test2:get_random(Context),
                     {struct, Row}
             end,
             lists:seq(1, NQueries)
            ),

    %% And return it
    {array, Rows}.


%% @doc Get and sanitize the 'queries' request parameter
get_n_queries(Context) ->
    try
        N = list_to_integer(z_context:get_q("queries", Context)),
        erlang:max(1, erlang:min(500, N))
    catch
        _:_ ->
            1
    end.    

%% @author Arjan Scherpenisse
%% @copyright 2013 Arjan Scherpenisse

%% @doc Model file implementing the database logic for test 2.

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

-module(m_techempower_test2).

-export([init/1, get_random/1, update_random/2]).
-include("zotonic.hrl").

-define(TABLE, world).
-define(N, 10000).

init(Context) ->
    case z_db:table_exists(?TABLE, Context) of
        true ->
            ok;
        false ->
            lager:warning("Initializing test 2 table..."),
            z_db:create_table(?TABLE, [
                        #column_def{name=id, type="integer", is_nullable=false, primary_key=true},
                        #column_def{name=randomNumber, type="integer", is_nullable=false}
                    ], Context),

            spawn_link(fun() ->
                               %% insert 10,000 rows
                               lists:foreach(
                                 fun(Id) ->
                                         z_db:insert(?TABLE, [{id, Id}, {randomNumber, random:uniform(?N)}], Context)
                                 end,
                                 lists:seq(1, ?N)
                                ),
                               lager:warning("done.")
                       end),
            ok
    end.

get_random(Context) ->
    Id = random:uniform(?N),
    z_db:select(?TABLE, Id, Context).

update_random(Row, Context) ->
    Id = proplists:get_value(id, Row),
    NewValue = random:uniform(?N),
    z_db:update(?TABLE, Id, [{randomNumber, NewValue}], Context),
    {ok,
     [{id, Id}, {randomNumber, NewValue}]}.


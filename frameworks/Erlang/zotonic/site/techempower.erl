%% @author Arjan Scherpenisse
%% @copyright 2013 Arjan Scherpenisse

%% @doc Zotonic site for the TechEmpower web framework benchmarks,
%% http://www.techempower.com/benchmarks/.

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

-module(techempower).
-author("Arjan Scherpenisse").

-mod_title("TechEmpower benchmark website").
-mod_description("Zotonic site for the TechEmpower web framework benchmarks.").
-mod_prio(10).

-include_lib("zotonic.hrl").

-export([init/1]).

%%====================================================================
%% support functions go here
%%====================================================================

init(Context) ->
    m_techempower_test2:init(Context),
    ok.

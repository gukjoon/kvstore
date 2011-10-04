
-module(kvstore_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    io:format("yay"),
    RestartStrategy = one_for_one,
    MaxRestarts = 1000,
    MaxSecondsBetweenRestarts = 3600,
    
    SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},
    
    Restart = permanent,
    Shutdown = 2000,
    Type = supervisor,
    
    WebSup = {kvstore_web_sup,
	      {kvstore_web_sup, start_link, []},
	      Restart,
	      Shutdown,
	      Type,
	      [kvstore_web_sup]},
    
    DictSup = {kvstore_dict_sup,
		 {kvstore_dict_sup, start_link,[]},
		 Restart,
		 Shutdown,
	         Type,
		 [kvstore_dict_sup]},
    io:format("yay2"),
    {ok, { SupFlags, [WebSup, DictSup]} }.

-module(kvstore_web_sup).
-behavior(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).


init([]) ->
    RestartStrategy = one_for_one,
    MaxRestarts = 1000,
    MaxSecondsBetweenRestarts = 3600,
    
    SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},
    
    Restart = permanent,
    Shutdown = 2000,
    Type = supervisor,
    
    Web = {kvstore_spooky,
	    {spooky, start_link, [kvstore_spooky]},
	    permanent, 5000, worker, dynamic},    
    
    {ok, { SupFlags, [Web]} }.



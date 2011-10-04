-module(kvstore).
-export([start/0, start_link/0, stop/0]).

start_link() ->
    kvstore_sup:start_link().

start()->
    application:start(spooky),
    application:start(kvstore).

stop()->
    Res = application:stop(kvstore),
    Res.

		    
    

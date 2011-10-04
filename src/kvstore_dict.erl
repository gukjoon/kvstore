-module(kvstore_dict).
-behavior(gen_server).

-export([start_link/0]).
-export([init/1, handle_call/3]).
-export([get/1,put/2]).


start_link()->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([])->
    {ok, dict:new()}.


get(Key)->
    gen_server:call(?MODULE,{get,Key}).

put(Key,Value)->
    gen_server:call(?MODULE,{put,Key,Value}).

handle_call({get,Key},_From,State)->
    KeyExists = dict:is_key(Key,State),
    if KeyExists == true ->
	    {reply, {success, dict:fetch(Key, State)}, State};
       true ->
	    {reply, {error, "Key does not exist"}, State}
    end;

handle_call({put, Key, Value}, _From, State)->
    {reply, {success, "Holler"}, dict:store(Key, Value, State)}.
    

-module(kvstore_spooky).
-behavior(spooky).

-export([init/1,get/2]).

init([])->
    [{port, 8000}].

get(Req, [])->
    Req:ok("Hello world.");
get(Req, [Key,Value])->
    kvstore_dict:put(Key,Value),
    Req:ok("Put " ++ Key ++ "|" ++ Value);
get(Req, [Key])->
    {success, Value} = kvstore_dict:get(Key),
    Req:ok("Get " ++ Key ++ ":" ++ Value).

module Tic exposing (..)

import Duration exposing (Duration, Interval(..))
import Time exposing (Time)


type alias Topic =
    String


type alias Tic =
    { amount : Duration
    , interval : Interval
    , topic : Topic
    , startTime : Time
    }


init : Interval -> Topic -> Tic
init interval topic =
    { amount = Duration.init interval
    , interval = interval
    , topic = topic
    , startTime = 0
    }


initRest : Tic
initRest =
    init Rest "rest"


initWork : Topic -> Tic
initWork topic =
    init Work topic


isWork : Tic -> Bool
isWork { interval } =
    interval == Work


withTime : Time -> Tic -> Tic
withTime t tic =
    { tic | startTime = t }


withTopic : Topic -> Tic -> Tic
withTopic topic tic =
    { tic | topic = topic }


next : List Tic -> Tic
next trail =
    case trail of
        [] ->
            -- This should be unreachable
            initWork "none"

        x :: xs ->
            initWork x.topic

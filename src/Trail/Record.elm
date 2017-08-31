module Trail.Record exposing (..)

-- import Date.Extra
-- import Time exposing (Time)

import Date exposing (Date)
import Duration exposing (Interval(..))
import Maybe.Extra


type alias Topic =
    String


type alias Record =
    { interval : Interval
    , topic : Topic
    , startDate : Maybe Date
    , endDate : Maybe Date
    }


init : Interval -> Topic -> Record
init interval topic =
    { interval = interval
    , topic = topic
    , startDate = Nothing
    , endDate = Nothing
    }


initRest : Record
initRest =
    init Rest "rest"


isRest : Record -> Bool
isRest { interval } =
    interval == Rest


initWork : Topic -> Record
initWork topic =
    init Work topic


isWork : Record -> Bool
isWork { interval } =
    interval == Work


{-| Returns the opposite record type of the given type.

    initWork "mystuff"
    |> opposite "mystuff"
    |> isRest

-}
opposite : Topic -> Record -> Record
opposite topic record =
    if isWork record then
        initRest
    else
        initWork topic


{-| Returns the next record according to the given trail of records
-}
next : List Record -> Record
next trail =
    case trail of
        [] ->
            -- This should be unreachable. Consider using a Result
            initRest

        _ :: [] ->
            initRest

        first :: second :: _ ->
            if isWork first then
                initRest
            else
                initWork second.topic


startWith : Date -> Record -> Record
startWith date record =
    { record | startDate = Just date }


endWith : Date -> Record -> Record
endWith date record =
    { record | endDate = Just date }


isDone : Record -> Bool
isDone { endDate } =
    Maybe.Extra.isJust endDate


withTopic : Topic -> Record -> Record
withTopic topic record =
    { record | topic = topic }

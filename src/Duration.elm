module Duration exposing (..)


type alias Duration =
    Int


type Interval
    = Work -- Chunk of work
    | Rest -- Rest between chunks of work
    | LongRest -- Rest every few chunks of work


init : Interval -> Duration
init interval =
    fromInterval interval


initWork : Duration
initWork =
    fromInterval Work


initRest : Duration
initRest =
    fromInterval Rest


fromInterval : Interval -> Duration
fromInterval interval =
    case interval of
        Work ->
            60 * 25

        Rest ->
            60 * 5

        LongRest ->
            60 * 15


subtract : Duration -> Maybe Duration
subtract amount =
    if amount == 0 then
        Nothing
    else
        Just (amount - 1)


format : Duration -> String
format amount =
    formatMinutes amount ++ ":" ++ formatSeconds amount


formatMinutes : Duration -> String
formatMinutes amount =
    formatDigit (amount // 60)


formatSeconds : Duration -> String
formatSeconds amount =
    formatDigit (amount % 60)


formatDigit : Int -> String
formatDigit x =
    String.padLeft 2 '0' (toString x)

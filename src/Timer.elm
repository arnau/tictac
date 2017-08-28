module Timer exposing (..)

import Duration exposing (Duration, Interval(..))


type alias Error =
    String


type Timer
    = Stopped Duration
    | Started Duration
    | Done


init : Interval -> Timer
init interval =
    Stopped (Duration.init interval)


initWork : Timer
initWork =
    init Work


initRest : Timer
initRest =
    init Rest


tick : Timer -> Timer
tick timer =
    case timer of
        Started amount ->
            fromAmount (Duration.subtract amount)

        _ ->
            timer


{-| Returns the next ticked timer or the provided default if it's a Done timer.

    tickWithDefault initWork (Started 0)  -- Started 1500
    tickWithDefault initWork (Started 2)  -- Started 1

-}
tickWithDefault : Timer -> Timer -> Timer
tickWithDefault default timer =
    let
        timer_ =
            tick timer
    in
    if isDone timer_ then
        default
    else
        timer_


fromAmount : Maybe Duration -> Timer
fromAmount maybeAmount =
    case maybeAmount of
        Nothing ->
            Done

        Just amount ->
            Started amount


isDone : Timer -> Bool
isDone timer =
    timer == Done


isRunning : Timer -> Bool
isRunning timer =
    case timer of
        Started _ ->
            True

        _ ->
            False


isStopped : Timer -> Bool
isStopped timer =
    case timer of
        Stopped _ ->
            True

        _ ->
            False


start : Timer -> Result Error Timer
start timer =
    case timer of
        Stopped amount ->
            Ok (Started amount)

        _ ->
            Err "You can't start anything that's not stopped"


stop : Timer -> Result Error Timer
stop timer =
    case timer of
        Started amount ->
            Ok (Stopped amount)

        Stopped _ ->
            Err "You can't stop what's not started"

        Done ->
            Err "You can't stop what's already done"


startOr : Timer -> Duration -> Timer -> Timer
startOr timer amount alt =
    Result.withDefault alt (start timer)


stopOr : Timer -> Timer -> Timer
stopOr timer alt =
    Result.withDefault alt (stop timer)


formatWithDefault : Duration -> Timer -> String
formatWithDefault default timer =
    case timer of
        Done ->
            Duration.format default

        Stopped amount ->
            Duration.format amount

        Started amount ->
            Duration.format amount

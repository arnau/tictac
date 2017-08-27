module World exposing (..)

import Task
import Tic exposing (Tic)
import Time exposing (Time, second)
import Timer exposing (Timer)


-- MODEL


type alias Model =
    { tic : Tic
    , trail : List Tic
    , timer : Timer
    }


init : ( Model, Cmd Msg )
init =
    ( { tic = Tic.initWork "elm"
      , trail = []
      , timer = Timer.initWork
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Tick Time
    | TicAddTopic String
    | TicStamp Time
    | TimerReset
    | TimerStart
    | TimerStop


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            ( updateTimer model, Cmd.none )

        TicAddTopic topic ->
            ( { model | tic = Tic.withTopic topic model.tic }, Cmd.none )

        TicStamp t ->
            ( { model | tic = Tic.withTime t model.tic }
            , Cmd.none
            )

        TimerStart ->
            ( { model | timer = Timer.startOr model.timer model.tic.amount Timer.initWork }
            , Task.perform TicStamp Time.now
            )

        TimerStop ->
            ( stopTimer model, Cmd.none )

        TimerReset ->
            ( { model | timer = Timer.initWork }, Cmd.none )


stopTimer : Model -> Model
stopTimer model =
    { model | timer = Timer.stopOr model.timer Timer.initWork }


updateTimer : Model -> Model
updateTimer model =
    if Timer.isRunning model.timer then
        let
            timer =
                Timer.tick model.timer
        in
            if Timer.isDone timer then
                updateDoneTimer model
            else
                { model | timer = timer }
    else
        model


updateDoneTimer : Model -> Model
updateDoneTimer model =
    if Tic.isWork model.tic then
        { model
            | timer = Timer.initRest
            , tic = Tic.initRest
            , trail = model.tic :: model.trail
        }
    else
        { model
            | timer = Timer.initWork
            , tic = Tic.next model.trail
            , trail = model.tic :: model.trail
        }

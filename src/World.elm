module World exposing (..)

import LocalStorage exposing (storeTopic)
import Notification exposing (Permission, notify, requestPermission)
import Task
import Tic exposing (Tic)
import Time exposing (Time, second)
import Timer exposing (Timer)


-- MODEL


type alias Flags =
    { topic : Maybe String }


type alias Model =
    { tic : Tic
    , trail : List Tic
    , timer : Timer
    , notifications : Permission
    }


init : Flags -> ( Model, Cmd Msg )
init { topic } =
    ( { tic = Maybe.withDefault "elm" topic |> Tic.initWork
      , trail = []
      , timer = Timer.initWork
      , notifications = Notification.denied
      }
    , requestPermission ""
    )



-- UPDATE


type Msg
    = Tick Time
    | TicAddTopic String
    | TicStamp Time
    | TimerReset
    | TimerStart
    | TimerStop
    | AllowNotifications String
    | RequestPermission


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RequestPermission ->
            ( model, requestPermission "" )

        AllowNotifications answer ->
            let
                perm =
                    Notification.toPermission answer
            in
            if Notification.isGranted perm then
                ( { model | notifications = perm }, Cmd.none )
            else
                ( model, Cmd.none )

        Tick _ ->
            updateTimer model

        TicAddTopic topic ->
            ( { model | tic = Tic.withTopic topic model.tic }, storeTopic topic )

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


updateTimer : Model -> ( Model, Cmd Msg )
updateTimer model =
    if Timer.isRunning model.timer then
        let
            timer =
                Timer.tick model.timer
        in
        if Timer.isDone timer then
            ( updateDoneTimer model, notify "Time is up" )
        else
            ( { model | timer = timer }, Cmd.none )
    else
        ( model, Cmd.none )


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

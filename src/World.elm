module World exposing (..)

import Date exposing (Date, second)
import Keyboard exposing (KeyCode)
import Keyring exposing (Mode)
import Keyring.Action exposing (Action(..))
import LocalStorage exposing (storeTopic)
import Notification exposing (Permission, notify, requestPermission)
import Task
import Time exposing (Time, second)
import Timer exposing (Timer)
import Trail.Record as Record exposing (Record)


-- MODEL


type alias Flags =
    { topic : Maybe String }


type alias Model =
    { record : Record
    , trail : List Record
    , timer : Timer
    , notifications : Permission
    , mode : Mode
    }


init : Flags -> ( Model, Cmd Msg )
init { topic } =
    let
        topic_ =
            Maybe.withDefault "elm" topic

        ( timer, record ) =
            Timer.initWork topic_
    in
    ( { record = record
      , trail = []
      , timer = timer
      , notifications = Notification.denied
      , mode = Keyring.normal
      }
    , requestPermission ""
    )



-- UPDATE


type Msg
    = Tick Time
    | RecordAddTopic String
    | RecordStampStart Date
    | RecordStampEnd Date
    | TimerReset
    | TimerStart
    | TimerStop
    | AllowNotifications String
    | RequestPermission
    | KeyIn KeyCode


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyIn code ->
            ( model
                |> updateModeFromCode code
                |> updateActionFromCode code
            , Cmd.none
            )

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

        RecordAddTopic topic ->
            ( updateTopic topic model, storeTopic topic )

        RecordStampStart date ->
            ( { model | record = Record.startWith date model.record }
            , Cmd.none
            )

        RecordStampEnd date ->
            ( { model | record = Record.endWith date model.record }
            , Cmd.none
            )

        TimerStart ->
            ( startTimer model
            , Task.perform RecordStampStart Date.now
            )

        TimerStop ->
            ( stopTimer model, Cmd.none )

        TimerReset ->
            ( updateDoneTimer model, Cmd.none )


updateTopic : String -> Model -> Model
updateTopic topic model =
    { model | record = Record.withTopic topic model.record }


startTimer : Model -> Model
startTimer model =
    { model | timer = Timer.startOr model.timer (Timer.init model.record.interval) }


stopTimer : Model -> Model
stopTimer model =
    { model | timer = Timer.stopOr model.timer (Timer.init model.record.interval) }


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
    let
        trail =
            model.record :: model.trail

        ( timer, record ) =
            Timer.next trail
    in
    { model
        | timer = timer
        , record = record
        , trail = trail
    }


updateModeFromCode : KeyCode -> Model -> Model
updateModeFromCode code model =
    code
        |> Keyring.toMode
        |> Maybe.map (updateMode model)
        |> Maybe.withDefault model


updateMode : Model -> Mode -> Model
updateMode model mode =
    { model | mode = mode }


updateActionFromCode : KeyCode -> Model -> Model
updateActionFromCode code model =
    code
        |> Keyring.toAction model.mode
        |> Maybe.map (updateAction model)
        |> Maybe.withDefault model


updateAction : Model -> Action -> Model
updateAction model action =
    case action of
        Reset ->
            updateDoneTimer model

        Start ->
            if Timer.isRunning model.timer then
                model
            else
                startTimer model

        Pause ->
            if Timer.isStopped model.timer then
                model
            else
                stopTimer model

        _ ->
            model

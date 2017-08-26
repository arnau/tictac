module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onWithOptions, targetValue)
import Json.Decode as Json
import StatsIcon
import Task
import Tic exposing (Tic)
import Time exposing (Time, second)
import Timer exposing (Timer)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



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



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every second Tick



-- VIEW


view : Model -> Html Msg
view model =
    let
        headerStyle =
            [ ( "height", "4vh" )
            , ( "padding", "0.4rem" )
            , ( "box-sizing", "border-box" )
            , ( "background-color", "black" )
            , ( "display", "flex" )
            , ( "flex-direction", "row" )
            , ( "justify-content", "space-between" )
            , ( "align-items", "stretch" )
            ]

        resetButton =
            [ ( "font-size", "1rem" )
            , ( "font-family", "'Roboto Condensed', sans-serif" )
            , ( "background-color", "black" )
            , ( "border", "1px solid #555" )
            , ( "border-radius", "3px" )
            , ( "color", "#999" )
            , ( "min-height", "3vh" )
            , ( "padding", "0 1rem" )
            ]
    in
    div []
        [ header [ style headerStyle ]
            [ StatsIcon.regular
            , topicView model.tic.topic
            , button [ onClick TimerReset, style resetButton ] [ text "Reset timer" ]
            ]
        , timerView model.timer model.tic
        ]


timerView : Timer -> Tic -> Html Msg
timerView state { topic, amount } =
    let
        clickAction =
            if Timer.isRunning state then
                TimerStop
            else
                TimerStart

        buttonStyle =
            [ ( "font-size", "10rem" )
            , ( "font-family", "'Roboto Condensed', sans-serif" )
            , ( "width", "100vw" )
            , ( "height", "96vh" )
            , ( "display", "block" )
            , ( "color"
              , if Timer.isRunning state then
                    "grey"
                else
                    "white"
              )
            , ( "background-color", "black" )
            , ( "border", "none" )
            , ( "outline", "none" )
            ]
    in
    button [ onClick clickAction, style buttonStyle ]
        [ text (Timer.formatWithDefault 0 state)
        ]


onInput : (String -> msg) -> Attribute msg
onInput msg =
    onWithOptions "input"
        { stopPropagation = True, preventDefault = True }
        (Json.map msg targetValue)


topicView : String -> Html Msg
topicView topic =
    let
        topicStyle =
            [ ( "font-size", "1.4rem" )
            , ( "font-family", "'Roboto Condensed', sans-serif" )
            , ( "color", "grey" )
            , ( "background-color", "black" )
            , ( "margin", "0 1rem" )
            , ( "padding", "0.8rem 0" )
            , ( "display", "block" )
            , ( "border", "none" )
            , ( "border-bottom", "1px solid #444" )
            , ( "width", "20vw" )
            ]
    in
    input
        [ type_ "text"
        , style topicStyle
        , placeholder "Topic"
        , onInput TicAddTopic
        , value topic
        ]
        []

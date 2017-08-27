module StatsIcon exposing (..)

import Svg exposing (..)
import Svg.Attributes exposing (..)


type alias Color =
    String


regular : Svg msg
regular =
    icon "#FFF"


active : Svg msg
active =
    icon "#7EA"


icon : Color -> Svg msg
icon color =
    svg
        [ width "20", height "20", viewBox "0 0 40 40" ]
        [ bar 0 40 20 color
        , bar 1 40 40 color
        , bar 2 40 30 color
        ]


bar : Int -> Int -> Int -> Color -> Svg msg
bar n total value color =
    let
        x_ =
            n * 15 |> toString

        y_ =
            total - value |> toString

        height_ =
            value |> toString
    in
        rect
            [ fill color
            , x x_
            , y y_
            , width "10"
            , height height_
            , rx "2"
            , ry "2"
            ]
            []

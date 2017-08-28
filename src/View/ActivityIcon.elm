module View.ActivityIcon exposing (..)

{-| This icon is a translation from "activity.svg" from <https://feathericons.com/>

Its original license is MIT <https://github.com/colebemis/feather/blob/master/LICENSE>

Thanks to Cole Bemis for the effort of making this nice icon set.

-}

import Svg exposing (..)
import Svg.Attributes exposing (..)


icon : String -> Svg msg
icon color =
    svg
        [ width "24"
        , height "24"
        , viewBox "0 0 24 24"
        , stroke color
        , strokeWidth "2"
        , fill "none"
        , strokeLinecap "round"
        , strokeLinejoin "round"
        ]
        [ Svg.title [] [ text "Activity" ]
        , polyline [ points "22 12 18 12 15 21 9 3 6 12 2 12" ] []
        ]

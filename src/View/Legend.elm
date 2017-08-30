module View.Legend exposing (..)

import Css exposing (..)
import Css.Elements exposing (..)
import Html exposing (Attribute, Html)
import Html.Attributes as At
import World exposing (Model, Msg(LegendToggle))


type Name
    = Legend


rule : Snippet
rule =
    class Legend
        [ backgroundColor (hex "000")
        , border3 (px 1) solid (hex "555")
        , borderRadius (px 3)
        , color (hex "999")
        , fontFamilies [ "Roboto Condensed", "sans-serif" ]
        , fontSize (Css.rem 1.2)
        , minHeight (vh 3)
        , padding2 zero (vh 4)
        , margin2 (vh 10) auto
        , width (pct 50)
        , children
            [ ul
                [ margin zero
                , padding zero
                , listStyleType none
                , children
                    [ li
                        [ displayFlex
                        , justifyContent spaceBetween
                        , margin3 zero zero (px 8)
                        , children
                            [ strong [ color (hex "FC0"), flex (int 1) ]
                            , span [ flex (int 8) ]
                            ]
                        ]
                    ]
                ]
            ]
        ]


node : Model -> Html Msg
node model =
    Html.div [ At.class (toString Legend) ]
        [ Html.h1 [] [ Html.text "Help" ]
        , Html.ul [] (List.map toItem model.help)
        ]


toItem : ( String, String ) -> Html Msg
toItem ( stroke, desc ) =
    Html.li []
        [ Html.strong [] [ Html.text stroke ]
        , Html.span [] [ Html.text desc ]
        ]

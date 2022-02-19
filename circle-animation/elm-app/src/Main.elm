module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { time : String
    , shape : Bool
    , color : Bool
    , colorToChange : String
    , shapeToChange : String
    , shapeToChangeWidth : String
    , shapeToChangeHeight : String
    , colors : List { name : String, hex : String }
    , shapes : List { name : String, width : String, height : String }
    }


init : Model
init =
    { time = "500"
    , shape = True
    , color = False
    , colorToChange = "#ff0000"
    , shapeToChange = "square"
    , shapeToChangeWidth = "100px"
    , shapeToChangeHeight = "100px"
    , colors =
        [ { name = "red", hex = "#ff0000" }
        , { name = "yellow", hex = "ffff00" }
        , { name = "pink", hex = "#ffc0cb" }
        , { name = "orange", hex = "#ffa500" }
        , { name = "purple", hex = "#800080" }
        , { name = "cyan", hex = "#00ffff" }
        , { name = "chocolate", hex = "#D2691E" }
        ]
    , shapes =
        [ { name = "small square", width = "50px", height = "50px" }
        , { name = "square", width = "100px", height = "100px" }
        , { name = "rectangle", width = "150px", height = "100px" }
        , { name = "elongated rectangle", width = "250px", height = "100px" }
        , { name = "vertical rectangle", width = "50px", height = "100px" }
        , { name = "full rectangle", width = "100%", height = "100px" }
        ]
    }



-- UPDATE


type Msg
    = ChangeTime String
    | ChangeShape
    | ChangeColor
    | Both
    | ShapeToChange String String String
    | ColorPickerChange String
    | ColorToChange String


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeTime newTime ->
            { model | time = newTime }

        ChangeShape ->
            { model | shape = True, color = False }

        ChangeColor ->
            { model | shape = False, color = True }

        Both ->
            { model | shape = True, color = True }

        ShapeToChange name width height ->
            { model | shapeToChange = name, shapeToChangeWidth = width, shapeToChangeHeight = height }

        ColorPickerChange color ->
            { model | colorToChange = color }

        ColorToChange hex ->
            { model | colorToChange = hex }



-- VIEW


view : Model -> Html Msg
view model =
    div [ id "container", style "--color-to-change" model.colorToChange ]
        [ div
            [ class "animated"
            , style "transition" (model.time ++ "ms ease")
            , style "--width-to-change" model.shapeToChangeWidth
            , style "--height-to-change" model.shapeToChangeHeight
            , class
                (if model.shape then
                    "shape"

                 else
                    ""
                )
            , class
                (if model.color then
                    "color"

                 else
                    ""
                )
            ]
            []
        , label [ for "time" ] [ text "Animation Time:" ]
        , div []
            [ input [ id "time", type_ "range", Html.Attributes.min "0", Html.Attributes.max "2000", step "10", value model.time, onInput ChangeTime ] []
            , input [ type_ "number", Html.Attributes.min "0", Html.Attributes.max "2000", step "10", value model.time, onInput ChangeTime ] []
            ]
        , div []
            [ button
                [ class
                    (if model.shape && not model.color then
                        "selected"

                     else
                        ""
                    )
                , onClick ChangeShape
                ]
                [ text "Change Shape" ]
            , button
                [ class
                    (if model.color && not model.shape then
                        "selected"

                     else
                        ""
                    )
                , onClick ChangeColor
                ]
                [ text "Change Color" ]
            , button
                [ class
                    (if model.shape && model.color then
                        "selected"

                     else
                        ""
                    )
                , onClick Both
                ]
                [ text "Both" ]
            ]
        , if not (not model.shape && model.color) then
            p [] [ text "Change to Shape" ]

          else
            text ""
        , if not (not model.shape && model.color) then
            div [ style "display" "flex", style "gap" "10px" ]
                (List.map
                    (\shape ->
                        button
                            [ class
                                (if shape.name == model.shapeToChange then
                                    "selected"

                                 else
                                    ""
                                )
                            , onClick (ShapeToChange shape.name shape.width shape.height)
                            ]
                            [ text shape.name ]
                    )
                    model.shapes
                )

          else
            text ""
        , if not (model.shape && not model.color) then
            p [] [ text "Change to Color" ]

          else
            text ""
        , if not (model.shape && not model.color) then
            div [ style "display" "flex", style "gap" "10px", style "align-items" "center" ]
                (List.map
                    (\color ->
                        button
                            [ class
                                (if color.hex == model.colorToChange then
                                    "selected"

                                 else
                                    ""
                                )
                            , onClick (ColorToChange color.hex)
                            ]
                            [ text color.name ]
                    )
                    model.colors
                    ++ [ input [ type_ "color", id "color-picker", value model.colorToChange, onInput ColorPickerChange ] [] ]
                )

          else
            text ""
        ]

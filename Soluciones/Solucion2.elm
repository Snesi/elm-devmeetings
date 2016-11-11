module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App

-- model
model = 0


-- update

type Msg 
    = Increment
    | Decrement
    | Reset


update msg model = 
    case msg of
        Increment ->
            model + 1
        Decrement ->
            model - 1
        Reset ->
            0
            

-- view

view model = 
    div []
        [ input [ value (toString model) ] []
        , button [ onClick Increment ] [ text "Suma 1" ]
        , button [ onClick Decrement ] [ text "Resta 1" ]
        , button [ onClick Reset ] [ text "Resetea" ]
        ]
        
        
main =
    App.beginnerProgram 
        { model = model
        , view = view
        , update = update 
        }
module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App

-- model
model = 0


-- update

type Msg 
    = Increment
    | Decrement


update msg model = 
    case msg of
        Increment ->
            model + 1
        Decrement ->
            model - 1
            

-- view

view model = 
    div []
        [ input [ value (toString model) ] []
        , button [] [ text "Suma 1" ]
        , button [] [ text "Resta 1" ]
        ]
        
        
main =
    App.beginnerProgram 
        { model = model
        , view = view
        , update = update 
        }
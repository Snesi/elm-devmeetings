module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App

-- model

type alias Model = Int

model : Model
model = 0


-- update

type Msg 
    = Increment
    | Decrement

update : Msg -> Model -> Model
update msg model = 
    case msg of
        Increment ->
            model + 1
        Decrement ->
            model - 1
            

-- view
view : Model -> Html a
view model = 
    div []
        [ input [ value (toString model) ] []
        , button [] [ text "Suma 1" ]
        , button [] [ text "Resta 1" ]
        ]
        
main : Program Never    
main =
    App.beginnerProgram 
        { model = model
        , view = view
        , update = update 
        }
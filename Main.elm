module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App


-- model
type alias Model = Int

initModel : Model
initModel = 0


-- update

type Msg = Something
    

update : Msg -> Model -> Model
update msg model =
    case msg of
        Something ->
            0


-- view

view : Model -> Html Msg
view model =
    div [ ][ text "Leaderboard goes here" ]


main : Program Never
main =
    App.beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }

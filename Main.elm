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
    div [ class "leaderboard" ]
        [ h2 []
            [ text "Nyan Cat Leaderboard" ]
        , ol [] 
            [ li []
                [ div [ class "ranking-number" ]
                    [ text "1" ]
                , div [ class "player-name" ]
                    [ text "David" ]
                , div [ class "score" ]
                    [ text "5000" ]
                ]
            ]
        , Html.form [ class "new-player" ]
            [ input
                [ name "player-name"
                , placeholder "Add player..."
                , type' "text"
                ]
                []
            , input
                [ name "score"
                , placeholder "Score"
                , type' "text"
                ]
                []
            , input [ class "btn-add", type' "submit", value "+" ]
                []
            ]
        ]


main : Program Never
main =
    App.beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }

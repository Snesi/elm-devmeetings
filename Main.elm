module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App
import String


-- model


type alias Model =
    { players : List Player
    , newPlayer : String
    , newScore : String
    , errorMessage : String
    , title : String
    }


type alias Player =
    { name : String
    , score : Int
    , id : Int
    }


initModel : Model
initModel =
    { players = 
        [ Player "David" 5000 1
        , Player "Gabi" 3000 2 
        ]
    , newPlayer = ""
    , newScore = ""
    , errorMessage = ""
    , title = "Nyan Cat Leaderboard (in seconds)"
    }



-- update


type Msg
    = InputScore String
    | InputPlayer String
    | AddPlayer
    | RemovePlayer Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        InputScore score ->
            { model | newScore = score }

        InputPlayer player ->
            { model | newPlayer = player }

        AddPlayer ->
            addPlayer model
            
        RemovePlayer id ->
            { model 
                | players = (List.filter (\p -> p.id /= id) model.players)
            }


addPlayer : Model -> Model
addPlayer model =
    case String.toInt model.newScore of
        Ok score ->
            let
                newPlayer =
                    Player model.newPlayer
                        score
                        (List.length model.players)
            in
                { model
                    | players = newPlayer :: model.players
                    , newScore = ""
                    , newPlayer = ""
                    , errorMessage = ""
                }

        Err err ->
            { model | errorMessage = "Please add a valid score." }



-- view


view : Model -> Html Msg
view model =
    div [ class "leaderboard" ]
        [ h2 []
            [ text model.title ]
        , playerList model
        , playerForm model
        ]


playerForm : Model -> Html Msg
playerForm model =
    Html.form [ action "#", class "new-player", onSubmit AddPlayer ]
        [ input
            [ name "player-name"
            , placeholder "Add player..."
            , type' "text"
            , onInput InputPlayer
            , value model.newPlayer
            ]
            []
        , input
            [ name "score"
            , placeholder "Score"
            , type' "text"
            , onInput InputScore
            , value model.newScore
            ]
            []
        , input [ class "btn-add", type' "submit", value "+" ]
            []
        ]


playerList : Model -> Html Msg
playerList model =
    model.players
        |> List.sortBy .score
        |> List.reverse
        |> List.indexedMap player
        |> ol []


player : Int -> Player -> Html Msg
player index player =
    li []
        [ div [ class "ranking-number" ]
            [ text (toString (index + 1)) ]
        , div [ class "player-name" ]
            [ text player.name ]
        , div [ class "score" ]
            [ text (toString player.score) ]
        , button [ class "btn-close", onClick (RemovePlayer player.id) ]
            [ i [ class "fa fa-times fa-2x" ] []
            ]
        ]


main : Program Never
main =
    App.beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }

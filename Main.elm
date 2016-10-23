port module Main exposing (..)

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
    , id : String
    }


initModel : Model
initModel =
    { players = []
    , newPlayer = ""
    , newScore = ""
    , errorMessage = ""
    , title = "Nyan Cat Leaderboard (in seconds)"
    }


init : (Model, Cmd Msg)
init =
    (initModel, Cmd.none)


-- update


type Msg
    = InputScore String
    | InputPlayer String
    | AddPlayer Player
    | SavePlayer


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        InputScore score ->
            ({ model | newScore = score }, Cmd.none)

        InputPlayer player ->
            ({ model | newPlayer = player }, Cmd.none)

        AddPlayer player ->
            ({ model 
                | players = player::model.players
                , newPlayer = ""
                , newScore = ""
                , errorMessage = ""
            }, Cmd.none)
            
        SavePlayer ->
            addPlayer model
            


addPlayer : Model -> (Model, Cmd Msg)
addPlayer model =
    case String.toInt model.newScore of
        Ok score ->
            let
                newScore = { name = model.newPlayer, score = score }
            in 
                (model, addScore newScore)

        Err err ->
            ({ model | errorMessage = "Please add a valid score." }, Cmd.none)



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
    Html.form [ action "#", class "new-player", onSubmit SavePlayer ]
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
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch 
        [ newScore AddPlayer ]
        
        
port addScore : {name: String, score: Int} -> Cmd msg
port newScore : (Player -> msg) -> Sub msg


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

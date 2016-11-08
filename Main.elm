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
    , inEditMode: Bool
    , newName : String
    , newScore : String
    }


initModel : Model
initModel =
    { players = 
        [ Player "David" 5000 1 False "" ""
        , Player "Gabi" 3000 2 False "" ""
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
    | EditPlayer Int
    | InputNewPlayer Int String
    | InputNewScore Int String
    | UpdatePlayer Int
    | CancelEdit Int
    


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
                | players = List.filter (\p -> p.id /= id) model.players
            }
            
        EditPlayer id ->
            { model 
                | players = List.map 
                                (\p -> 
                                    if p.id /= id then 
                                        p 
                                    else 
                                        { p 
                                            | inEditMode=True
                                            , newName = p.name
                                            , newScore = toString p.score 
                                            
                                        }) model.players
            }
            
        InputNewPlayer id newName ->
            { model 
                | players = List.map (\p -> if p.id /= id then p else { p | newName=newName }) model.players
            }
        
        InputNewScore id newScore ->
            { model 
                | players = List.map (\p -> if p.id /= id then p else { p | newScore=newScore }) model.players
            }
            
        UpdatePlayer id ->
            { model 
                | players = List.map (updatePlayer id) model.players
            }
            
        CancelEdit id ->
            { model 
                | players = List.map (\p -> if p.id /= id then p else { p | inEditMode=False }) model.players
            }

addPlayer : Model -> Model
addPlayer model =
    case String.toInt model.newScore of
        Ok score ->
            let
                newPlayer =
                    Player 
                        model.newPlayer
                        score
                        (List.length model.players)
                        False
                        ""
                        ""
            in
                { model
                    | players = newPlayer :: model.players
                    , newScore = ""
                    , newPlayer = ""
                    , errorMessage = ""
                }

        Err err ->
            { model | errorMessage = "Please add a valid score." }


updatePlayer : Int -> Player -> Player
updatePlayer id player =
    if player.id /= id then 
        player
    else 
        { player 
            | name = player.newName
            , score = Result.withDefault 0 (String.toInt player.newScore)
            , newName = ""
            , newScore = ""
            , inEditMode = False
        }


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
    if player.inEditMode then
        editablePlayerRow index player
    else 
        normalPlayerRow index player        


editablePlayerRow : Int -> Player -> Html Msg
editablePlayerRow index player = 
    li []
        [ div [ class "ranking-number" ]
            [ text (toString (index + 1)) ]
        , input 
            [ value player.newName 
            , onInput (InputNewPlayer player.id)
            ][]
        , input 
            [ value player.newScore
            , onInput (InputNewScore player.id)
            ][]
        , button [ class "btn-cancel", onClick (CancelEdit player.id) ]
            [ i [ class "fa fa-times" ] []
            ]
        , button [ class "btn-save", onClick (UpdatePlayer player.id) ]
            [ i [ class "fa fa-check" ] []
            ]
        ]


normalPlayerRow : Int -> Player -> Html Msg
normalPlayerRow index player = 
    li [ onClick (EditPlayer player.id) ]
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

import Html
import String

threeTimes string =
    string ++ string ++ string
    

-- En Elm al igual que en muchos lenguajes funcionales
-- no tiene loops, así que dependes de la recursividad
nTimes n string = 
    if n == 1 then
        string
    else
        string ++ (nTimes (n-1) string)


grabFirstLetter string =
    let
        result = string
            |> String.toList
            |> List.head
    in
        case result of
            Just letter -> String.fromChar letter
            Nothing -> ""


initials name =
    name
        |> String.split " "
        |> List.map grabFirstLetter
    

initialsToString initials = 
    String.join "" initials
    

randomnes = ["éle", "ucha", "rasa", "eñor"]
    

initialsToRandomnes initials' = 
    randomnes
        |> List.map2 (++) initials'
        |> String.join " "


main = 
    "David Miguel González Shannon"
        |> initials
        |> initialsToRandomnes
        |> Html.text
# Elm Workshop

![Leaderboard in action](http://g.recordit.co/DnsFbL8TzX.gif "Leaderboard in action")

This project was designed to teach the basics about Elm.

Pre-requesits:

- elm 
- node & npm

Steps to get started():

1. `npm install`
2. `elm-package install`
3. `npm start` (Compiles the elm project, starts watch and runs a simple dev server with gulp)



## DevMeeting Information

### Elm for frontend developers

#### Who is this workshop for? 

Someone who...

- Is familiar with js, html and css
- Has never used Elm before
- Has little to no knowledge of functional programming

#### Workshop Goals

By the end of the workshop they should be able to program small interactive components for any website. This way they can slowly introduce Elm in their day to day work.

They should be able to make small apps with `Html.beginnerProgram`.

List of features:

- Elm package manager
- Elm build process
- Elm syntax
- Elm Architecture
- Elm types
- Elm Html module
- Elm Html.Attributes module
- Elm Html.Events module
- Elm List operations like map, filter, reverse...
- Elm Ports for JS interop

#### The App

During the workshop the students will develop a very basic leaderboard.

The leaderboard can be used for ranking anything but it needs to be sorted in descending order and have two inputs to add a new player score.

#### Sprints

1. Elm Hello World
2. Basic Elm Architecture example
3. Leaderboard layout
4. Input new players
5. Sort leaderboard
6. Store/Read ranking in firebase

#### 1. Elm Hello World

- [ ] Install Elm
- [ ] Install Elm plugins for student's editors
- [ ] Setup Elm project 
- [ ] Checkout Elm docs
- [ ] Use Html.text to output "Hello World"
- [ ] Elm functions, infix funtions, composition, forward and backward function application
- [ ] Local "variables"

#### 2. Basic Elm Architecture

- [ ] Write a model, view and update section and use beginnerProgram
- [ ] Create a simple counter with an Increase and a Decrease button

#### 3. Leaderboard layout

- [ ] Create leaderboard layout in Elm html
- [ ] Write user actions in the app (Type Msg)
- [ ] Write app model

#### 4. Input new players

- [ ] Add events to inputs
- [ ] Add new players to the model
- [ ] Check if score is a number
- [ ] Add a remove button to each score (Additional)

#### 5. Store/Read ranking in firebase

- [ ] Add ports for reading/adding players to firebase
- [ ] Subscribe to events
- [ ] Add new input for user's github account and display each user's profile image in leaderboard. (Extra)

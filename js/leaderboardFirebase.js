/* global firebase */

// File copied from Elm Beyond the Basics 
// http://courses.knowthen.com/p/elm-beyond-the-basics
'use strict';
// Initialize Firebase
// config comes from fbConfig.js
var app = firebase.initializeApp(config);
var database = app.database();
var SCOREREFPATH = "scores"

function addScore(score){
  var promise = database
    .ref(SCOREREFPATH)
    .push(score);
  return promise;
}

function updateScore(score){
  var id = score.id;
  var promise = database
    .ref(SCOREREFPATH + "/" + id)
    .set(score);
  return promise;
}

function deleteScore(score){
  var id = score.id;
  var promise = database
    .ref(SCOREREFPATH + "/" + id)
    .remove();
  return promise;
}

function scoreListener(){
  return database.ref(SCOREREFPATH);
}

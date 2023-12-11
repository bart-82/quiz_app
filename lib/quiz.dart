
//main widget that manages the entire quiz, it's a stateful widget

import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';
import 'package:quiz_app/start_screen.dart';


class Quiz extends StatefulWidget {
const Quiz({super.key});

  @override
State<Quiz> createState(){
  return _QuizState();
}
}

//con l'underscore si intende una classe privata che può essere usata solamente all'interno di questo file
class _QuizState extends State<Quiz> {
 List<String> selectedAnswers=[];
var activeScreen='start-screen';
//?sta ad indicare che activeScreen can also be null
//Widget? activeScreen;//creo una variabile di tipo Widget, che poi viene riassegnata nella funzione SwitchScreen
//se passo il nome della funzione switchScreen dentro al costruttore di StartScreen, gli sto dicendo a cosa puntere,
//se invece avessi messo swithScreen() con le parentesi allora il metodo sarebbe subito eseguito ma è troppo presto
//perchè il metodo deve partire al click sul bottone Start Quiz

// @override
//   void initState() {//dobbiamo usare questa perchè sarà eseguita prima di build
//     activeScreen=  StartScreen(switchScreen);
//     super.initState();
//   }

void switchScreen(){

  //quando si invoca questo metodo, la funzione build viene eseguita di nuovo - Render Screen Conditionally
setState(() {
  activeScreen=  'questions-screen';
});

}

void chooseAnswer(String answer){
  selectedAnswers.add(answer);
 
 if(selectedAnswers.length==questions.length){
  setState(() {
    
    (activeScreen='results-screen');
  });
 }
}

void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

 @override
  Widget build( context) {
    Widget screenWidget= StartScreen(switchScreen);

    if(activeScreen=='questions-screen'){
      screenWidget=QuestionsScreen(onSelectAnswer: chooseAnswer,);
    }

    if(activeScreen == 'results-screen'){
      screenWidget = ResultsScreen(chosenAnswers: selectedAnswers,onRestart: restartQuiz,);
    }


    return 
     MaterialApp(
      home: Scaffold(
        body: Container(
          decoration:const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 92, 10, 187),
                Color.fromARGB(255, 131, 10, 187)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
            ),
            ),
          child:screenWidget,),
      ),
    );
  }
}
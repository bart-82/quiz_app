import 'package:flutter/material.dart';
import 'package:quiz_app/answere_button.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key,required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswers) {
    widget.onSelectAnswer(selectedAnswers);//questa è una proprietà di State che ci permette di usare la funzione onSelectAnswer che appartiene ad un'altra classe
//currentQuestionIndex=currentQuestionIndex +1; //oppure
//currentQuestionIndex +=1;// oppure
//currentQuestionIndex++;
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment
              .stretch, //i componenti contenuti in questa colonna prenderanno tutta la sua larghezza
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
                height:
                    30), //shaffle() serve per modificare l'ordine della lista, ma a differenza di map modifica anche la lista originale.Qindi dentro question è stato creato un modo alternativo chiamato getShuffledAnswers
            ...currentQuestion.getShuffledAnsweres().map((answer) {
              //children sopra vuole una lista di Widget, mentre qui abbiamo un'altra lista, con i tre pintii(spread operator) convertiamo questa lista in un oggetto Widget
              return AnswerButton(
                answer,
               (){answerQuestion(answer);} ,
              );
            })
          ],
        ),
      ),
    );
  }
}

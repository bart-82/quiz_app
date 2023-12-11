import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key,required this.chosenAnswers,required this.onRestart});

  final void Function() onRestart;
  final List<String> chosenAnswers;

List<Map<String,Object>> getSummaryData(){//Maps are collections of kay/value pairs, pass the mouse on MAp word. Nel nostro caso key sarà una stringa e value sarà un oggetto.
//Object is a flexible value that allows all kinds of values

final List<Map<String,Object>> summery = [];

for (var i = 0; i < chosenAnswers.length; i++){
  summery.add({//stiamo creando un Map
    'question_index': i,
    'question' : questions[i].text,
    'correct_answer': questions[i].answers[0],//the first answer is always right=[0]
    'user_answer' : chosenAnswers[i]
  },);

  
}

return summery;

}

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestins = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];  //filtro solo le risposte uguali a quelle corrette e ottengo una lista 
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text('You answered $numCorrectQuestions out of $numTotalQuestins questions correctly!',),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: onRestart,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Restart Quiz!'),
            )
          ],
        ),
      ),
    );
  }
}
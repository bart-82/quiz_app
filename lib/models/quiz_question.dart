class QuizQuestion {
  const QuizQuestion(this.text,this.answers);

  final String text;
  final List<String> answers;

  List<String> getShuffledAnsweres(){
    final shuffledList= List.of(answers);//con of creiamo una nuova lista che possiamo modificare attraverso shaffle senza intaccare la lista originale
    shuffledList.shuffle();
    return shuffledList;
  }
}
import 'package:conditional_questions/conditional_questions.dart';

class QuestionnairePage extends StatefulWidget {
  QuestionnairePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<QuestionnairePage> {
  final _key = GlobalKey<QuestionFormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire'),
      ),


      body: ConditionalQuestions(
        key: _key,
        children: questions(),
        trailing: [
          MaterialButton(
            color: Colors.deepOrange,
            splashColor: Colors.orangeAccent,
            onPressed: () async {
              if (_key.currentState!.validate()) {
                print("validated!");
              }
            },
            child: Text("Submit"),
          )
        ],
      ),
    );
  }
}
List<Question> questions() {
  return [
    Question(
      question: "What is your name?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Field cannot be empty";
        return null;
      },
    ),
    PolarQuestion(
        question: "Do you suffer from hair loss?"
            "هل تعاني من فقدان سقوط الشعر؟",
        answers: ["None لا","Mid متوسط","Severe حاد"],
        isMandatory: true),
    PolarQuestion(
        question: "Do you suffer from loss of appetite?"
            "هل تعاني من فقدان الشهية؟",
        answers: ["None لا","Mid متوسط","Severe حاد"]),
    PolarQuestion(
        question: "Do you suffer from diarrhea?"
            "هل تعاني من الاسهال؟",
        answers: ["None لا","Mid متوسط","Severe حاد"]),
    PolarQuestion(
        question: "Do you suffer from vomiting?"
            "هل تعاني من القئ؟",
        answers: ["None لا","Mid متوسط","Severe حاد"]),
    PolarQuestion(
        question: "Do you suffer from weight loss?"
            "هل تعاني من فقدان الوزن؟",
        answers: ["None لا","Mid متوسط","Severe حاد"]),
    PolarQuestion(
        question: "Do you suffer from changes in the nails and skin?"
            "هل تعاني من تغيرات في الأظافر والجلد؟",
        answers: ["None لا","Mid متوسط","Severe حاد"]),
    PolarQuestion(
        question: "Do you suffer from changes in ulcers in the mouth?"
            "هل تعاني من تغيرات تقرحات في الفم؟",
        answers: ["None لا","Mid متوسط","Severe حاد"]),
    PolarQuestion(
        question: "Do you suffer from vaginal dryness?"
            "هل تعاني من جفاف مهبلي؟",
        answers: ["None لا","Mid متوسط","Severe حاد"]),
    PolarQuestion(
        question: "Do you suffer from poor memory?"
            "هل تعاني من ضعف في الذاكرة؟",
        answers: ["None لا","Mid متوسط","Severe حاد"]),
    PolarQuestion(
        question: "Do you suffer from anemia?"
            "هل تعاني من فقر الدم؟",
        answers: ["None لا","Mid متوسط","Severe حاد"]),
    Question(
      question: "Comments",
    ),

  ];
}



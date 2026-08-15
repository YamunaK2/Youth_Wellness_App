import 'package:flutter/material.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {

  int selectedMood = 3;

  final List<Map<String, dynamic>> moods = [

    {
      "emoji":"😡",
      "text":"Very Bad",
      "color":Colors.red,
    },

    {
      "emoji":"😞",
      "text":"Bad",
      "color":Colors.orange,
    },

    {
      "emoji":"😐",
      "text":"Okay",
      "color":Colors.amber,
    },

    {
      "emoji":"😊",
      "text":"Good",
      "color":Colors.green,
    },

    {
      "emoji":"😁",
      "text":"Great",
      "color":Colors.teal,
    },

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF4F7F6),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Mood Tracker",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(

              "How are you feeling today?",

              style: TextStyle(

                fontSize: 24,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 8),

            const Text(

              "Tap your current mood",

              style: TextStyle(

                color: Colors.grey,

              ),

            ),

            const SizedBox(height: 25),

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: List.generate(

                moods.length,

                (index){

                  bool selected=index==selectedMood;

                  return GestureDetector(

                    onTap:(){

                      setState(() {

                        selectedMood=index;

                      });

                    },

                    child: Column(

                      children:[

                        AnimatedContainer(

                          duration: const Duration(milliseconds:300),

                          width: selected?70:60,

                          height:selected?70:60,

                          decoration: BoxDecoration(

                            color: moods[index]["color"].withOpacity(.15),

                            shape: BoxShape.circle,

                            border:selected
                                ?Border.all(
                                color:moods[index]["color"],
                                width:3)
                                :null,

                          ),

                          child: Center(

                            child: Text(

                              moods[index]["emoji"],

                              style: TextStyle(

                                fontSize:selected?34:28,

                              ),

                            ),

                          ),

                        ),

                        const SizedBox(height:8),

                        Text(

                          moods[index]["text"],

                          style: const TextStyle(

                            fontSize:11,

                          ),

                        ),

                      ],

                    ),

                  );

                },

              ),

            ),

            const SizedBox(height:35),

            Card(

              shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.circular(20),

              ),

              child: Padding(

                padding: const EdgeInsets.all(20),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: const [

                    Text(

                      "Weekly Mood",

                      style: TextStyle(

                        fontSize:20,

                        fontWeight: FontWeight.bold,

                      ),

                    ),

                    SizedBox(height:20),

                    LinearProgressIndicator(

                      value:.80,

                      minHeight:10,

                    ),

                    SizedBox(height:10),

                    Text("😊 Positive Days : 80%"),

                  ],

                ),

              ),

            ),

            const SizedBox(height:20),

            Card(

              shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.circular(20),

              ),

              child: Padding(

                padding: const EdgeInsets.all(20),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children:[

                    const Text(

                      "Today's Wellness Tip",

                      style: TextStyle(

                        fontWeight: FontWeight.bold,

                        fontSize:18,

                      ),

                    ),

                    const SizedBox(height:15),

                    Text(

                      selectedMood>=3

                          ?"Keep doing what makes you happy! 🌿"

                          :"Take a short walk, breathe deeply, and talk with someone you trust 💚",

                      style: const TextStyle(

                        fontSize:15,

                      ),

                    ),

                  ],

                ),

              ),

            ),

            const SizedBox(height:20),

            SizedBox(

              width: double.infinity,

              height:55,

              child: ElevatedButton(

                style: ElevatedButton.styleFrom(

                  backgroundColor: const Color(0xff00897B),

                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(30),

                  ),

                ),

                onPressed:(){

                  ScaffoldMessenger.of(context).showSnackBar(

                    const SnackBar(

                      content: Text("Mood Saved Successfully"),

                    ),

                  );

                },

                child: const Text(

                  "Save Mood",

                  style: TextStyle(

                    fontSize:18,

                  ),

                ),

              ),

            )

          ],

        ),

      ),

    );

  }

}
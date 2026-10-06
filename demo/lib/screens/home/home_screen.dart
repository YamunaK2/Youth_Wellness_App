import 'package:flutter/material.dart';
import 'package:demo/screens/drawing/drawing_screen.dart';
import '../../widgets/service_card.dart';
import 'package:demo/screens/appointment/booking_screen.dart';
import 'package:demo/screens/chatbot/chatbot_screen.dart';
import 'package:demo/screens/mood/mood_screen.dart';
import 'package:demo/screens/journal/journal_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F7F6),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Youth Wellness",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18),
            child: CircleAvatar(
              backgroundColor: Color(0xff00897B),
              child: Text(
                "Y",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Welcome Yamuna 👋",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "How are you feeling today?",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            // AI CHAT CARD
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff00897B),
                    Color(0xff00695C),
                  ],
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Need Someone to Talk?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Our AI Wellness Companion is available 24/7.",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChatbotScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      "Start AI Chat",
                      style: TextStyle(
                        color: Color(0xff00897B),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Quick Services",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,

              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,

              childAspectRatio: 1.1,

              children: [

                // AI CHAT
                ServiceCard(
                  title: "AI Chat",
                  icon: Icons.chat,
                  color: Colors.teal,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ChatbotScreen(),
                      ),
                    );
                  },
                ),

                // MOOD
                ServiceCard(
                  title: "Mood Tracker",
                  icon: Icons.mood,
                  color: Colors.orange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MoodScreen(),
                      ),
                    );
                  },
                ),

                // JOURNAL
                ServiceCard(
                  title: "Journal",
                  icon: Icons.menu_book,
                  color: Colors.purple,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const JournalScreen(),
                      ),
                    );
                  },
                ),

                // PODCAST
                const ServiceCard(
                  title: "Podcast",
                  icon: Icons.podcasts,
                  color: Colors.blue,
                ),

                // MUSIC
                const ServiceCard(
                  title: "Music",
                  icon: Icons.music_note,
                  color: Colors.green,
                ),

                // DRAWING
                ServiceCard(
  title: "Drawing",
  icon: Icons.palette,
  color: Colors.red,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const DrawingScreen(),
      ),
    );
  },
),

                // WRITING
                const ServiceCard(
                  title: "Writing",
                  icon: Icons.edit,
                  color: Colors.deepOrange,
                ),

                // PSYCHOLOGIST
                ServiceCard(
                  title: "Psychologist",
                  icon: Icons.psychology,
                  color: Colors.indigo,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BookingScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),

            // DAILY TIP
            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "💡 Daily Wellness Tip",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Take a 5-minute break every hour. "
                    "Stretch, breathe deeply, and relax your mind.",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
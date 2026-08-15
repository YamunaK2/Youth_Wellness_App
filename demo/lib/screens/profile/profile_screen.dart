import 'package:flutter/material.dart';
import '../../widgets/profile_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F7F6),

      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            /// Profile Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [

                    const CircleAvatar(
                      radius: 45,
                      backgroundColor: Color(0xff00897B),
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "Yamuna K",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      "Student Member",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: const Text(
                        "🎓 Youth Wellness Member",
                        style: TextStyle(
                          color: Color(0xff00897B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// Statistics
            Row(
              children: [

                Expanded(
                  child: _buildStatCard(
                    "🔥",
                    "12",
                    "Streak",
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _buildStatCard(
                    "📖",
                    "18",
                    "Journal",
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _buildStatCard(
                    "😊",
                    "82%",
                    "Mood",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            ProfileTile(
              icon: Icons.person_outline,
              title: "Personal Details",
              onTap: () {},
            ),

            ProfileTile(
              icon: Icons.notifications_none,
              title: "Notifications",
              onTap: () {},
            ),

            ProfileTile(
              icon: Icons.lock_outline,
              title: "Privacy",
              onTap: () {},
            ),

            ProfileTile(
              icon: Icons.dark_mode_outlined,
              title: "Dark Mode",
              onTap: () {},
            ),

            ProfileTile(
              icon: Icons.info_outline,
              title: "About App",
              onTap: () {},
            ),

            ProfileTile(
              icon: Icons.logout,
              title: "Logout",
              onTap: () {},
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String emoji,
      String number,
      String title,
      ) {

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),

        child: Column(
          children: [

            Text(
              emoji,
              style: const TextStyle(fontSize: 28),
            ),

            const SizedBox(height: 8),

            Text(
              number,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
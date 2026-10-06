import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int selectedPsychologist = 0;
  DateTime? selectedDate;
  String? selectedTime;

  final List<Map<String, dynamic>> psychologists = [
    {
      "name": "Dr. Ananya Sharma",
      "specialization": "Youth & Anxiety Specialist",
      "experience": "8 years experience",
      "rating": "4.9",
      "icon": Icons.person,
    },
    {
      "name": "Dr. Rahul Mehta",
      "specialization": "Stress & Wellness Counselor",
      "experience": "6 years experience",
      "rating": "4.8",
      "icon": Icons.person,
    },
    {
      "name": "Dr. Priya Nair",
      "specialization": "Teen & Young Adult Counselor",
      "experience": "7 years experience",
      "rating": "4.9",
      "icon": Icons.person,
    },
  ];

  final List<String> timeSlots = [
    "10:00 AM",
    "11:30 AM",
    "2:00 PM",
    "3:30 PM",
    "5:00 PM",
    "6:30 PM",
  ];

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void bookSession() {
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please select a date and time for your session.",
          ),
        ),
      );
      return;
    }

    final psychologist =
        psychologists[selectedPsychologist]["name"];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Color(0xff00897B),
              ),
              SizedBox(width: 10),
              Text("Session Booked"),
            ],
          ),
          content: Text(
            "Your session with $psychologist has been booked.\n\n"
            "Date: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}\n"
            "Time: $selectedTime\n\n"
            "Your Google Meet link will be available here once the appointment is confirmed.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Done",
                style: TextStyle(
                  color: Color(0xff00897B),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5FAF9),

      appBar: AppBar(
        backgroundColor: const Color(0xffF5FAF9),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Book a Psychologist",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Header card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff00897B),
                    Color(0xff26A69A),
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.video_call,
                      size: 32,
                      color: Color(0xff00897B),
                    ),
                  ),

                  SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Talk to a Professional 💚",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          "Connect privately through Google Meet.",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Choose a Psychologist",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Psychologist cards
            ListView.builder(
              itemCount: psychologists.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final psychologist = psychologists[index];

                final bool selected =
                    selectedPsychologist == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPsychologist = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: selected
                            ? const Color(0xff00897B)
                            : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [

                        CircleAvatar(
                          radius: 28,
                          backgroundColor:
                              const Color(0xffE0F2F1),
                          child: Icon(
                            psychologist["icon"],
                            color: const Color(0xff00897B),
                            size: 30,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                psychologist["name"],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                psychologist["specialization"],
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                "${psychologist["experience"]} • ⭐ ${psychologist["rating"]}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Icon(
                          selected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: selected
                              ? const Color(0xff00897B)
                              : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            const Text(
              "Select Date",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            GestureDetector(
              onTap: selectDate,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: Color(0xff00897B),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Text(
                        selectedDate == null
                            ? "Choose a date"
                            : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                        style: TextStyle(
                          fontSize: 15,
                          color: selectedDate == null
                              ? Colors.grey
                              : Colors.black87,
                        ),
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Select Time",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: timeSlots.map((time) {
                final bool selected =
                    selectedTime == time;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTime = time;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xff00897B)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: selected
                            ? const Color(0xff00897B)
                            : Colors.grey.shade200,
                      ),
                    ),
                    child: Text(
                      time,
                      style: TextStyle(
                        color: selected
                            ? Colors.white
                            : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            // Google Meet information
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xffE8F5E9),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.video_camera_front,
                    color: Color(0xff00897B),
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      "Your session will be conducted privately through Google Meet.",
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: bookSession,
                icon: const Icon(Icons.calendar_month),
                label: const Text(
                  "Book Session",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff00897B),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
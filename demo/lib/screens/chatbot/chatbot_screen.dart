import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  static const String _configuredBackendUrl =
      String.fromEnvironment('CHAT_API_BASE_URL');

  final TextEditingController messageController =
      TextEditingController();

  final ScrollController scrollController =
      ScrollController();

  final List<Map<String, dynamic>> messages = [
    {
      "message":
          "Hi! 👋 I'm your Youth Wellness Companion. How are you feeling today?",
      "isUser": false,
    },
  ];

  bool isLoading = false;

  // Backend URL
  String get backendUrl {
    if (_configuredBackendUrl.isNotEmpty) {
      return _configuredBackendUrl.endsWith('/')
          ? _configuredBackendUrl.substring(
              0,
              _configuredBackendUrl.length - 1,
            )
          : _configuredBackendUrl;
    }

    if (kIsWeb) {
      // Chrome / Web
      return "http://127.0.0.1:5000";
    }

    // Android Emulator
    return "http://10.0.2.2:5000";
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();

    if (text.isEmpty || isLoading) {
      return;
    }

    setState(() {
      messages.add({
        "message": text,
        "isUser": true,
      });

      messageController.clear();
      isLoading = true;
    });

    _scrollToBottom();

    try {
      final response = await http.post(
        Uri.parse("$backendUrl/chat"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "message": text,
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final reply = data["reply"] ?? "I couldn't understand that.";

        setState(() {
          messages.add({
            "message": reply,
            "isUser": false,
          });
        });
      } else {
        setState(() {
          messages.add({
            "message":
                "I'm having trouble connecting right now. Please try again. 💚",
            "isUser": false,
          });
        });
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        messages.add({
          "message":
              "I couldn't connect to the wellness assistant. Please make sure the backend server is running. 💚",
          "isUser": false,
        });
      });

      debugPrint("Chatbot connection error: $e");
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });

        _scrollToBottom();
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;

      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5FAF9),

      // HEADER
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff00897B),
        foregroundColor: Colors.white,

        title: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.spa,
                color: Color(0xff00897B),
              ),
            ),

            const SizedBox(width: 12),

            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Wellness AI",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Your wellness companion",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          // CHAT MESSAGES
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length + (isLoading ? 1 : 0),

              itemBuilder: (context, index) {
                // AI typing indicator
                if (isLoading && index == messages.length) {
                  return _buildTypingIndicator();
                }

                final message = messages[index];

                final bool isUser =
                    message["isUser"] as bool;

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,

                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 300,
                    ),

                    margin: const EdgeInsets.only(
                      bottom: 12,
                    ),

                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),

                    decoration: BoxDecoration(
                      color: isUser
                          ? const Color(0xff00897B)
                          : Colors.white,

                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(18),
                        topRight: const Radius.circular(18),

                        bottomLeft: Radius.circular(
                          isUser ? 18 : 4,
                        ),

                        bottomRight: Radius.circular(
                          isUser ? 4 : 18,
                        ),
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                        ),
                      ],
                    ),

                    child: Text(
                      message["message"].toString(),

                      style: TextStyle(
                        fontSize: 15,
                        height: 1.4,

                        color: isUser
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // MESSAGE INPUT
          Container(
            padding: const EdgeInsets.fromLTRB(
              12,
              10,
              12,
              15,
            ),

            decoration: const BoxDecoration(
              color: Colors.white,
            ),

            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,

                    textInputAction:
                        TextInputAction.send,

                    onSubmitted: (_) {
                      sendMessage();
                    },

                    enabled: !isLoading,

                    decoration: InputDecoration(
                      hintText: isLoading
                          ? "AI is thinking..."
                          : "Type a message...",

                      filled: true,

                      fillColor:
                          const Color(0xffF1F5F4),

                      prefixIcon: const Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.grey,
                      ),

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(25),

                        borderSide:
                            BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                GestureDetector(
                  onTap: isLoading
                      ? null
                      : sendMessage,

                  child: Container(
                    width: 50,
                    height: 50,

                    decoration: BoxDecoration(
                      color: isLoading
                          ? Colors.grey
                          : const Color(0xff00897B),

                      shape: BoxShape.circle,
                    ),

                    child: isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(15),
                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,

      child: Container(
        margin: const EdgeInsets.only(
          bottom: 12,
        ),

        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(18),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
            ),
          ],
        ),

        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xff00897B),
              ),
            ),

            SizedBox(width: 10),

            Text(
              "Wellness AI is thinking...",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
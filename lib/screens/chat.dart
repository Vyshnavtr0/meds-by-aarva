import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:share_plus/share_plus.dart';

class Chat extends StatefulWidget {
  String m;
  Chat({super.key, required this.m});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  dynamic text = '';
  List<dynamic> chats = [];
  bool animate = true;
  TextEditingController _textEditingController = TextEditingController();

  Future<void> gettext(String prompt) async {
    // Replace with your actual Gemini API key (securely stored)
    final apiKey = 'AIzaSyCELc4FP-pbj8U4r4JNYjlkR16ux2nIpRA';
    final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey');
    print('hello');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        // Extract generated text
        chats.removeAt(0);
        Map<String, dynamic> jsonData = jsonDecode(response.body);

        // Extract text content
        List<dynamic> candidates = jsonData['candidates'];
        if (candidates.isNotEmpty) {
          Map<String, dynamic> content = candidates[0]['content'];
          List<dynamic> parts = content['parts'];
          if (parts.isNotEmpty) {
            setState(() {
              chats.insert(0, parts[0]['text'] + "/////false");
            });
          }
        }

        // Update UI using your state management solution
        // (e.g., Provider, Bloc)
        // ...
      } else {
        print(
            'Failed to fetch response: ${response.statusCode} ${response.reasonPhrase}');
        // Consider displaying user-friendly error message in UI
      }
    } catch (e) {
      print('Exception: $e');
      // Consider displaying user-friendly error message in UI
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //gettext();
    chats.add(
      "${widget.m}/////true",
    );
    chats.insert(0, "Loading" + "/////false");
    gettext(widget.m);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.add, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Chat(
                    m: widget.m,
                  ),
                ),
              );
            },
          ),
        ],
        title: Text(
          "  MedsGPT",
          style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              fontStyle: FontStyle.italic),
        ),
        //centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Stack(
          children: [
            ListView.builder(
              reverse: true,
              padding: EdgeInsets.only(bottom: 80),
              physics: BouncingScrollPhysics(),
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: chats[index].split('/////')[1] == 'true'
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.11,
                        child: Column(
                          children: [
                            ChatBubble(
                              shadowColor: Colors.transparent,
                              backGroundColor:
                                  chats[index].split('/////')[1] == 'true'
                                      ? const Color(0xff04A498)
                                      : Color.fromARGB(255, 238, 235, 235),
                              alignment:
                                  chats[index].split('/////')[1] == 'true'
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              clipper: ChatBubbleClipper3(
                                  type: chats[index].split('/////')[1] == 'true'
                                      ? BubbleType.sendBubble
                                      : BubbleType.receiverBubble),
                              child: chats[index].split('/////')[0] == 'Loading'
                                  ? LoadingAnimationWidget.staggeredDotsWave(
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  : (chats[index].split('/////')[1] ==
                                                  'false' &&
                                              index == 0) &&
                                          animate == true
                                      ? AnimatedTextKit(
                                          animatedTexts: [
                                            TypewriterAnimatedText(
                                              chats[index].split('/////')[0],
                                              textAlign: TextAlign.start,
                                              textStyle: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              speed: const Duration(
                                                  milliseconds: 20),
                                            ),
                                          ],
                                          onFinished: () {
                                            setState(() {
                                              animate = false;
                                            });
                                          },
                                          totalRepeatCount: 1,
                                          pause: const Duration(
                                              milliseconds: 1000),
                                          displayFullTextOnTap: true,
                                          stopPauseOnTap: true,
                                        )
                                      : Text(
                                          chats[index].split('/////')[0],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                          ),
                                        ),
                            ),
                            Visibility(
                              visible:
                                  chats[index].split('/////')[1] == 'false' &&
                                          chats[index].split('/////')[0] !=
                                              'Loading' &&
                                          index != chats.length - 1
                                      ? true
                                      : false,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Share.share(
                                              chats[index].split('/////')[0]);
                                        },
                                        icon: Icon(
                                          CupertinoIcons.share,
                                          color: Colors.black,
                                          size: 18,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            chats.insert(0, chats[index + 1]);
                                            chats.insert(
                                                0, "Loading" + "/////false");
                                            animate = true;
                                          });
                                          gettext(_textEditingController.text);
                                        },
                                        icon: Icon(
                                          Icons.replay_outlined,
                                          color: Colors.black,
                                          size: 20,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          await Clipboard.setData(ClipboardData(
                                              text: chats[index]
                                                  .split('/////')[0]));
                                        },
                                        icon: Icon(
                                          Icons.copy,
                                          color: Colors.black,
                                          size: 18,
                                        )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // height: 120,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.3,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 241, 240, 240),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: _textEditingController,
                            maxLines: 5,
                            minLines: 1,
                            style: TextStyle(color: Colors.black),
                            onChanged: (t) {
                              setState(() {});
                            }, // Set text color
                            decoration: InputDecoration(
                                suffixIcon: _textEditingController.text
                                            .trimLeft()
                                            .trimRight() !=
                                        ''
                                    ? IconButton(
                                        onPressed: () {
                                          _textEditingController.clear();
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          CupertinoIcons.clear,
                                          color: Colors.grey,
                                          size: 15,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          CupertinoIcons.lightbulb,
                                          color: Colors.grey,
                                          size: 15,
                                        ),
                                      ),
                                focusColor: Colors.transparent,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                // Set label color
                                hintText: 'Type a message to MedsGPT',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: chats[0].split('/////')[0] == 'Loading'
                                ? SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: LoadingAnimationWidget.inkDrop(
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xff04A498),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: IconButton(
                                      icon: const Icon(
                                          CupertinoIcons.paperplane,
                                          color: Colors.white),
                                      onPressed: () {
                                        // Add your send message logic here
                                        if (_textEditingController.text
                                                .trimLeft()
                                                .trimRight() !=
                                            '') {
                                          setState(() {
                                            chats.insert(
                                                0,
                                                _textEditingController.text
                                                        .toString() +
                                                    "/////true");
                                            chats.insert(
                                                0, "Loading" + "/////false");
                                            animate = true;
                                          });
                                          print(animate);
                                          gettext(_textEditingController.text);
                                          _textEditingController.clear();
                                        }
                                      },
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

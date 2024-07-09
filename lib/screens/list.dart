import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meds/screens/chat.dart';

class ListD extends StatefulWidget {
  List<String> img;
  int i;
  List<String> m;
  ListD({super.key, required this.img, required this.i, required this.m});

  @override
  State<ListD> createState() => _ListDState();
}

class _ListDState extends State<ListD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
        "Details",
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: widget.img.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 85,
                      height: 85,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Hero(
                        tag: 'hero-${widget.i.toString()}-${index.toString()}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.img[index],
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        '    ' + widget.m[index],
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xff04A498),
                          borderRadius: BorderRadius.circular(40)),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Chat(m: widget.m[index])));
                        },
                        icon: Icon(
                          CupertinoIcons.chat_bubble,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'dart:typed_data';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:meds/screens/cam.dart';
import 'package:meds/screens/list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

String greeting = 'Hello !';

class _HomeState extends State<Home> {
  Future<void> getGreeting() async {
    final currentHour = DateTime.now().hour;

    if (currentHour >= 5 && currentHour < 12) {
      setState(() {
        greeting = "Good morning";
      });
    } else if (currentHour >= 12 && currentHour < 17) {
      setState(() {
        greeting = "Good afternoon";
      });
    } else {
      setState(() {
        greeting = "Good evening";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGreeting();
  }

  List<String> l = [
    'https://www.drugs.com/images/pills/fio/LNK01572/aspirin.JPG',
    "https://m.media-amazon.com/images/I/71Agxp1vEfL._AC_SL1500_.jpg",
    'https://5.imimg.com/data5/SELLER/Default/2021/11/CL/EZ/VN/131643987/amoxicillin-capsules-500x500.jpeg',
    'https://s.turbifycdn.com/aah/yhst-135855760451349/ciprofloxacin-250mg-tab-100-tabs-manufacture-may-vary-32.jpg'
  ];

  final List<String> medicines = [
    "Aspirin",
    "Ibuprofen",
    "Amoxicillin",
    "Ciprofloxacin",
  ];
  final _controller = DocumentScannerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$greeting,',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            const Text(
              'Vyshnav !',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cam()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 90,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff04A498), Color(0xff0b7871)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14)),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.white,
                    ),
                    Text(
                      'New Scan',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'History',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  List<Widget> stackChildren = [];

                  for (int i = 0; i < l.length; i++) {
                    stackChildren.add(Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Hero(
                          tag: 'hero-$index-$i',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              l[i],
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ),
                      ),
                    ));
                  }
                  stackChildren = stackChildren.reversed.toList();
                  stackChildren.add(
                    Container(
                      width: 90,
                      height: 90,
                      child: Swiper(
                        itemBuilder: (BuildContext context, int i) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    l[i],
                                    fit: BoxFit.cover,
                                    width: 85,
                                    height: 85,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: l.length,
                        itemWidth: 100,
                        itemHeight: 100,
                        loop: true,
                        layout: SwiperLayout.TINDER,
                      ),
                    ),
                  );
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                height: 90,
                                width: 90,
                                child: Stack(
                                  children: stackChildren,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            medicines.join(', '),
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
                                      builder: (context) => ListD(
                                          img: l, i: index, m: medicines)));
                            },
                            icon: Icon(
                              CupertinoIcons.right_chevron,
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
            )
          ],
        ),
      )),
    );
  }
}

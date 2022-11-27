import 'package:flutter/material.dart';
import 'package:home_alone_recipe/screen/myTown_screen.dart';
import 'package:provider/provider.dart';
import 'package:home_alone_recipe/provider/userProvider.dart';
import 'package:home_alone_recipe/widget/postStream.dart';
import 'package:home_alone_recipe/screen/postGroupBuying_screen.dart';
import 'package:home_alone_recipe/config/palette.dart';
import 'package:home_alone_recipe/models/post.dart';
import 'package:home_alone_recipe/screen/groupChatting.dart';

class GroupBuyingDetailPage extends StatefulWidget {
  final Post post;

  const GroupBuyingDetailPage(this.post, {super.key});

  @override
  State<GroupBuyingDetailPage> createState() => _GroupBuyingDetailPageState();
}

class _GroupBuyingDetailPageState extends State<GroupBuyingDetailPage> {
  String curState() {
    if (widget.post.maxParticipants == null) {
      return "null입니다";
    } else if (widget.post.maxParticipants! > widget.post.curParticipants!) {
      return "모집중";
    } else {
      return "모집완료";
    }
  }

  void showPopup(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("이 공동구매에 참여하시겠습니까?",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        textAlign: TextAlign.center),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 110,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return MessageListScreen();
                                  }),
                                );
                              },
                              icon: const Icon(Icons.circle_outlined),
                              label: const Text('네'),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff686EFF),
                                onPrimary: Colors.white, // Background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 110,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close),
                              label: const Text('아니요'),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff686EFF),
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ), // Background color
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var stringlist = widget.post.userLocation!.join(" ");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '공동 구매',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        elevation: 3.0,
        backgroundColor: Colors.white,
      ),
      body: ListView(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 10, 5),
            child: Container(
              height: MediaQuery.of(context).size.width * 0.08,
              width: MediaQuery.of(context).size.width * 0.15,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Palette.lightgrey,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Center(
                  child: Text(
                    widget.post.lowerCategory.toString(),
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 8, 20, 5),
            child: Row(
              children: [
                Icon(Icons.person_pin, color: Colors.blueAccent, size: 60),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(" ${widget.post.writerName.toString()}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black)),
                      Text(" " + stringlist,
                          style: TextStyle(fontSize: 13, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              height: 1.0,
              width: 500.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Row(
              children: [
                Text("${curState()}  ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: curState() == "모집중"
                            ? Palette.blue
                            : Colors.redAccent)),
                Text("${widget.post.title}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black)),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.people,
                          ),
                        ),
                        TextSpan(
                            text:
                                "  ${widget.post.curParticipants}/${widget.post.maxParticipants}명 참여\n",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            )),
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Icon(
                              Icons.calendar_month,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: "  ${widget.post.date} ${widget.post.time}\n",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Icon(
                              Icons.location_on,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: "  ${widget.post.meetingPlace}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 18, 0, 7),
                    width: MediaQuery.of(context).size.width * 0.98,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Palette
                                  .grey, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                            //color: Palette.lightgrey,
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(13, 15, 13, 15),
                            child: Text(
                              widget.post.content.toString(),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              height: 1.0,
              width: 500.0,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(104, 150, 235, 1),
                      Color.fromRGBO(104, 100, 255, 1),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                height: MediaQuery.of(context).size.width * 0.15,
                width: MediaQuery.of(context).size.width * 0.90,
                child: OutlinedButton(
                  onPressed: () {
                    showPopup(context);
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23.0),
                    ),
                  ),
                  child: const Text(
                    '참여하기',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}

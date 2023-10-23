import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widget/tab.dart';

class Comment extends StatefulWidget {
  static String routName = "Comment";
  const Comment({Key? key}) : super(key: key);
  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  List<String> com = [];
  List Name = [];
  List<String> cID = [];
  int l = 0, f = 1;
  late String cid = "1";
  late String op ="";
  int ?selectedRating ;

  void all_comment() {
    final all = FirebaseFirestore.instance.collection("Review");
    final name = FirebaseFirestore.instance.collection("CUSTOMER");
    all.get().then((value) => value.docs.forEach((element) {
      setState(() {
        com.add(element.get("comment"));
        cid = element.get("CID");
        name.get().then((value) => value.docs.forEach((element) {
          setState(() {
            print("++++++++++++++++++++++++++++++");
            if (element.get("cID") == cid) {
              String fullName = element.get("fName") + element.get("lName");
              Name.add(fullName);
            }
            print(Name);
          });
        }));
        l = com.length;
      });
    }));
  }
  void showAlert(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: Color.fromRGBO(226, 206, 206, 1),
              width: 2,
            ),
          ),
          title: Text(title),
          content: Text(content, style: TextStyle(color: Colors.black)),
          actions: [
            Center(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromRGBO(226, 206, 206, 1),
                  ),
                ),
                child: Text("حسنا", style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void validateCommentAndRating() {
    if (op.isEmpty) {
      showAlert("تنبيه", "الرجاء إدخال تعليق قبل الضغط على زر الإرسال.");
    } else if (selectedRating == null) {
      showAlert("تنبيه", "الرجاء تقييم التجربة قبل الضغط على زر الإرسال.");
    } else {
      addCommentToFirestore();
    }
  }

  void addCommentToFirestore() {
    final all = FirebaseFirestore.instance.collection("Review");
    all.doc().set({
      "comment": op,
      "rating": selectedRating,
      "CID": cid,
    }).then((value) {
      showAlert("تنبيه", "تم إرسال التعليق بنجاح.");
      setState(() {
        cid = "1";
        op = "";
        selectedRating = null;
      });
    });
  }




  @override
  void initState() {
    all_comment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height - AppBar().preferredSize.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("الاراء والتقييمات"),
        actions: const [
          Icon(
            Icons.bookmark,
            color: Color.fromRGBO(212, 85, 85, 1),
            size: 30,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.01, left: width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
                child: Text(
                  "(${l > 3 && f == 1 ? 3 : l}) التعليقات ",
                  style: TextStyle(
                    color: Color.fromRGBO(57, 42, 39, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(width * 0.02),
                width: width,
                height: height / 2.7,
                child: ListView.builder(
                  itemCount: l > 3 && f == 1 ? 3 : l,
                  itemBuilder: (context, index) {
                    return Name.length > 0
                        ? Padding(
                      padding: EdgeInsets.all(width * 0.018),
                      child: Container(
                        padding: EdgeInsets.only(
                          left: width * 0.07,
                          top: height * 0.01,
                          right: width * 0.07,
                        ),
                        width: width,
                        height: height * 0.1,
                        color: Color.fromRGBO(246, 241, 230, 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              com[index],
                              style: TextStyle(
                                color: Color.fromRGBO(57, 42, 39, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Name[index],
                                  style: TextStyle(
                                    color: Color.fromRGBO(146, 132, 123, 1),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Text(
                                  "قبل ساعتين",
                                  style: TextStyle(
                                    color: Color.fromRGBO(146, 132, 123, 1),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                        : CircularProgressIndicator();
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    f = 0;
                    print(l);
                  });
                },
                child: const Text(
                  "عرض المزيد",
                  style: TextStyle(
                    color: Color.fromRGBO(65, 166, 180, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.12, right: width * 0.12),
                child: const Text(
                  "!اضف رأيك وتقييمك الان ",
                  style: TextStyle(
                    color: Color.fromRGBO(57, 42, 39, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      child: TextField(
                        onChanged: (val) {
                          setState(() {
                            op = val;
                          });
                        },
                        cursorColor: Colors.black,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          labelText: "أضف رأي",
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(146, 132, 123, 1),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0.0),
                            ),
                            borderSide: BorderSide(width: 0, style: BorderStyle.none),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "قيم التجربة",
                      style: TextStyle(
                        color: Color.fromRGBO(57, 42, 39, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: selectedRating,
                          onChanged: (val) {
                            setState(() {
                              selectedRating = val as int;
                            });
                          },
                        ),
                        Text("ضعيف"),
                        Radio(
                          value: 2,
                          groupValue: selectedRating,
                          onChanged: (val) {
                            setState(() {
                              selectedRating = val as int;
                            });
                          },
                        ),
                        Text("متوسط"),
                        Radio(
                          value: 3,
                          groupValue: selectedRating,
                          onChanged: (val) {
                            setState(() {
                              selectedRating = val as int;
                            });
                          },
                        ),
                        Text("جيد"),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.04),
                child: SizedBox(
                  width: width / 2,
                  height: height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      addCommentToFirestore();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(131, 153, 163, 1),
                      ),
                    ),
                    child: Row(
                      children: const [
                        Text(
                          "ارسال الرأي",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: TabeScreen(),
    );
  }
}
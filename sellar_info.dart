import 'package:book/widget/tab.dart';
import 'package:book/widget/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class SellerInfo extends StatefulWidget {
  static String routName = "SellerInfo";

  const SellerInfo({super.key});

  @override
  State<SellerInfo> createState() => _SellerInfoState();
}

class _SellerInfoState extends State<SellerInfo> {
  late String insta="", whats="", phone="", email="g", lName="", fName="", sid="1";
  TextEditingController nameController = TextEditingController();
  TextEditingController complaintReasonController = TextEditingController();
  TextEditingController complaintDateController = TextEditingController();

  Future<void> _launchInBrowser(String url) async {
    if (!await launch(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void S_de() async {
    final seller = FirebaseFirestore.instance.collection("Seller");
    seller
        .where("SID", isEqualTo: sid)
        .get()
        .then((value) => value.docs.forEach((element) {
      setState(() {
        insta = element.get("insta");
        whats = element.get("whats");
        phone = element.get("phoneNumber");
        email = element.get("email");
        lName = element.get("lName");
        fName = element.get("fName");
      });
    }));
  }

  @override
  void initState() {
    S_de();
    super.initState();
  }

  void _showComplaintForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'تقديم شكوى',
            style: TextStyle(color: Colors.black),
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'الاسم',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    // Handle the name input
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  controller: complaintReasonController,
                  decoration: InputDecoration(
                    labelText: 'سبب الشكوى',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    // Handle the complaint reason input
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  controller: complaintDateController,
                  decoration: InputDecoration(
                    labelText: 'تاريخ الشكوى',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    // Handle the complaint date input
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Color.fromRGBO(226, 206, 206, 1)),
              child: Text(
                'إرسال',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                // Handle complaint submission here
                if (nameController.text.isEmpty ||
                    !RegExp(r'^[a-zA-Z\s]+$').hasMatch(nameController.text)) {
                  // إذا كان الاسم فارغاً أو يحتوي على أرقام، قم بإظهار تنبيه
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('تنبيه'),
                        content: Text('الرجاء إدخال اسم صحيح.'),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Color.fromRGBO(226, 206, 206, 1)),
                            child: Text('حسناً'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }

                if (complaintReasonController.text.isEmpty) {
                  // إذا كان سبب الشكوى فارغاً، قم بإظهار تنبيه
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('تنبيه'),
                        content: Text('الرجاء إدخال سبب الشكوى.'),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Color.fromRGBO(226, 206, 206, 1)),
                            child: Text('حسناً'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }

                if (complaintDateController.text.isEmpty) {
                  // إذا كان تاريخ الشكوى فارغاً، قم بإظهار تنبيه
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('تنبيه'),
                        content: Text('الرجاء إدخال تاريخ الشكوى.'),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Color.fromRGBO(226, 206, 206, 1)),
                            child: Text('حسناً'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }

                Navigator.of(context).pop(); // Close the dialog
                _showConfirmationDialog(); // Show confirmation dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تم الإرسال بنجاح'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('موافق'),
              style: ElevatedButton.styleFrom(primary: Color.fromRGBO(226, 206, 206, 1)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height-AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("معلومات البائع"),
        actions: const [
          Icon(
            Icons.bookmark,
            color: Color.fromRGBO(212, 85, 85, 1),
            size: 30,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: width / 2.5,
              height: height / 5.5,
              decoration: BoxDecoration(
                color: Color.fromRGBO(236, 231, 225, 1.0),
                borderRadius: BorderRadius.all(Radius.circular(120.0)),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 60,
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.black,
                ),
              ),
            ),
            text(
                t: "${fName + lName}",
                c: Colors.black,
                s: 20,
                w: FontWeight.w600),
            Card(
                color: const Color.fromRGBO(226, 206, 206, 1),
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.07, vertical: height * 0.03),
                    width: width,
                    height: height / 4.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.message_outlined,
                                color: Colors.black,
                              ),
                            ),
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.phone,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.14,
                            ),
                            const text(
                                c: Colors.black,
                                t: "رقم الهاتف",
                                s: 20,
                                w: FontWeight.w700),
                          ],
                        ),
                        text(
                            t: phone,
                            c: Color.fromRGBO(172, 172, 172, 1),
                            s: 16,
                            w: FontWeight.w600),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.14,
                                ),
                                const text(
                                    c: Colors.black,
                                    t: "الايميل",
                                    s: 20,
                                    w: FontWeight.w700),
                              ],
                            ),
                            text(
                                t: email,
                                c: Color.fromRGBO(172, 172, 172, 1),
                                s: 16,
                                w: FontWeight.w600)
                          ],
                        )
                      ],
                    ))),
            Padding(
              padding: EdgeInsets.only(left: width * 0.45),
              child: const text(
                  t: "التواصل المباشر",
                  c: Colors.black,
                  s: 20,
                  w: FontWeight.w700),
            ),
            Card(
                color: const Color.fromRGBO(226, 206, 206, 1),
                margin: EdgeInsets.all(width * 0.02),
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.07, vertical: height * 0.03),
                    width: width,
                    height: height / 4,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                _launchInBrowser(insta);
                              },
                              child: const text(
                                  t: "Instagram",
                                  c: Colors.black,
                                  s: 20,
                                  w: FontWeight.w700),
                            ),
                            Image.asset(
                              "images/img_2.png",
                              height: height * 0.04,
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                _launchInBrowser(whats);
                              },
                              child: text(
                                  t: "WhatsApp",
                                  c: Colors.black,
                                  s: 20,
                                  w: FontWeight.w700),
                            ),
                            Image.asset(
                              "images/img_1.png",
                              height: height * 0.04,
                            )
                          ],
                        )
                      ],
                    ))),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: ElevatedButton(
                onPressed: () {
                  _showComplaintForm();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(226, 206, 206, 1),
                ),
                child: Text(
                  'تقديم شكوى',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TabeScreen(),
    );
  }
}

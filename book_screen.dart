import 'package:book/screens/comment.dart';
import 'package:book/screens/sellar_info.dart';
import 'package:book/widget/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widget/tab.dart';
class BookScreen extends StatefulWidget {
  const BookScreen({super.key});
  @override
  State<BookScreen> createState() => _BookScreenState();
}
class _BookScreenState extends State<BookScreen> {
  late final String bookId = "1";
  late String Title = "";
  late String description = "";
  late String sellerId = "1";
  late String authorId = "";
  late String image = "";
  late String fName = "";
  late String lName = "";
  late String NameAuthor = "";
  void det() async {
    final book = await FirebaseFirestore.instance.collection('Book');
    final seller = await FirebaseFirestore.instance.collection('Seller');
    final Author = await FirebaseFirestore.instance.collection('Author');
    book
        .where('bookID', isEqualTo: bookId)
        .get()
        .then((value) => value.docs.forEach((element) {
              setState(() {
                Title = element.get('Title');
                // description = element.get('description');
                sellerId = element.get('sellerID');
                authorId = element.get('autherID');
                image = element.get('Image');
                description=element.get("description");
                print(element.get('autherID'));
                // print("+++++++++++++++++++");
              });
            }));
    seller
        .where('SID', isEqualTo: sellerId)
        .get()
        .then((value) => value.docs.forEach((element) {
              setState(() {
                fName = element.get('fName');
                lName = element.get('lName');
                // print("+++++++++++++++++++");
              });
            }));
    Author
        .get()
        .then((value) => value.docs.forEach((element) {
              setState(() {
                if(authorId==element.get('AuthorId'))
                  {
                    print("+++++++++++++++++++");
                    NameAuthor = element.get("AuthorName");
                  }
              });
            }));
  }

  @override
  void initState() {
    det();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height-AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("تفاصيل الكتاب"),
        actions: const [
          Icon(
            Icons.bookmark,
            color: Color.fromRGBO(212, 85, 85, 1),
            size: 30,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
            child: Container(
              width: width * 0.6,
              height: height * 0.4,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
              ),
              child: image != ""
                  ? Image.network(
                      image,
                      fit: BoxFit.contain,
                    )
                  : const CircularProgressIndicator(),
            ),
          ),
          Center(
            child: text(
                t: Title,
                c: const Color.fromRGBO(25, 25, 27, 1),
                s: 20,
                w: FontWeight.w600),
          ),
          Center(
            child: text(
                t: NameAuthor,
                c: Color.fromRGBO(157, 157, 157, 1),
                s: 15,
                w: FontWeight.w500),
          ),
          Padding(
            padding: EdgeInsets.only(right: width * 0.02), // تحديث الوسم ليتحرك إلى اليمين
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end, // تحديد العرض على الجهة اليمنى
              children: [
                const text(
                  t: "عن الكاتبة",
                  c: Color.fromRGBO(25, 25, 27, 1),
                  s: 20,
                  w: FontWeight.w600,
                ),
                text(
                  t: description,
                  c: const Color.fromRGBO(132, 132, 132, 1.0),
                  s: 16,
                  w: FontWeight.w500,
                ),
              ],
            ),
          ),


          Padding(
            padding: EdgeInsets.only(top: height * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width / 2,
                  height: height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SellerInfo.routName);
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.file_open,
                          color: Color.fromRGBO(177, 137, 137, 0.89),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        text(
                            t: "${fName +" "+ lName}",
                            c: Color.fromRGBO(177, 137, 137, 0.89),
                            s: 18,
                            w: FontWeight.w500)
                      ],
                    ),
                  ),
                ),
                Container(
                  width: width / 3,
                  height: height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Comment.routName);
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.message_outlined,
                          color: Color.fromRGBO(177, 137, 137, 0.89),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        text(
                            t: "التقييمات",
                            c: Color.fromRGBO(177, 137, 137, 0.89),
                            s: 18,
                            w: FontWeight.w500)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width / 2.3,
                  height: height * 0.08,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(177, 137, 137, 1))),
                      child: text(
                          t: "الاضافة للمفضلة",
                          c: Colors.white,
                          s: 15,
                          w: FontWeight.w600)),
                ),
                Container(
                  width: width / 2.3,
                  height: height * 0.08,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(131, 153, 163, 1)),
                      ),
                      child: text(
                          t: "الشراء",
                          c: Colors.white,
                          s: 15,
                          w: FontWeight.w600)),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: TabeScreen(),
    );
  }
}

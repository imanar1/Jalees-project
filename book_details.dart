import 'package:cloud_firestore/cloud_firestore.dart';


class Book_details {
  late final String bookId="1";
  late String Title="";
  late String description="";
  late String sellerId="1";
 late String authorId="";
  late String Image="";
 late String fName="";
  late String lName="";
  late String NameAuthor="";


  Future book_det() async {
    final book = await FirebaseFirestore.instance.collection('Book');
    final seller=await FirebaseFirestore.instance.collection('Seller');
    book
        .where('bookID', isEqualTo: bookId)
        .get()
        .then((value) => value.docs.forEach((element) {
              Title = element.get('Title');
              description = element.get('description');
              sellerId = element.get('sellerID');
              authorId = element.get('autherID');
              Image = element.get('Image');
              description=element.get("description");
            }));
     seller.where('SID',isEqualTo: sellerId).get().then((value) => value.docs.forEach((element) {
       fName=element.get('fName');
       lName=element.get('lName');
     }));
    final Map<String, String> det = {
      "Title": Title,
      "description": description,
      "sellerId": sellerId,
      "authorId": authorId,
      "Image": Image,
      "fName":fName,
      "lName":lName
    };
    return det;
  }
}

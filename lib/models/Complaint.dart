
import 'package:cloud_firestore/cloud_firestore.dart';

class Complaint {


  String clientId;
  String feedback;
  
  Complaint({

    this.clientId,
    this.feedback,
    
  });




  static Complaint fromMap(DocumentSnapshot map) {
    if (map == null) return null;
  
    return Complaint(
 
      clientId: map['clientId'],
      feedback: map['feedback'],
    
    );
  }


}

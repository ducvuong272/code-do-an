import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirebaseServices {
  Future<dynamic> uploadImageToFireBaseStorage(File imageFile) async {
    String fileName = basename(imageFile.path);
    StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = ref.putFile(imageFile);
    var uri = await (await uploadTask.onComplete).ref.getDownloadURL();
    return uri;
  }

  Future<Null> deleteImageFromFirebaseStorage(String imageUrl) async {
    StorageReference storageReference =
        await FirebaseStorage.instance.getReferenceFromUrl('$imageUrl');
    storageReference.delete();
  }
}

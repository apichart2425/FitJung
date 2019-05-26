import 'dart:io';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitjung/utility/firestore_util.dart';
import 'package:fitjung/utility/share.dart';

class ImageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ImageState();
  }
}

class ImageState extends State<ImageScreen> {
  File sampleImage = null;

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }

  TextEditingController email = TextEditingController();

  @override
  void initState() {
    super.initState();
    SharedPreferencesUtil.loadLastLogin().then((value) {
      setState(() {
        email.text = value.toString();
        print('email image ${email.text}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: Text('Image'),
        centerTitle: true,
      ),
      body: Center(
        child: sampleImage == null ? Text("Photo") : enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Add image',
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(sampleImage, height: 300, width: 300),
          RaisedButton(
            elevation: 7.0,
            child: Text('Upload'),
            textColor: Colors.blue,
            onPressed: () async {
              print(this.email.text);
              final StorageReference firebaseStorageRef =
                  FirebaseStorage.instance.ref().child(this.email.text);
              final StorageUploadTask task =
                  firebaseStorageRef.putFile(sampleImage);
              print(await (await task.onComplete).ref.getDownloadURL());
              if (task.isComplete) {
                print( "task Complate");
                // Toast.show("UPLOAD complete", context);
                // Navigator.pushReplacementNamed(context, '/profile');
              }
            },
          )
        ],
      ),
    );
  }
}

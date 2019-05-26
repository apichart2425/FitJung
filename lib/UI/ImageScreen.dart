import 'dart:io';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ImageScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ImageState();
  }
}

class ImageState extends State<ImageScreen>{
  File sampleImage;

  Future getImage() async{
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
        sampleImage = tempImage;
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
        child: sampleImage == null? Text('Select Image'): enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Add image',
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget enableUpload(){
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(sampleImage, height:300, width:300),
          RaisedButton(
            elevation: 7.0,
            child: Text('Upload'),
            textColor: Colors.blue,
            onPressed: () async {
              final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('myimage.jpg');
              final StorageUploadTask task = firebaseStorageRef.putFile(sampleImage);
              print(await(await task.onComplete).ref.getDownloadURL());
              if (task.isComplete){
                Toast.show("UPLOAD complete", context);
                Navigator.pushNamed(context, "/signin");
              }
            },
          )
        ],
      ),
    );
  }

}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportForm extends StatefulWidget {
  @override
  _ReportFormState createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final _formKey = GlobalKey<FormState>();
  final _barangayController = TextEditingController();
  final _messageController = TextEditingController();
  List<File> _imageList = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _barangayController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _uploadImages() async {
    setState(() {
      _isLoading = true;
    });

    List<String> imageURLs = [];

    // Upload each image to Firebase Storage
    for (File imageFile in _imageList) {
      final Reference ref = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().toString()}');
      final UploadTask uploadTask = ref.putFile(imageFile);
      final TaskSnapshot downloadUrl = (await uploadTask.whenComplete(() {}));
      final String url = (await downloadUrl.ref.getDownloadURL());
      imageURLs.add(url);
    }

    // Add report data to Firestore
    FirebaseFirestore.instance.collection('reports').add({
      'barangay': _barangayController.text,
      'message': _messageController.text,
      'images': imageURLs,
      'timestamp': FieldValue.serverTimestamp(),
    });

    setState(() {
      _isLoading = false;
      _imageList = [];
      _barangayController.text = '';
      _messageController.text = '';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Report submitted!')),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageList.add(File(pickedFile.path));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _imageList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Report Form')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _barangayController,
                decoration: InputDecoration(labelText: 'Barangay'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a barangay';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                    labelText: 'Message', hintText: 'Enter your message'),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text('Upload Images'),
              SizedBox(height: 8.0),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () => _pickImage(ImageSource.camera),
                  ),
                  IconButton(
                    icon: Icon(Icons.photo_library),
                    onPressed: () => _pickImage(ImageSource.gallery),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: _imageList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        Image.file(
                          _imageList[index],
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () => _removeImage(index),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(Icons.close, size: 16.0),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 16.0),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _uploadImages();
                        }
                      },
                      child: Text('Submit'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:dsmap/models/response.dart';
import 'package:dsmap/services/dataService.dart';
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
  final _messageController = TextEditingController();
  List<File> _imageList = [];
  bool _isLoading = false;

  String selectedItem = 'Barangay';
  List<String> dropdownItems = [
    'Apayao',
    'Aquib',
    'Baung',
    'Calaoagan',
    'Catarauan',
    'Dugayung',
    'Gumarueng',
    'Macapil',
    'Maguilling',
    'Minanga',
    'Poblacion I',
    'Poblacion II',
    'Santa Barbara',
    'Santo Domingo',
    'Sicatna',
    'Villa Rey (San Gaspar)',
    'Villa Reyno',
    'Warat'
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });

    Response result = await DataService.addReport(
      barangay: selectedItem,
      message: _messageController.text,
      imageList: _imageList,
    );

    if (result.code == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Report submitted!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.message.toString())),
      );
    }

    setState(() {
      _isLoading = false;
      _imageList = [];
      _messageController.text = '';
    });
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
    // SELECT BARANGAY
    final Widget barangay = DropdownButtonFormField<String>(
      value: selectedItem == 'Barangay' ? null : selectedItem,
      onChanged: (String? newValue) {
        setState(() {
          selectedItem = newValue!;
        });
      },
      items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hint: Text(selectedItem),
      validator: (value) {
        if (value == null) {
          return 'Please select an option';
        }
        return null;
      },
    );
    // MESSAGE
    final Widget message = TextFormField(
      controller: _messageController,
      decoration:
          InputDecoration(labelText: 'Message', hintText: 'Enter your message'),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a message';
        }
        return null;
      },
    );
    return Scaffold(
      appBar: AppBar(title: Text('Report Form')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              barangay,
              SizedBox(height: 16.0),
              message,
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
                  ? Center(child: CircularProgressIndicator())
                  : Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _submit();
                              }
                              Future.delayed(Duration(milliseconds: 2500), () {
                                Navigator.pop(context);
                              });
                            },
                            child: Text('Submit'),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

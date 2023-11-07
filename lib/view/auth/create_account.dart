import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutterfeed/common/assets/Reusables/appbar.dart';
import 'package:flutterfeed/theme/pallete.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class create_account extends StatefulWidget {
  const create_account({super.key});

  @override
  State<create_account> createState() => _create_accountState();
}

class _create_accountState extends State<create_account> {
  DateTime? _selectedDate;

  var name = TextEditingController();
  var emailid = TextEditingController();
  var pswd = TextEditingController();

  File? _imagefile;
  String? downloadURL;

  Future<void> _selectDate(BuildContext context) async {
    var datePicked = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2003),
      lastDate: DateTime(2024),
      dateFormat: "dd-MMMM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );

    if (datePicked != null && datePicked != _selectedDate) {
      setState(() {
        _selectedDate = datePicked;
      });
    }
  }

  void createaccount() async {
    var auth = FirebaseAuth.instance;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: emailid.text, password: pswd.text);
      Map<String, dynamic> User = {
        'name': name.text,
        'email': emailid.text,
        'password': pswd.text,
        'date': _selectedDate,
        'ProfilePic': downloadURL,
      };
      GoRouter.of(context).go('/login');
      await FirebaseFirestore.instance.collection('Users').add(User);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('Password is Weak');
        }
        AlertDialog(
          title: const Text('Password is Weak'),
          content: const Text('Please enter a strong password'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'))
          ],
        );
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('Email aldready exists');
        }
      }
      AlertDialog(
        title: const Text('email already in use'),
        content: const Text('Please enter another email'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'))
        ],
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getImage() async {
    ImagePicker imagePicker = ImagePicker();
    var file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (kDebugMode) {
      print('${file?.path}');
    }
    if (file != null) {
      setState(() {
        _imagefile = File(file.path);
      });
    }
  }

  Future<String> uploadImageToStorage() async {
    if (_imagefile == null) {
      return '';
    }
    String filename = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceroot = FirebaseStorage.instance.ref();

    Reference referenceDirImages = referenceroot.child('Profilepic');

    Reference referenceToUploadImage = referenceDirImages.child(filename);

    try {
      await referenceToUploadImage.putFile(_imagefile!);
      downloadURL = await referenceToUploadImage.getDownloadURL();
      if (kDebugMode) {
        print(downloadURL);
      }
      return downloadURL!;
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      return '';
    }
  }

  Widget _buildImagePreview() {
    if (_imagefile != null) {
      return Padding(
        padding: const EdgeInsets.all(15),
        child: Image.file(_imagefile!),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: UIcomponenets.appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: _imagefile == null
                    ? const AssetImage('assets/images/profile.png')
                    : FileImage(_imagefile!) as ImageProvider,
                radius: 50,
              ),
              ElevatedButton(onPressed: getImage, child: Text('Upload Image')),
              const Gap(20),
              TextFormField(
                onChanged: (value) {
                  name.text = value;
                },
                controller: name,
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
                decoration: const InputDecoration(
                    hintText: 'Name',
                    hintMaxLines: 50,
                    hintStyle: TextStyle(
                      color: Pallete.whiteColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Pallete.greyColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Pallete.whiteColor))),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  emailid.text = value;
                },
                controller: emailid,
                textInputAction: TextInputAction.go,
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
                decoration: const InputDecoration(
                    hintText: 'email address',
                    hintMaxLines: 50,
                    hintStyle: TextStyle(
                      color: Pallete.whiteColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Pallete.whiteColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Pallete.whiteColor))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  pswd.text = value;
                },
                controller: pswd,
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
                decoration: const InputDecoration(
                    hintText: 'password',
                    hintMaxLines: 50,
                    hintStyle: TextStyle(
                      color: Pallete.whiteColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Pallete.whiteColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Pallete.whiteColor))),
                obscureText: true,
              ),
              const Gap(20),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.backgroundColor,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Select Date",
                      style: TextStyle(color: Pallete.greyColor),
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: Pallete.greyColor,
                    ),
                  ],
                ),
              ),
              if (_selectedDate != null)
                Text("Selected Date: ${_selectedDate!.toLocal()}"),
              ElevatedButton(
                  onPressed: () {
                    createaccount();
                  },
                  child: const Text('Create Account')),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}

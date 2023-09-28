import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutterfeed/common/Reusables/appbar.dart';
import 'package:flutterfeed/theme/pallete.dart';

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

  Future<void> _selectDate(BuildContext context) async {
    var datePicked = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2090),
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('Password is Weak');
        }
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('Email aldready exists');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: UIcomponenets.appBar,
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
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
            const SizedBox(
              height: 20,
            ),
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
                child: const Text('Create Account'))
          ],
        ),
      ),
    );
  }
}

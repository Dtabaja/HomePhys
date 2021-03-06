import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homephiys/Controller/TherapistController.dart';
import 'package:homephiys/Entity/Therapist.dart';
import 'package:homephiys/Helpers/constant.dart';
import 'package:toast/toast.dart';

import 'PhysiotherapistPage.dart';
import 'PhysiotherapistRegistrationPage.dart';

class PhysiotherapistLoginPage extends StatelessWidget {
  final username = TextEditingController();
  final password = TextEditingController();
  TherapistCotroller therapisController = new TherapistCotroller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'homephys',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 60.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        '??????????????????????',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lobster',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildUserNameTF(username),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(password),
                      _buildForgotPasswordBtn(),
                      _buildLoginBtn(
                          context, therapisController, username, password),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildNewPhysBtn(context),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildUserNameTF(TextEditingController email) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        '?????????? ???????? ',
        style: kLabelStyle,
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          controller: email,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            hintText: '???? ???????????? :123456789',
            hintStyle: kHintTextStyle,
          ),
        ),
      ),
    ],
  );
}

Widget _buildPasswordTF(TextEditingController password) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        '??????????',
        style: kLabelStyle,
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        child: TextField(
          controller: password,
          obscureText: true,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.white,
            ),
            hintText: '??????????',
            hintStyle: kHintTextStyle,
          ),
        ),
      ),
    ],
  );
}

Widget _buildForgotPasswordBtn() {
  return Container(
    alignment: Alignment.centerRight,
    child: FlatButton(
      onPressed: () => print('Forgot Password Button Pressed'),
      padding: EdgeInsets.only(right: 0.0),
      child: Text(
        '???????? ???????????',
        style: kLabelStyle,
      ),
    ),
  );
}

Widget _buildLoginBtn(
    BuildContext context,
    TherapistCotroller therapistCotroller,
    TextEditingController username,
    TextEditingController password) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25.0),
    width: double.infinity,
    child: RaisedButton(
      elevation: 5.0,
      onPressed: () {
        //login theraphist
        Future loginTheraphist = therapistCotroller.loginTherapist(
            username.text.trim(), password.text.trim());
        loginTheraphist.then((value) {
          if (value == true) {
            //get therapshit from db
            Future<Therapist> fatchTherapist =
                therapistCotroller.getTherapistFromDB(username.text.trim());
            fatchTherapist.then((therapist) {
              //get allPatient fron db
              Future patientList =
                  therapistCotroller.getAllPatientsFromDB(username.text.trim());
              patientList.then((allPatient) {

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PhysiotherapistPage(allPatients:allPatient)));
              });
            });
          } else {
            Toast.show("?????????????? ??????????", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
        });
      },
      padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.white,
      child: Text(
        '??????????????',
        style: TextStyle(
          color: Color(0xFF527DAA),
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
    ),
  );
}

Widget _buildNewPhysBtn(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PhysiotherapistRegistrationPage()));
    },
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '?????? ???????????? ?????????????????? ? ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: ' ?????? ??????',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storehelper/loginscreen.dart';
import 'package:http/http.dart' as http;


 
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _conpasswordController = new TextEditingController();
  bool _isChecked = false;
  double screenHeight;

  @override
  Widget build(BuildContext context) {
    
        return MaterialApp(
          title: 'Material App',
          home: Scaffold(
            
            body: Center(
              child: SingleChildScrollView(
                              child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(70, 50, 70, 10),
                      child: Image.asset('assets/images/StoreHelper.png', scale: 2),
                    ),
                    
                    Card(
                      margin: EdgeInsets.fromLTRB(30, 1, 30, 1),
                      
                      elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Column(
                      children: [
                        Text('Registration',style: TextStyle(color: Colors.blue[200],fontWeight: FontWeight.bold,fontSize:22,)
                        ),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: 'Email',icon: Icon(Icons.email))
                        ,),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(labelText: 'Password',icon: Icon(Icons.lock)),
                        obscureText: true,
                        ),
                        TextField(
                          controller: _conpasswordController,
                          decoration: InputDecoration(labelText: 'Enter Password Again',icon: Icon(Icons.lock)),
                        obscureText: true,
                        ),
                        
                         Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Checkbox(
                            value: _isChecked,
                            onChanged: (bool value) {
                              _onChange(value);
                            },
                          ),
                          GestureDetector(
                            onTap: _showEULA,
                            child: Text('I Agree to Terms  ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ]),
                        MaterialButton(
                         

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minWidth: 50,
                          height: 35,
                          child: Text('Register',
                                style: TextStyle(
                                  color: Colors.white,
                                ) ),
                                onPressed: _onRegister,
                                color: Colors.blue[100], ),
                                                      ],
                                                      
                                                    ),
                                                  ),
                                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  child: Text("Already have a Account",
                                  style:TextStyle(fontSize:12)),onTap: _onAccount),
                                  
                                
                                                                ],
                                                                ),
                                                                ),
                                                           ),
                                                       ),
                                                     );
                                                   }
                                                                                                    
                        void _onRegister() {
                            String email = _emailController.text.toString();
                            String password = _passwordController.text.toString();
                            String passwordb= _conpasswordController.text.toString();

                            if (email.isEmpty ||
        password.isEmpty ||
        passwordb.isEmpty) {
      Fluttertoast.showToast(
          msg: "Email/password is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    if (!validateEmail(email)) {
      Fluttertoast.showToast(
          msg: "Check your email format",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    if (password != passwordb) {
      Fluttertoast.showToast(
          msg: "Please use the same password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    if (password.length < 5) {
      Fluttertoast.showToast(
          msg: "Password should atleast 5 characters long ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (!_isChecked) {
      Fluttertoast.showToast(
          msg: "Please accept terms",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    http.post(Uri.parse("https://crimsonwebs.com/s272043/storehelper/php/register_user.php"),
                              body: {
                                "email":email,
                                "password":password,
                              }                      
                              );
                              Fluttertoast.showToast(
                                  msg:"Registration Sucess",
                                  toastLength: Toast.LENGTH_SHORT,
                                   gravity:ToastGravity.TOP,
                                   timeInSecForIosWeb: 1,
                                    backgroundColor:Colors.red,
                                   textColor:Colors.white,
                                   fontSize:16.0);
                                   Navigator.push(
                            context, MaterialPageRoute(builder:(content)=> LoginScreen()));

                            //   if (email.isEmpty || password.isEmpty || passwordb.isEmpty){

                            //     Fluttertoast.showToast(
                            //       msg:"Your email/password is empty",
                            //       toastLength: Toast.LENGTH_SHORT,
                            //        gravity:ToastGravity.TOP,
                            //        timeInSecForIosWeb: 1,
                            //         backgroundColor:Colors.red,
                            //        textColor:Colors.white,
                            //        fontSize:16.0);
                            //   }else{
                            //     if (password != passwordb){
                            //       Fluttertoast.showToast(
                            //       msg:"password is wrong",
                            //       toastLength: Toast.LENGTH_SHORT,
                            //        gravity:ToastGravity.TOP,
                            //        timeInSecForIosWeb: 1,
                            //         backgroundColor:Colors.red,
                            //        textColor:Colors.white,
                            //        fontSize:16.0);

                            //     }else{
                            //       http.post(Uri.parse("https://crimsonwebs.com/s272043/storehelper/php/register_user.php"),
                            //   body: {
                            //     "email":email,
                            //     "password":password,
                            //   }                      
                            //   );
                            //   Fluttertoast.showToast(
                            //       msg:"Registration Sucess",
                            //       toastLength: Toast.LENGTH_SHORT,
                            //        gravity:ToastGravity.TOP,
                            //        timeInSecForIosWeb: 1,
                            //         backgroundColor:Colors.red,
                            //        textColor:Colors.white,
                            //        fontSize:16.0);
                            //        Navigator.push(
                            // context, MaterialPageRoute(builder:(content)=> LoginScreen()));
                            //     }
                              
                            //   }
                              
                                                                      }
                                                                    
                        void _onAccount() {
                          Navigator.push(
                            context, MaterialPageRoute(builder:(content)=> LoginScreen()));
                                    }

                        bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }


  void _onChange(bool value) {
    setState(() {
      _isChecked = value;
      //savepref(value);
    });
  }

  void _showEULA() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("EULA"),
          content: new Container(
            height: screenHeight / 2,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              //fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                            text:
                                "This End-User License Agreement is a legal agreement between you and Slumberjer This EULA agreement governs your acquisition and use of our TOURINGHOLIC software (Software) directly from Slumberjer or indirectly through a Slumberjer authorized reseller or distributor (a Reseller).Please read this EULA agreement carefully before completing the installation process and using the TOURINGHOLIC software. It provides a license to use the TOURINGHOLIC software and contains warranty information and liability disclaimers. If you register for a free trial of the TOURINGHOLIC software, this EULA agreement will also govern that trial. By clicking accept or installing and/or using the TOURINGHOLIC software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement. If you are entering into this EULA agreement on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement, do not install or use the Software, and you must not accept this EULA agreement.This EULA agreement shall apply only to the Software supplied by Slumberjer herewith regardless of whether other software is referred to or described herein. The terms also apply to any Slumberjer updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply. This EULA was created by EULA Template for TOURINGHOLIC. Slumberjer shall at all times retain ownership of the Software as originally downloaded by you and all subsequent downloads of the Software by you. The Software (and the copyright, and other intellectual property rights of whatever nature in the Software, including any modifications made thereto) are and shall remain the property of Slumberjer. Slumberjer reserves the right to grant licences to use the Software to third parties"
                            //children: getSpan(),
                            )),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text(
                "Close",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

}
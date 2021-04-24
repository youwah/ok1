import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storehelper/registerscreen.dart';
import 'package:http/http.dart' as http;

import 'mainscreen.dart';
 
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  SharedPreferences prefs;

  @override
  void initState(){
    loadPref();
    super.initState();
  }

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
                    SizedBox(height: 5),
                    Card(
                      margin: EdgeInsets.all(20),
                      elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Column(
                      children: [
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
                        Row(
                          children: [
                            Checkbox(value: _rememberMe, onChanged: (bool value){_onChange(value);}),
                                                        Text("Remember Me")
                                                      ],
                                                    ),
                        MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  minWidth: 100,
                                  height: 40,
                                  child: Text('Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ) ),
                                        onPressed: _onLogin,
                                        color: Colors.blue[100], ),
                                        
                                                              ],
                                                              
                                                            ),
                                                          ),
                                                        ),
                                        GestureDetector(
                                          child: Text("Register New Account",
                                          style:TextStyle(fontSize:12)),onTap: _onRegister),
                                          SizedBox(height:5),
                                        GestureDetector(
                                          child: Text("Forgot Password",
                                          style:TextStyle(fontSize:12)),onTap: _onPassword),
                                                                        ],
                                                                        ),
                                                                        ),
                                                                    ),
                                                                ),
                                                              );
                                                            }
                                                                                                            
                                void _onLogin() {
                                  String email = _emailController.text.toString();
                                    String password = _passwordController.text.toString();
        
                                      if(email.isEmpty || password.isEmpty){
                                        Fluttertoast.showToast(
                                          msg:"Please Enter Email/Password",
                                          toastLength: Toast.LENGTH_SHORT,
                                            gravity:ToastGravity.TOP,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:Colors.red,
                                            textColor:Colors.white,
                                            fontSize:16.0);
                                      }else {
                                          http.post(Uri.parse("https://crimsonwebs.com/s272043/storehelper/php/login_user.php"),
                                      body: {"email":email,"password":password}).then((response){
                                        print(response.body);
                                        if (response.body == "sucess") {
                                            Navigator.push(
                                    context, MaterialPageRoute(builder:(content)=> MainScreen()));
                                        }else {
                                          Fluttertoast.showToast(
                                          msg:"Login Failed",
                                          toastLength: Toast.LENGTH_SHORT,
                                            gravity:ToastGravity.TOP,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:Colors.red,
                                            textColor:Colors.white,
                                            fontSize:16.0);
                                        }
                                      });
                                      }
                                        
                                                                              }
                                                                            
                                void _onRegister() {
                                  Navigator.push(
                                    context, MaterialPageRoute(builder:(content)=> RegisterScreen()));
                                            }
                                          
                                void _onPassword() {
                                  TextEditingController _useremailController = new TextEditingController();
                                  showDialog(context: context, builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text("Forgot Password?"),
                                        content: new Container(
                                          height: 80,
                                          child: Column(
                                            children: [
                                              Text("Enter your recovery email"),
                                              TextField(
                                                controller: _useremailController,
                                                decoration: InputDecoration(labelText: 'Email',icon: Icon(Icons.email))
                                              )
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(child: Text('Submit'),onPressed:(){
                                            _resetPassword(_useremailController.text);
                                                                              },),
                                          TextButton(child: Text('Cancel'),onPressed:(){
                                            Navigator.of(context).pop();
                                                                              }),
                                                                            ],
                                                                          );
                                                                      }
                                                                      );
                                              }
                                            
                                              void _resetPassword(String email) {
                                                http.post(Uri.parse("https://crimsonwebs.com/s272043/storehelper/php/forgot_password.php"),
                                      body: {"email":email});
                                              }
        
                              void _onChange(bool value) {
                                String email = _emailController.text.toString();
                                String password = _passwordController.text.toString();

                                if (email.isEmpty || password.isEmpty){
                                  Fluttertoast.showToast(
                                                              msg:"Please Enter Email/Password",
                                                              toastLength: Toast.LENGTH_SHORT,
                                                               gravity:ToastGravity.TOP,
                                                               timeInSecForIosWeb: 1,
                                                                backgroundColor:Colors.red,
                                                               textColor:Colors.white,
                                                               fontSize:16.0);
                                                               return;
                                }
                                setState(() {
                                  _rememberMe = value;
                                  savePref(value,email,password);
                                                                  });
                                  
                                                                }
                                  
                                    Future<void> savePref(bool value, String email, String password) async {
                                      prefs = await SharedPreferences.getInstance();
                                      if (value){
                                        await prefs.setString("email", email);
                                        await prefs.setString("password", password);
                                        await prefs.setBool("rememberme", value);
                                        Fluttertoast.showToast(
                                                              msg:"Preference Stored",
                                                              toastLength: Toast.LENGTH_SHORT,
                                                               gravity:ToastGravity.TOP,
                                                               timeInSecForIosWeb: 1,
                                                                backgroundColor:Colors.red,
                                                               textColor:Colors.white,
                                                               fontSize:16.0);
                                                               return;
                                      }else {
                                        await prefs.setString("email", '');
                                        await prefs.setString("password", '');
                                        await prefs.setBool("rememberme", false);
                                         Fluttertoast.showToast(
                                                              msg:"Preference Removed",
                                                              toastLength: Toast.LENGTH_SHORT,
                                                               gravity:ToastGravity.TOP,
                                                               timeInSecForIosWeb: 1,
                                                                backgroundColor:Colors.red,
                                                               textColor:Colors.white,
                                                               fontSize:16.0);
                                                               return;
                                      }
                                    }

                      Future<void> loadPref() async {
                        prefs = await SharedPreferences.getInstance();
                        String email = prefs.getString("email")??'';
                        String password = prefs.getString("password")??'';
                        _rememberMe = prefs.getBool("rememberme")??false;

                        setState(() {
                          _emailController.text = email;
                          _passwordController.text = password;
                
                        });
                      }

}
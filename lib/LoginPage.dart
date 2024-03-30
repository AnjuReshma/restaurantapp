import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurantapp/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
late bool _passwordVisible;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> mykey=GlobalKey();
  TextEditingController emailcntr=TextEditingController();
  TextEditingController passwordcntr=TextEditingController();
  bool? isChecked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
  }
  @override

  Widget build(BuildContext context) {
    getSavedData(context);
    return Scaffold(
     body: Center(
       child: SingleChildScrollView(
         child: Form(
           key: mykey,
           child: Padding(
           padding: const EdgeInsets.all(20.0),
           child: Container(
           child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Center(
                 child: Container(
                     height: 350,
                     width: 350,
                     decoration: BoxDecoration(
                       image: DecorationImage(
                           image:
                           AssetImage("assets/images/loginrest.png")),)),
               ),
               SizedBox(height: 10,),
               Text("Log in",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold ),),
               Text("your account",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
               SizedBox(height: 20,),
               SizedBox(
                 width: 350,
                 height: 60,
                 child: TextFormField(

                   controller: emailcntr,
                   textAlign: TextAlign.left,
                   validator: (value) {

                     if(value==null|| value.isEmpty){
                       return "Required Field";
                     }
                   },
                   style: TextStyle(
                       fontSize: 15.0,
                       color: Colors.grey,
                       fontWeight: FontWeight.w300),
                   decoration: InputDecoration(
                       hintText: "User Name",
                       border: UnderlineInputBorder(
                           borderSide:
                           BorderSide(color:Colors.blueGrey )),
                       focusedBorder: UnderlineInputBorder(
                           borderSide:
                           BorderSide(color: Colors.blueGrey)),
                       enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10),
                           borderSide: BorderSide(
                               color: Colors.orange.shade300
                           )

                       )
                   ),
                 ),),
               SizedBox(height: 20),
               SizedBox(width: 350,
                 height: 60,
                 child: TextFormField(
                   controller: passwordcntr,
                   validator: (value) {
                     if(value==null|| value.isEmpty){
                       return "Required Field";
                     }
                   },
                   obscureText: !_passwordVisible,
                   style: TextStyle(
                       fontSize: 15.0,
                       color: Colors.grey,
                       fontWeight: FontWeight.w300),
                   decoration: InputDecoration(
                       hintText: "Password",
                       suffixIcon: IconButton(
                           onPressed: () {
                             setState(() {
                               _passwordVisible = !_passwordVisible;
                             });
                           },
                           icon: Icon(_passwordVisible
                               ? Icons.visibility
                               : Icons.visibility_off)),
                       border: UnderlineInputBorder(
                           borderSide:
                           BorderSide(color:Colors.blueGrey )),
                       focusedBorder: UnderlineInputBorder(
                           borderSide:
                           BorderSide(color: Colors.blueGrey)),
                       enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10),
                           borderSide: BorderSide(
                               color: Colors.orange.shade300
                           )
                       )
                   ),
                 ),),
               Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Expanded(
                     child: CheckboxListTile(
                       title: Text("Remember me",style: TextStyle(fontSize: 13,fontWeight: FontWeight.normal,color: Colors.blueGrey),),
                       value: isChecked,
                       onChanged: (value) {
                         setState(() {
                           isChecked=value;
                         });
                       },
                       controlAffinity: ListTileControlAffinity.leading,
                       side: BorderSide(
                         color: Colors.blueGrey
                       ),//  <-- leading Checkbox
                     ),
                   ),
                   TextButton(
                     child: Text("Forgot Password?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.blueGrey)), onPressed: () {  },)
                 ],
               ),
               SizedBox(height: 30,),
               SizedBox(
                 width: 350,
                   height: 60,
                   child: ElevatedButton(
                       onPressed: (){
                         if(mykey.currentState!.validate()){
                           print("Button Pressed");
                         }
                         saveDataToStorage();
                         if(emailcntr.text=="admin@gmail.com" && passwordcntr.text=="123456"){
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepage(),));
                         }
                       },
                       child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                     style: ButtonStyle(
                       shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                         backgroundColor: MaterialStateProperty.all(Colors.orange.shade600),
                     ),
                   ))
             ],
           ),
                  ),
         ),)
       ),
     ),
    );
  }
  Future<void> saveDataToStorage() async{
    print(emailcntr.text);
    final prefs=await SharedPreferences.getInstance();
    await prefs.setString("saved_value", emailcntr.text);

  }
  Future<void> getSavedData(BuildContext context) async{
    final prefs=await SharedPreferences.getInstance();
    final savedValue=  prefs.getString("saved_value");
    if(savedValue!=null){
      emailcntr.text=savedValue;
    }
  }
}
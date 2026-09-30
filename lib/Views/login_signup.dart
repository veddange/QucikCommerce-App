import 'package:flutter/material.dart';
import 'package:quickcommerce_app/Views/ItemDetailView.dart';
import 'package:quickcommerce_app/Views/otp_verification.dart';

class LoginSignupView extends StatefulWidget {
  const LoginSignupView({super.key});

  @override
  State<LoginSignupView> createState() => _LoginSignupViewState();
}

class _LoginSignupViewState extends State<LoginSignupView> {
  TextEditingController mobileTxtField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.lightBlue],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                  ), // Adds space from the very top edge
                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      alignment: AlignmentGeometry.center,
                      children: [
                        Image.asset("brand_logo.png", height: 50),
                        
                        Positioned(
                          right: 0,
                          child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ) 
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Enter your mobile number",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: mobileTxtField,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "Enter Mobile Number",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.yellow,
                        minimumSize: const Size(600, 50),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => OtpVerification(),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Continue",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.arrow_circle_right,
                            color: Colors.black,
                            size: 15,
                          ),
                        ],
                      ),
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

// decoration: InputDecoration(
//                 hintText: "Enter Mobile Number",
//                 enabledBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10),
// borderSide: BorderSide(
//   color: Colors.amber
// )
//                 ),
//                 focusedBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10),
// borderSide: BorderSide(
//   color: Colors.blue
// ),

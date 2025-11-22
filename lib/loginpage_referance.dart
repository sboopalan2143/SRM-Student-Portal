import 'package:flutter/material.dart';

class StudentLoginPage extends StatefulWidget {
  const StudentLoginPage({super.key});

  @override
  State<StudentLoginPage> createState() => StudentLoginPageState();
}

class StudentLoginPageState extends State<StudentLoginPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  String message = '';
  final bool _isLoading = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  // key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 300,
                        height: 150,
                      ),
                      const SizedBox(height: 50),
                      Text(
                        'SRM STUDENT LOGIN',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 28,
                          color: Colors.blue.shade800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 50),
                      TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        controller: nameController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person_4_sharp,
                            // color: themeProvider.isDarkMode
                            //     ? Colors.blue.shade200
                            //     : Colors.blue.shade800,
                          ),
                          hintText: "NetID (without '@srmist.edu.in')",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        controller: pwdController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.key_sharp,
                            // color: themeProvider.isDarkMode
                            //     ? Colors.blue.shade200
                            //     : Colors.blue.shade800,
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          fixedSize: const Size(175, 50),
                          backgroundColor: Colors.blue.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Center(
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.blue.shade400,
                                )
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     // builder: (context) => const ChangePassword(),
                          //   ),
                          // );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue.shade800,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'Powered by',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      Image.asset(
                        'assets/images/eVarsity.png',
                        width: 200,
                        height: 50,
                      ),
                      const Text(
                        'V 13.9',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

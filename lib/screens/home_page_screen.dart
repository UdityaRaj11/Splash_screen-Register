import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:splash_screen_animation/modal/location.dart';
import 'package:splash_screen_animation/screens/great_job_screen.dart';

class HomePageScreen extends StatefulWidget {
  static const routeName = '/splash_screen';
  HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textcontroller = TextEditingController();
  String? pincode;
  Location? location;
  String _country = '';
  double turns = 0.0;
  bool animate = false;
  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    textcontroller.dispose();
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1)).then(
      (value) => setState(
        () {
          animate = true;
        },
      ),
    );
    await Future.delayed(const Duration(milliseconds: 1000)).then(
      (value) => setState(
        () {
          turns += 1.0 / 8.0;
        },
      ),
    );
  }

  List<Location> locations = [];

  Future _getLocations(pincode) async {
    final JsonDecoder decoder = const JsonDecoder();
    await http
        .get(Uri.parse("http://www.postalpincode.in/api/pincode/$pincode"))
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        throw Exception("Error while fetching data");
      }
      setState(() {
        var json = decoder.convert(res);
        var tmp = json['PostOffice'] as List;
        locations =
            tmp.map<Location>((json) => Location.fromJson(json)).toList();
        print(locations);
        location = locations.elementAt(0);
        print(location);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 600),
        opacity: animate ? 1 : 0,
        child: Container(
          color: const Color.fromARGB(255, 76, 55, 47),
          child: Stack(
            children: [
              Center(
                child: Card(
                  elevation: 7,
                  color: const Color.fromARGB(255, 41, 29, 25),
                  margin: const EdgeInsets.all(18),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedRotation(
                              duration: const Duration(milliseconds: 1600),
                              turns: turns,
                              child: const Image(
                                color: Color.fromARGB(255, 229, 206, 0),
                                image: AssetImage('assets/bg.png'),
                                height: 70,
                                width: 70,
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 10,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                right: 10,
                                top: 10,
                                bottom: 15,
                              ),
                              child: const Card(
                                elevation: 9,
                                color: Color.fromARGB(255, 76, 55, 47),
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    'Register Now!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 221, 221, 221),
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 14),
                                  key: const ValueKey('email'),
                                  autocorrect: false,
                                  textCapitalization: TextCapitalization.none,
                                  enableSuggestions: false,
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !value.contains('@')) {
                                      return 'Please enter a valid email address.';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    labelText: 'Email address',
                                  ),
                                  onSaved: (value) {},
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 14),
                                  key: const ValueKey('username'),
                                  autocorrect: true,
                                  textCapitalization: TextCapitalization.words,
                                  enableSuggestions: false,
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 4) {
                                      return 'Please Enter atleast 4 characters';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Username',
                                  ),
                                  onSaved: (value) {},
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 14),
                                  key: const ValueKey('mobile_number'),
                                  autocorrect: true,
                                  textCapitalization: TextCapitalization.words,
                                  enableSuggestions: false,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 9) {
                                      return 'Please Enter atleast 9 characters';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Mobile Number',
                                  ),
                                  onSaved: (value) {},
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 14),
                                  key: const ValueKey('fullname'),
                                  autocorrect: true,
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.name,
                                  enableSuggestions: false,
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 5) {
                                      return 'Please Enter atleast 4 characters';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Full Name',
                                  ),
                                  onSaved: (value) {},
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
                                  elevation: 5,
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    width: 125,
                                    child: TextFormField(
                                      onFieldSubmitted: (value) {
                                        setState(() {
                                          pincode = value;
                                          _getLocations(pincode).then((_) {
                                            setState(() {
                                              _country =
                                                  location!.country.toString();
                                              textcontroller.text = _country;
                                            });
                                          });
                                        });
                                      },
                                      style: const TextStyle(fontSize: 14),
                                      key: const ValueKey('pincode'),
                                      autocorrect: true,
                                      keyboardType: TextInputType.number,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      enableSuggestions: false,
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 5) {
                                          return 'Please Enter atleast 4 characters';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Pincode',
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 5,
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    width: 150,
                                    child: TextFormField(
                                      controller: textcontroller,
                                      style: const TextStyle(fontSize: 14),
                                      key: const ValueKey('Country'),
                                      autocorrect: true,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      keyboardType: TextInputType.streetAddress,
                                      enableSuggestions: true,
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 5) {
                                          return 'Please Enter atleast 4 characters';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Country',
                                      ),
                                      onSaved: (value) {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 14),
                                  key: const ValueKey('password'),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 7) {
                                      return 'Password must be at least 7 characters long.';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Password',
                                  ),
                                  onSaved: (value) {},
                                  obscureText: true,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Keep it up!!')),
                                  );
                                  _formKey.currentState!.reset();
                                  textcontroller.clear();
                                  Navigator.of(context)
                                      .pushNamed(GreatJobScreen.routeName);
                                }
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('I\'ve already registered.'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

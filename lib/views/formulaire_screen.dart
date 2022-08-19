import 'package:agency/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../components/widgets.dart';

class FormulairePage extends StatefulWidget {
  const FormulairePage({Key? key}) : super(key: key);

  @override
  State<FormulairePage> createState() => _FormulairePageState();
}

class _FormulairePageState extends State<FormulairePage> {
  final formkey = GlobalKey<FormState>();
  final GlobalKey<SlideActionState> key = GlobalKey();
  bool isloading = false;
  User user = User();
  TextEditingController name_controller = TextEditingController();
  TextEditingController passport_code_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController lastname_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController wilaya_controller = TextEditingController();
  TextEditingController commune_controller = TextEditingController();
  TextEditingController DOBcontroller = TextEditingController();
  TextEditingController Nationalitycontroller = TextEditingController();
  TextEditingController state_controller = TextEditingController();
  TextEditingController city_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "Bienvenue",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                    color: Colors.black87),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              width: 55,
              height: 2,
              color: Colors.blue,
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "veuillez remplir vos informations personnelles",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      defaultTextField(
                        validator: (value) {
                          if (value.isEmpty || value.toString().trim() == '') {
                            return "ce champ est obligatoire ";
                          } else {
                            return null;
                          }
                        },
                        controller: name_controller,
                        labeltext: "Nom*",
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextField(
                          validator: (value) {
                            if (value.isEmpty ||
                                value.toString().trim() == '') {
                              return "ce champ est obligatoire ";
                            } else {
                              return null;
                            }
                          },
                          controller: lastname_controller,
                          labeltext: "Prenom*",
                          keyboardType: TextInputType.text),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextField(
                          controller: email_controller,
                          labeltext: "email",
                          keyboardType: TextInputType.emailAddress),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextField(
                          validator: (value) {
                            if (value.isEmpty ||
                                value.toString().trim() == '') {
                              return "ce champ est obligatoire ";
                            } else {
                              return null;
                            }
                          },
                          controller: phone_controller,
                          labeltext: "telephone*",
                          keyboardType: TextInputType.number),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: DOBcontroller,
                        onTap: () async {
                          DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.parse('1920-12-12'),
                            lastDate: DateTime.now(),
                          ).then((value) {
                            if (value != null) {
                              DOBcontroller.text =
                                  DateFormat.yMMMd().format(value);
                            }

                            setState(() {
                              print(DOBcontroller.text);
                            });
                            return null;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: 'Date de naissance',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        keyboardType: TextInputType.none,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextField(
                          validator: (value) {
                            if (value.isEmpty ||
                                value.toString().trim() == '') {
                              return "ce champ est obligatoire ";
                            } else {
                              return null;
                            }
                          },
                          controller: passport_code_controller,
                          labeltext: "code passport*",
                          keyboardType: TextInputType.number),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextField(
                        keyboardType: TextInputType.none,
                        validator: (value) {
                          if (value.isEmpty || value.toString().trim() == '') {
                            return "ce champ est obligatoire ";
                          } else {
                            return null;
                          }
                        },
                        controller: Nationalitycontroller,
                        labeltext: "Nationalite*",
                        function: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode:
                                true, // optional. Shows phone code before the country name.
                            onSelect: (Country country) {
                              Nationalitycontroller.text =
                                  country.displayNameNoCountryCode;
                              print('Selected country: ${country.displayName}');
                              user.nationality = Nationalitycontroller.text;
                              user.time = DateTime.now().toString().trim();
                              print(user.time);
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CSCPicker(
                        onCountryChanged: (value) {
                          setState(() {
                            state_controller.text = value.toString();
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            state_controller.text = value.toString();
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            city_controller.text = value.toString();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SlideAction(
                elevation: 0,
                text: " Glisser pour proceder",
                alignment: Alignment.center,
                textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                outerColor: Colors.black87,
                key: key,
                onSubmit: () {
                  Future.delayed(const Duration(microseconds: 50), () async {
                    if (formkey.currentState!.validate()) {
                      dataRetrievefromControllerstoUserModel(user);
                      if (await checkConnectionAvailability()) {
                        createFirebaseUser();
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Attention !'),
                                  content: Row(
                                    children: const [
                                      Flexible(
                                          flex: 2,
                                          child: Text(
                                              'verifier votre connexion internet')),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Flexible(
                                          flex: 1,
                                          child: Icon(
                                            Icons
                                                .signal_wifi_connected_no_internet_4_rounded,
                                            color: Colors.redAccent,
                                            size: 60,
                                          )),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(color: Colors.blue),
                                        )),
                                  ],
                                ));
                      }
                    }
                    key.currentState?.reset();
                  });
                  Alignment.centerRight;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  dataRetrievefromControllerstoUserModel(User user) {
    user.firstName = name_controller.text;
    user.lastName = lastname_controller.text;
    user.email = email_controller.text;
    user.phone = phone_controller.text;
    user.dateOfBirth = DOBcontroller.text;
    user.passportCode = passport_code_controller.text;
    user.nationality = Nationalitycontroller.text;
    user.state = state_controller.text;
    user.city = city_controller.text;
    user.time =
        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}  ${DateTime.now().hour}:${DateTime.now().minute}';

    // print(user.time+'      '+user.passportCode+user.nationality+user.city);
  }

  createFirebaseUser() async {
    setState(() {
      isloading = true;
    });
    final json = user.toJson();
    final documentUser =
        FirebaseFirestore.instance.collection('users').doc(user.passportCode);
    final doc = await documentUser.get();
    if (!doc.exists) {
      setState(() {
        isloading = true;
      });
      await documentUser.set(json);
      customDialog(
          title: 'félicitation',
          label: 'vos coordonnées sont ajoutés',
          icon: const Icon(
            Icons.gpp_good,
            color: Colors.lightGreen,
            size: 60,
          ),
          context: context);
    } else {
      print('user already exists');
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Attention'),
                content: Row(
                  children: const [
                    Flexible(
                        flex: 2,
                        child: Text(
                            'vérifiez votre code passport (code passport existe déja')),
                    SizedBox(
                      width: 30,
                    ),
                    Flexible(
                        flex: 1,
                        child: Icon(
                          Icons.error_outline_outlined,
                          color: Colors.redAccent,
                          size: 60,
                        )),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(color: Colors.blue),
                      )),
                ],
              ));
    }

    setState(() {
      isloading = false;
    });
  }

  checkConnectionAvailability() async {
    return await InternetConnectionChecker().hasConnection;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../../Themeing/themeing.dart';
import '../../authenticate/authenticating.dart';
import '../../main.dart';
import '../../services/bottom_appbar.dart';
import '../cart.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          margin: const EdgeInsets.all(10),
          child: settingsView(),
        ),
      ),
      bottomNavigationBar: bottomAppBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: ((context) => const CartScreen())));
        },
        child: const Icon(Icons.shopping_cart_checkout_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  bool isFirstTime = true;

  settingsView() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListTile(
            leading: const Text('Profile'),
            trailing: const Icon(Icons.person_rounded),
            onTap: (() => isFirstTime
                ? Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => createUserProfile())))
                : Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => userProfile(context)))))),
        ListTile(
          leading: const Text('Your Orders'),
          trailing: const Icon(Icons.shopping_bag_rounded),
          onTap: (() => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: ((context) => const CartScreen())))),
        ),
        ListTile(
          leading: const Text('About App'),
          trailing: const Icon(Icons.app_shortcut_rounded),
          onTap: (() => dialogOfAbout()),
        ),
        ListTile(
          leading: const Text('Switch theme'),
          trailing: const Icon(Icons.colorize_rounded),
          onTap: (() => dialogOfSwitchingTheme()),
        ),
        ListTile(
          leading: const Text('Sign out'),
          trailing: const Icon(Icons.logout_rounded),
          onTap: (() {
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => const MainPage())));
          }),
        ),
      ],
    );
  }

  dialogOfAbout() {
    const String textOfAboutBooks =
        "A stop to order your favorite books at an impressive price with no compromise in quality with good customer service too where you get the world's most loved books.";
    const String textOfAboutUsage =
        "You'll have to Sign up and verify your email then books are divided into different categories here. The orders will be tracked down and will show in the cart accordingly.You can't order more than 10 books per order .There is functionality to switch between different themes. Email to the id below for any inconvenience";
    const String developerId = "sakib.developer1@gmail.com";

    textAboutApp() => const Wrap(
          runSpacing: 5,
          children: [
            Text(
              'About App',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(textOfAboutBooks),
            Text(
              'App Usage',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(textOfAboutUsage),
            Text(
              'Developer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(developerId),
          ],
        );

    return showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            contentPadding: const EdgeInsets.all(2),
            content: Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: textAboutApp(),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Back',
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          )),
    );
  }

  userProfile(
    BuildContext context,
  ) {
    showintProfileImage() {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 110,
          ),
          CircleAvatar(
            radius: 20,
            child: Icon(Icons.person),
          ),
        ],
      );
    }

    Stream<List<User>> readUsers() => FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

    buildUserProfile(User? currentUser) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(2),
        content: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Wrap(
                direction: Axis.vertical,
                runSpacing: 5,
                spacing: 10,
                children: [
                  showintProfileImage(),
                  const Text(
                    'Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(currentUser!.name),
                  const Text(
                    'Age',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(currentUser.age),
                  const Text(
                    'Email',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(currentUser.userEmail),
                ]),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Back',
                style: TextStyle(color: Colors.blue),
              ))
        ],
      );
    }

    return Scaffold(
      body: StreamBuilder<List<User>>(
          stream: readUsers(),
          builder: ((context, snapshot) {
            User? currentUser;
            if (snapshot.hasData) {
              final users = snapshot.data;
              for (var user in users!.map((user) => user)) {
                if (user.userEmail ==
                    FirebaseAuth.instance.currentUser!.email) {
                  currentUser = user;
                }
              }
              return buildUserProfile(currentUser);
            } else {
              return const Center(child: Text('Error loading profile'));
            }
          })),
    );
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final getUserEmail = FirebaseAuth.instance.currentUser!.email;

  createUserProfile() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textfields(_nameController, 'Full name', null),
            const SizedBox(
              height: 5,
            ),
            textfields(_ageController, 'Age', TextInputType.number),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
                onPressed: () => createUser(context),
                child: const Text('Create Profile'))
          ],
        ),
      ),
    );
  }

  Future createUser(BuildContext context) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    final jsonDoc = User(
        name: _nameController.text.trim(),
        age: _ageController.text.trim(),
        userId: FirebaseFirestore.instance.hashCode,
        userEmail: getUserEmail.toString().trim());

    try {
      await docUser.set(jsonDoc.toJson());
      ToastContext().init(context);
      Toast.show('Profile created successfully', duration: 3);
      Navigator.of(context).pop();
      isFirstTime = false;
    } on FirebaseException catch (_) {
      Utilis.showSnackBar('Error creating profile. Try again later');
      Navigator.of(context).pop();
    }

    if (!mounted) {
      _nameController.dispose();
      _ageController.dispose();
    }
  }

  textfields(TextEditingController controller, String hintText,
      TextInputType? inputType) {
    return SizedBox(
      height: 80,
      width: 250,
      child: TextField(
        keyboardType: inputType,
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText, border: const OutlineInputBorder()),
      ),
    );
  }

  dialogOfSwitchingTheme() {
    circleAvatarThemes() {
      List<Color> themeColors = [
        const Color(0xFFC4E4E9), //blue
        const Color(0xFFAEE6A6), //green
        const Color(0xFF464846), //black
        const Color(0XFFf48fb1), //red
        const Color(0xFFD1C4E9), //purple
      ];

      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: themeColors.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                child: InkWell(
                  onTap: () {
                    currentTheme = themeColors[index];
                    runApp(const App());
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: themeColors[index],
                  ),
                ),
              ),
            );
          });
    }

    showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            contentPadding: const EdgeInsets.all(2),
            content: SizedBox(
              height: 100,
              width: 50,
              child: Card(
                child: circleAvatarThemes(),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Back',
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          )),
    );
  }
}

class User {
  String name;
  String age;
  String userEmail;
  int userId;
  User(
      {required this.name,
      required this.age,
      required this.userEmail,
      required this.userId});

  Map<String, dynamic> toJson() =>
      {'name': name, 'age': age, 'userEmail': userEmail, 'id': userId};

  static User fromJson(Map<String, dynamic> json) => User(
      name: json['name'],
      age: json['age'],
      userEmail: json['userEmail'],
      userId: json['id']);
}

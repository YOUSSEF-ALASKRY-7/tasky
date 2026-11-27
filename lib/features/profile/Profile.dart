import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:tasky/features/welcome/Welcome_screan.dart';
import 'package:tasky/features/profile/useredit.dart';
import 'package:tasky/core/theme/theme_controler.dart';
import 'package:tasky/main.dart';

import '../../core/services/preferences_manger.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? name;
  String? qouite;
  bool? darkmood;
  File? SelectedImage;
  String? imagepath;

  @override
  void initState() {
    super.initState();
    get_name();
  }

  Future<void> get_name() async {
    if (!mounted) return;
    setState(() {
      name = PreferencesManger().getString("name") ?? "gust";
      qouite =
          PreferencesManger().getString("quote") ??
          "One task at a time. One step closer.";
      darkmood = PreferencesManger().getBool("darkmood") ?? false;
      imagepath = PreferencesManger().getString("userImage");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Profile")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 85,
                        backgroundColor: Colors.transparent,
                        backgroundImage: imagepath == null
                            ? AssetImage("assets/Thumbnail.png")
                            : FileImage(File(imagepath!)),
                      ),

                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async{
                            imageDaloge(context, (image) {
                              setState(() {
                                get_name();
                              });
                            });

                          },
                          child: SizedBox(
                            height: 34,
                            width: 34,
                            child: CircleAvatar(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text("$name", style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 4),
                  Text(
                    "${qouite ?? "One task at a time.One step closer."}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            Text("Profile Info", style: Theme.of(context).textTheme.titleLarge),

            ListTile(
              contentPadding: EdgeInsets.zero,

              title: Text(
                "User Details",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              leading: SvgPicture.asset(
                "assets/profile_Icon.svg",
                colorFilter: ColorFilter.mode(
                  Theme.of(context).iconTheme.color!,
                  BlendMode.srcIn,
                ),
              ),
              trailing: IconButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Useredit()),
                  );

                  if (result == true) {
                    get_name();
                  }
                },
                icon: Icon(Icons.arrow_forward),
              ),
            ),

            Divider(thickness: 1),

            ListTile(
              contentPadding: EdgeInsets.zero,

              title: Text(
                "Dark Mode",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              leading: Icon(Icons.nightlight_outlined),

              trailing: ValueListenableBuilder(
                valueListenable: ThemeControler.themenotifier,
                builder: (context, value, Widget? child) {
                  return Switch(
                    value: value == ThemeMode.dark,
                    onChanged: (value) {
                      ThemeControler.toggle();
                    },
                  );
                },
              ),
            ),
            Divider(thickness: 1),
            ListTile(
              onTap: () async {
                PreferencesManger().remove("quote");
                PreferencesManger().remove("name");
                PreferencesManger().remove("tasks");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => WelcomeScrean()),
                );
              },
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Log Out",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              leading: Icon(Icons.logout),
              trailing: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveimage(XFile file) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final newfile = await File(
      file.path,
    ).copy("${appDocumentsDir.path}/${file.name}");
    PreferencesManger().setString("userImage", newfile.path);
  }

  void imageDaloge(BuildContext context, Function(File) selectedFileImage) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Choose Image :"),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                XFile? image = await picker.pickImage(
                  source: ImageSource.camera,
                );

                if (image != null) {
                  Navigator.pop(context);
                  await saveimage(image);
                  selectedFileImage(File(image.path));
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Icon(Icons.camera_alt), Text("Camera")],
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                );

                if (image != null) {
                  Navigator.pop(context);
                 await saveimage(image);
                  selectedFileImage(File(image.path));
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Icon(Icons.photo_library_outlined), Text("Gallary")],
              ),
            ),
          ],
        );
      },
    );
  }
}

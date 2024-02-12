import 'package:cartafri/core/functionality/Image_selector.dart';
import 'package:cartafri/core/utils/constants/color_constants.dart';
import 'package:cartafri/core/utils/constants/constants.dart';
import 'package:cartafri/core/utils/theme/pallete.dart';
import 'package:cartafri/features/auth/controller/authController.dart';
import 'package:cartafri/features/auth/models/user_model.dart';
import 'package:cartafri/router.dart';
import 'package:cartafri/screens/AppScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class SplashScreen1 extends ConsumerStatefulWidget {
  const SplashScreen1({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends ConsumerState<SplashScreen1>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation scaleAnimation;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    scaleAnimation = Tween<double>(begin: 1, end: 1).animate(controller);
    controller.addListener(() {
      if (controller.isCompleted) {
        ref.watch(authStateChangeProvider).whenData((data) {
          if (data != null) {
            getData(ref, data);
            if (userModel != null) {
              return loggedInRoute;
            }
          }
          return loggedOutRoute;
        });
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    final String text = lorem(paragraphs: 1, words: 20);
    final theme = ref.watch(themeNotifierProvider.notifier).mode;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 1,
              ),
              SizedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(ImagePicker().getFirstImage(),
                      colorBlendMode: BlendMode.screen,
                      height: 200.0,
                      width: 200,
                      fit: BoxFit.fill),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text(
                      "Find Lots of products\n around the world",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              kSizedBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(text),
              ),
              const Spacer(
                flex: 1,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: TextButton(
                          onPressed: () {}, child: const Text('SKIP'))),
                  const SplashDivider(
                    width: 3.5,
                  ),
                  const SizedBox(
                    width: 3.0,
                  ),
                  SplashDivider(
                    width: 10,
                    color: theme == ThemeMode.dark
                        ? ColorConstants.kCardColor
                        : ColorConstants.kCardColorD,
                  ),
                  const SizedBox(
                    width: 3.0,
                  ),
                  SplashDivider(
                    width: 10,
                    color: theme == ThemeMode.dark
                        ? ColorConstants.kCardColor
                        : ColorConstants.kCardColorD,
                  ),
                  const Spacer()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  UserModel? userModel;
  // gets the user data
  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }
}

class SplashDivider extends StatelessWidget {
  const SplashDivider({super.key, this.color, required this.width});
  final double width;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / width,
      child: Divider(
        thickness: 3.0,
        color: color ?? ColorConstants.kButtonColor,
      ),
    );
  }
}

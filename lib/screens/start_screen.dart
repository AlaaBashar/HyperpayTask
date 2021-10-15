import 'package:flutter/material.dart';
import '../export.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(
                flex: 2,
              ),
              SvgPicture.asset(
                ImageHelper.LOGO_SVG,
              ),
              const Spacer(
                flex: 1,
              ),
              SvgPicture.asset(
                ImageHelper.ILLUSTRATION_SVG,
                width: getScreenWidth(context),
                fit: BoxFit.fitWidth,
              ),
              const Spacer(
                flex: 3,
              ),
              const Text(
                'More than just\nshorter links',
                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 35.0,
                  fontFamily: 'Poppins-Bold',

                ),
              ),
              const Spacer(
                flex: 1,
              ),
              const Text(
                'Build your brand\'s recognition and\nget detailed insights on how your\nlinks are performing.',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(
                flex: 3,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: MaterialButton(
                  onPressed: onStart,
                  color: ColorsHelper.CYAN,
                  height: 50,
                  minWidth: getScreenWidth(context),
                  child: Text(
                    'START',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24.0),
                  ),
                ),
              ),
              const Spacer(
                flex: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onStart() {
    openNewPage(context, BenefitsScreen(), popPreviousPages: true);
  }
}

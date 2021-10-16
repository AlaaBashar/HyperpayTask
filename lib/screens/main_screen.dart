import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../export.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController urlController = TextEditingController();

  bool? isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsHelper.OF_WIGHT,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (_, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      getMainUI(),
                      const Spacer(
                        flex: 1,
                      ),
                      Container(
                        width: double.infinity,
                        color: ColorsHelper.DARK_VIOLET,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: SvgPicture.asset(ImageHelper.SHAPE_SVG),
                            ),
                            Container(
                              height: getScreenHeight(context) / 4,
                              padding: EdgeInsets.symmetric(horizontal: 37),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 55.0,
                                    alignment: Alignment.center,
                                    child: TextFormField(
                                      controller: urlController,
                                      textAlign: TextAlign.center,
                                      onChanged: onChangeUrl,
                                      keyboardType: TextInputType.url,
                                      inputFormatters: [
                                        FilteringTextInputFormatter(new RegExp(r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?")  , allow: true)
                                      ],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: isError! ? 'Please add a link here':'Shorten a link here ...',
                                        fillColor: ColorsHelper.WIGHT,

                                        filled: true,
                                        hintStyle: TextStyle(
                                            color: isError! ? ColorsHelper.RED :  ColorsHelper.LIGHT_GRAY,
                                            fontFamily: 'Poppins-Light',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: isError!
                                                    ? ColorsHelper.RED
                                                    : Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: isError!
                                                    ? ColorsHelper.RED
                                                    : Colors.white)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  MaterialButton(
                                    onPressed: onShorten,
                                    color: ColorsHelper.CYAN,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(4.0),
                                    ),
                                    minWidth: getScreenWidth(context,
                                        realWidth: true),
                                    height: 55,
                                    child: const Text(
                                      'SHORTEN IT!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'Poppins-Bold',
                                          fontSize: 18.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    urlController.dispose();
    super.dispose();
  }

  void onShorten() {
    String? url = urlController.text ;

    if(url.isEmpty) {
      setState(() {
        isError = true;
      });
    }
  }

  Widget getMainUI() => Column(
        children: [
          SvgPicture.asset(
            ImageHelper.LOGO_SVG,
          ),
          SvgPicture.asset(
            ImageHelper.ILLUSTRATION_SVG,
          ),
          Text(
            'Let\'s get started!',
            style: TextStyle(fontSize: 18.0, fontFamily: 'Poppins-Bold'),
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Text(
            'Paste your first link into\nthe field to shorten it ',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      );

  void onChangeUrl(String value) {
    if (isError!)
      setState(() {
        isError = false;
      });
  }
}

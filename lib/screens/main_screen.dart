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
  late ShortlyBloc bloc;
  TextEditingController urlController = TextEditingController();
  bool? isError = false;
  bool? isCopied = false;
  int? selectId;
  late DbHelper helper;
  List<ShortlyModelDB>? shortlyDBList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDate();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    urlController.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsHelper.OF_WIGHT,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (_, constraints) {
                  return SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
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
                            const Spacer(
                              flex: 1,
                            ),
                            shortlyDBList == null || shortlyDBList!.isEmpty
                                ? getMainUI()
                                : Column(
                                  children: [
                                    const Text('Your history link',style: TextStyle(fontFamily: 'Poppins-Bold'),),
                                   const SizedBox(height: 30.0,),

                                    Container(
                                      height: 500,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: shortlyDBList!.length,
                                          itemBuilder: (_, index) {
                                            ShortlyModelDB shortlyModel =
                                                shortlyDBList![index];
                                            return Column(
                                              children: [
                                                Container(
                                                  width: getScreenWidth(context) -
                                                      20.0,
                                                  child: Card(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  '${shortlyModel.originalLink}'),
                                                              Spacer(
                                                                flex: 4,
                                                              ),
                                                              GestureDetector(
                                                                  onTap: () {
                                                                     helper.deleteShortLink(shortlyDBList![index].id!);

                                                                  },
                                                                  child: SvgPicture
                                                                      .asset(ImageHelper
                                                                          .DEL_SVG)),
                                                              Spacer(
                                                                flex: 1,
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(
                                                            thickness: 2,
                                                          ),
                                                          Text(
                                                              '${shortlyModel.shortlyLink}'),
                                                           MaterialButton(
                                                                  onPressed: () {

                                                                    Clipboard.setData(ClipboardData(
                                                                            text: shortlyDBList![index].shortlyLink)).then((value) {
                                                                              final snackBar = SnackBar(
                                                                        content: Text(
                                                                            'Copied the short link'),
                                                                        action:
                                                                            SnackBarAction(
                                                                          label:
                                                                              'Undo',
                                                                          onPressed:
                                                                              () {},
                                                                        ),
                                                                      );
                                                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);});
                                                                    setState(() {isCopied = true;});

                                                                      },
                                                                  color:ColorsHelper.CYAN,
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                4.0),
                                                                  ),
                                                                  minWidth: getScreenWidth(context, realWidth: true),
                                                                  height: 40,
                                                                  child: const Text(
                                                                    'COPY',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white,
                                                                        fontFamily:
                                                                            'Poppins-Bold',
                                                                        fontSize:
                                                                            18.0),
                                                                  ),)

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                )
                                              ],
                                            );
                                          }),
                                    ),
                                  ],
                                ),
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
                                    child:
                                        SvgPicture.asset(ImageHelper.SHAPE_SVG),
                                  ),
                                  Container(
                                    height: getScreenHeight(context) / 4,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 37),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              // FilteringTextInputFormatter(
                                              //     new RegExp(
                                              //         r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?"),
                                              //     allow: true)
                                            ],
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: isError!
                                                  ? 'Please add a link here'
                                                  : 'Shorten a link here ...',
                                              fillColor: ColorsHelper.WIGHT,
                                              filled: true,
                                              hintStyle: TextStyle(
                                                  color: isError!
                                                      ? ColorsHelper.RED
                                                      : ColorsHelper.LIGHT_GRAY,
                                                  fontFamily: 'Poppins-Light',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                  borderSide: BorderSide(
                                                      width: 1.0,
                                                      color: isError!
                                                          ? ColorsHelper.RED
                                                          : Colors.white)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
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
                                          onPressed: (){
                                            onShorten();

                                          },
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
          ],
        ),
      ),
    );
  }


  void onShorten() {
    String? url = urlController.text;

    if (url.isEmpty) {
      setState(() {
        isError = true;
        isCopied = true;
      });
    }
   else{

      ShortlyBloc.get(context).add(FetchUrlEvent(url));


      final snackBar = SnackBar(
        content: Text(
            'Copied the short link'),
        action:
        SnackBarAction(
          label:
          'Undo',
          onPressed:
              () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);



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

  }

  void loadDate() async {
    DbHelper? dbHelper = DbHelper();

    shortlyDBList = await dbHelper.getAllShortlyLinks();

    print('============ ${shortlyDBList?.length}');
    setState(() {});
  }
}
/*
* Expanded(
              child: LayoutBuilder(
                builder: (_, constraints) {
                  return SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
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
                            shortlyDBList == null || shortlyDBList!.isEmpty
                                ? getMainUI()
                                : Container(
                                  height: 350,
                                  child: ListView.builder(
                                      itemCount: shortlyDBList!.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (_, index) {
                                        ShortlyModelDB shortlyModel = shortlyDBList![index];
                                        return Text('${shortlyModel.shortlyLink}');
                                      }),
                                ),
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
                                              // FilteringTextInputFormatter(
                                              //     new RegExp(
                                              //         r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?"),
                                              //     allow: true)
                                            ],
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: isError!
                                                  ? 'Please add a link here'
                                                  : 'Shorten a link here ...',
                                              fillColor: ColorsHelper.WIGHT,
                                              filled: true,
                                              hintStyle: TextStyle(
                                                  color: isError!
                                                      ? ColorsHelper.RED
                                                      : ColorsHelper.LIGHT_GRAY,
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
                                            borderRadius: BorderRadius.circular(4.0),
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
* */

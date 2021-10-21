import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../export.dart';

class BenefitsScreen extends StatefulWidget {
  const BenefitsScreen({Key? key}) : super(key: key);

  @override
  _BenefitsScreenState createState() => _BenefitsScreenState();
}

class _BenefitsScreenState extends State<BenefitsScreen> {

  final CarouselController _controllerSlider = CarouselController();
  int? _currentIndex = 0;


  List<Map<String, dynamic>> _benefitsList = [
    {
      'title': 'Brand Recognition',
      'subTitle':
          'Boost your brand recognition with each click. Generic links don\'t mean a thing. Branded links help instil confidence in your content.',
      'icon': ImageHelper.DIAGRAM_SVG,
    },
    {
      'title': 'Detailed Records',
      'subTitle':
          'Gain insights into who is clicking your links. Knowing when and where people engage with your content helps inform better decisions.',
      'icon': ImageHelper.GAUGE_SVG,
    },
    {
      'title': 'Fully Customizable',
      'subTitle':
      'Improve brand awareness and content discoverability through customizable links, supercharging audience engagement',
      'icon': ImageHelper.TOOLS_SVG,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsHelper.OF_WIGHT,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (_ , constraints){
            return SingleChildScrollView(

              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),

                child: IntrinsicHeight(
                  child: Column(

                    children: [

                      const Spacer(
                        flex: 1,
                      ),

                      SvgPicture.asset(
                        ImageHelper.LOGO_SVG,
                      ),

                      const Spacer(
                        flex: 2,
                      ),

                      CarouselSlider(
                        carouselController: _controllerSlider,
                        options: CarouselOptions(
                            height: 350,
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                            onPageChanged: onChangedSlider),
                        items: _benefitsList.map(
                              (data) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 50.0),
                                      child: Card(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const Spacer(
                                              flex: 3,
                                            ),
                                            Text(
                                              data['title'],
                                            style: TextStyle(fontFamily: 'Poppins-Bold'),),
                                            const Spacer(
                                              flex: 1,
                                            ),
                                            Text(
                                              data['subTitle'],
                                              style: TextStyle(fontWeight: FontWeight.w900),
                                              textAlign: TextAlign.center,
                                            ),
                                            const Spacer(
                                              flex: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: CircleAvatar(
                                        radius: 50.0,
                                        backgroundColor: ColorsHelper.DARK_VIOLET,
                                        child:
                                        SvgPicture.asset(data['icon'].toString()),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ).toList(),
                      ),

                      const SizedBox(height: 16.0,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _benefitsList.asMap().entries.map((entry) {
                          return InkWell(
                            onTap: () => _controllerSlider.animateToPage(entry.key),
                            child: Container(
                              width: 12.0,
                              height: 12.0,
                              margin:
                              EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: _currentIndex == entry.key
                                          ? ColorsHelper.VERY_DARK_VIOLET
                                          : ColorsHelper.VERY_DARK_VIOLET,
                                      width: 1.5),
                                  color: _currentIndex == entry.key
                                      ? ColorsHelper.VERY_DARK_VIOLET
                                      : Colors.transparent),
                            ),
                          );
                        }).toList(),
                      ),

                      const Spacer(flex: 2,),

                      CupertinoButton(
                        child: Text('Skip',style: TextStyle(color: Colors.black),),
                        onPressed: onSkip,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ) ;
          },
        ),
      ),
    );
  }

  void onChangedSlider(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentIndex = index;
    });
  }

  void onSkip() {
   openNewPage(context, MainScreen(), popPreviousPages: true);

  }
}

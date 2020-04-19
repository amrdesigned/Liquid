import 'package:liquid/liquid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LiquidApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      // builder: (context, child) => child,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result;

  void _showModel() {
    showLModel(context,
        positionTween: Tween(begin: Offset(0, 10.0), end: Offset.zero),
        barrierDismissable: true, builder: (context) {
      return LModel(
        positon: MainAxisAlignment.end,
        margin: EdgeInsets.all(20.0),
        header: LModelHeader(
          title: "Terms & Conditions",
          onClose: () {
            setState(() {
              result = "Canceled";
            });
          },
        ),
        body: LModelBody(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SelectableText(
                """Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Praesencibus dolor auctor.Aenean lacinia bibendum nulla sed consectetur. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Donec sed odio dui. Donec ullamcorper nulla non metus auctor fringilla."""),
          ),
        ),
        footer: LModelFooter(
          actions: <Widget>[
            LButton(
              text: "Cancel",
              onPressed: () async {
                final _ = await LiquidStateManager.of(context)
                    .popModel<String>("Helllo world");
                setState(() {
                  result = _;
                });
              },
              type: ButtonType.secondary,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              margin: const EdgeInsets.only(right: 5.0),
            ),
            LButton(
              text: "Accept",
              onPressed: () async {
                final _ = await LiquidStateManager.of(context)
                    .popModel<String>("Terms Accepted");
                setState(() {
                  result = _;
                });
              },
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(result ?? widget.title),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0),
        child: LColumn(
          children: <Widget>[
            LRow(children: [
              LColumn(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LAlert(
                    "Aww yeah, you successfully read this important alert message. This example text is going to run a bit longer so that you can see how spacing within an alert works with this kind of content.",
                    heading: "Well done!",
                    type: LAlertType.success,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 7.0),
                    child: LBreadCrumbs(
                      items: [
                        LBreadCrumbItem(
                          "Home",
                          onTap: () {},
                        ),
                        LBreadCrumbItem(
                          "Library",
                          onTap: () {},
                        ),
                        LBreadCrumbItem(
                          "Data",
                          active: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              LColumn(
                children: <Widget>[
                  LBox(
                    height: LBoxDimension(
                      xl: 450.0,
                      lg: 350.0,
                      md: 250.0,
                      sm: 200.0,
                      xs: 200.0,
                    ),
                    child: LCorousel(
                      withCaption: true,
                      autoScroll: true,
                      withControls: true,
                      canScroll: true,
                      showIndicator: true,
                      enableIndicatorTapControl: true,
                      items: [
                        LCorouselItem(
                          child: Image.network(
                            "https://source.unsplash.com/random/?mountain",
                            fit: BoxFit.cover,
                          ),
                          caption: LCorouselCaption(
                            titleText: "First Slide",
                            subTitleText: "Cool Work Cool Work Cool",
                            actions: <Widget>[
                              LButton(
                                text: "Accept",
                                onPressed: _showModel,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                margin: const EdgeInsets.all(5.0),
                              ),
                            ],
                          ),
                        ),
                        LCorouselItem(
                          child: Image.network(
                            "https://source.unsplash.com/random/?mountain,sunset",
                            fit: BoxFit.cover,
                          ),
                        ),
                        LCorouselItem(
                          child: Image.network(
                            "https://source.unsplash.com/random/?sunrise",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
            LRow(
              gutter: 0,
              children: [
                LColumn(
                  xs: 6,
                  xl: 1,
                  children: <Widget>[
                    LBadges(
                      "Hello",
                      shape: BadgesShape.standard,
                      type: BadgesType.dark,
                    ),
                  ],
                ),
                LColumn(
                  xs: 6,
                  xl: 3,
                  children: <Widget>[
                    LButton(
                      type: ButtonType.success,
                      shape: ButtonShape.standard,
                      text: "hello",
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            LRow(gutter: 5.0, children: [
              LColumn(
                sm: 6,
                children: <Widget>[
                  LModel(
                    header: LModelHeader(
                      title: "Hello World",
                      onClose: () {},
                    ),
                    body: LModelBody(
                      padding: EdgeInsets.zero,
                      child: LCard(
                        radius: 0.0,
                        width: null,
                        border:
                            Border.all(width: 0.0, color: Colors.transparent),
                        image: LCardImage(
                          image: NetworkImage(
                              'https://source.unsplash.com/random/?girl'),
                          fit: BoxFit.cover,
                        ),
                        body: LCardBody(
                          title: "hasjhdja",
                        ),
                      ),
                    ),
                    footer: LModelFooter(
                      actions: <Widget>[
                        LOutlineButton(
                          text: "Cancel",
                          onPressed: () {},
                          type: ButtonType.primary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          margin: const EdgeInsets.only(right: 5.0),
                        ),
                        LButton(
                          text: "Accept",
                          onPressed: () {},
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              LColumn(
                children: <Widget>[
                  LCard(
                    header: LCardHeader(title: "title"),
                    footer: LCardFooter(
                      actions: <Widget>[Text('Footer')],
                    ),
                    color: Colors.white,
                    border: Border.all(color: Colors.black26),
                    image: LCardImage(
                      image: NetworkImage(
                        'https://source.unsplash.com/random/?cars',
                      ),
                    ),
                    body: LCardBody(
                      subTitle:
                          "hi how are you fine from my side hi how are you fine from my side hi how are you fine from my side ",
                      title: "Hello",
                      child: LButton(
                        text: "welcome",
                        type: ButtonType.dark,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
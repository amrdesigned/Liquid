import 'package:flutter/rendering.dart';
import 'package:liquid/components/buttons.dart';
import 'package:liquid/liquid.dart';

void main() {
  // debugPaintSizeEnabled != true;
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
  void _showModel() {
    showLModel(context, builder: (context) {
      return LModel(
        positon: MainAxisAlignment.start,
        margin: EdgeInsets.all(20.0),
        header: LModelHeader(
          title: "Hello World",
          onClose: () {},
        ),
        body: LModelBody(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text("Modal body text goes here."),
          ),
        ),
        footer: LModelFooter(
          actions: <Widget>[
            SizedBox(
              height: 35.0,
              child: FlatButton(
                color: LiquidTheme.of(context).textColors.muted,
                textColor: Colors.white,
                child: Text("Close"),
                onPressed: () {},
              ),
            ),
            SizedBox(width: 10.0),
            SizedBox(
              height: 35.0,
              child: FlatButton(
                color: LiquidTheme.of(context).buttonColors.primaryColor,
                textColor: Colors.white,
                child: Text("Save changes"),
                onPressed: _showModel,
              ),
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
        title: Text(widget.title),
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
                  LCorousel(
                    withCaption: true,
                    autoScroll: true,
                    withControls: true,
                    canScroll: false,
                    showIndicator: true,
                    height: 200.0,
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
                            RaisedButton(
                                child: Text("press me"), onPressed: _showModel)
                          ],
                        ),
                      ),
                      LCorouselItem(
                        child: Image.network(
                          "https://source.unsplash.com/random/?girl",
                          fit: BoxFit.cover,
                        ),
                      ),
                      LCorouselItem(
                        child: Image.network(
                          "https://source.unsplash.com/random/",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
            LRow(children: [
              LColumn(
                sm: 6,
                children: <Widget>[
                  LModel(
                    header: LModelHeader(
                      title: "Hello World",
                      onClose: () {},
                    ),
                    body: LModelBody(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text("Modal body text goes here."),
                      ),
                    ),
                    footer: LModelFooter(
                      actions: <Widget>[
                        SizedBox(
                          height: 35.0,
                          child: FlatButton(
                            color: LiquidTheme.of(context).textColors.muted,
                            textColor: Colors.white,
                            child: Text("Close"),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: 10.0),
                        SizedBox(
                          height: 35.0,
                          child: FlatButton(
                            color: LiquidTheme.of(context)
                                .buttonColors
                                .primaryColor,
                            textColor: Colors.white,
                            child: Text("Save changes"),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              LColumn(
                children: <Widget>[
                  LBadges(
                  "Hello",
                  shape: BadgesShape.standard,
                  type: BadgesType.dark,
                ),
                  LCard(
                  color: Colors.white,
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.black26),
                  body: LCardBody(
                    title: "Hello",
                    //
                  ),
                    LButton(
                  type: ButtonType.success,
                  shape: ButtonShape.standard,
                  text: "hello",
                  onPressed: () {},
                ),
                ),
                ],
              ),
              LColumn(
                children: <Widget>[
                  Text("Hello world"),
                ],
              ),
              LColumn(
                children: <Widget>[
                  Text("Hello world"),
                  SizedBox(
                    height: 60.0,
                    child: Center(child: Text("hello world")),
                  ),
                  Text("hello world"),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

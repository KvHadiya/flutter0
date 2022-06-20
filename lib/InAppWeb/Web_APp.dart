import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWeb_Screen extends StatefulWidget {
  const InAppWeb_Screen({Key? key}) : super(key: key);

  @override
  State<InAppWeb_Screen> createState() => _InAppWeb_ScreenState();
}

class _InAppWeb_ScreenState extends State<InAppWeb_Screen> {
  InAppWebViewController? inAppWebViewController;
  TextEditingController txt_url = TextEditingController();
  String url="https://blog.codemagic.io/inappwebview-the-real-power-of-webviews-in-flutter/";
  double progress = 0;

  @override
  void initState()
  {
    super.initState();
    setState((){
      txt_url.text = url;
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ListTile(
               leading: IconButton(
                 onPressed: (){

                 },
                 icon: Icon(Icons.add),
               ),
              title: TextField(
                controller: txt_url,
              ),
              trailing: IconButton(
                onPressed: (){
                  setState((){
                    url = txt_url.text;
                  });
                },
                icon: Icon(Icons.search),
              ),
            ),
            LinearProgressIndicator(value: progress,),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                    url: Uri.parse(
                        "$url")),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(javaScriptEnabled: true),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  inAppWebViewController = controller;
                },
                onLoadStart: (controller, url) {
                  setState(() {
                    this.url = url.toString();
                  });
                },
                onLoadStop: (controller, url) async {
                  setState(() {
                    this.url = url.toString();
                  });
                },
                onProgressChanged: (InAppWebViewController controller, int progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

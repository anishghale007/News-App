import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  final String link;
  WebViewWidget(this.link);

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {

  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              color: Colors.red,
              value: progress,
            ),
            Expanded(
              child: WebView(
                initialUrl: widget.link,
                javascriptMode: JavascriptMode.unrestricted,
                onProgress: (val) {
                  setState(() {
                    progress = val / 100;
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

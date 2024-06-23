import 'package:doge_coffee/payment_page/payment_fail.dart';
import 'package:doge_coffee/payment_page/payment_success.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class MidtransWebview extends ConsumerStatefulWidget {
  final String url;
  final int order;
  const MidtransWebview({Key? key, required this.url, required this.order})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MidtransWebviewState();
}

class _MidtransWebviewState extends ConsumerState<MidtransWebview> {
  var loadingPercentage = 0;
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    // Platform-specific WebView parameters
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _webViewController = controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageStarted: (String url) {
            debugPrint("urlcheck start" + url);
            setState(() {
              loadingPercentage = 0;
            });
          },
          onPageFinished: (String url) {
            debugPrint("urlcheck finish" + url);
            if (url.contains('success')) {
              print("benar");
              updateOrder(widget.order.toString(), 'settlement');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return const PaymentSuccess();
                  },
                ),
              );
            }
            if (url.contains('failed')) {
              updateOrder(widget.order.toString(), 'deny');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return const PaymentFail();
                  },
                ),
              );
            }
            setState(() {
              loadingPercentage = 100;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // final host = Uri.parse(request.url).host;
            _launchInExternalBrowser(Uri.parse(request.url));
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  Future<void> _launchInExternalBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> updateOrder(String id, String status) async {
    final url = "http://10.0.2.2:8000/api/payment/$id/$status";
    print('update order called');
    final uri = Uri.parse(url);
    await http.put(
      uri,
      headers: {
        'Content-type': 'application/json',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: WebViewWidget(
                controller: _webViewController,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              height: 30,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                child: Text('Exit', style: TextStyle(color: Colors.white)),
              ),
            ),
            if (loadingPercentage < 100)
              LinearProgressIndicator(
                value: loadingPercentage / 100.0,
                color: Colors.amber,
              ),
          ],
        ),
      ),
    );
  }
}

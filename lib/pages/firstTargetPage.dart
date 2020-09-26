import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:inappwebview_test/helpers/colorMsg.dart';
import 'package:inappwebview_test/data/rgbColors.dart';

class FirstTargetPage extends StatefulWidget
{
    @override
    _FirstTargetPageState createState() => _FirstTargetPageState();
}

class _FirstTargetPageState extends State<FirstTargetPage>
{
    InAppWebViewController webView;

    String url = '';

    double progress = 0;

    /// 上次點擊返回鍵時間
    DateTime lastBackPressedAt;

    @override
    void initState()
    {
        super.initState();
    }

    @override
    void dispose()
    {
        super.dispose();
    }

    @override
    Widget build(BuildContext context)
    {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                body: WillPopScope(
                    onWillPop: () async
                    {
                        if (lastBackPressedAt == null || DateTime.now().difference(lastBackPressedAt) > Duration(milliseconds: 400))
                        {
                            lastBackPressedAt = DateTime.now();     // 兩次點擊間隔超過 0.4 秒則重新計時
                            Fluttertoast.showToast(
                                msg: '連按返回退出'
                            );
                            return false;
                        }
                        return true;
                    },
                    child: Container(
                        alignment: Alignment.center,
                        child: InAppWebView(
                            initialUrl: 'http://test.wujidadi.com/flutter/target',
                            initialOptions: InAppWebViewGroupOptions(
                                crossPlatform: InAppWebViewOptions(
                                    debuggingEnabled: true,
                                    minimumFontSize: 0
                                )
                            ),
                            onWebViewCreated: (InAppWebViewController controller)
                            {
                                webView = controller;
                                // webView.addJavaScriptHandler(handlerName: 'flutterApp', callback: (args)
                                // {
                                //     // return data to JavaScript side!
                                //     // return {
                                //     //     'action': 'plusOne'
                                //     // };
                                // });
                                // webView.addJavaScriptHandler(handlerName: 'targetPage', callback: (args)
                                // {
                                //     print(args);
                                // });
                            },
                            onConsoleMessage: (InAppWebViewController controller, ConsoleMessage consoleMessage)
                            {
                                print(consoleMessage);
                            },
                            onLoadStart: (InAppWebViewController controller, String url)
                            {
                                setState(()
                                {
                                    this.url = url;
                                    print(colorMsg('Load start: ${this.url}', color: RGBColors.goldenYellow));
                                });
                            },
                            onLoadStop: (InAppWebViewController controller, String url) async
                            {
                                setState(()
                                {
                                    this.url = url;
                                    print(colorMsg('Load stop: ${this.url}', color: RGBColors.atomicTangerine));
                                });
                            },
                            onProgressChanged: (InAppWebViewController controller, int progress)
                            {
                                setState(()
                                {
                                    this.progress = progress / 100;
                                    print(colorMsg('Progress changed: ${this.progress}', color: RGBColors.bittersweet));
                                });
                            }
                        )
                    )
                ),
                floatingActionButton: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                        Positioned(
                            bottom: 0.0,
                            right: 0.0,
                            child: FloatingActionButton(
                                heroTag: 'refresh',
                                child: Icon(Icons.refresh),
                                onPressed: ()
                                {
                                    if (webView != null)
                                    {
                                        webView.reload();
                                    }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)
                                )
                            )
                        ),
                        Positioned(
                            bottom: 0.0,
                            right: 72.0,
                            child: FloatingActionButton(
                                heroTag: 'plusOne',
                                child: Icon(Icons.add),
                                backgroundColor: Colors.amberAccent[700],
                                onPressed: ()
                                {
//                                     webView.evaluateJavascript(source: """
// window.flutter_inappwebview.callHandler('flutterApp')
// .then(function(result)
// {
//     target.innerHTML = parseInt(target.innerHTML) + 1;
//     alert('hi');
//     console.log(result);
// });
// """);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)
                                )
                            )
                        )
                    ]
                )
            )
        );
    }
}
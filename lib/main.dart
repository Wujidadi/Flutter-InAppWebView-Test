import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:inappwebview_test/pages/firstTargetPage.dart';

void main()
{
    WidgetsFlutterBinding.ensureInitialized();

    debugPaintSizeEnabled = false;

    runApp(InAppWebViewApp());
}

class InAppWebViewApp extends StatefulWidget
{
    @override
    _InAppWebViewAppState createState() => _InAppWebViewAppState();
}

class _InAppWebViewAppState extends State<InAppWebViewApp>
{
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
            initialRoute: '/',
            routes: {
                '/': (context) => FirstTargetPage()
            }
        );
    }
}

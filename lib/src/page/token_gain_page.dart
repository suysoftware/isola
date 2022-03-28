import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:in_app_review/in_app_review.dart';


enum Availability { loading, available, unavailable }

class TokenGainPage extends StatefulWidget {
  const TokenGainPage({Key? key}) : super(key: key);

  @override
  State<TokenGainPage> createState() => _TokenGainPageState();
}

class _TokenGainPageState extends State<TokenGainPage> {

  final InAppReview _inAppReview = InAppReview.instance;

  Availability _availability = Availability.loading;

    String _appStoreId = '';




 void _setAppStoreId(String id) => _appStoreId = id;




 @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();

        setState(() {
          // This plugin cannot be tested on Android by installing your app
          // locally. See https://github.com/britannio/in_app_review#testing for
          // more information.
          _availability = isAvailable && !Platform.isAndroid
              ? Availability.available
              : Availability.unavailable;
        });
      } catch (e) {
        setState(() => _availability = Availability.unavailable);
      }
    });


  
  }

      Future<void> _requestReview() => _inAppReview.requestReview();

  Future<void> _openStoreListing() => _inAppReview.openStoreListing(
        appStoreId: _appStoreId,
      
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          automaticallyImplyLeading: true,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

CupertinoButton(child: Text('222'), onPressed: (){}),

               CupertinoTextField(
              onChanged: _setAppStoreId,
  
            ),
         
            CupertinoButton(
              onPressed: _requestReview,
              child: Text('Request Review'),
            ),
            CupertinoButton(
              onPressed: _openStoreListing,
              child: Text('Open Store Listing'),
            ),
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:legal_info/mappings/view_module_mapping.dart';
import 'package:legal_info/mappings/view_text_mapping.dart';
import 'package:legal_info/models/enum_view_list.dart';
import 'package:legal_info/models/view_detail_model.dart';
import 'package:legal_info/views/overview_area.dart';
import 'models/view_list_model.dart';
import 'views/tools/modules/calcAge.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String notFound = 'Not found';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Legal Info',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Legal Info'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .titleLarge
        ?.merge(const TextStyle(overflow: TextOverflow.ellipsis));
    const iconSize = 40.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    _getColumn(context, ViewListType.PrivateLaw),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _getColumn(context, ViewListType.PublicLaw)
                    ]),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    _getColumn(context, ViewListType.CriminalLaw)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[_getColumn(context, ViewListType.Tools)],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getColumn(context, ViewListType viewListType) {
    var textStyle = Theme.of(context)
        .textTheme
        .titleLarge
        ?.merge(const TextStyle(overflow: TextOverflow.ellipsis));

    IconData iconData = Icons.warning;
    IViewListModel viewListModel;

    switch (viewListType) {
      case ViewListType.PrivateLaw:
        iconData = Icons.security;
        viewListModel = ViewModuleMapping.viewsPrivateLaw;
        break;
      case ViewListType.PublicLaw:
        iconData = Icons.groups;
        viewListModel = ViewModuleMapping.viewsPublicLaw;
        break;
      case ViewListType.CriminalLaw:
        iconData = Icons.gavel;
        viewListModel = ViewModuleMapping.viewsCriminalLaw;
        break;
      case ViewListType.Tools:
        iconData = Icons.handyman;
        viewListModel = ViewModuleMapping.viewsTools;
        break;
    }

    Icon icon = Icon(iconData, size: 40);

    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(20.0),
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon,
            Text(
              viewListModel.title,
              style: textStyle,
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OverViewArea(
              title: viewListModel.title, childViews: viewListModel.childViews);
        }));
      },
    );
  }
}

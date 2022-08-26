import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:legal_info/mappings/view_module_mapping.dart';
import 'package:legal_info/models/enum_view_list.dart';
import 'package:legal_info/views/overview_area.dart';
import 'models/view_list_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String notFound = 'Not found';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = kDebugMode ? ThemeMode.light : ThemeMode.system;

    return MaterialApp(
      title: 'Legal Info',
      theme: FlexThemeData.light(scheme: FlexScheme.ebonyClay),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.ebonyClay),
      themeMode: themeMode,
      home: const MyHomePage(title: 'Legal Info'),
      debugShowCheckedModeBanner: false,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _getCategorie(context, ViewListType.privateLaw),
                _getCategorie(context, ViewListType.criminalLaw),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _getCategorie(context, ViewListType.publicLaw),
                _getCategorie(context, ViewListType.tools)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getCategorie(context, ViewListType viewListType) {
    var textStyle = Theme.of(context)
        .textTheme
        .titleLarge
        ?.merge(const TextStyle(overflow: TextOverflow.ellipsis));

    IconData iconData = Icons.warning;
    IViewListModel viewListModel;

    switch (viewListType) {
      case ViewListType.privateLaw:
        iconData = Icons.security;
        viewListModel = ViewModuleMapping.viewsPrivateLaw;
        break;
      case ViewListType.publicLaw:
        iconData = Icons.groups;
        viewListModel = ViewModuleMapping.viewsPublicLaw;
        break;
      case ViewListType.criminalLaw:
        iconData = Icons.gavel;
        viewListModel = ViewModuleMapping.viewsCriminalLaw;
        break;
      case ViewListType.tools:
        iconData = Icons.handyman;
        viewListModel = ViewModuleMapping.viewsTools;
        break;
    }

    Icon icon = Icon(iconData, size: 40);

    return InkWell(
      child: Row(
        children: [
          Container(
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
        ],
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

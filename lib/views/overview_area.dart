import 'package:flutter/material.dart';
import 'package:legal_info/models/view_detail_model.dart';
import 'package:legal_info/models/view_list_model.dart';

class OverViewArea extends StatelessWidget implements IViewListModel {
  @override
  final List<IViewDetailModel> childViews;
  @override
  final String title;

  const OverViewArea({Key? key, required this.title, required this.childViews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)), body: _getBody(context));
  }

  _getBody(BuildContext context) {
    var headline = Theme.of(context).textTheme.headline1;

    return childViews.isEmpty
        ? Center(
            child: Text(
              'Empty',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .merge(TextStyle(color: Colors.red)),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, i) {
              if (i >= childViews.length) return const Text('Not found');

              if (i.isOdd) return const Divider();

              final index = i ~/ 2;
              return ListTile(
                  title: Text(
                    childViews[index].title,
                    style: headline,
                  ),
                  /*
            trailing: Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : null,
              semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
            ),
            */
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => childViews[index]));
                  });
            },
          );
  }
}

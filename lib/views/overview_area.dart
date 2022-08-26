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
    var headline = Theme.of(context).textTheme.titleLarge;

    return childViews.isEmpty
        ? Center(
            child: Text(
              'Im Aufbau',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .merge(const TextStyle(color: Colors.red)),
            ),
          )
        : ListView.separated(
            itemCount: childViews.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              return ListTile(
                  leading: Icon(
                    childViews[index].icon,
                    size: 40,
                  ),
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
            separatorBuilder: (context, i) => const Divider(
              color: Colors.grey,
            ),
          );
  }
}

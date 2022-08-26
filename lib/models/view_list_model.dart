import 'package:legal_info/models/view_detail_model.dart';

abstract class IViewListModel {
  String get title;
  List<IViewDetailModel> get childViews;
}

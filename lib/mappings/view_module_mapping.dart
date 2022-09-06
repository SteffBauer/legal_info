import 'package:legal_info/mappings/view_text_mapping.dart';

import '../models/view_list_model.dart';
import '../views/overview_area.dart';
import '../views/tools/modules/calc_age.dart';
import '../views/tools/modules/calc_alc.dart';
import '../views/tools/modules/calc_deadline.dart';

class ViewModuleMapping {
  ViewModuleMapping();

  static final IViewListModel viewsPrivateLaw =
      OverViewArea(title: ViewTextMapping.privateLaw(), childViews: const []);

  static final IViewListModel viewsPublicLaw =
      OverViewArea(title: ViewTextMapping.publicLaw(), childViews: const []);

  static final IViewListModel viewsTools = OverViewArea(
      title: ViewTextMapping.tools(),
      childViews: const [
        CalculateAgePage(),
        CalculateAlcPage(),
        CalculateDeadlinePage()
      ]);

  static final IViewListModel viewsCriminalLaw =
      OverViewArea(title: ViewTextMapping.criminalLaw(), childViews: const []);
}

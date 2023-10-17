import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:jiffy/jiffy.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vss_date_time_util/date_time_util.dart';
import 'package:vss_global_constant/global_constant.dart';
import 'package:vss_ivt_api/api_consumer.dart';
import 'package:vss_environment/environment_enum.dart';
import 'package:vss_environment/environment_switch.dart';
import 'package:vss_ivt_api/api_result_model.dart';
import 'package:vss_ivt_api/dot_net_api.dart';
import 'package:vss_locale/language_store.dart';
import 'package:vss_log/vss_log.dart';
import 'package:vss_message_util/message_util.dart';
import 'package:vss_navigator/navigator.dart';
import 'package:vss_theme/theme_store.dart';
import 'package:emr_app_store/login_store.dart';
import 'package:emr_app_store/tab_store.dart';
import 'package:emr_uri/emr_uri.dart';
import 'package:emr_uri/acs_uri.dart';
import 'package:emr_backend_domain/backend_domain.dart';

import 'component/FilteredResultComponent.dart';
import 'component/clear_button.dart';
import 'date_constans.dart';
import 'document_screen.dart';
import 'filtered_screen.dart';
import 'l10n/translate.dart';
import 'model/emr_document_model.dart';
import 'model/filter_model.dart';

class DocumentCreatorScreen extends StatefulWidget {
  DocumentCreatorScreen({super.key, this.option = 'creator'});

  String option = 'creator';

  @override
  State<DocumentCreatorScreen> createState() => _DocumentCreatorScreenState();
}

class _DocumentCreatorScreenState extends State<DocumentCreatorScreen> {
  @override
  Widget build(BuildContext context) {
    return DocumentScreen(
      option: widget.option,
    );
  }
}

import 'package:first_flutter_app/page/store/store_audit_page.dart';
import 'package:first_flutter_app/page/store/store_audit_result_page.dart';
import 'package:first_flutter_app/router/router_init.dart';
import 'package:fluro/fluro.dart';

class StoreRouter implements IRouterProvider {

  static String auditPage = "/store/audit";
  static String auditResultPage = "/store/auditResult";

  @override
  void initRouter(Router router) {
    router.define(
        auditPage, handler: Handler(handlerFunc: (_, params) => StoreAudit()));
    router.define(auditResultPage,
        handler: Handler(handlerFunc: (_, params) => StoreAuditResult()));
  }
}
enum AppTab {
  proformas,
  comprobantes,
  plantillas,
  configuracion;

  String get routePath => switch (this) {
        AppTab.proformas => '/proformas',
        AppTab.comprobantes => '/comprobantes',
        AppTab.plantillas => '/plantillas',
        AppTab.configuracion => '/configuracion',
      };

  String get routeName => switch (this) {
        AppTab.proformas => 'proformas',
        AppTab.comprobantes => 'comprobantes',
        AppTab.plantillas => 'plantillas',
        AppTab.configuracion => 'configuracion',
      };

  String get screenLabel => switch (this) {
        AppTab.proformas => 'Proforma',
        AppTab.comprobantes => 'Comprobante',
        AppTab.plantillas => 'Plantillas',
        AppTab.configuracion => 'Configuración',
      };

  static AppTab? fromLocation(String location) {
    for (final tab in AppTab.values) {
      if (location == tab.routePath || location.startsWith('${tab.routePath}/')) {
        return tab;
      }
    }
    return null;
  }
}

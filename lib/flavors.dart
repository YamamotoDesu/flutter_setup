enum Flavor {
  dev,
  qa,
  uat,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'EcomApp';
      case Flavor.qa:
        return 'EcomApp';
      case Flavor.uat:
        return 'EcomApp';
      case Flavor.prod:
        return 'EcomApp';
      default:
        return 'title';
    }
  }

}

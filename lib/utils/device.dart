/// Store Dimension of Device and other UI calculation
class Device {
  Device(this.deviceHeight, this.deviceWidth) {
    isMobile = deviceWidth > deviceHeight ? false : true;
  }

  /// deviceWidth
  double deviceWidth = 0.0;

  /// deviceHeight
  double deviceHeight = 0.0;

  /// Is Platform Mobile
  bool isMobile = true;
}

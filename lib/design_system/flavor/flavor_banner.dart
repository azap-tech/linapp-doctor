import 'package:azap_app/design_system/flavors.dart';
import 'package:flutter/material.dart';

class FlavorBanner extends StatelessWidget {
  final Widget child;
  BannerConfig bannerConfig;
  FlavorBanner({@required this.child});
  
  @override
  Widget build(BuildContext context) {
    if(FlavorConfig.isProduction()) return child;
    bannerConfig ??= _getDefaultBanner();
    return Stack(
      children: <Widget>[
        child,
        _buildBanner(context)
      ],
    );
  }
  
  BannerConfig _getDefaultBanner() {
    return BannerConfig(
      bannerName: FlavorConfig.instance.name,
      bannerColor: FlavorConfig.instance.color
    );
  }
  Widget _buildBanner(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: CustomPaint(
        painter: BannerPainter(
          message: bannerConfig.bannerName,
          textDirection: Directionality.of(context),
          layoutDirection: Directionality.of(context),
          location: BannerLocation.topStart,
          color: bannerConfig.bannerColor
        ),
      ),
    );
  }
}

class BannerConfig {
  final String bannerName;
  final Color bannerColor;
  BannerConfig({
    @required this.bannerName,
    @required this.bannerColor});
}
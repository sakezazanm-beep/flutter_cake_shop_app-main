import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/cake_shop.dart';
import '../theme/app_theme.dart';

class CakeShopDetailUI extends StatefulWidget {
  const CakeShopDetailUI({super.key, required this.shop});

  final CakeShop shop;

  @override
  State<CakeShopDetailUI> createState() => _CakeShopDetailUIState();
}

class _CakeShopDetailUIState extends State<CakeShopDetailUI> {
  int _activeImage = 0;

  Future<void> _openUri(Uri uri) async {
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('ไม่สามารถเปิดลิงก์นี้ได้')));
    }
  }

  Future<void> _callShop() =>
      _openUri(Uri(scheme: 'tel', path: widget.shop.phone));

  Future<void> _openWebsite() => _openUri(Uri.parse(widget.shop.website));

  Future<void> _openFacebook() => _openUri(Uri.parse(widget.shop.facebook));

  Future<void> _openMap() => _openUri(
    Uri.https('www.google.com', '/maps/search/', {
      'api': '1',
      'query': [widget.shop.latitude, widget.shop.longitude].join(','),
    }),
  );

  @override
  Widget build(BuildContext context) {
    final shop = widget.shop;
    final location = LatLng(shop.latitude, shop.longitude);

    return Scaffold(
      appBar: AppBar(title: const Text('รายละเอียดร้านเค้ก')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: shop.images.length,
                  options: CarouselOptions(
                    height: 248,
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, _) {
                      setState(() => _activeImage = index);
                    },
                  ),
                  itemBuilder: (context, index, realIndex) => SizedBox.expand(
                    child: Image.asset(
                      shop.images[index],
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: AppColors.pinkLine,
                        alignment: Alignment.center,
                        child: const Icon(Icons.cake_outlined, size: 60),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      shop.images.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: _activeImage == index ? 18 : 6,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: _activeImage == index
                              ? AppColors.red
                              : Colors.white.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shop.name,
                    style: const TextStyle(
                      fontSize: 22,
                      height: 1.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    child: Text(shop.address),
                  ),
                  _InfoRow(
                    icon: Icons.phone_outlined,
                    child: InkWell(
                      onTap: _callShop,
                      child: Text(
                        shop.phone,
                        style: const TextStyle(
                          color: AppColors.redDark,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  _InfoRow(
                    icon: Icons.access_time,
                    child: Text(shop.openCloseTime),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'เกี่ยวกับร้าน',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    shop.description,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.55,
                      color: AppColors.muted,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'แผนที่ร้าน',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 9),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: SizedBox(
                      height: 205,
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: location,
                          initialZoom: 14,
                          interactionOptions: const InteractionOptions(
                            flags: InteractiveFlag.all,
                          ),
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'flutter_cake_shop_app',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: location,
                                width: 48,
                                height: 54,
                                child: const Icon(
                                  Icons.location_pin,
                                  color: AppColors.red,
                                  size: 48,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _openMap,
                      icon: const Icon(Icons.directions_outlined),
                      label: const Text('เปิดเส้นทางในแผนที่'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.red,
                        side: const BorderSide(color: AppColors.red),
                        padding: const EdgeInsets.symmetric(vertical: 11),
                        textStyle: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: _ActionButton(
                          icon: FontAwesomeIcons.phone,
                          label: 'โทรหาร้าน',
                          onPressed: _callShop,
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: _ActionButton(
                          icon: FontAwesomeIcons.globe,
                          label: 'เว็บไซต์',
                          onPressed: _openWebsite,
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: _ActionButton(
                          icon: FontAwesomeIcons.facebookF,
                          label: 'Facebook',
                          onPressed: _openFacebook,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.child});

  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 19, color: AppColors.red),
          const SizedBox(width: 9),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final FaIconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.red,
        side: const BorderSide(color: AppColors.pinkLine),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        textStyle: const TextStyle(fontSize: 12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(icon, size: 16),
          const SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }
}





import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../data/cake_shops.dart';
import '../models/cake_shop.dart';
import '../theme/app_theme.dart';
import 'cake_shop_detail_ui.dart';

class CakeShopListUI extends StatefulWidget {
  const CakeShopListUI({super.key});

  @override
  State<CakeShopListUI> createState() => _CakeShopListUIState();
}

class _CakeShopListUIState extends State<CakeShopListUI> {
  static const _shopBanners = [
    'assets/images/ck01.png',
    'assets/images/ck02.png',
    'assets/images/ck03.png',
    'assets/images/ck04.png',
    'assets/images/ck05.png',
    'assets/images/ck06.png',
    'assets/images/ck07.png',
  ];

  int _activeSlide = 5;

  void _openShop(CakeShop shop) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => CakeShopDetailUI(shop: shop)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('สายด่วนกินเค้ก')),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 184,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CarouselSlider.builder(
                  itemCount: _shopBanners.length,
                  options: CarouselOptions(
                    height: 184,
                    initialPage: 5,
                    viewportFraction: 1,
                    enlargeCenterPage: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    onPageChanged: (index, _) {
                      setState(() => _activeSlide = index);
                    },
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: SizedBox.expand(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            _shopBanners[index],
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Container(
                              color: AppColors.pinkLine,
                              alignment: Alignment.center,
                              child: const Icon(Icons.cake_outlined, size: 52),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _shopBanners.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: _activeSlide == index ? 18 : 6,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: _activeSlide == index
                              ? AppColors.red
                              : AppColors.red.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 10),
              itemCount: cakeShops.length,
              separatorBuilder: (_, _) => const Divider(
                height: 1,
                thickness: 1,
                color: AppColors.pinkLine,
              ),
              itemBuilder: (context, index) {
                final shop = cakeShops[index];
                return Material(
                  color: AppColors.pink,
                  child: InkWell(
                    onTap: () => _openShop(shop),
                    child: SizedBox(
                      height: 88,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 11),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.asset(
                                shop.images.first,
                                width: 64,
                                height: 64,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => Container(
                                  width: 64,
                                  height: 64,
                                  color: AppColors.pinkLine,
                                  child: const Icon(Icons.cake_outlined),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    shop.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      height: 1.15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    shop.phone,
                                    style: const TextStyle(
                                      color: AppColors.muted,
                                      fontSize: 13,
                                      height: 1.1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              tooltip: ['ดูข้อมูลร้าน', shop.name].join(' '),
                              onPressed: () => _openShop(shop),
                              icon: const Icon(
                                Icons.info,
                                color: AppColors.red,
                                size: 21,
                              ),
                              constraints: const BoxConstraints.tightFor(
                                width: 40,
                                height: 46,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


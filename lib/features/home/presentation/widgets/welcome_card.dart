import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WelcomeCard extends StatefulWidget {
  const WelcomeCard({super.key});

  @override
  State<WelcomeCard> createState() => _WelcomeCardState();
}

class _WelcomeCardState extends State<WelcomeCard> {
  int _currentImageIndex = 0;

  final List<String> _imageUrls = [
    'https://wallpapers.com/images/hd/traveling-pictures-g7xldpjb3alphjso.jpg',
    'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AA1J99j2.img?w=1280&h=720&m=4&q=99',
    'https://i.content4travel.com/cms/img/u/desktop/se/xsochor_0.jpg?version=1',
    'https://avatars.dzeninfra.ru/get-zen_doc/271828/pub_66c498f324005a7b57d28d4e_66c4990a7c836c13b8db57a3/scale_1200',
    'https://kubnews.ru/upload/resize_cache/iblock/0aa/1200_630_2/w7zkr3ijiudh1xb8glfeeb5oxojrl6gv.jpg',
  ];

  void _changeImage() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % _imageUrls.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: CupertinoColors.systemBlue.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: _changeImage,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: _imageUrls[_currentImageIndex],
                height: 120,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 120,
                  color: CupertinoColors.systemGrey5,
                  child: const Center(
                    child: Icon(
                      CupertinoIcons.photo,
                      color: CupertinoColors.systemGrey,
                      size: 48,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _imageUrls.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == _currentImageIndex
                      ? CupertinoColors.systemBlue
                      : CupertinoColors.systemGrey4,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Добро пожаловать!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Исследуйте страны, отмечайте места и планируйте поездки в одном месте.',
            style: TextStyle(
              fontSize: 14,
              color: CupertinoColors.secondaryLabel,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

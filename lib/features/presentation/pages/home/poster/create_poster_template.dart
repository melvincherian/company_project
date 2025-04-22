// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
import 'package:company_project/features/presentation/pages/home/poster/add_element_screen.dart';
import 'package:company_project/features/presentation/pages/home/poster/add_image.dart';
import 'package:company_project/features/presentation/pages/home/poster/add_shape.dart';
import 'package:company_project/features/presentation/pages/home/poster/animation_screen.dart';
import 'package:company_project/features/presentation/pages/home/poster/audio_screen.dart';
import 'package:company_project/features/presentation/pages/home/poster/brand_screen.dart';
import 'package:flutter/material.dart';

class PosterTemplate extends StatefulWidget {
  const PosterTemplate({super.key});

  @override
  State<PosterTemplate> createState() => _PosterTemplateState();
}

class _PosterTemplateState extends State<PosterTemplate> {
  double _sliderPosition = 150;
  bool _showLayerSlider = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showLayerSlider = !_showLayerSlider;
                          });
                        },
                        child: const Icon(Icons.layers),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF5C6BC0),
                                Color.fromARGB(255, 127, 81, 255)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.download_for_offline_sharp,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Download',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: ClipRRect(
                        child: Image.network(
                          'https://s3-alpha-sig.figma.com/img/9cf6/9546/ebfe8be7faa0bcece189903d1e14b4d7?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=YGwJR0j8WDu-tfa~nvJd90b9coqrtqXsWyqXePok5XUXvpyN5lVWahW33A5oomX6R05rIsJnDgFouHZMy3-~iGFbdXhbaupOkOAtNM2p3O6o9iBJDeil8qfb519bIUiu-7dZBHmy~y~UUOf-eymwdj9ikjqOY~XTlycxvxcZJE3rwdcZg6pAptH6Kw~nVTymvMpIq~eLrcrq2vLxVdWVhw7jNLHAZkpfIe0jCALLAgmQ5nyZNvMqRwmnAcpSKxwjudRM0ZsDqcCUukmupdFSNCB8fbpurIjoTK7v9KR6S0WCkv5MpzD0sJiXfsXGVLHK80RHO69RMXtGZAPhRsRNkQ__',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    color: Colors.black,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              showAddTextBottomSheet(context);
                            },
                            child: BottomNavbaritem(
                                icon: Icons.text_fields, label: 'Text'),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AudioScreen()));
                            },
                            child: BottomNavbaritem(
                                icon: Icons.music_note, label: 'Audio'),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AnimationScreen()));
                            },
                            child: BottomNavbaritem(
                                icon: Icons.animation, label: 'Animation'),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FlyerScreen()));
                            },
                            child: BottomNavbaritem(
                                icon: Icons.info_outline, label: 'Brand Info'),
                          ),
                          SizedBox(width: 24),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20))),
                                  builder: (context) => StickerPicker());
                            },
                            child: BottomNavbaritem(
                                icon: Icons.emoji_emotions_outlined,
                                label: 'Sticker'),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                backgroundColor: Colors.white,
                                isScrollControlled: true,
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Effects',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 16),
                                        GridView.builder(
                                          shrinkWrap: true,
                                          itemCount: 12,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        'https://s3-alpha-sig.figma.com/img/5e8e/a20b/0e90eda78d8ce5b358accbc97b5e0476?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=lcb~llFZJWH3X9GXWLJbZP9FH-Va3HaqX0-tUqh312afObF3eTTYontZpvDAKmg~HiGoX9OeqqrWxNIL3Vc~y~7Y7HS0bu2MvXuBrjp~CjjabYJvuwK2z~tnnFKMhjGXUVLzzBQeXjEb5VrEuF2XZdlUYhpSV5DiyBbdtDKJ8-9tqYdu~wW7Fk~YhDN1HoEB0FHUa4Pbvd2jKnhr1Uoj~o0TDQbbS6zBMxEHVscCpnXAIQqPyRVwQrapidke8t09n5LR7yLyGHCW01xnNNDJNPe51KQq6As4BLsoIgdOpJN-J1C9Uwrae10q7EvYfdD9BKmCfVgYBTqdHdbnbP6KVA__'), // Replace with your asset path
                                                    fit: BoxFit.cover,
                                                  ),
                                                  border: Border.all(
                                                    color: index == 2
                                                        ? Colors.cyanAccent
                                                        : Colors.transparent,
                                                    width: 3,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: BottomNavbaritem(
                                icon: Icons.explore_off_outlined,
                                label: 'Effects'),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddElementScreen()));
                            },
                            child: BottomNavbaritem(
                                icon: Icons.electric_meter_rounded,
                                label: 'Elements'),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddShape()));
                            },
                            child: BottomNavbaritem(
                                icon: Icons.category, label: 'Shapes'),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddImage()));
                            },
                            child: BottomNavbaritem(
                                icon: Icons.badge, label: 'Background'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (_showLayerSlider) ...[
              Positioned.fill(
                left: _sliderPosition,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              Positioned(
                left: _sliderPosition - 1,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      _sliderPosition += details.delta.dx;
                      if (_sliderPosition < 0) _sliderPosition = 0;
                      if (_sliderPosition > screenWidth) {
                        _sliderPosition = screenWidth;
                      }
                    });
                  },
                  child: Container(
                    width: 3,
                    color: Colors.white,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  void showAddTextBottomSheet(BuildContext context) {
    TextEditingController _textController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 10,
            left: 10,
            right: 10,
          ),
          child: Container(
            height:
                MediaQuery.of(context).size.height * 0.5, // Half screen height
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      "Add Text",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        String addedText = _textController.text;
                        Navigator.pop(context);
                        print("Text added: $addedText");
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // TextField
                Expanded(
                  child: TextField(
                    controller: _textController,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      hintText: 'Add Your Text here',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BottomNavbaritem extends StatelessWidget {
  final IconData icon;
  final String label;

  BottomNavbaritem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}

class StickerPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 300, // adjust height as needed
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Select Sticker",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              // SizedBox(width: 40,),
              // Icon(Icons.image),
              // SizedBox(width: 70,),
              // Text('Choose from\nGallery ')
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _categoryChip(context, "Business", true),
              _categoryChip(context, "Education", false),
              _categoryChip(context, "Ugadi", false),
              _categoryChip(context, "Beauty", false),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _stickerCard("assets/sticker1.png"),
              _stickerCard("assets/sticker2.png"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _categoryChip(BuildContext context, String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
        borderRadius: BorderRadius.circular(20),
        color: isSelected ? Colors.blue.shade100 : Colors.transparent,
      ),
      child: Text(label),
    );
  }

  Widget _stickerCard(String assetPath) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
          width: 80,
          height: 80,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.network(
              'https://s3-alpha-sig.figma.com/img/07a0/1466/64d5872b93df17bb100eb7a52c533210?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=hYYZm~RMOrGasAsiyp4pjNKBSKdv3BTdbnlcSA4agRYmGyLLYExfGSPi59GL2JErFA1oaZcvxWkzXawazyerSbeaAuwleIcyTykjBRqBW5eiDigQ2vlCpOfpIJHGX2DHbqL7Uw7FO5iERMvlkeU8RvJH15hWvJncYvvq2qzcdpphordCrfInqe0RO22KvwDrWPt6oIJiZaP8k5o3sbAwZm9KiRijnaBJtpK6H9sgv~GaCjPOIEwIo7WvO3ZLpJ-54CgnArzWwV3zbf~H~K-WxcU5MmQa395qSKo~bys4mD-b07ad40yiIzCdZqgkuG7zAn7NwLp5aroxWzfx3Gyuig__') // Replace with NetworkImage or FileImage if needed
          ),
    );
  }
}

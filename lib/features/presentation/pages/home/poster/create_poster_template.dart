// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
import 'package:company_project/features/presentation/pages/home/poster/animation_screen.dart';
import 'package:company_project/features/presentation/pages/home/poster/audio_screen.dart';
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 4),
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
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AudioScreen()));
                            },
                            child: BottomNavbaritem(
                                icon: Icons.music_note, label: 'Audio'),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AnimationScreen()));
                            },
                            child: BottomNavbaritem(
                                icon: Icons.animation, label: 'Animation'),
                          ),
                          const SizedBox(width: 24),
                          BottomNavbaritem(
                              icon: Icons.info_outline, label: 'Brand Info'),
                          const SizedBox(width: 24),
                          BottomNavbaritem(
                              icon: Icons.emoji_emotions_outlined,
                              label: 'Sticker'),
                          const SizedBox(width: 24),
                          BottomNavbaritem(
                              icon: Icons.explore_off_outlined,
                              label: 'Effects'),
                          const SizedBox(width: 24),
                          BottomNavbaritem(
                              icon: Icons.electric_meter_rounded,
                              label: 'Elements'),
                          const SizedBox(width: 24),
                          BottomNavbaritem(
                              icon: Icons.category, label: 'Shapes'),
                          const SizedBox(width: 24),
                          BottomNavbaritem(
                              icon: Icons.badge, label: 'Background'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Overlay and slider handle
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
          height: MediaQuery.of(context).size.height * 0.5, // Half screen height
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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

import 'package:flutter/material.dart';

class AnimationScreen extends StatelessWidget {
  final List<Map<String, dynamic>> animationOptions = const [
    {'icon': Icons.flip, 'label': 'FlipinX'},
    {'icon': Icons.flip_camera_android, 'label': 'FlipinY'},
    {'icon': Icons.vibration, 'label': 'Wobble'},
    {'icon': Icons.rotate_right, 'label': 'Rollin'},
    {'icon': Icons.zoom_out_map, 'label': 'Zoom'},
    {'icon': Icons.zoom_in, 'label': 'ZoomIn'},
  ];

  const AnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    }, icon: const Icon(Icons.arrow_back_ios)),
                const Icon(Icons.layers),
                const SizedBox(
                  width: 70,
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
                          Color.fromARGB(255, 75, 102, 255),
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
                ),
              ],
            ),
            Expanded(
                child: Center(
              child: ClipRRect(
                child: Image.network(
                    'https://s3-alpha-sig.figma.com/img/9cf6/9546/ebfe8be7faa0bcece189903d1e14b4d7?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=YGwJR0j8WDu-tfa~nvJd90b9coqrtqXsWyqXePok5XUXvpyN5lVWahW33A5oomX6R05rIsJnDgFouHZMy3-~iGFbdXhbaupOkOAtNM2p3O6o9iBJDeil8qfb519bIUiu-7dZBHmy~y~UUOf-eymwdj9ikjqOY~XTlycxvxcZJE3rwdcZg6pAptH6Kw~nVTymvMpIq~eLrcrq2vLxVdWVhw7jNLHAZkpfIe0jCALLAgmQ5nyZNvMqRwmnAcpSKxwjudRM0ZsDqcCUukmupdFSNCB8fbpurIjoTK7v9KR6S0WCkv5MpzD0sJiXfsXGVLHK80RHO69RMXtGZAPhRsRNkQ__'),
              ),
            )),
            const Text(
              'Animation',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
             Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Animation",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    
                    ],
                  ),
                  SizedBox(height: 16),

                  // Buttons
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       
                        _buildBrandButton(Icons.flip, "FlipinX"),
                        _buildBrandButton(Icons.flip_camera_android, "FlipinY"),
                        _buildBrandButton(Icons.vibration, "Wobble"),
                        _buildBrandButton(Icons.rotate_right, "Rollin"),
                        _buildBrandButton(Icons.zoom_out_map, "Zoom"),
                         _buildBrandButton(Icons.zoom_in, "ZoomIn"),
                      ],
                    ),
                  ),
                ],
              ),
            )
            // SizedBox(
            //   height: 100,
            //   child: ListView.separated(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: animationOptions.length,
            //     separatorBuilder: (_, __) => const SizedBox(width: 10),
            //     itemBuilder: (context, index) {
            //       final option = animationOptions[index];
            //       return Container(
            //         width: 80,
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(12),
            //         ),
            //         padding:
            //             const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Icon(option['icon'], color: Colors.blue),
            //             const SizedBox(height: 8),
            //             Text(
            //               option['label'],
            //               style: const TextStyle(
            //                   fontSize: 12, color: Colors.black),
            //               textAlign: TextAlign.center,
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      )),
    );

    
  }
  Widget _buildBrandButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.black),
        ),
        SizedBox(height: 6),
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 10),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

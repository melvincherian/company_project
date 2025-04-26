// Add this class to your file or create a new file for it
import 'package:flutter/material.dart';

class StickerPicker extends StatelessWidget {
  const StickerPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Stickers',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            itemCount: 12,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://s3-alpha-sig.figma.com/img/5e8e/a20b/0e90eda78d8ce5b358accbc97b5e0476?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=lcb~llFZJWH3X9GXWLJbZP9FH-Va3HaqX0-tUqh312afObF3eTTYontZpvDAKmg~HiGoX9OeqqrWxNIL3Vc~y~7Y7HS0bu2MvXuBrjp~CjjabYJvuwK2z~tnnFKMhjGXUVLzzBQeXjEb5VrEuF2XZdlUYhpSV5DiyBbdtDKJ8-9tqYdu~wW7Fk~YhDN1HoEB0FHUa4Pbvd2jKnhr1Uoj~o0TDQbbS6zBMxEHVscCpnXAIQqPyRVwQrapidke8t09n5LR7yLyGHCW01xnNNDJNPe51KQq6As4BLsoIgdOpJN-J1C9Uwrae10q7EvYfdD9BKmCfVgYBTqdHdbnbP6KVA__'
                      ),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: index == 0 ? Colors.blue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
import 'package:company_project/features/presentation/pages/home/poster/customize_audio_screen.dart';
import 'package:flutter/material.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.arrow_back_ios),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Audio',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor:const Color.fromARGB(255, 37, 33, 243),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.folder_special,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Select Audio\nfrom Phone',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 37, 33, 243),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const CustomAudioScreen()));
                            },
                            icon: const Icon(
                              Icons.person_3_rounded,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Create your Own\nAudio Clip',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ugadi Offers',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Ugadi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Gudi padwaoffers',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Ugadi', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Image.network(
                              'https://s3-alpha-sig.figma.com/img/0ecf/3002/f92c2409ce06e164bb3a782347a48343?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=GjYKXmSexY9HSlbKQeM3NS62YqdwIF8cX5B92qwYUSKbkfsPE9RnpNO1-oicRG6PrXHhlvqdrfOiYNyBRY7XY9e7g~i8ENoxvc5yn6a0rghIBX6deO1URx1MwQrNYebooTjLQgjQ55DPDyHHV-fsqOf4-jno9yd4Z6SnUf1CWCHwbIRB3yyDS8h9HLh-RXxWr6uPZE1Q4OE4EKy8cVCYavkFNCBDxEvWTOVluUpHS2KPVtN4OwPZjk4FxZbsMiIFbJ4LPgoYWwbakV73xSws2H2xdZulRHmolkAizLrPA4H7GqtTM1hB9FC7jiEQoywc97bc38YvTop52FVHX3rCmw__',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ugadi Offer Female English...',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.play_circle_outline,
                                        color: Color.fromARGB(255, 54, 33, 243),
                                      ),
                                      SizedBox(width: 4),
                                      Text('00:30'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Checkbox(
                              value: false,
                              onChanged: (bool? value) {
                                
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

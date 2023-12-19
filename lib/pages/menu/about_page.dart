import 'package:church_app/pages/menu/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/app_data.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            title: const Center(child: Text('About Us')),
            actions: [
              Builder(builder: (context) {
                return IconButton(
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    icon: Image.asset('assets/icons/menu.png',
                        color: Theme.of(context)
                            .appBarTheme
                            .actionsIconTheme!
                            .color));
              })
            ],
          ),
          body: Container(
            width: screenSize.width,
            height: screenSize.height,
            color: Theme.of(context).primaryColor,
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Our Vision',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                        'To establish the house of God, through the development of Model New Testament Christians and churches with the philosophical common denominator of practical christianity, human dignity and excellence. \n\nConsequently, we are committed to train and equip God`s people who come to our church to develop and grow into maturity in Christ so they will manifest the character of Christ.\n',
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(
                      'Our Mission',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '- Raising Leaders​​​ \n- Shaping Vision​ \n- Influencing Society through Christ\n',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Through our programs, we trust to make the lives of our people better than before they came to Church, and redirect their perception and behavior in conformity with God`s word. This attitude which is based on the word of God will transform the lives of people in their communities, work place, schools and more.\n',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Our Philosophy',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '- Practical Christianity​​​ \n- Human Dignity​ \n- Excellence\n',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'We believe Christianity is not a myth. God`s word preached must bring truth that can produce results when applied to one’s life. \n\nAgain, every human being is created in the image and likeness of God and must be treated with respect and honor. Everything the Christian or the human being will do must be done with the propensity to excel. Because being created in His image and likeness you have been structured and programmed by Him to excel (Daniel 5:12)\n',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Our Faith',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '- We believe… that there is one God, eternally existing in three persons: God the Father, God the Son, and God the Holy Spirit.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '- We believe… in the deity of our Lord Jesus Christ, in His virgin birth, and in His bodily resurrection.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '- We believe… the Bible to be the inspired and infallible Word of God.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '- We believe… in salvation by grace through faith in the Lord Jesus Christ.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '- We believe… in the baptism of the Holy Spirit with the evidence of speaking in other tongues as a subsequent gift to salvation.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '- We believe… in the provision of bodily healing in the atoning work of Jesus our Saviour.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '- We believe… in the return of the Lord Jesus Christ and the resurrection of the saved and the lost; the saved unto eternal life, living eternally in the presence of God, and the unsaved unto eternal damnation',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                )),
          ),
          endDrawer: const MenuDrawer()),
    );
  }
}

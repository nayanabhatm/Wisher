import 'package:flutter/material.dart';
import 'package:wisher/screens/firebase_images_list.dart';
import 'package:wisher/utils/constants.dart';
import 'package:wisher/widgets/sticky_note.dart';
import 'package:wisher/widgets/wisher_banner.dart';

class TemplateScreen extends StatelessWidget {
  const TemplateScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const WisherBanner(),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: Constants.wishes.length,
              itemBuilder: (BuildContext ctx, index) {
                return StickyNote(
                  color: Constants.wishes.values.toList()[index],
                  wishesText: Constants.wishes.keys.toList()[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoadFirebaseImages(
                            appBarText: Constants.wishes.keys.toList()[index],
                            firebaseDirectoryName: _getFirebaseDirectoryName(
                                Constants.wishes.keys.toList()[index]),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getFirebaseDirectoryName(String wishType) {
    switch (wishType) {
      case Constants.republicDay:
        {
          return Constants.republicDay;
        }
      case Constants.independenceDay:
        {
          return Constants.independenceDay;
        }
      case Constants.sankranti:
        {
          return Constants.sankranti;
        }
      case Constants.birthday:
        {
          return Constants.birthday;
        }
      case Constants.wedding:
        {
          return Constants.wedding;
        }
      case Constants.anniversary:
        {
          return Constants.anniversary;
        }
      case Constants.mothersDay:
        {
          return Constants.mothersDay;
        }
      case Constants.fathersDay:
        {
          return Constants.fathersDay;
        }
      case Constants.womenDay:
        {
          return Constants.womenDay;
        }
      case Constants.eidMubarak:
        {
          return Constants.eidMubarak;
        }
      // case Constants.ramNavami:
      //   {
      //     return Constants.ramNavami;
      //   }
      case Constants.ugadi:
        {
          return Constants.ugadi;
        }
      case Constants.easter:
        {
          return Constants.easter;
        }
      // case Constants.thanksFor:
      //   {
      //     return Constants.thanksFor;
      //   }
      case Constants.holy:
        {
          return Constants.holy;
        }
      // case Constants.shivratri:
      //   {
      //     return Constants.shivratri;
      //   }
      case Constants.friendShipDay:
        {
          return Constants.friendShipDay;
        }
      case Constants.valentineDay:
        {
          return Constants.valentineDay;
        }
      case Constants.newYear:
        {
          return Constants.newYear;
        }
      case Constants.christmas:
        {
          return Constants.christmas;
        }
      case Constants.diwali:
        {
          return Constants.diwali;
        }
      case Constants.ganeshaChaturti:
        {
          return Constants.ganeshaChaturti;
        }
      case Constants.navaratri:
        {
          return Constants.navaratri;
        }
      case Constants.onam:
        {
          return Constants.onam;
        }
      case Constants.janmashtami:
        {
          return Constants.janmashtami;
        }
      case Constants.rakshaBandhan:
        {
          return Constants.rakshaBandhan;
        }
      default:
        {
          return '';
        }
    }
  }
}

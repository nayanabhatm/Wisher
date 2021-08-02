import 'package:flutter/material.dart';
import 'package:wisher/screens/firebase_images_list.dart';
import 'package:wisher/utils/constants.dart';
import 'package:wisher/utils/widget_style.dart';
import 'package:wisher/widgets/sticky_note.dart';

class Templates extends StatelessWidget {
  const Templates({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Styles.padding10),
      child: GridView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
    );
  }

  String _getFirebaseDirectoryName(String wishType) {
    switch (wishType) {
      case 'RepublicDay':
        {
          return 'RepublicDay';
        }
      case 'IndependenceDay':
        {
          return 'IndependenceDay';
        }
      case 'Sankranti':
        {
          return 'Sankranti';
        }
      case 'Birthday':
        {
          return 'Birthday';
        }
      case 'Wedding':
        {
          return 'Wedding';
        }
      case 'Anniversary':
        {
          return 'Anniversary';
        }
      case ' MothersDay':
        {
          return 'MothersDay';
        }
      case ' FathersDay':
        {
          return 'FathersDay';
        }
      case ' WomensDay':
        {
          return 'WomensDay';
        }
      case 'Eid':
        {
          return 'Eid';
        }
      // case 'RamNavami':
      //   {
      //     return 'RamNavami';
      //   }
      case 'Ugadi':
        {
          return 'Ugadi';
        }
      case 'Easter':
        {
          return 'Easter';
        }
      // case 'Thanks For':
      //   {
      //     return 'Thanks';
      //   }
      case 'Holy':
        {
          return 'Holy';
        }
      // case 'Maha Shivratri':
      //   {
      //     return 'Shivratri';
      //   }
      case 'FriendshipDay':
        {
          return 'Friendship';
        }
      case 'ValentinesDay':
        {
          return 'ValentinesDay';
        }
      case 'NewYear':
        {
          return 'NewYear';
        }
      case 'Christmas':
        {
          return 'Christmas';
        }
      case 'Diwali':
        {
          return 'Diwali';
        }
      case 'GaneshChaturti':
        {
          return 'GaneshChaturti';
        }
      case 'Dussehra, Navaratri, DurgaPuja':
        {
          return 'Navaratri';
        }
      case 'Onam':
        {
          return 'Onam';
        }
      case 'Krishna Janmashtami':
        {
          return 'KrishnaJanmashtami';
        }
      case 'Raksha Bandhan':
        {
          return 'RakshaBandhan';
        }
      default:
        {
          return '';
        }
    }
  }
}

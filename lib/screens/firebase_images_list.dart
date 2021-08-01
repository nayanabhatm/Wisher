import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wisher/screens/user_input1.dart';
import 'package:wisher/widgets/app_bar.dart';
import 'package:wisher/widgets/error_card.dart';
import 'package:wisher/widgets/firebase_image.dart';
import 'package:wisher/widgets/place_holder_image.dart';
import 'package:wisher/widgets/progress_indicator.dart';

class LoadFirebaseImages extends StatelessWidget {
  const LoadFirebaseImages({
    Key key,
    this.firebaseDirectoryName,
    this.appBarText,
  }) : super(key: key);

  final String firebaseDirectoryName;
  final String appBarText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WisherAppBar(
        appBarText: '$appBarText Wishes' ?? '',
      ),
      body: StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder:
            (BuildContext context, AsyncSnapshot<ConnectivityResult> result) {
          if (result.data == ConnectivityResult.none) {
            return const ErrorCard(
              iconData: Icons.wifi,
              errorText: 'Please check you Internet Connectivity',
            );
          }
          return FutureBuilder(
            future: _getImages(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, String> firebaseImageMap = snapshot.data;

                if (firebaseImageMap == null) {
                  return const ErrorCard(
                    errorText:
                        'Something went wrong. Please check your InternetConnectivity',
                  );
                } else if (firebaseImageMap.isEmpty) {
                  return const ErrorCard(
                    iconData: Icons.error,
                    errorText: 'No Images',
                  );
                } else {
                  return ListView(
                    children: firebaseImageMap.entries
                        .map((image) => AspectRatio(
                              aspectRatio: 4 / 3,
                              child: CachedNetworkImage(
                                imageUrl: image.value,
                                imageBuilder: (context, imageProvider) =>
                                    InkWell(
                                  hoverColor:
                                      Theme.of(context).colorScheme.secondary,
                                  splashColor:
                                      Theme.of(context).colorScheme.secondary,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return UserInputScreen1(
                                            imageUrl: image.value,
                                            imageProvider: imageProvider,
                                            directoryName: appBarText,
                                            fileName: image.key,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: FirebaseImage(
                                    imageUrl: image.value,
                                    imageProvider: imageProvider,
                                  ),
                                ),
                                fadeInCurve: Curves.easeIn,
                                placeholder: (context, url) =>
                                    const PlaceHolderImageWidget(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ))
                        .toList(),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.none) {
                return const ErrorCard(
                  errorText: 'No Images',
                );
              }
              if (snapshot.hasError) {
                return ErrorCard(
                  errorText: snapshot.error.toString(),
                );
              }
              return const WisherProgressIndicator();
            },
          );
        },
      ),
    );
  }

  Future<Map<String, String>> _getImages() async {
    List<String> firebaseImagePaths = [];
    List<String> firebaseImageNames = [];
    Map<String, String> firebaseImageMap = {};

    await FirebaseStorage.instance
        .ref()
        .root
        .child(firebaseDirectoryName)
        .listAll()
        .then((value) {
      for (var element in value.items) {
        firebaseImagePaths.add(element.fullPath);
        firebaseImageNames.add(element.name);
      }
    }).timeout(const Duration(seconds: 20));

    for (int i = 0; i < firebaseImagePaths.length; i++) {
      String imageURL = await FirebaseStorage.instance
          .ref()
          .child(firebaseImagePaths[i])
          .getDownloadURL();

      firebaseImageMap[firebaseImageNames[i]] = imageURL;
    }

    return firebaseImageMap;
  }
}

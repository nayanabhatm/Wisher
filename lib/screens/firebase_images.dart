import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wisher/screens/user_input.dart';
import 'package:wisher/utils/constants.dart';
import 'package:wisher/widgets/app_bar.dart';
import 'package:wisher/widgets/error_card.dart';
import 'package:wisher/widgets/image_widget.dart';
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
    ThemeData themeData = Theme.of(context);
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
              errorText: Constants.checkConnectivity,
            );
          }
          return FutureBuilder(
            future: _getImages(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, String> firebaseImageMap = snapshot.data;

                if (firebaseImageMap == null) {
                  return const ErrorCard(
                    errorText: Constants.someError,
                  );
                } else if (firebaseImageMap.isEmpty) {
                  return const ErrorCard(
                    iconData: Icons.error,
                    errorText: Constants.noImages,
                  );
                } else {
                  return ListView(
                    children: firebaseImageMap.entries
                        .map(
                          (image) => AspectRatio(
                            aspectRatio: 4 / 3,
                            child: CachedNetworkImage(
                              imageUrl: image.value,
                              imageBuilder: (context, imageProvider) => InkWell(
                                hoverColor: themeData.colorScheme.secondary,
                                splashColor: themeData.colorScheme.secondary,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return UserInputScreen(
                                          imageUrl: image.value,
                                          imageProvider: imageProvider,
                                          directoryName: appBarText,
                                          fileName: image.key,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: ImageWidget(
                                  imageProvider: imageProvider,
                                  boxFit: BoxFit.fill,
                                ),
                              ),
                              fadeInCurve: Curves.easeIn,
                              placeholder: (context, url) =>
                                  const PlaceHolderImageWidget(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        )
                        .toList(),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.none) {
                return const ErrorCard(
                  errorText: Constants.noImages,
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

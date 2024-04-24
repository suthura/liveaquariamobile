import 'package:aquaria_mobile/models/advertisement_model.dart';
import 'package:aquaria_mobile/providers/auth_provider.dart';
import 'package:aquaria_mobile/providers/item_order_provider.dart';
import 'package:aquaria_mobile/screens/home/single_user_request.dart';
import 'package:aquaria_mobile/utils/color_constants.dart';
import 'package:aquaria_mobile/utils/size_config.dart';
import 'package:aquaria_mobile/widgets/custom_background_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ItemOrderProvider>(context, listen: false).loadFavorites(context);
    });
    super.initState();
  }

  SingleAvertisement? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = SizeConfig();
    return CustomBackGroundContainer(
      child: Consumer2<ItemOrderProvider, AuthProvider>(
        builder: (context, loadedItems, auth, child) {
          if (loadedItems.getisLoadingItems) {
            return const CupertinoActivityIndicator(
              color: kTxtWhite,
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: size.getPropotionateHeight(15),
                ),
                const Text(
                  "Favorites",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: size.getPropotionateHeight(5),
                ),
                SizedBox(
                  height: size.getPropotionateHeight(5),
                ),
                SizedBox(
                  height: size.getPropotionateHeight(17),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1,
                    ),
                    itemCount: loadedItems.getloadedfavoriteslist!.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => SingleUserRequest(item: loadedItems.getloadedfavoriteslist!.data![index]),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, -3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      child: loadedItems.getloadedfavoriteslist!.data![index].images!.isEmpty
                                          ? Image.asset(
                                              'assets/images/fish.png',
                                              // width: MediaQuery.of(context).size.width * .4,
                                              height: size.getPropotionateHeight(120),
                                              fit: BoxFit.cover,
                                            )
                                          : CachedNetworkImage(
                                              // width: MediaQuery.of(context).size.width * .4,
                                              height: size.getPropotionateHeight(120),
                                              fit: BoxFit.cover,
                                              imageUrl: loadedItems.getloadedfavoriteslist!.data![index].images![0],
                                              progressIndicatorBuilder: (context, url, downloadProgress) => const CupertinoActivityIndicator(
                                                color: kTxtWhite,
                                              ),
                                              errorWidget: (context, url, error) => const Icon(
                                                Icons.error,
                                              ),
                                            ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: loadedItems.getprocecingFavId.contains(loadedItems.getloadedadslist!.data![index].id!)
                                          ? CupertinoActivityIndicator()
                                          : IconButton(
                                              onPressed: () {
                                                if (loadedItems.getloadedfavoriteslist!.data!
                                                    .any((element) => element.id == loadedItems.getloadedadslist!.data![index].id)) {
                                                  loadedItems.removeFavorite(context, loadedItems.getloadedadslist!.data![index].id!);
                                                } else {
                                                  loadedItems.addToFavorite(context, loadedItems.getloadedadslist!.data![index].id!);
                                                }
                                              },
                                              icon: Icon(
                                                Icons.favorite,
                                                color: loadedItems.getloadedfavoriteslist!.data!
                                                        .any((element) => element.id == loadedItems.getloadedadslist!.data![index].id)
                                                    ? Colors.red
                                                    : Colors.white,
                                              ),
                                            ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * .4,
                                      child: Text(
                                        '${loadedItems.getloadedfavoriteslist!.data![index].item!.commonName}',
                                        style: const TextStyle(
                                          color: Color(0xFF0E52A8),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    // const SizedBox(
                                    //   height: 5,
                                    // ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * .4,
                                      child: Text(
                                        '${loadedItems.getloadedfavoriteslist!.data![index].item!.code}',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),
                                    if (loadedItems.getloadedfavoriteslist!.data![index].description != null)
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * .4,
                                        child: Text(
                                          limitText('${loadedItems.getloadedfavoriteslist!.data![index].description}', 40),
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: size.getPropotionateHeight(17),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String limitText(String text, int limit) {
    if (text.length <= limit) {
      return text;
    } else {
      return text.substring(0, limit) + '...';
    }
  }
}

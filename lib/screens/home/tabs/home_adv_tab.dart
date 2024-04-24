import 'package:aquaria_mobile/models/advertisement_model.dart';
import 'package:aquaria_mobile/providers/auth_provider.dart';
import 'package:aquaria_mobile/providers/item_order_provider.dart';
import 'package:aquaria_mobile/screens/home/favorites.dart';
import 'package:aquaria_mobile/screens/home/single_user_request.dart';
import 'package:aquaria_mobile/utils/color_constants.dart';
import 'package:aquaria_mobile/utils/size_config.dart';
import 'package:aquaria_mobile/widgets/common_button.dart';
import 'package:aquaria_mobile/widgets/common_input_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeAdvTab extends StatefulWidget {
  const HomeAdvTab({super.key});

  @override
  State<HomeAdvTab> createState() => _HomeAdvTabState();
}

class _HomeAdvTabState extends State<HomeAdvTab> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ItemOrderProvider>(context, listen: false).loadAdvertisements(context);
      Provider.of<ItemOrderProvider>(context, listen: false).loadFavorites(context);
    });
    super.initState();
  }

  SingleAvertisement? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = SizeConfig();
    return Consumer2<ItemOrderProvider, AuthProvider>(
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
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: size.getPropotionateHeight(50),
                      decoration: BoxDecoration(
                        color: kTxtWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // width: double.infinity,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<SingleAvertisement>(
                          isExpanded: true,
                          iconStyleData: IconStyleData(
                            icon: Container(
                              width: 40,
                              height: 40,
                              decoration: const ShapeDecoration(
                                color: Color(0xFFFFF200),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                              ),
                              child: const Icon(
                                Icons.search,
                                color: Color(0xFF002E57),
                              ),
                            ),
                          ),
                          hint: Text(
                            'Search by name/item number.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: loadedItems.getloadedadslist!.data!
                              .map((SingleAvertisement? item) => DropdownMenuItem<SingleAvertisement>(
                                    value: item!,
                                    child: Text(
                                      item.item!.commonName ?? '', // You can choose any property to display here
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.only(right: 7, left: 20),
                            height: 40,
                            width: 200,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                          dropdownSearchData: DropdownSearchData(
                            searchController: textEditingController,
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                controller: textEditingController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'Type Here...',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              return ((item.value!.item!.commonName ?? '').toLowerCase().contains(searchValue.toLowerCase()));
                            },
                          ),
                          onMenuStateChange: (isOpen) {
                            if (!isOpen) {
                              textEditingController.clear();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => FavoritesPage(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                ],
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
                child: ListView.builder(
                  itemCount: loadedItems.getloadedadslist!.data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => SingleUserRequest(item: loadedItems.getloadedadslist!.data![index]),
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
                            Container(
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: loadedItems.getloadedadslist!.data![index].images!.isEmpty
                                        ? Image.asset(
                                            'assets/images/fish.png',
                                            // width: MediaQuery.of(context).size.width * .4,
                                            width: double.infinity,
                                            height: size.getPropotionateHeight(120),
                                            fit: BoxFit.cover,
                                          )
                                        : CachedNetworkImage(
                                            // width: MediaQuery.of(context).size.width * .4,
                                            width: double.infinity,
                                            height: size.getPropotionateHeight(120),
                                            fit: BoxFit.cover,
                                            imageUrl: loadedItems.getloadedadslist!.data![index].images![0],
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
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * .4,
                                          child: Text(
                                            '${loadedItems.getloadedadslist!.data![index].item!.commonName}',
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
                                            '${loadedItems.getloadedadslist!.data![index].item!.code}',
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
                                        if (loadedItems.getloadedadslist!.data![index].description != null)
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * .4,
                                            child: Text(
                                              limitText('${loadedItems.getloadedadslist!.data![index].description}', 40),
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
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Alert(
                                            context: context,
                                            content: Consumer<ItemOrderProvider>(
                                              builder: (context, itmO, child) {
                                                return Column(
                                                  children: [
                                                    CommonInputField(
                                                      controller: itmO.getlikedislikenoteController,
                                                      hint: "Note",
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    CommonButton(
                                                      size: size,
                                                      btnTxt: 'Like',
                                                      onTap: () {
                                                        itmO.sendlikeDislike(context, id: loadedItems.getloadedadslist!.data![index].id!, vote: 1);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                            buttons: [],
                                          ).show();
                                        },
                                        icon: Icon(
                                          Icons.thumb_up_outlined,
                                          color: loadedItems.getloadedadslist!.data![index].isLiked == 1 ? Colors.blue : Colors.grey,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Alert(
                                            context: context,
                                            content: Consumer<ItemOrderProvider>(
                                              builder: (context, itmO, child) {
                                                return Column(
                                                  children: [
                                                    CommonInputField(
                                                      controller: itmO.getlikedislikenoteController,
                                                      hint: "Note",
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    CommonButton(
                                                      size: size,
                                                      btnTxt: 'Unlike',
                                                      onTap: () {
                                                        itmO.sendlikeDislike(context, id: loadedItems.getloadedadslist!.data![index].id!, vote: -1);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                            buttons: [],
                                          ).show();
                                        },
                                        icon: Icon(
                                          Icons.thumb_down_outlined,
                                          color: loadedItems.getloadedadslist!.data![index].isLiked == -1 ? Colors.blue : Colors.grey,
                                        ),
                                      )
                                    ],
                                  )
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

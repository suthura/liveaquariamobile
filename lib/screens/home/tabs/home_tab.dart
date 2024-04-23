import 'package:aquaria_mobile/models/main_item_model.dart';
import 'package:aquaria_mobile/providers/auth_provider.dart';
import 'package:aquaria_mobile/providers/item_order_provider.dart';
import 'package:aquaria_mobile/screens/home/single_suplier_request.dart';
import 'package:aquaria_mobile/utils/color_constants.dart';
import 'package:aquaria_mobile/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ItemOrderProvider>(context, listen: false).loadAllMainItems(context);
    });
    super.initState();
  }

  SingleItem? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = SizeConfig();
    return Consumer2<ItemOrderProvider, AuthProvider>(
      builder: (context, loadedItems, auth, child) {
        if (loadedItems.getisLoadingItems) {
          return CupertinoActivityIndicator(
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
              Container(
                height: size.getPropotionateHeight(50),
                decoration: BoxDecoration(
                  color: kTxtWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<SingleItem>(
                    isExpanded: true,
                    iconStyleData: IconStyleData(
                      icon: Container(
                        width: 40,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: Color(0xFF0E52A8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                        ),
                        child: Icon(
                          Icons.search,
                          // color:  Color(0xFF0E52A8),
                          color: kTxtWhite,
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
                    items: loadedItems.getloadedMainItems!.data!
                        .map((SingleItem? item) => DropdownMenuItem<SingleItem>(
                              value: item!,
                              child: Text(
                                item.commonName ?? '', // You can choose any property to display here
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
                        return ("${item.value!.commonName ?? ''}".toLowerCase().contains(searchValue.toLowerCase()));
                        // return item.value!.name!.toLowerCase().contains(searchValue.toLowerCase());
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
              SizedBox(
                height: size.getPropotionateHeight(5),
              ),
              // if (auth.getloggedinUser!.data!.role == "super admin")
              //   Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 10),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         CommonButton(
              //           size: size,
              //           btnTxt: '+ Add',
              //           width: size.getPropotionateWidth(120),
              //           height: size.getPropotionateHeight(40),
              //           bgColor: Color(0xFFF8E328),
              //           txtColor: Colors.black,
              //           onTap: () => Navigator.push(
              //             context,
              //             MaterialPageRoute<void>(
              //               builder: (BuildContext context) => const AddItemScreen(),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              SizedBox(
                height: size.getPropotionateHeight(5),
              ),
              Row(
                children: [
                  Text(
                    'Recently added items.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(
                height: size.getPropotionateHeight(17),
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: loadedItems.loadedMainItems!.data!.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 20,
                    );
                  },
                  itemBuilder: (context, index) {
                    return Neumorphic(
                      style: NeumorphicStyle(
                        color: Color(0xFF0E52A8),
                        shape: NeumorphicShape.flat,
                        lightSource: LightSource.bottom,
                        depth: -20,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => SingleSupplierRequest(item: loadedItems.loadedMainItems!.data![index]),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: size.getPropotionateHeight(120),
                          child: Row(
                            children: [
                              loadedItems.loadedMainItems!.data![index].images!.isEmpty
                                  ? Image.asset(
                                      'assets/images/fish.png',
                                      width: MediaQuery.of(context).size.width * .4,
                                      height: size.getPropotionateHeight(120),
                                      fit: BoxFit.cover,
                                    )
                                  : CachedNetworkImage(
                                      width: MediaQuery.of(context).size.width * .4,
                                      height: size.getPropotionateHeight(120),
                                      fit: BoxFit.cover,
                                      imageUrl: loadedItems.loadedMainItems!.data![index].images![0],
                                      progressIndicatorBuilder: (context, url, downloadProgress) => CupertinoActivityIndicator(
                                        // value: downloadProgress.progress,
                                        color: kTxtWhite,
                                      ),
                                      errorWidget: (context, url, error) => Icon(
                                        Icons.error,
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * .4,
                                      child: Text(
                                        '${loadedItems.loadedMainItems!.data![index].commonName}',
                                        style: TextStyle(
                                          color: kTxtWhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * .4,
                                      child: Text(
                                        '${loadedItems.loadedMainItems!.data![index].code}',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    if (loadedItems.loadedMainItems!.data![index].description != null)
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * .4,
                                        child: Text(
                                          limitText('${loadedItems.loadedMainItems!.data![index].description}', 50),
                                          style: TextStyle(
                                            color: Colors.grey,
                                            // fontWeight: FontWeight.,
                                            fontSize: 10,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                    // return InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute<void>(
                    //         builder: (BuildContext context) => SingleSupplierRequest(item: loadedItems.loadedMainItems!.data![index]),
                    //       ),
                    //     );
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(12),
                    //       image: loadedItems.loadedMainItems!.data![index].images!.isEmpty
                    //           ? DecorationImage(image: AssetImage('assets/images/fish.png'))
                    //           : DecorationImage(
                    //               image: NetworkImage(
                    //                 loadedItems.loadedMainItems!.data![index].images![0],
                    //               ),
                    //               fit: BoxFit.cover,
                    //             ),
                    //     ),
                    //     width: double.infinity,
                    //     height: size.getPropotionateHeight(120),
                    //     child: Stack(
                    //       children: [
                    //         Positioned(
                    //           top: size.getPropotionateWidth(11),
                    //           left: size.getPropotionateWidth(11),
                    //           child: Container(
                    //             width: size.getPropotionateWidth(101),
                    //             height: size.getPropotionateHeight(43),
                    //             alignment: Alignment.center,
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(12),
                    //               gradient: LinearGradient(
                    //                 begin: Alignment.topCenter,
                    //                 end: Alignment.bottomRight,
                    //                 colors: [
                    //                   Colors.black.withOpacity(0.4),
                    //                   Colors.black.withOpacity(0.3),
                    //                 ],
                    //               ),
                    //             ),
                    //             child: Text.rich(
                    //               TextSpan(
                    //                 children: [
                    //                   TextSpan(
                    //                     text: '${loadedItems.loadedMainItems!.data![index].commonName}\n',
                    //                     style: TextStyle(
                    //                       color: Colors.white,
                    //                       fontSize: 12,
                    //
                    //                       fontWeight: FontWeight.w600,
                    //                       height: 0,
                    //                     ),
                    //                   ),
                    //                   TextSpan(
                    //                     text: 'Item ID: ${loadedItems.loadedMainItems!.data![index].code}',
                    //                     style: TextStyle(
                    //                       color: Colors.white,
                    //                       fontSize: 10,
                    //
                    //                       fontWeight: FontWeight.w400,
                    //                       height: 0,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //         Positioned(
                    //           right: size.getPropotionateWidth(10),
                    //           top: size.getPropotionateWidth(10),
                    //           child: Container(
                    //             height: size.getPropotionateWidth(30),
                    //             width: size.getPropotionateWidth(30),
                    //             decoration: BoxDecoration(
                    //               color: kTxtWhite,
                    //               shape: BoxShape.circle,
                    //             ),
                    //             child: Icon(
                    //               Icons.arrow_forward_ios_sharp,
                    //               size: 15,
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // );
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

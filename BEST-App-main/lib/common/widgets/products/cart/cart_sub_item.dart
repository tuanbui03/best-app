import 'package:best/api/order_detail_api.dart';
import 'package:best/api/product_color_api.dart';
import 'package:best/common/widgets/icons/t_circular_icon.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/features/shop/screens/cart/cart.dart';
import 'package:best/model/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/t_rounded_image.dart';
import '../../texts/product_title_text.dart';

List listImage = [];
Future<List> _loadDataImage(int productID, int colorID) async {
  listImage = await ProductColorAPI.getListProductColorByProductIdAndColorID(
      productID, colorID);
  return listImage;
}

class TCartSubItem extends StatefulWidget {
  dynamic data;
  int stateVoucher; //0 text, 1 voucher, 2 vote
  TCartSubItem(this.data,this.stateVoucher ,{super.key});

  @override
  State<TCartSubItem> createState() => _TCartItemState();
}

class _TCartItemState extends State<TCartSubItem> {
  int rating = 0;
  int quantity = 0;
  //
  List listProductCart = [1];
  dynamic dataOrderDetail ;
  Future<List> _loadDataProductCart(int odID) async {
    dataOrderDetail = await OrderDetailAPI.getOrderDetailByID(odID);
    quantity = dataOrderDetail['quantity'];
    return listProductCart;
  }

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
          future: _loadDataProductCart(widget.data['id']),
          builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) => snapshot
              .hasData
              ?
          Row(
            children: [
              /// Image
              FutureBuilder(
                  future: _loadDataImage(
                      dataOrderDetail['productDetail']
                      ['productSize']['product']['id'],
                      dataOrderDetail['productDetail']
                      ['productColor']['color']['id']),
                  builder: (BuildContext ctx,
                      AsyncSnapshot<List> snapshots) =>
                  snapshots.hasData
                      ? TRoundedImage(
                    imageUrl:
                    "${snapshots.data![0]['image']}",
                    width: 60,
                    height: 60,
                    padding:
                    const EdgeInsets.all(TSizes.sm),
                    backgroundColor:
                    THelperFunctions.isDarkMode(
                        context)
                        ? TColors.darkerGrey
                        : TColors.light,
                  )
                      : const Center(
                    child: CircularProgressIndicator(),
                  )),
              const SizedBox(width: TSizes.spaceBtwItems),
              /// Title, Price & Size
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: TProductTitleText(
                            title: dataOrderDetail
                            ['productDetail']
                            ['productSize']['product']
                            ['name'],
                            maxLines: 1)),
                    /// Attributes
                    Text.rich(TextSpan(
                      children: [
                        TextSpan(
                            text:
                            '\$${getPriceSale(dataOrderDetail)} ',
                            style: const TextStyle(
                                color: Colors.red)),
                        TextSpan(
                            text:
                            '\$${dataOrderDetail['productDetail']['productSize']['product']['price']}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .apply(
                                decoration: TextDecoration
                                    .lineThrough)),
                        TextSpan(
                            text:
                            '   Size: ${dataOrderDetail['productDetail']['productSize']['size']['size']}',
                            ),
                        TextSpan(
                            text: (widget.stateVoucher == 1)
                                ? ''
                                : '\nVoucher : -${dataOrderDetail['warehouseVoucher']['voucher']['discount_percent']}%',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall),
                        TextSpan(
                            text:(widget.stateVoucher == 1)
                                ? '':
                            '\nQt: ${dataOrderDetail['quantity']}  = \$${getTotalPrice(dataOrderDetail).toStringAsFixed(3)}.  ',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall),
                      ],
                    )),
                    /// Add Remove Button Row with total Price
                    (widget.stateVoucher == 1)?
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TCircularIcon(
                          onPressed: ()async{
                            quantity--;
                            if(quantity == 0){
                              showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return AlertDialog(
                                      title: const Text('Are you sure you want to quit this product?'),
                                      content: Text('${dataOrderDetail['productDetail']['productSize']['product']['name']}'),
                                      actions: [
                                        TextButton(onPressed: ()async{
                                          dynamic result = await OrderDetailAPI.deleteOrderDetailByID(dataOrderDetail['id']);
                                          if(result){
                                            setState(() {
                                              DataApp.stateShop = true;
                                              Get.offAll(() => CartScreen());
                                              // Navigator.of(context).pop();
                                            });
                                          }
                                        }, child: Container(height: 30,width: 100,color: Colors.red,child: const Center(child: Text('Yes',style: TextStyle(color: Colors.white),)))),
                                        TextButton(onPressed: (){
                                          quantity == 1;
                                          setState(() {
                                            Navigator.of(context).pop();
                                          });
                                        }, child: Container(height: 30,width: 100,color: Colors.white,child: const Center(child: Text('No')))),
                                      ],
                                    );
                                  });
                            }else{
                              dynamic ob = await OrderDetailAPI.getOrderDetailByID( dataOrderDetail['id']);
                              OrderDetail orderDetail = OrderDetail(
                                  ob['id'],
                                  ob['order']['id'],
                                  ob['warehouseVoucher']['id'],
                                  ob['productDetail']['id'],
                                  quantity,
                                  getPriceSale(dataOrderDetail));
                              await OrderDetailAPI.updateOrderDetail(orderDetail);
                              dynamic result = await OrderDetailAPI.updateOrderDetail(orderDetail);
                              if(result){
                                setState(() {
                                });
                              }
                            }

                          },
                          icon: Iconsax.minus,
                          width: 32,
                          height: 32,
                          size: TSizes.md,
                          color: THelperFunctions.isDarkMode(context)
                              ? TColors.white
                              : TColors.black,
                          backgroundColor: THelperFunctions.isDarkMode(context)
                              ? TColors.darkerGrey
                              : TColors.light,
                        ),
                        Text(' $quantity ',
                            style: Theme.of(context).textTheme.titleSmall),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        TCircularIcon(
                          onPressed: ()async{
                            quantity++;
                            if(quantity > widget.data['productDetail']['quantity']){
                              quantity--;
                              showDialog(
                              context: context,
                              builder: (builder) {
                              return
                              AlertDialog(
                                content: Text(
                                    'Limited number of products : ${widget.data['productDetail']['quantity']}'),
                              );
                            });
                            }else{
                              dynamic ob = await OrderDetailAPI.getOrderDetailByID( dataOrderDetail['id']);
                              OrderDetail orderDetail = OrderDetail(
                                  ob['id'],
                                  ob['order']['id'],
                                  ob['warehouseVoucher']['id'],
                                  ob['productDetail']['id'],
                                  quantity,
                                  getPriceSale(dataOrderDetail));
                              dynamic result = await OrderDetailAPI.updateOrderDetail(orderDetail);
                              if(result){
                                setState(() {
                                });
                              }
                            }
                          },
                          icon: Iconsax.add,
                          width: 32,
                          height: 32,
                          size: TSizes.md,
                          color: THelperFunctions.isDarkMode(context)
                              ? TColors.white
                              : TColors.black,
                          backgroundColor: THelperFunctions.isDarkMode(context)
                              ? TColors.darkerGrey
                              : TColors.light,
                        ),
                        Text('        \$${getTotalPrice(dataOrderDetail).toStringAsFixed(3)}')
                      ],
                    ): const Text('')
                  ],
                ),
              )
            ],
          ):const Text(''))
    ;
  }
}

//Handle Data
Future reloadData(int quantity, int odID) async {
  dynamic ob = await OrderDetailAPI.getOrderDetailByID(odID);
  OrderDetail orderDetail = OrderDetail(
      ob['id'],
      ob['order']['id'],
      ob['warehouseVoucher']['id'],
      ob['productDetail']['id'],
      quantity,
      ob['price']);
  await OrderDetailAPI.updateOrderDetail(orderDetail);
}

dynamic getPriceSale(dynamic data) {
  return data['productDetail']['productSize']['product']['price'] -
      data['productDetail']['productSize']['product']['price'] *
          data['productDetail']['productSize']['product']['discount'] /
          100;
}

dynamic getTotalPrice(dynamic data) {
  return (data['quantity'] * getPriceSale(data)) *
      (100 - data['warehouseVoucher']['voucher']['discount_percent']) /
      100;
}




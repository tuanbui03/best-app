import 'package:best/api/order_api.dart';
import 'package:best/api/product_api.dart';
import 'package:best/api/product_detail_api.dart';
import 'package:best/common/widgets/appbar/appbar.dart';
import 'package:best/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:best/common/widgets/success_screen/success_screen.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/features/shop/screens/cart/widgets/cart_item.dart';
import 'package:best/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:best/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:best/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:best/model/order.dart';
import 'package:best/model/product.dart';
import 'package:best/model/product_detail.dart';
import 'package:best/utils/constants/colors.dart';
import 'package:best/utils/constants/image_strings.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:best/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../api/order_detail_api.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';
import '../../../../navigation_menu.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen( {super.key});
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text('Payment',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Items in Cart
              TCartItems(showAddRemoveButtons: false),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Coupon TextField
              const TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Billing Section
              TRoundedContainer(
                showBorder: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                child: const Column(
                  children: [
                    /// Pricing
                    TBillingAmountSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    /// Divider
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    /// Payment Methods
                    TBillingPaymentSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    /// Address
                    TBillingAddressSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      /// Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child:
    FutureBuilder(
    future: _loadDataOrderDetail(),
    builder: (BuildContext ctx,
    AsyncSnapshot<List> snapshots) =>
    snapshots.hasData
    ?
        ElevatedButton(
            onPressed: () async {
              if(DataApp.indexPaymentID == 0){
                showDialog(
                context: context,
                builder: (builder) {
                return const AlertDialog(
                content: Text(
                'Please select payment method !'),
                );
                });
              }else if(DataApp.order.address == '' || DataApp.order.phone == '' || DataApp.order.phone.length != 10){
                showDialog(
                    context: context,
                    builder: (builder) {
                      return const AlertDialog(
                        content: Text(
                            'Address cannot be left blank!\n'
                                'Phone number cannot be left blank, length = 10!'),
                      );
                    });
              }else{
              Order order = Order(
                  DataApp.orderId,
                  DataApp.user['id'],
                  DataApp.indexPaymentID,
                  DataApp.order.address,
                  double.parse(sumTotalBill.toStringAsFixed(3)),
                  '',DataApp.order.phone,
                  0);
              dynamic result = await OrderAPI.updateOrder(order);
              if (result == true) {
                updateQuantityProduct();
                DataApp.setCart();
                Get.to(
                  () => SuccessScreen(
                      image: TImages.successfulPaymentIcon,
                      title: 'Payment Success!',
                      subTitle: 'Your item will be shipped soon!',
                      onPressed: () =>
                          Get.offAll(() => const NavigationMenu())),
                );
              }}
            },
            child: Text('Checkout \$${sumTotalBill.toStringAsFixed(3)}')):const Text('')
    )));
  }
}
//Handle Data
List listOrderDetail = [0];
dynamic sumTotalBill = 0;
Future<List> _loadDataOrderDetail() async {
  sumTotalBill = await OrderDetailAPI.getSumOrderDetailByOrderID(DataApp.orderId);
  print('----------119Checkout $sumTotalBill\n ${DataApp.orderId}');
  return listOrderDetail;
}
void updateQuantityProduct() async{
  List orderDetail = await OrderDetailAPI.getOrderDetailByOrderID(DataApp.orderId);// sluong spham da mua
  for(var data in orderDetail){
    //sub quantity by product detail
    dynamic productDetail = await ProductDetailAPI.getProductDetailByProductIdAndColorIdAndSizeID(data['productDetail']['productSize']['product']['id'], data['productDetail']['productColor']['id'], data['productDetail']['productSize']['id']);
    productDetail['quantity'] -= data['quantity'];
    ProductDetail ob = ProductDetail(productDetail['id'], productDetail['productSize']['id'], productDetail['productColor']['id'], productDetail['quantity']);
    await ProductDetailAPI.updateProductDetail(ob);
    //sub quantity by product
    dynamic product = await ProductAPI.getProductByID(data['productDetail']['productColor']['product']['id']);
    product['quantity'] -= data['quantity'];
    product['sold'] += data['quantity'];
    Product p = Product(product['id'], product['brand']['id'], product['category']['id'],product['shop']['id'] ,product['name'], product['quantity'], product['price'], product['description'], product['code'], product['discount'],product['sold'],product['created_at'] ,product['status']);
    await ProductAPI.updateProduct(p);
  }

}
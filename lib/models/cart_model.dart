import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;
  List<CartProduct> products = [];
  bool isLoading = false;
  String couponCode;
  int discountPercentage = 0;

  CartModel(this.user) {
    if (user.isLoggedIn()) _loadCartItems();
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.documentID;
    });
    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(cartProduct.cid)
        .delete();
    products.remove(cartProduct);
    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());
    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity++;
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());
    notifyListeners();
  }

  void setCoupons(String couponCode, int percentage) {
    this.couponCode = couponCode;
    this.discountPercentage = percentage;
  }

  void updatePrices() {
    notifyListeners();
  }

  double getProductsPrice() {
    double price = 0;
    for (CartProduct c in products) {
      if (c.productData != null) price += c.quantity * c.productData.price;
    }
    return price;
  }

  double getShipPrice() {
    return 9.99;
  }

  double getDiscount() {
    return getProductsPrice() * discountPercentage / 100;
  }

  Future<String> finishOrder() async {
    if (products.length == 0) return null ;
    isLoading = true;
    notifyListeners();
    double productsprice=getProductsPrice();
    double shipprice=getShipPrice();
    double discount=getDiscount();
    DocumentReference refOrder = await Firestore.instance.collection('orders').add({
      "clientId": user.firebaseUser.uid, 
      "products": products.map((cartProduct) => cartProduct.toMap()).toList(), 
      "shipPrice": shipprice, 
      "productsPrice": productsprice, 
      "discount": discount, 
      "totalPrice": productsprice-discount+shipprice, 
      "status": 1, 
    });

    await Firestore.instance.collection('users').document(user.firebaseUser.uid).collection('orders').document(refOrder.documentID).setData({
      'orderId':refOrder.documentID
    });

    QuerySnapshot query = await Firestore.instance.collection('users').document(user.firebaseUser.uid).collection('cart').getDocuments();

    for(DocumentSnapshot doc in query.documents){doc.reference.delete();}
    products.clear();
    discountPercentage=0;
    couponCode=null;
    isLoading=false;
    notifyListeners();
    return refOrder.documentID;
  }


  void _loadCartItems() async {
    QuerySnapshot query = await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .getDocuments();
    products =
        query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();
    notifyListeners();
  }
}

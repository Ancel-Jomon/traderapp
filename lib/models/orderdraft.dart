

import 'package:flutter/material.dart';
import 'package:traderapp/models/product.dart';

class OrderDraft extends ChangeNotifier {
  int total = 0;
 final Map<Product, int> orderitems = {};
 final Map<Product,String> existingitems={};

  Map<Product, int> viewOderItems() {
    return orderitems;
  }

  int viewOderItemCount(Product orderitem) {
    
    return orderitems[orderitem] ?? 0;
  }

  void addOrderItem(Product orderitem) {
    
    if (orderitems.containsKey(orderitem)) {
      orderitems[orderitem] = orderitems[orderitem]! + 1;
      
      
      
    } else {
      orderitems[orderitem] = 1;
    }
    total+=orderitem.productPrice;
    notifyListeners();
  }

  void removeOrderItem(Product orderitem) {
    if (orderitems.containsKey(orderitem)) {
      if (orderitems[orderitem]! == 1) {
        orderitems.remove(orderitem);
      } else {
        orderitems[orderitem] = orderitems[orderitem]! - 1;
      }
      total-=orderitem.productPrice;
      notifyListeners();
    }
  }

  void emptyOrderMap(){
    total=0;
    orderitems.clear();
  }

  int totalPrice(){
   
    
   return total;
    
  }

  void refillorders(Product orderitem,int count,String id){
    orderitems[orderitem] = count;
    total=total+count*orderitem.productPrice;
    existingitems[orderitem]=id;
    
    notifyListeners();
  }
    
 Map<Product, String>  itemspresent(){return existingitems;}
 
}

package com.best.springbest.controller;

import com.best.springbest.dto.OrderDetailDto;
import com.best.springbest.model.OrderDetail;
import com.best.springbest.service.OrderDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@CrossOrigin(origins = "*")
@RestController
public class OrderDetailController {
    @Autowired
    OrderDetailService orderDetailService;
    @RequestMapping(value = "api/best_app/order_detail/all", method = RequestMethod.GET)
    public List<OrderDetail> getAllOrderDetails(){
        return orderDetailService.getAllOrderDetail();
    }
    @RequestMapping(value = "api/best_app/order_detail/detail", method = RequestMethod.GET)
    public OrderDetail getOrderDetailByID(@RequestParam int id){
        return orderDetailService.getOrderDetailByID(id);
    }
    @RequestMapping(value = "api/best_app/order_detail/byOrderID", method = RequestMethod.GET)
    public List<OrderDetail> getOrderDetailByOrderID(@RequestParam int orderID){
        return orderDetailService.getOrderDetailByOrderID(orderID);}

    @RequestMapping(value = "api/best_app/order_detail/sumByOrderID", method = RequestMethod.GET)
    public double getSumOrderDetailByOrderID(@RequestParam int orderID){
        return orderDetailService.getSumOrderDetailByOrderID(orderID);}
    @RequestMapping(value = "api/best_app/order_detail/byOrderID_ProductDetailID", method = RequestMethod.GET)
    public OrderDetail getOrderDetailByOrderIDAndProductDetailID(@RequestParam int orderID, @RequestParam int productDetailID){
        return orderDetailService.getOrderDetailByOrderIDAndProductDetailID(orderID, productDetailID);}
    @RequestMapping(value = "api/best_app/order_detail/byShopID_OrderID", method = RequestMethod.GET)
    public List<OrderDetail> getOrderDetailByShopIdAndOrderID(@RequestParam int shopID, @RequestParam int orderID){
        return orderDetailService.getOrderDetailsByShopIdAndOrderID(shopID, orderID);}

    @RequestMapping(value = "api/best_app/order_detail/byOrderID_ProductID", method = RequestMethod.GET)
    public List<OrderDetail> getOrderDetailByOrderIDAndProductID(@RequestParam int orderID, @RequestParam int productID){
        return orderDetailService.getOrderDetailByOrderIDAndProductID(orderID, productID);}
      @RequestMapping(value = "api/best_app/order_detail/create", method = RequestMethod.POST)
    public boolean addOrderDetail(@RequestBody OrderDetailDto orderDetail){
        return orderDetailService.addOrderDetail(orderDetail);}
    @RequestMapping(value = "api/best_app/order_detail/update", method = RequestMethod.PUT)
    public boolean updateOrderDetail(@RequestBody OrderDetailDto orderDetail){
        return orderDetailService.updateOrderDetail(orderDetail);}
    @RequestMapping(value = "api/best_app/order_detail/delete", method = RequestMethod.DELETE)
    public boolean removeOrderDetail(@RequestParam int id){
        return orderDetailService.removeOrderDetail(id);
    }
}

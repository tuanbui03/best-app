package com.best.springbest.controller;

import com.best.springbest.dto.OrderDto;
import com.best.springbest.model.Order;
import com.best.springbest.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@CrossOrigin(origins = "*")
@RestController
public class OrderController {
    @Autowired
    OrderService orderService;
    @RequestMapping(value = "api/best_app/order/all", method = RequestMethod.GET)
    public List<Order> getAllOrders(){
        return orderService.getAllOrder();
    }
    @RequestMapping(value = "api/best_app/order/detail", method = RequestMethod.GET)
    public Order getOrderByID(@RequestParam int id){
        return orderService.getOrderByID(id);
    }
    @RequestMapping(value = "api/best_app/order/sumQuantityProduct", method = RequestMethod.GET)
    public int getSumQuantityProductSold(@RequestParam int productID){
        return orderService.getSumQuantityProductSold(productID);}
    @RequestMapping(value = "api/best_app/order/byShop", method = RequestMethod.GET)
    public List<Order> getOrderByShopID(@RequestParam int shopID){
        return orderService.getOrderByShopID(shopID);
    }
    @RequestMapping(value = "api/best_app/order/action", method = RequestMethod.GET)
    public Order getOrderAction(@RequestParam int userID){
        return orderService.getOrderAction(userID);
    }
    @RequestMapping(value = "api/best_app/order/disAction", method = RequestMethod.GET)
    public List<Order> getOrderDisAction(@RequestParam int userID){
        return orderService.getOrderDisAction(userID);
    }
    @RequestMapping(value = "api/best_app/order/create", method = RequestMethod.POST)
    public boolean addOrder(@RequestBody OrderDto order){
        return orderService.addOrder(order);
    }
    @RequestMapping(value = "api/best_app/order/update", method = RequestMethod.PUT)
    public boolean updateOrder(@RequestBody OrderDto order){
        return orderService.updateOrder(order);
    }
    @RequestMapping(value = "api/best_app/order/delete", method = RequestMethod.DELETE)
    public boolean removeOrder(@RequestParam int id){
        return orderService.removeOrder(id);
    }
}

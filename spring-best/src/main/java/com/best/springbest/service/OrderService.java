package com.best.springbest.service;

import com.best.springbest.dto.OrderDto;
import com.best.springbest.handle.DateHanle;
import com.best.springbest.model.*;
import com.best.springbest.repository.OrderRepository;
import com.best.springbest.repository.PaymentRepository;
import com.best.springbest.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class OrderService {
    @Autowired
    OrderRepository obRepository;
    @Autowired
    UserRepository uRepository;
    @Autowired
    PaymentRepository pRepository;
    public List<Order> getAllOrder(){
        try{
            return obRepository.findAll();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public Order getOrderByID(int id){
        try{
            return obRepository.findOrdersByID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public Order getOrderAction(int userID){
        try{
            return obRepository.findOrdersAction(userID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public int getSumQuantityProductSold(int productID){
        try{
            return obRepository.getSumQuantityProductSold(productID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return 0;
    }

    public List<Order> getOrderByShopID(int shopID){
        try{
            return obRepository.getOrderByShopID(shopID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public List<Order> getOrderDisAction(int userID){
        try{
            return obRepository.findOrdersDisAction(userID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public boolean addOrder(OrderDto ob){
        try{
            User user = uRepository.findUsersByID(ob.getUser_id());
            Payment payment = pRepository.findPaymentsByID(ob.getPayment_id());
            obRepository.save(new Order(0,user,payment,ob.getAddress(),ob.getTotal(),DateHanle.getDateNow(),ob.getPhone(),ob.getStatus()));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean updateOrder(OrderDto ob){
        try{
            User user = uRepository.findUsersByID(ob.getUser_id());
            Payment payment = pRepository.findPaymentsByID(ob.getPayment_id());
            obRepository.save(new Order(ob.getId(),user,payment,ob.getAddress(),ob.getTotal(),DateHanle.getDateNow(),ob.getPhone(),ob.getStatus()));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean removeOrder(int id){
        try{
            Order ob = obRepository.findOrdersByID(id);
            obRepository.delete(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
}

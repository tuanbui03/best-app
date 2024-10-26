package com.best.springbest.service;

import com.best.springbest.dto.OrderDetailDto;
import com.best.springbest.model.*;
import com.best.springbest.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class OrderDetailService {
    @Autowired
    OrderDetailRepository obRepository;
    @Autowired
    OrderRepository oRepository;
    @Autowired
    WarehouseVoucherRepository warehouseVoucherRepository;
    @Autowired
    ProductDetailRepository pdRepository;
    public List<OrderDetail> getAllOrderDetail(){
        try{
            return obRepository.findAll();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public OrderDetail getOrderDetailByID(int id){
        try{
            return obRepository.findOrderDetailsByID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public double getSumOrderDetailByOrderID(int orderID){
        try{
            return obRepository.sumOrderDetailByOrderID(orderID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return 0;
    }
    public  OrderDetail getOrderDetailByOrderIDAndProductDetailID(int orderID, int pdID){
        try{
            return obRepository.findOrderDetailByOrderIDAndProductDetailID(orderID, pdID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public  List<OrderDetail> getOrderDetailsByShopIdAndOrderID(int orderID, int pdID){
        try{
            return obRepository.findOrderDetailsByShopIdAndOrderID(orderID,pdID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public  List<OrderDetail> getOrderDetailByOrderIDAndProductID(int orderID, int pdID){
        try{
            return obRepository.findOrderDetailByOrderIDAndProductID(orderID,pdID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public List<OrderDetail> getOrderDetailByOrderID(int id){
        try{
            return obRepository.findOrderDetailsByOrderID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public boolean addOrderDetail(OrderDetailDto ob){
        try{
            Order order = oRepository.findOrdersByID(ob.getOrder_id());
            WarehouseVoucher warehouseVoucher = warehouseVoucherRepository.findWarehouseVoucherByID(ob.getWarehouse_voucher_id());
            ProductDetail productDetail = pdRepository.findProductDetailByID(ob.getProduct_detail_id());
            obRepository.save(new OrderDetail(0,order,warehouseVoucher,productDetail,ob.getQuantity(),ob.getPrice()));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean updateOrderDetail(OrderDetailDto ob){
        try{
            Order order = oRepository.findOrdersByID(ob.getOrder_id());
            WarehouseVoucher warehouseVoucher = warehouseVoucherRepository.findWarehouseVoucherByID(ob.getWarehouse_voucher_id());
            ProductDetail productDetail = pdRepository.findProductDetailByID(ob.getProduct_detail_id());
            obRepository.save(new OrderDetail(ob.getId(),order,warehouseVoucher,productDetail,ob.getQuantity(),ob.getPrice()));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean removeOrderDetail(int id){
        try{
            OrderDetail ob = obRepository.findOrderDetailsByID(id);
            obRepository.delete(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
}

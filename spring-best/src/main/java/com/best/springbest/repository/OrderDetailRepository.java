package com.best.springbest.repository;

import com.best.springbest.model.OrderDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {
    @Query("Select c from OrderDetail c where c.id = ?1")
    OrderDetail findOrderDetailsByID(int id);
    @Query("Select c from OrderDetail c where c.order.id = ?1 order by c.productDetail.productColor.product.id")
    List<OrderDetail> findOrderDetailsByOrderID(int id);
    @Query("Select c from OrderDetail c where c.productDetail.productColor.product.shop.id = ?1 and c.order.id = ?2 order by c.productDetail.productColor.product.id")
    List<OrderDetail> findOrderDetailsByShopIdAndOrderID(int shopID, int orderID);
    @Query("SELECT o from  OrderDetail  o where o.order.id = ?1 and o.productDetail.id = ?2")
    OrderDetail findOrderDetailByOrderIDAndProductDetailID(int orderDI, int productDetailID);
    @Query("SELECT o from  OrderDetail  o where o.order.id = ?1 and o.productDetail.productColor.product.id = ?2")
    List<OrderDetail> findOrderDetailByOrderIDAndProductID(int orderDI, int productID);
    @Query("Select sum(od.quantity * od.price * (100 - od.warehouseVoucher.voucher.discount_percent)/100) from OrderDetail od where od.order.id = ?1 ")
    double sumOrderDetailByOrderID(int orderID);
}

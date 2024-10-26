package com.best.springbest.repository;

import com.best.springbest.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    @Query("Select c from Order c where c.id = ?1")
    Order findOrdersByID(int id);
    @Query("SELECT sum(od.quantity) FROM Order o join OrderDetail od on o.id = od.order.id where od.productDetail.productColor.product.id =?1 and o.status  = 0")
    int getSumQuantityProductSold(int productID);
    @Query("SELECT o FROM Order o join OrderDetail od on od.order.id = o.id where od.productDetail.productColor.product.shop.id =?1 and o.status  = 0 group by o")
    List<Order> getOrderByShopID(int shopID);
    @Query("select o from Order o where o.user.id = ?1 and o.status = 0 ")// hoa don da thanh toan
    List<Order> findOrdersDisAction(int userID);
    @Query("select o from Order o where o.user.id = ?1 and o.status = 1 ")// hoa don chua thanh toan
    Order findOrdersAction(int userID);
}

package com.best.springbest.repository;

import com.best.springbest.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    @Query("Select p from Product p where p.status = 1")
    List<Product> findAllProductAction();
    @Query("Select c from Product c where c.id = ?1")
    Product findProductsByID(int id);
    List<Product> findProductsByNameContaining(String productName);
    @Query("Select c from Product c where c.category.id = ?1")
    List<Product> findProductsByCategoryID(int categoryID);
    @Query("Select c from Product c where c.brand.id = ?1")
    List<Product> findProductsByBrandBrandID(int brandID);
    @Query("Select c from Product c where c.shop.id = ?1")
    List<Product> findProductsByShopID(int shopID);
    @Query(nativeQuery = true, value = "Select * from products c where c.shop_id = ?1 and c.id != ?2 limit 4")
    List<Product> findProductRemaining(int shopID, int productID);
    @Query("Select c from Product c where c.discount > 0")
    List<Product> findProductsSale();
}

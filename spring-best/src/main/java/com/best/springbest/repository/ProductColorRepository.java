package com.best.springbest.repository;

import com.best.springbest.model.ProductColor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface ProductColorRepository extends JpaRepository<ProductColor, Long> {
    @Query("Select c from ProductColor c where c.id = ?1")
    ProductColor findProductColorByID(int id);
    @Query("SELECT i from ProductColor i where i.product.id = ?1")
    List<ProductColor> findProductColorByProductID(int id);
    @Query("SELECT i from ProductColor i where i.product.id = ?1 and i.color.id = ?2")
    List<ProductColor> findProductColorByProductIdAndColorID(int productID, int colorId);
}

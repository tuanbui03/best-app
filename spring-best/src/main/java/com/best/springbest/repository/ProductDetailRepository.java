package com.best.springbest.repository;

import com.best.springbest.model.ProductDetail;
import com.best.springbest.model.ProductSize;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface ProductDetailRepository extends JpaRepository<ProductDetail, Long> {
    @Query("Select p from ProductDetail p where p.id = ?1")
    ProductDetail findProductDetailByID(int id);

    @Query("Select p from ProductDetail p where p.productColor.product.id = ?1 and p.productSize.product.id = ?1 and p.productColor.id = ?2 and p.productSize.id = ?3")
    ProductDetail findProductDetailByProductIdAndColorIdAndSizeID(int productID, int colorID, int sizeID);
    @Query("Select p from ProductDetail p where p.productColor.product.shop.id = ?1 order by p.productColor.product.id,p.productColor.id,p.productSize.id")
    List<ProductDetail> findProductDetailByShopID(int shopID);
    @Query("Select p from ProductDetail p where p.productColor.product.shop.id = ?1 and p.productColor.product.id = ?2 order by p.productColor.product.id,p.productColor.id,p.productSize.id  ")
    List<ProductDetail> findProductDetailByShopIDAndProductID(int shopID, int productID);
    @Query("Select sum(p.quantity) from ProductDetail p where p.productColor.id = ?1")
    int sumProductByColorID(int colorID);
    @Query("Select sum(p.quantity) from ProductDetail p where p.productSize.id = ?1")
    int sumProductBySizeID(int sizeID);
    @Query("Select sum(p.quantity) from ProductDetail p where p.productColor.id = ?1 and p.productSize.id = ?2")
    int sumProductByColorIdAndSizeId(int colorID, int sizeID);
}

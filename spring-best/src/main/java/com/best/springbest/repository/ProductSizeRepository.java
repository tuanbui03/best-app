package com.best.springbest.repository;

import com.best.springbest.dto.ProductSizeDto;
import com.best.springbest.model.ProductSize;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import java.util.List;
@Repository
public interface ProductSizeRepository extends JpaRepository<ProductSize, Long> {
    @Query("Select c from ProductSize c where c.id = ?1")
    ProductSize findProductSizeByID(int id);

    @Query("Select c from ProductSize c where c.product.id = ?1")
    List<ProductSize> findProductSizeByProductID(int id);

    @Query("Select c from ProductSize c where c.product.id = ?1 and c.size.id =?2")
    List<ProductSize> findProductSizeByProductIdAndSizeID(int productID, int sizeID);
}

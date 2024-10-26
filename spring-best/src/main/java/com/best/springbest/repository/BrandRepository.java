package com.best.springbest.repository;

import com.best.springbest.model.Brand;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
@Repository
public interface BrandRepository extends JpaRepository<Brand, Long> {
    @Query("Select b from Brand b where b.id = ?1")
    Brand findBrandsByID(int id);
}

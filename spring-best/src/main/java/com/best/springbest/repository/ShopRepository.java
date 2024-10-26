package com.best.springbest.repository;

import com.best.springbest.model.Feedback;
import com.best.springbest.model.Shop;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ShopRepository extends JpaRepository<Shop, Long> {
    @Query("Select f from Shop f where f.id = ?1")
    Shop findShopByID(int id);

    List<Shop> findShopsByNameContaining(String name);
}

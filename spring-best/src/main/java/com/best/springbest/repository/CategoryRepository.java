package com.best.springbest.repository;

import com.best.springbest.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {
    @Query("Select c from Category c where c.id = ?1")
    Category findCategoriesByID(int id);
}

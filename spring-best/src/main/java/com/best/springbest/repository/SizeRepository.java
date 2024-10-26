package com.best.springbest.repository;

import com.best.springbest.model.Brand;
import com.best.springbest.model.Size;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
@Repository
public interface SizeRepository extends JpaRepository<Size, Long> {
    @Query("Select c from Size c where c.id = ?1")
    Size findSizeByID(int id);
}

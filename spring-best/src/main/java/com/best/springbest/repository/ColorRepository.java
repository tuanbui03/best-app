package com.best.springbest.repository;

import com.best.springbest.model.Color;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
@Repository
public interface ColorRepository extends JpaRepository<Color, Long> {
    @Query("Select c from Color c where c.id = ?1")
    Color findColorByID(int id);
}

package com.best.springbest.repository;

import com.best.springbest.model.Feedback;
import com.best.springbest.model.Message;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MessageRepository extends JpaRepository<Message, Long> {
    @Query("Select f from Message f where f.id = ?1")
    Message findMessageByID(int id);

}

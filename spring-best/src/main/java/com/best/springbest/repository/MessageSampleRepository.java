package com.best.springbest.repository;

import com.best.springbest.model.Feedback;
import com.best.springbest.model.MessageSample;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MessageSampleRepository extends JpaRepository<MessageSample, Long> {
    @Query("Select f from MessageSample f where f.id = ?1")
    MessageSample findMessageSampleByID(int id);

}

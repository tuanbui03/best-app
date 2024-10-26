package com.best.springbest.repository;

import com.best.springbest.model.Feedback;
import com.best.springbest.model.MessageRecipient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MessageRecipientRepository extends JpaRepository<MessageRecipient, Long> {
    @Query("Select f from MessageRecipient f where f.id = ?1")
    MessageRecipient findMessageRecipientByID(int id);
}

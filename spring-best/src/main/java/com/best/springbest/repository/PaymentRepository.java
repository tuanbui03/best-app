package com.best.springbest.repository;

import com.best.springbest.model.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
@Repository
public interface PaymentRepository extends JpaRepository<Payment, Long> {
    @Query("Select c from Payment c where c.id = ?1")
    Payment findPaymentsByID(int id);
}

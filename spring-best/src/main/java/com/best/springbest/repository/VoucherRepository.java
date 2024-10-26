package com.best.springbest.repository;

import com.best.springbest.model.Voucher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface VoucherRepository extends JpaRepository<Voucher, Long> {
    @Query("Select c from Voucher c where c.id = ?1")
    Voucher findVouchersByID(int id);
    @Query("Select c from Voucher c where c.shop.id = ?1")
    List<Voucher> findVouchersShopID(int id);
}

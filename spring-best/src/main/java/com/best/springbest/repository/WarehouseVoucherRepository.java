package com.best.springbest.repository;

import com.best.springbest.model.Feedback;
import com.best.springbest.model.WarehouseVoucher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WarehouseVoucherRepository extends JpaRepository<WarehouseVoucher, Long> {
    @Query("Select f from WarehouseVoucher f where f.id = ?1")
    WarehouseVoucher findWarehouseVoucherByID(int id);
    @Query("Select f from WarehouseVoucher f where f.user.id = ?1 and f.voucher.product.id = ?2")
    List<WarehouseVoucher> findWarehouseVoucherByUserIdAndProductID(int userID, int productID);
    @Query("Select f from WarehouseVoucher f where f.user.id = ?1 ")
    List<WarehouseVoucher> findWarehouseVoucherByUserId(int userID);
}

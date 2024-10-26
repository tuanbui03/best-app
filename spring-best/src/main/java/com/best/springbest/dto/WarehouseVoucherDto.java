package com.best.springbest.dto;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class WarehouseVoucherDto {
    private int id;
    private int user_id;
    private int voucher_id;

    public WarehouseVoucherDto(int id, int user_id, int voucher_id) {
        this.id = id;
        this.user_id = user_id;
        this.voucher_id = voucher_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getVoucher_id() {
        return voucher_id;
    }

    public void setVoucher_id(int voucher_id) {
        this.voucher_id = voucher_id;
    }
}

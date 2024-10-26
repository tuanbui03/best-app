package com.best.springbest.dto;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class VoucherDto {
    private int id;

    private String code;
    private int shop_id;
    private int product_id;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date date_start;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date date_end;

    private int discount_percent;

    private String description;

    public VoucherDto(int id, String code, int shop_id, int product_id, Date date_start, Date date_end, int discount_percent, String description) {
        this.id = id;
        this.code = code;
        this.shop_id = shop_id;
        this.product_id = product_id;
        this.date_start = date_start;
        this.date_end = date_end;
        this.discount_percent = discount_percent;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getShop_id() {
        return shop_id;
    }

    public void setShop_id(int shop_id) {
        this.shop_id = shop_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public Date getDate_start() {
        return date_start;
    }

    public void setDate_start(Date date_start) {
        this.date_start = date_start;
    }

    public Date getDate_end() {
        return date_end;
    }

    public void setDate_end(Date date_end) {
        this.date_end = date_end;
    }

    public int getDiscount_percent() {
        return discount_percent;
    }

    public void setDiscount_percent(int discount_percent) {
        this.discount_percent = discount_percent;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}

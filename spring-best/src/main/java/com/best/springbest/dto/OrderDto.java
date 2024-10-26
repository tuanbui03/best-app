package com.best.springbest.dto;

import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;
public class OrderDto {
    private int id;
    private int user_id;
    private int payment_id;
    private String address;
    private double total;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date created_at;
    private String phone;
    private int status;

    public OrderDto(int id, int user_id, int payment_id, String address, double total, Date created_at, String phone, int status) {
        this.id = id;
        this.user_id = user_id;
        this.payment_id = payment_id;
        this.address = address;
        this.total = total;
        this.created_at = created_at;
        this.phone = phone;
        this.status = status;
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

    public int getPayment_id() {
        return payment_id;
    }

    public void setPayment_id(int payment_id) {
        this.payment_id = payment_id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}

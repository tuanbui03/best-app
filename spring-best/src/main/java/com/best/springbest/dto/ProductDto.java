package com.best.springbest.dto;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class ProductDto {
    private int id;
    private int brand_id;
    private int category_id;
    private int shop_id;
    private String name;
    private int quantity;
    private double price;
    private String description;
    private String code;
    private int discount;
    private int sold;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date created_at;
    private int status;

    public ProductDto(int id, int brand_id, int category_id, int shop_id, String name, int quantity, double price, String description, String code, int discount, int sold, Date created_at, int status) {
        this.id = id;
        this.brand_id = brand_id;
        this.category_id = category_id;
        this.shop_id = shop_id;
        this.name = name;
        this.quantity = quantity;
        this.price = price;
        this.description = description;
        this.code = code;
        this.discount = discount;
        this.sold = sold;
        this.created_at = created_at;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBrand_id() {
        return brand_id;
    }

    public void setBrand_id(int brand_id) {
        this.brand_id = brand_id;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public int getShop_id() {
        return shop_id;
    }

    public void setShop_id(int shop_id) {
        this.shop_id = shop_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public int getSold() {
        return sold;
    }

    public void setSold(int sold) {
        this.sold = sold;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}

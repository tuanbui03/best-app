package com.best.springbest.dto;

public class ProductDetailDto {
    private int id;
    private int product_size_id;
    private int product_color_id;
    private int quantity;

    public ProductDetailDto(int id, int product_size_id, int product_color_id, int quantity) {
        this.id = id;
        this.product_size_id = product_size_id;
        this.product_color_id = product_color_id;
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProduct_size_id() {
        return product_size_id;
    }

    public void setProduct_size_id(int product_size_id) {
        this.product_size_id = product_size_id;
    }

    public int getProduct_color_id() {
        return product_color_id;
    }

    public void setProduct_color_id(int product_color_id) {
        this.product_color_id = product_color_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}

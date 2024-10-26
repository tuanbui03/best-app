package com.best.springbest.dto;

public class ProductSizeDto {
    private int id;
    private int product_id;
    private int size_id;

    public ProductSizeDto(int id, int product_id, int size_id) {
        this.id = id;
        this.product_id = product_id;
        this.size_id = size_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getSize_id() {
        return size_id;
    }

    public void setSize_id(int size_id) {
        this.size_id = size_id;
    }
}

package com.best.springbest.dto;
public class ProductColorDto {
    private int id;
    private int product_id;
    private int color_id;
    private String image;

    public ProductColorDto(int id, int product_id, int color_id, String image) {
        this.id = id;
        this.product_id = product_id;
        this.color_id = color_id;
        this.image = image;
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

    public int getColor_id() {
        return color_id;
    }

    public void setColor_id(int color_id) {
        this.color_id = color_id;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}

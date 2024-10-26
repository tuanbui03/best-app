package com.best.springbest.dto;
public class OrderDetailDto {
    private int id;
    private int order_id;
    private int warehouse_voucher_id;
    private int product_detail_id;
    private  int quantity;
    private double price;

    public OrderDetailDto(int id, int order_id, int warehouse_voucher_id, int product_detail_id, int quantity, double price) {
        this.id = id;
        this.order_id = order_id;
        this.warehouse_voucher_id = warehouse_voucher_id;
        this.product_detail_id = product_detail_id;
        this.quantity = quantity;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getWarehouse_voucher_id() {
        return warehouse_voucher_id;
    }

    public void setWarehouse_voucher_id(int warehouse_voucher_id) {
        this.warehouse_voucher_id = warehouse_voucher_id;
    }

    public int getProduct_detail_id() {
        return product_detail_id;
    }

    public void setProduct_detail_id(int product_detail_id) {
        this.product_detail_id = product_detail_id;
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
}

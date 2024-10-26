package com.best.springbest.model;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;

@Entity
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "vouchers")
public class Voucher {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String code;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "shop_id",nullable = false)
    private Shop shop;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "product_id",nullable = false)
    private Product product;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date date_start;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date date_end;

    private int discount_percent;

    private String description;
}

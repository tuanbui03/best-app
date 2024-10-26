package com.best.springbest.dto;

import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;
public class FeedbackDto {
    private int id;
    private int user_id;
    private int product_id;
    private  String content;
    private int vote;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date created_at;

    public FeedbackDto(int id, int user_id, int product_id, String content, int vote, Date created_at) {
        this.id = id;
        this.user_id = user_id;
        this.product_id = product_id;
        this.content = content;
        this.vote = vote;
        this.created_at = created_at;
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

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getVote() {
        return vote;
    }

    public void setVote(int vote) {
        this.vote = vote;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }
}

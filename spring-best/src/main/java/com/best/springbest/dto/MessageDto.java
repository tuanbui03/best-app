package com.best.springbest.dto;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class MessageDto {
    private int id;
    private int user_id;
    private int message_sample_id;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date date_sent;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date date_read;
    private  String content;

    public MessageDto(int id, int user_id, int message_sample_id, Date date_sent, Date date_read, String content) {
        this.id = id;
        this.user_id = user_id;
        this.message_sample_id = message_sample_id;
        this.date_sent = date_sent;
        this.date_read = date_read;
        this.content = content;
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

    public int getMessage_sample_id() {
        return message_sample_id;
    }

    public void setMessage_sample_id(int message_sample_id) {
        this.message_sample_id = message_sample_id;
    }

    public Date getDate_sent() {
        return date_sent;
    }

    public void setDate_sent(Date date_sent) {
        this.date_sent = date_sent;
    }

    public Date getDate_read() {
        return date_read;
    }

    public void setDate_read(Date date_read) {
        this.date_read = date_read;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}

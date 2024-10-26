package com.best.springbest.dto;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class MessageRecipientDto {
    private int id;
    private int message_id;
    private int user_id;

    public MessageRecipientDto(int id, int message_id, int user_id) {
        this.id = id;
        this.message_id = message_id;
        this.user_id = user_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMessage_id() {
        return message_id;
    }

    public void setMessage_id(int message_id) {
        this.message_id = message_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }
}

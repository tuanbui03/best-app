package com.best.springbest.dto;

public class MessageSampleDto {
    private int id;
    private int shop_id;
    private String question;
    private String answer;

    public MessageSampleDto(int id, int shop_id, String question, String answer) {
        this.id = id;
        this.shop_id = shop_id;
        this.question = question;
        this.answer = answer;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getShop_id() {
        return shop_id;
    }

    public void setShop_id(int shop_id) {
        this.shop_id = shop_id;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }
}

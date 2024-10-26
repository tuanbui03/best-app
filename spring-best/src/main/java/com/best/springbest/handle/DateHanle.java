package com.best.springbest.handle;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class DateHanle {
    public static Date getDateNow(){
        Date date = new Date();
        Instant instant = Instant.ofEpochMilli(date.getTime());
        LocalDateTime ldt = LocalDateTime.ofInstant(instant, ZoneOffset.UTC);
        instant = ldt.toInstant(ZoneOffset.UTC);
        return Date.from(instant);

//        LocalDateTime lt = LocalDateTime.now();
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
//        String formatDateTime = lt.format(formatter);
    }
}

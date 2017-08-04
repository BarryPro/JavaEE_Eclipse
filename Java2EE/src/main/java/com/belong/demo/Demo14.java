package com.belong.demo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;

/**
 * @Description: <p>传统的date和java8的日期的比较</p>
 * @Author: belong.
 * @Date: 2017/5/6.
 */
public class Demo14 {
    public static void main(String[] args) {
        Demo14 demo14 = new Demo14();
        demo14.java8_Date();
    }

    /**
     * java8最新的日期API
     * LocalDate 获取日期
     * DateTimeFormatter 对日期进行格式化
     */
    public void java8_Date(){
        LocalDate localDate = LocalDate.now();
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        LocalDate localDate2 =  LocalDate.of(2017,5,6);
        System.out.println(localDate.format(dateTimeFormatter));
        System.out.println(localDate2);
    }

    public void java7_Date(){
        Date date = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date tmp = simpleDateFormat.parse(simpleDateFormat.format(date));
            System.out.println(tmp);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}

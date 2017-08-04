package com.belong.demo;

import java.io.Serializable;
import java.sql.Connection;
import java.util.HashMap;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/4/20.
 */
public class Demo8 implements Serializable{

    public static void main(String[] args) {
        Connection connection = null;
        HashMap<String,Object> map = new HashMap<>();
        map.put("ff",""+null);
        connection = (Connection) map.get("ff");
        System.out.println(connection);
    }
}

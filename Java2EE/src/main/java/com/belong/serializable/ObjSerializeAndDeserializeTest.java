package com.belong.serializable;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.ObjectInputStream;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/4/21.
 */
public class ObjSerializeAndDeserializeTest {

    public static void main(String[] args) {

        // 反序列化生成Person对象
        Person person = DeserializePerson();
        System.out.println("name :" + person.getName());
        System.out.println("age  :" + person.getAge());
    }

    /**
     * 执行反序列化过程生产Person对象
     *
     * @author crazyandcoder
     * @Title: DeserializePerson
     * @param @return
     * @return Person
     * @throws
     * @date [2015-8-5 下午1:30:12]
     */
    private static Person DeserializePerson() {

        Person person = null;
        ObjectInputStream inputStream = null;
        try {
            inputStream = new ObjectInputStream(new FileInputStream("D:\\logs\\tmp.txt"));
            try {
                person = (Person) inputStream.readObject();
                System.out.println("执行反序列化过程成功。");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return person;
    }
}

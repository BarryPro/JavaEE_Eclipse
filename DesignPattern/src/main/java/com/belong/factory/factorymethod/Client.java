package com.belong.factory.factorymethod;

/**
 * @Description: <p>客户来选择工厂进行生产</p>
 * @Author: belong.
 * @Date: 2017/7/13.
 */
public class Client {
    public static void main(String[] args) {
        ConcreteFactroy concreteFactroy = new ConcreteFactroy();
        concreteFactroy.factoryMethod().attr();
    }
}

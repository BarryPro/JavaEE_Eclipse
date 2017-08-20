package com.belong.factory.factorymethod;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/7/13.
 */
public class ConcreteProduct implements Product{
    @Override
    public void attr() {
        System.out.println("具体产品");
    }
}

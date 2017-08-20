package com.belong.factory.abstractfactory;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/7/13.
 */
public class ConcreateFactory2 implements AbstractFactory {
    @Override
    public AbstractProductA createProductA() {
        return new ProductA();
    }

    @Override
    public AbstractProductB createProductB() {
        return new ProductB();
    }
}

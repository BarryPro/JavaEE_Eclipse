package com.belong.factory.factorymethod;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/7/13.
 */
public class ConcreteFactroy implements Factory {
    @Override
    public Product factoryMethod() {
        return new ConcreteProduct();
    }
}

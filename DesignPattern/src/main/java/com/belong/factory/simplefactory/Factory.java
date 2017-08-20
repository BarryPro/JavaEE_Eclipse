package com.belong.factory.simplefactory;
//简单工厂类实现
public class Factory {
    public IProduct factory(int productFlag){
        switch(productFlag){
            case 1:
                return new ProductA();
            case 2:
                return new ProductB();
            default:
                return null; 
        }
    }
}

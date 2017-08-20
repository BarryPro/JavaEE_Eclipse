package com.belong.factory.simplefactory;
//具体产品的实现类A
public class ProductA implements IProduct{
    @Override
    public void saleProduct(){
          System.out.println("产品A");
    }

}

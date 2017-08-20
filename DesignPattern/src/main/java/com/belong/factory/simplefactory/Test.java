package com.belong.factory.simplefactory;

public class Test {

	public static void main(String[] args) {
		Factory factory = new Factory();
		IProduct product = factory.factory(1);
		product.saleProduct();
	}

}

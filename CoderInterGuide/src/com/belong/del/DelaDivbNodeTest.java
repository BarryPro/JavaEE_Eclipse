package com.belong.del;

public class DelaDivbNodeTest {
	public static void main(String[] args) {
		DelaDivbNode list = new DelaDivbNode();
		list.add(1);
		list.add(2);
		list.add(3);
		list.add(14);
		list.add(5);
		System.out.println(list.removeByRatio(list.getHead(), 2, 5).value);
	}	
	
}

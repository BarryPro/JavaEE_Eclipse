package com.belong.list;

public class LinkRemoveLastNodeTest {
	public static void main(String[] args) {
		LinkRemoveLastNode list = new LinkRemoveLastNode();
		list.add(1);
		list.add(2);
		list.add(3);
		list.add(4);
		list.add(5);		
		System.out.println(list.removeLastNode(list.getHead(), 1).value);
	}
}

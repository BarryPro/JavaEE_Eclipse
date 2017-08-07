package com.belong.list;

import com.belong.list.ReverseDoubleList.Node;

public class ReverseDListTest {
	public static void main(String[] args) {
		ReverseDoubleList list = new ReverseDoubleList();
		list.add(1);
		list.add(2);
		list.add(3);
		list.add(4);
		list.add(5);
		Node head = list.reverseDList(list.getHeader());
		for(int i = 0;i<5;i++){
			System.out.println(head.data);
			head = head.next;			
		}
	}
}

package com.belong.list;

import com.belong.list.ReversalList.Node;

public class ReversalTest {
	public static void main(String[] args) {
		ReversalList list = new ReversalList();
		list.add(1);
		list.add(2);
		list.add(3);
		list.add(4);
		list.add(5);
		Node head = list.reversal(list.getHead());
		for(int i = 0;i<5;i++){
			System.out.println(head.value);
			head = head.next;			
		}
	}
}

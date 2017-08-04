package com.belong.list;

import com.belong.list.ReversePartList.Node;

public class ReversePartListTest {

	public static void main(String[] args) {
		ReversePartList list = new ReversePartList();
		list.add(1);
		list.add(2);
		list.add(3);
		list.add(4);
		list.add(5);
		Node head = list.reversePart(list.getHead(),2,4);
		for(int i = 0;i<5;i++){
			System.out.println(head.value);
			head = head.next;			
		}
	}

}

package com.belong.list;

import com.belong.list.MergeList.Node;

public class MergeListTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		MergeList list1 = new MergeList();
		list1.add(5);
		list1.add(8);
		list1.add(9);
		list1.add(12);
		list1.add(34);
		MergeList list2 = new MergeList();
		list2.add(1);
		list2.add(2);
		list2.add(3);
		list2.add(4);
		list2.add(5);
		Node head = list1.merger(list1.getHead(), list2.getHead());
		for(int i = 0;i<10;i++){
			if(head!=null){
				System.out.println(head.val);
				head = head.next;	
			}
					
		}
	}

}

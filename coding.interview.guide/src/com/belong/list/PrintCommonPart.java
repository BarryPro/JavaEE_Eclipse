package com.belong.list;

public class PrintCommonPart {
	public class Node{//定义内部节点（内部类）
		public int value;
		public Node next;
		public Node(int data){
			this.value = data;
		}
	}
	private Node head;//定义头节点
	public void printCommonPart(Node head1,Node head2){
		System.out.println("Common part:");
		while(head1!=null && head2!=null){
			if(head1.value < head2.value){//链表一进行向后移
				head1 = head1.next;
			} else if (head1.value > head2.value){
				head2 = head2.next;
			} else {//相等的部分
				System.out.println(head1.value +" ");
				head1 = head1.next;
				head2 = head2.next;
			}
		}
	}
}

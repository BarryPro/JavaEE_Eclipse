package com.belong.list;

public class MergeList {
	public class Node{
		public int val;
		public Node next;
		public Node(int val,Node next){
			this.val = val;
			this.next = next;
		}
	}
	private Node head;
	private Node tail;
	public void add(int data){
		if(head == null){
			head = new Node(data,null);
			tail = head;
		} else {
			Node newNode = new Node(data,null);
			tail.next = newNode;
			tail = newNode;
		}
	}
	public Node getHead(){
		return head;
	}
	public Node merger(Node head1,Node head2){
		Node newList = null;
		if(head1 == null){
			return head2;
		} else if (head2 == null){
			return head1;
		}
		if(head1.val < head2.val){
			newList = head1;
			newList.next = merger(head1.next,head2);
		} else {
			newList = head2;
			newList.next = merger(head1,head2.next);
		}
		return newList;
	}
}

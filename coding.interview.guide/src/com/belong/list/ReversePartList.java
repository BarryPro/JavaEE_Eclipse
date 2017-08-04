package com.belong.list;

public class ReversePartList {
	public class Node{
		public int value;
		public Node next;
		public Node(int value,Node next){
			this.value  = value;
			this.next = next;
		}
	}
	private Node head;
	private Node tial;
	public Node getHead(){
		return head;
	}
	public void add(int data){
		if(head==null){
			head = new Node(data,null);
			tial = head;
		} else {
			Node newNode = new Node(data,null);
			tial.next = newNode;
			tial = newNode;
		}
	}
	public Node reversePart(Node head,int from,int to){
		int len = 0;//���ڲ��ҵ�fpre �� tpos �ڵ���
		Node node1 = head;//���ڴ��ͷ�ڵ�(��ΪҪ�����һ��һ���ҽڵ�����Ҫ���ø���Ʒ���滻)
		Node fpre = null;
		Node tpos = null;
		while(node1!=null){
			len++;
			fpre = len == from - 1 ? node1 : fpre; 
			tpos = len == to + 1 ? node1 : tpos;
			node1 = node1.next;
		}
		if(from>to||from<1||to>len){
			return head;//������
		}
		node1 = fpre == null ? head : fpre.next;//�Ȱ�Ҫ��ת��ͷ��ԭ�����β����(ͷ��ǰһ���ڵ�)
		Node node2 = node1.next;//�õ�Ҫ��ת��ͷ������һ���ڵ�(�൱��pre)
		node1.next = tpos;//ָ��β�ڵ�
		Node next = null;//(�൱��next)
		while(node2 != null){//��Ϊtpos��null
			next = node2.next;
			node2.next = node1;//
			node1 = node2;//���൱�ڣ���node2��fpre
			node2 = next;
		}
		//�ѷ�ת֮�������ǰ�ڵ���
		if(fpre!=null){
			fpre.next = node1;//��node2Ϊ��ʱnode1���õ�ǰ�����β�ڵ�
			return head;
		}
		return node1;
	}
}

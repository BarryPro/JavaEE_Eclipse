package com.belong.list;

public class PrintCommonPart {
	public class Node{//�����ڲ��ڵ㣨�ڲ��ࣩ
		public int value;
		public Node next;
		public Node(int data){
			this.value = data;
		}
	}
	private Node head;//����ͷ�ڵ�
	public void printCommonPart(Node head1,Node head2){
		System.out.println("Common part:");
		while(head1!=null && head2!=null){
			if(head1.value < head2.value){//����һ���������
				head1 = head1.next;
			} else if (head1.value > head2.value){
				head2 = head2.next;
			} else {//��ȵĲ���
				System.out.println(head1.value +" ");
				head1 = head1.next;
				head2 = head2.next;
			}
		}
	}
}

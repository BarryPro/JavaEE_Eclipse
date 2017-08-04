package com.datastructure.list;

/**
 * Created by Administrator on 2016/8/24.
 */
public class AddLists2 {
    public class Node{
        public int value;
        public Node next;

        public Node(int value,Node next){
            this.value = value;
            this.next = next;
        }
    }
    //头节点
    private Node head;
    //尾节点
    private Node tial;

    public Node getHead() {
        return head;
    }

    public int size;
    public void add(int data){
        if(head == null){
            head = new Node(data,null);
            tial = head;
        } else {
            Node newNode = new Node(data,null);
            tial.next = newNode;
            tial = newNode;
        }
        size++;
    }
    public Node addLists2(Node head1,Node head2){
        head1 = reverseList(head1);
        head2 = reverseList(head2);
        int ca = 0;
        int n = 0;
        int n1 = 0;
        int n2 = 0;
        Node s1 = head1;
        Node s2 = head2;
        //新节点
        Node node = null;
        Node pre = null;
        while (s1 != null || s2 != null){
            n1 = s1 != null ? s1.value : 0;
            n2 = s2 != null ? s2.value : 0;
            n = n1 + n2 + ca;
            pre = node;
            node = new Node(n%10,null);
            node.next = pre;
            ca = n / 10;
            s1 = s1 != null ? s1.next : null;
            s2 = s2 != null ? s2.next : null;
        }
        if(ca == 1){
            pre = node;
            node = new Node(1,null);
            node.next = pre;
        }
        //还原原链表
        reverseList(head1);
        reverseList(head2);
        return node;
    }
    //逆序链表
    public Node reverseList(Node head){
        Node next = null;
        Node pre = null;
        while(head != null){
            next = head.next;
            head.next = pre;
            pre = head;
            head = next;
        }
        return pre;
    }
}

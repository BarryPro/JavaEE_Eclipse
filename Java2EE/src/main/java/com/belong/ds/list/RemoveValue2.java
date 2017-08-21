package com.belong.ds.list;

/**
 * 时间O(n) 空间O(1)
 * Created by belong on 2016/9/3.
 */
public class RemoveValue2 {
    public class Node{
        public int value;
        public Node next;
        public Node(int value,Node next){
            this.value = value;
            this.next = next;
        }
    }

    private Node head;
    private Node tail;
    private int size;

    public Node getHead(){
        return head;
    }

    public int getSize(){
        return size;
    }

    public void insert(int data){
        if(head == null){
            head = new Node(data,null);
            tail = head;
        } else {
            Node newNode = new Node(data,null);
            tail.next = newNode;
            tail = newNode;
        }
        size++;
    }

    public Node removeValue2(Node head,int num){
        //先确定head不是要查找的人
        while(head != null){
            if(head.value != num){
                break;
            }
            head = head.next;
        }
        Node cur = head;
        Node pre = head;
        while(cur != null){
            if(cur.value == num){
                pre.next = cur.next;
            } else {
                pre = cur;
            }
            cur = cur.next;
        }
        return head;
    }
}

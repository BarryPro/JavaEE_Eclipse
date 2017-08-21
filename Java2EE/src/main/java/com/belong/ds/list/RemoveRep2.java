package com.belong.ds.list;

/**
 * 时间复杂度O(n2) 空间是O(1)
 * Created by Administrator on 2016/9/3.
 */
public class RemoveRep2 {
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

    public void removeRep2(Node head){
        Node cur = head;
        Node pre = null;
        Node next = null;

        while(cur != null){
            //本轮的当前就是下一轮的前一个
            pre = cur;
            next = cur.next;
            while(next != null){
                if(cur.value == next.value){
                    pre.next = next.next;
                    size--;
                } else {
                    pre = next;
                }
                next = next.next;
            }
            cur = cur.next;
        }
    }
}

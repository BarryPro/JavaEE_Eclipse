package com.datastructure.list;

import java.util.Stack;

/**
 * 删除指定值的链表空间O(n) 时间O(n)
 * Created by belong on 2016/9/3.
 */
public class RemoveValue1 {
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

    public Node removeValue1(Node head,int num){
        Stack<Node> stack = new Stack<Node>();
        while(head != null){
            if(head.value != num){
                stack.push(head);
            }
            head = head.next;
        }
        while(!stack.isEmpty()){
            //把链表的next重新连接上
            stack.peek().next = head;
            head = stack.pop();
        }
        return head;
    }
}

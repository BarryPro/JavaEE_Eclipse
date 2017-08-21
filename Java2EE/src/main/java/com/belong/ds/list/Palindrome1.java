package com.belong.ds.list;

import java.util.Stack;

/**
 * 最简单的一中但是费内存
 * Created by belong on 2016/8/24.
 */
public class Palindrome1 {
    public class Node {
        public int value;
        public Node next;
        public Node(int value,Node next) {
            this.value = value;
            this.next = next;
        }
    }
    private Node head;
    private Node tail;
    private int size;

    public Node getHead() {
        return head;
    }

    public void add(int data){
        if(head == null){
            head = new Node(data,null);
            tail = head;
        } else {
            Node node = new Node(data,null);
            tail.next = node;
            tail = node;
        }
        size++;
    }
    public boolean isPalindrome1(Node head){
        //用类来实现逆序
        Stack<Node> stack = new Stack<Node>();
        Node cur = head;
        while(cur != null){
            stack.push(cur);
            cur = cur.next;
        }
        //判断是否是回文序列
        while(head != null){
            if(head.value != stack.pop().value){
                return false;
            }
            head = head.next;
        }
        return true;
    }
}

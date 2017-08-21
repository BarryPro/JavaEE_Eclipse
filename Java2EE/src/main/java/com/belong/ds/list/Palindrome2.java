package com.belong.ds.list;

import java.util.Stack;

/**
 * 节省一半的内存
 * Created by Administrator on 2016/8/24.
 */
public class Palindrome2 {
    public class Node{
        public int value;
        public Node next;
        public Node(int value ,Node next){
            this.value = value;
            this.next = next;
        }
    }
    private Node head;
    private Node tail;

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
    }
    public boolean isPalindrome2(Node head){
        //没有或只有一个的时候一定是回文的
        if(head == null || head.next == null){
            return true;
        }
        //用于存链表一半以后的右一半的第一个节点
        Node rigtht = head.next;
        Node cur = head ;
        //奇和偶数
        while(cur.next !=null && cur.next.next != null){
            rigtht = rigtht.next;
            //每次移动两个节点相当于除以2
            cur = cur.next.next;
        }
        //声明一个stack用于存放右半数据
        Stack<Node> stack = new Stack<Node>();
        while(rigtht != null){
            stack.push(rigtht);
            rigtht = rigtht.next;
        }
        //判断回文
        while(!stack.isEmpty()){
            if(stack.pop().value != head.value){
                return false;
            }
            head = head.next;
        }
        return true;
    }
}

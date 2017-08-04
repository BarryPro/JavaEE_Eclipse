package com.datastructure.list;

import java.util.Stack;

/**
 * Created by belong on 2016/8/24.
 */
public class AddLists1 {
    //定义链表节点
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
    public Node addLists1(Node head1,Node head2){
        Stack<Integer> s1 = new Stack<Integer>();
        Stack<Integer> s2 = new Stack<Integer>();
        //把head1的链表中的数都压入s1栈中
        while(head1 !=null){
            s1.push(head1.value);
            head1 = head1.next;
        }
        //把head2的链表中的数都压入s2栈中
        while(head2 !=null){
            s2.push(head2.value);
            head2 = head2.next;
        }
        //用于存放进位
        int ca = 0;
        //用于存当前栈顶的值
        int n1 = 0;
        int n2 = 0;
        //用于存放计算后的结果
        int n = 0;
        //新节点 用于存放计算后的结果
        Node node = null;
        //因为采用的是头插如
        Node pre = null;
        //只有两个栈都为空才会停止循环
        while(!s1.isEmpty() || !s2.isEmpty()){
            n1 = s1.isEmpty() ? 0 : s1.pop();
            n2 = s2.isEmpty() ? 0 : s2.pop();
            n = n1 + n2 + ca;
            //当前节点既是cur又是pre
            pre = node;
            node = new Node(n%10,null);
            node.next = pre;
            //计算进位
            ca = n / 10;
        }
        //最后在判断最高为有没有进位位
        if(ca == 1){
            pre = node;
            node = new Node(1,null);
            node.next = pre;
        }
        return node;
    }
}

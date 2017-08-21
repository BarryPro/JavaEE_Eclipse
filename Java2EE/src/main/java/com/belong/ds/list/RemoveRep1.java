package com.belong.ds.list;

import java.util.HashSet;

/**
 * 此方法的控件复杂度是O(n) 时间O(n)
 * Created by Administrator on 2016/9/3.
 */
public class RemoveRep1 {
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

    public int getSize(){
        return size;
    }

    public void removeRep1(Node head){
        if(head == null){
            return ;
        }
        //利用哈希表来存数据
        HashSet<Integer> set = new HashSet<Integer>();
        //第一个数一定是不能删的
        Node pre = head;
        //从第二个开始比对
        Node cur = head.next;
        set.add(head.value);
        while(cur!=null){
            //如果set里面有此元素返回的是真
            if(set.contains(cur.value)){
                pre.next = cur.next;
                size--;
            } else {
                set.add(cur.value);
                pre = cur;
            }
            //向后移动
            cur = cur.next;
        }
    }
}

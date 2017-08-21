package com.belong.ds.list;

/**
 * 单链表的选择排序
 * Created by belong on 2016/9/3.
 */
public class SelectionSort {
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

    public Node selectionSort(Node head){
        Node tail = null;
        //当前从head节点开始
        Node cur = head;
        //用于存放最小节点
        Node small = null;
        //用于存放最小节点的前一个节点
        Node smallPre = null;
        while(cur != null){
            //假设第一个节点为最小节点
            small = cur;
            //得到最小节点的前一个节点
            smallPre = getSmallestPreNode(cur);
            //如果有最小节点的前一个节点（把未排序的表中的最小删除）
            if(smallPre != null){
                //把最小的节点传出来用small保存
                small = smallPre.next;
                smallPre.next = small.next;
            }
            //当前的节点向后移
            cur = cur == small ?cur.next:cur;
            //进行排序
            if(tail == null){
                head = small;
            } else {
                tail.next = small;
            }
            tail = small;
        }
        return head;
    }

    //得到当前节点的最小节点的前一个节点
    private Node getSmallestPreNode(Node head) {
        Node smallPre = null;
        //默认从头开始
        //small用于存放最先的节点
        Node small = head;
        Node pre = head;
        Node cur = head.next;
        while(cur != null){
            if(cur.value < small.value){
                smallPre = pre;
                small = cur;
            }
            //对于下一圈来说是前一个节点了
            pre = cur;
            cur = cur.next;
        }
        return smallPre;
    }
}

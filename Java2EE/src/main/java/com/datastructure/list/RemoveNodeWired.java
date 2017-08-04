package com.datastructure.list;

/**
 * 不给头节点删除该节点
 * Created by belong on 2016/9/3.
 */
public class RemoveNodeWired {
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

    public void removeNodeWired(Node node){
        if(node == null){
            return ;
        }
        Node next = node.next;
        if(next == null){
            throw new RuntimeException(" can not remove last node.");
        }
        node.value = next.value;
        node.next = next.next;
    }
}

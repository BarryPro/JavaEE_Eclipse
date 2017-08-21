package com.belong.ds.list;

import java.util.Scanner;

/**
 * Created by belong on 2016/12/10.
 */
public class ID {
    static class Node {
        int id;
        int count;

        Node(int id, int count) {
            this.id = id;
            this.count = count;
        }

        Node next;
    }

    static Node head;
    static Node tail;

    public static void insert(int id, int count) {
        if (head == null) {
            head = new Node(id, count);
            tail = head;
        } else {
            Node node = new Node(id, count);
            tail.next = node;
            tail = node;
        }
    }

    public static Node tailNode(){
        Node node = head;
        while(node.next != null){
            node = node.next;
        }
        return node;
    }

    public static void main(String[] args) {
        Scanner cin = new Scanner(System.in);
        int T = cin.nextInt();
        while (T-- > 0) {
            int n = cin.nextInt();
            for (int i = 0; i < n; i++) {
                int id = cin.nextInt();
                if (head == null) {
                    insert(id, 0);//初始化头
                } else {
                    boolean flag = false;
                    Node node = head;
                    while(node!=null){
                        if(node.id==id){
                            node.count++;
                            flag = true;
                        }
                        node = node.next;
                    }
                    if(!flag){
                        insert(id,0);
                    }
                }

            }
            Node node = head;
            while (node != null) {
                if(node.count%2==0){
                    System.out.println(node.id);
                }
                node = node.next;
            }
        }
    }
}

package com.belong.test;

import java.util.Scanner;

/**
 * 编程题最多的数
 * Created by belong on 2016/12/15.
 */
public class MostNum {
    static class Node {
        int value;
        int count;
        Node next;

        public Node(int value, int count) {
            this.value = value;
            this.count = count;
        }
    }

    static Node head;
    static Node tail;

    public static void insert(int num) {
        if (head == null) {
            head = new Node(num, 0);
            tail = head;
        } else {
            Node node = new Node(num, 0);
            tail.next = node;
            tail = node;
        }
    }

    public static void main(String[] args) {
        Scanner cin = new Scanner(System.in);
        int n = cin.nextInt();
        if (n >= 1 && n <= 1000) {
            while (n-- > 0) {
                Node current = null;
                for (int i = 0; i <= n; i++) {
                     int num = cin.nextInt();
                    if (num >= 1 && num <= 10000) {
                        current = head;
                        if (current == null) {
                            insert(num);
                        } else {
                            boolean flag = false;
                            while (current != null) {
                                if (current.value == num) {
                                    current.count++;
                                    flag = true;
                                }
                                current = current.next;
                            }
                            if (!flag) {
                                insert(num);
                            }
                        }
                    }
                }
                current = sort(head);
                int max = 0;
                int mostNum = 0;
                while (current != null) {
                    if (current.count > max) {
                        max = current.count;
                        mostNum = current.value;
                    }
                    current = current.next;
                }
                System.out.println(mostNum);
                System.exit(0);
            }
        }
    }

    public static Node sort(Node head) {
        for (Node i = head; i != null; i = i.next) {
            for (Node j = head; j != null; j = j.next) {
                if (i.value < j.value) {
                    exchange(i,j);
                }
            }
        }
        return head;
    }

    public static void exchange(Node node1,Node node2){
        Node tmp = new Node(0,0);
        tmp.count = node1.count;
        tmp.value = node1.value;
        node1.count = node2.count;
        node1.value = node2.value;
        node2.count = tmp.count;
        node2.value = tmp.value;
    }

}

package com.datastructure.list;

/**
 * Created by Administrator on 2016/9/3.
 */
public class RemoveRep2Test {
    public static void main(String[] args) {
        RemoveRep2 list = new RemoveRep2();
        list.insert(2);
        list.insert(3);
        list.insert(2);
        list.insert(5);
        list.insert(2);
        list.insert(2);
        list.insert(7);
        list.insert(8);
        list.insert(9);
        list.insert(9);
        list.removeRep2(list.getHead());
        RemoveRep2.Node head = list.getHead();
        for(int i = 0;i<list.getSize();i++){

            System.out.println(head.value);
            head = head.next;

        }
    }
}

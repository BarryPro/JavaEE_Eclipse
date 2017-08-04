package com.datastructure.list;

/**
 * Created by Administrator on 2016/9/3.
 */
public class RemoveRep1Test {
    public static void main(String[] args) {
        RemoveRep1 list = new RemoveRep1();
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
        list.removeRep1(list.getHead());
        RemoveRep1.Node head  = list.getHead();
        for(int i = 0;i<list.getSize();i++){
            if(head!=null){
                System.out.println(head.value);
                head = head.next;
            }
        }


    }
}

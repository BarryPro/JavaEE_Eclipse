package com.datastructure.list;

/**
 * Created by belong on 2016/9/3.
 */
public class RemoveValue1Test {
    public static void main(String[] args) {
        RemoveValue1 list = new RemoveValue1();
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
        RemoveValue1.Node head = list.removeValue1(list.getHead(),2);
        for(int i = 0;i<list.getSize();i++){
            if(head!=null){
                System.out.println(head.value);
                head = head.next;
            }
        }
    }
}

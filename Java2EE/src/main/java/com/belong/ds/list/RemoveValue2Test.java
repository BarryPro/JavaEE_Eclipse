package com.belong.ds.list;

/**
 * Created by belong on 2016/9/3.
 */
public class RemoveValue2Test {
    public static void main(String[] args) {
        RemoveValue2 list = new RemoveValue2();
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
        RemoveValue2.Node head = list.removeValue2(list.getHead(),9);
        for(int i = 0;i<list.getSize();i++){
            if(head!=null){
                System.out.println(head.value);
                head = head.next;
            }
        }
    }
}

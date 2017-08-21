package com.belong.ds.list;

/**
 * Created by Administrator on 2016/8/24.
 */
public class AddLists2Test {
    public static void main(String[] args) {
        AddLists2 list1 = new AddLists2();
        list1.add(1);
        list1.add(2);
        list1.add(3);
        list1.add(4);
        list1.add(5);
        AddLists2 list2 = new AddLists2();
        list2.add(2);
        list2.add(3);
        list2.add(4);
        list2.add(5);
        list2.add(6);
        AddLists2.Node head = list1.addLists2(list1.getHead(), list2.getHead());
        for (int i = 0; i < 5; i++) {
            if(head!=null){
                System.out.println(head.value);
                head = head.next;
            }
        }
    }
}

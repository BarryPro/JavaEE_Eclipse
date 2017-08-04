package com.datastructure.list;

/**
 * Created by Administrator on 2016/8/24.
 */
public class AddLists1Test {
    public static void main(String[] args) {
        AddLists1 list1 = new AddLists1();
        list1.add(1);
        list1.add(2);
        list1.add(3);
        list1.add(4);
        list1.add(5);
        AddLists1 list2 = new AddLists1();
        list2.add(2);
        list2.add(3);
        list2.add(4);
        list2.add(5);
        list2.add(6);
        AddLists1.Node head = list1.addLists1(list1.getHead(), list2.getHead());
        for (int i = 0; i < 5; i++) {
            if(head!=null){
                System.out.println(head.value);
                head = head.next;
            }
        }
    }
}

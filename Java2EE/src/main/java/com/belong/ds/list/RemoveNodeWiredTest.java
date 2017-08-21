package com.belong.ds.list;

/**
 * Created by belong on 2016/9/3.
 */
public class RemoveNodeWiredTest {
    public static void main(String[] args) {
        RemoveNodeWired list = new RemoveNodeWired();
        list.insert(2);
        list.insert(3);
        list.insert(4);
        list.insert(5);
        list.insert(6);
        list.removeNodeWired( list.getHead().next.next.next);
        RemoveNodeWired.Node head = list.getHead();
        for(int i = 0;i<list.getSize();i++){
            if(head!=null){
                System.out.println(head.value);
                head = head.next;
            }
        }
    }
}

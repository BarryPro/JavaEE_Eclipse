package com.datastructure.list;

/**
 * Created by Administrator on 2016/9/3.
 */
public class SelectionSortTest {
    public static void main(String[] args) {
        SelectionSort list = new SelectionSort();
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
        SelectionSort.Node head = list.selectionSort(list.getHead());
        for(int i = 0;i<list.getSize();i++){
            if(head!=null){
                System.out.println(head.value);
                head = head.next;
            }
        }
    }
}

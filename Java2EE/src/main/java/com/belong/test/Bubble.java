package com.belong.test;

/**
 * Created by belong on 2016/12/15.
 */
public class Bubble {
    public static void main(String[] args) {
        MostNum.insert(4);
        MostNum.insert(6);
        MostNum.insert(2);
        MostNum.insert(10);
        MostNum.Node current = MostNum.sort(MostNum.head);

        while (current!=null){
            System.out.println(current.value);
            current = current.next;
        }


    }
    public static MostNum.Node sort(MostNum.Node head){
        for (MostNum.Node i = head; i != null; i = i.next) {
            for(MostNum.Node j = head; j!=null; j = j.next){
                if(i.value<j.value){
                    int tmp = i.value;
                    i.value = j.value;
                    j.value = tmp;
                }
            }
        }
        return head;
    }
}

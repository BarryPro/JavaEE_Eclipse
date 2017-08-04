package com.belong.thread;

import java.util.concurrent.Callable;

/**
 * 多线程快排
 * Created by belong on 2017/4/10.
 */
public class ConcurrentQuickSort implements Callable<Node>{
    // 定义开始的位置
    private final int start;
    // 定义结束的位置
    private final int end;
    // 定义参与运算的数组
    private int [] array;
    private boolean flag;

    public ConcurrentQuickSort(int start,int end,int[] array ){
        this.start = start;
        this.end = end;
        this.array = array;
    }

    // 重写多线程的带返回值的回调方法
    // 这个就是要实现多线程的方法都在这里进行调用
    @Override
    public Node call() throws Exception {
        quickSort();
        return null;
    }

    // 具体的快排实现 采用类成员进行传参
    public void quickSort(){
        int head = start;
        int tail = end;
        // 比较头和尾的索引值的大小
        if(head >= tail){
            return ;
        }
        // 开始循环分成左右两半，然后开两个线程进行排序
        while(head != tail){
            if(array[head] >= array[tail]){
                swap(array[head],array[tail]);
            }
            if(!flag){
                tail--;
            } else {
                head++;
            }
        }
        tail++;
        head--;
    }

    public void swap(int head,int tail){
        int tmp = array[head];
        array[head] = array[tail];
        array[tail] = tmp;
        flag = !flag;
    }

}

/**
 * 定义排序的节点
 * 用于存储待排序的节点的位置和子数组
 */
class Node<E> {
    // 定义开始的位置
    private E start;
    // 定义结束的位置
    private E end;
    // 定义参与运算的数组
    private E [] array;

    public Node(E start,E end,E[] array){
        this.start = start;
        this.end = end;
        this.array = array;
    }

    public E getStart() {
        return start;
    }

    public void setStart(E start) {
        this.start = start;
    }

    public E getEnd() {
        return end;
    }

    public void setEnd(E end) {
        this.end = end;
    }

    public E[] getArray() {
        return array;
    }

    public void setArray(E[] array) {
        this.array = array;
    }
}

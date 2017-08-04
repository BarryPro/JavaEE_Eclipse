package com.belong.thread;

import java.util.concurrent.Callable;

/**
 * Created by belong on 2017/4/9.
 */
public class ThreadQuickSort implements Callable<Point> {
    private int[] array;
    private final int start;
    private final int end;
    private int middle;

    public ThreadQuickSort(int start, int end, int[] array) {
        this.start = start;
        this.end = end;
        this.array = array;
    }

    @Override
    public Point call() {
        /*进行排序*/
        quickSort();
        return new Point(start, end, middle);
    }

    /**
     * 快排的具体实现方法
     */
    public void quickSort() {
        // 定义头和尾的索引变量
        int head, tail;
        head = this.start;
        tail = this.end + 1;
        while (true) {
            /*找到一个比head大的*/
            do {
                head++;
            } while (!(array[head] >= array[start] || head == end));
            /*找到一个比head小的*/
            do {
                tail--;
            } while (!(array[start] >= array[tail] || tail == start));
            if (head < tail)
                swap(head, tail);
            else
                break;
        }
        swap(start, tail);
        middle = tail;
    }

    public void swap(int a, int b) {
        int temp = 0;
        temp = array[a];
        array[a] = array[b];
        array[b] = temp;
    }
}

class Point {
    private int start;
    private int end;
    private int middle;

    public Point(int start, int end, int middle) {
        this.start = start;
        this.end = end;
        this.middle = middle;
    }

    public int getStart() {
        return start;
    }

    public int getEnd() {
        return end;
    }

    public int getMiddle() {
        return middle;
    }

    public boolean compareStartMiddle() {
        return start < middle - 1;
    }

    public boolean compareMiddleEnd() {
        return middle + 1 < end;
    }
}

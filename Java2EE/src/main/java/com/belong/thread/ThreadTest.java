package com.belong.thread;

/**
 * Created by belong on 2017/4/9.
 */
public class ThreadTest {
    public static void main(String[] args) {
        Thread thread_1 = new Thread(()->{
            for(int i = 0;i<100;i++){
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                System.out.println("thread_1: " + i);
            }
        });
        thread_1.start();
        Thread thread_2 = new Thread(()->{
            for(int i = 0;i<100;i++){
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                System.out.println("thread_2: " + i);
            }
        });
        thread_2.start();
        Thread thread_3 = new Thread(()->{
            for(int i = 0;i<100;i++){
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                System.out.println("thread_3: " + i);
            }
        });
        thread_3.start();
    }
}

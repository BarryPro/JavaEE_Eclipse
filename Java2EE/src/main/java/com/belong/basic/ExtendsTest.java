package com.belong.basic;

/**
 * Created by belong on 2016/12/7.
 */
public class ExtendsTest {
    public static void main(String[] args) {
        try {
            //int a = 1/0;
            assert false:"jiuhsdifhj";
            return ;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            System.out.println("belong");
            assert false:"jiuhsdifhj";
        }

    }
    public void fun(){
        int a  =0;
    }
    private void fun(int a){
        assert false:"make";
        System.out.println(a);
    }
}

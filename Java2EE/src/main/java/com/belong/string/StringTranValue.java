package com.belong.string;

/**
 * Created by belong on 2016/12/6.
 */
public class StringTranValue {
    public static void main(String[] args) {
        System.out.println("引用不改变");
        StringBuffer str = new StringBuffer("make");
        System.out.println(str);
        new StringTranValue().stringTranCValue2(str);
        System.out.println(str);
        System.out.println("引用改变");
        String str2 = new String("make");
        System.out.println(str2);
        new StringTranValue().stringTranCValue(str2);
        System.out.println(str2);
    }

    public void stringTranCValue(String a) {
        a = a+"belong";
        System.out.println(a);
    }
    public void stringTranCValue2(StringBuffer a) {
        a = a.append("belong");
        System.out.println(a);
    }
}

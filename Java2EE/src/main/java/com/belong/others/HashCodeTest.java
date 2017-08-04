package com.belong.others;

import java.util.HashSet;
import java.util.Set;

/**
 * Created by belong on 2017/4/6.
 */
public class HashCodeTest {
    private int i;

    public int getI() {
        return i;
    }

    public void setI(int i) {
        this.i = i;
    }

    public int hashCode() {
        return i % 10;
    }

    public final static void main(String[] args) {
        HashCodeTest a = new HashCodeTest();
        HashCodeTest b = new HashCodeTest();
        a.setI(1);
        b.setI(1);
        Set<HashCodeTest> set = new HashSet();
        set.add(a);
        set.add(b);
        System.out.println(a.hashCode() == b.hashCode());
        System.out.println(a.equals(b));
        System.out.println(set);
    }
}

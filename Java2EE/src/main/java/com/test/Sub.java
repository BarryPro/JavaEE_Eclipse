package com.test;

interface InterA {
 
    void interA();
} 
interface InterB {
    String interB(int i);
}
interface InterC {
    void interC();
}
class Base implements InterA {
 
    private int baseInt;
    protected String baseString;
 
    public int getBaseInt() {
        return baseInt;
    }
    public void setBaseInt(int baseInt) {
        this.baseInt = baseInt;
    }
 
    @Override
    public void interA() {
        System.out.println("the interA in Base");
    }
} 
 
 public class Sub extends Base implements InterB, InterC {
 
    private int subInt;
    private static String subString;
    private static Object subObject;
 
    public int getSubInt() {
        return subInt;
    }
    public void setSubInt(int subInt) {
        this.subInt = subInt;
    }
    public static String getSubString() {
        return subString;
    }
    public static void setSubString(String subString) {
        Sub.subString = subString;
    }
    public static Object getSubObject() {
        return subObject;
    }
    public static void setSubObject(Object subObject) {
        Sub.subObject = subObject;
    }
 
    @Override
    public void interC() {
        System.out.println("the interC in Sub");
    }
 
    @Override
    public String interB(int i) {
        return "the interB in Sub";
    }
}

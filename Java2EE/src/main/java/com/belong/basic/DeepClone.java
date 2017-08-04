package com.belong.basic;

/**
 * Created by belong on 2016/12/9.
 */
public class DeepClone {
    public static void main(String[] args) {
        Guo guo = new Guo();
        guo.setGj("China");
        Persion persion = new Persion(guo,"belong","23");
        System.out.println("name:"+persion.getName());
        System.out.println("age:"+persion.getAge());
        System.out.println("国籍:"+persion.getGuo().getGj());
        try {
            Persion persion1 = (Persion) persion.clone();
            persion1.getGuo().setGj("American");
        } catch (CloneNotSupportedException e) {
            e.printStackTrace();
        }
        System.out.println("name:"+persion.getName());
        System.out.println("age:"+persion.getAge());
        System.out.println("国籍:"+persion.getGuo().getGj());
    }

    public void fun(){

        System.out.println("ok"+getName());
    }

    private String name;
    private int age;

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public DeepClone(String name){
        this.name = name;
    }

    public String getName(){
        return name;
    }
}
class Persion implements Cloneable{
    private Guo guo;
    private String name;
    private String age;

    public Persion(Guo guo, String name, String age) {
        this.guo = guo;
        this.name = name;
        this.age = age;
    }

    @Override
    protected Object clone() throws CloneNotSupportedException {
        Persion persion = null;
        persion = (Persion)super.clone();
        persion.guo = (Guo) guo.clone();
        return persion;
    }

    public Guo getGuo() {
        return guo;
    }

    public void setGuo(Guo guo) {
        this.guo = guo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }
}
class Guo implements Cloneable{
    private String Gj;

    @Override
    protected Object clone() throws CloneNotSupportedException {
        Guo guo = null;
        guo = (Guo)super.clone();
        return guo;
    }

    public String getGj() {
        return Gj;
    }

    public void setGj(String gj) {
        Gj = gj;
    }
}


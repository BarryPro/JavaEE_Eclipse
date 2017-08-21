package com.belong.clone;

/**
 * Created by belong on 2016/12/9.
 */
public class ShallowClone {
    public static void main(String[] args) {
        Type type = new Type();
        type.setVip("是");
        type.setCount(100);
        Student student1 = new Student("belong","123456",type);
        System.out.println("student1:name=="+student1.getName());
        System.out.println("student1:password=="+student1.getPassword());
        System.out.println("是否是会员："+student1.getType().getVip()+"\n积分是多少："+student1.getType().getCount());
        try {
            Student student2 = (Student)student1.clone();
            System.out.println("student2:name=="+student2.getName());
            System.out.println("student2:password=="+student2.getPassword());
            student2.getType().setVip("否");
            System.out.println("是否是会员："+student2.getType().getVip()+"\n积分是多少："+student2.getType().getCount());
        } catch (CloneNotSupportedException e) {
            e.printStackTrace();
        }
        System.out.println("student1:name=="+student1.getName());
        System.out.println("student1:password=="+student1.getPassword());
        System.out.println("是否是会员："+student1.getType().getVip()+"\n积分是多少："+student1.getType().getCount());
    }
}

class Student implements Cloneable{
    private Type type;
    private String name;
    private String password;
    public Student (String name,String password,Type type){
        this.name = name;
        this.password = password;
        this.type = type;
    }

    @Override
    protected Object clone() throws CloneNotSupportedException {
        return super.clone();
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}

class Type {
    private String Vip;
    private int count;

    public String getVip() {
        return Vip;
    }

    public void setVip(String vip) {
        Vip = vip;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}


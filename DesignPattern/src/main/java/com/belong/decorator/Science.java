package com.belong.decorator;

public class Science extends GirlDecorator {

 

    private Girl girl;
 

    public Science(Girl girl){

        this.girl = girl;

    }

 

    @Override

    public String getDescription() {

        return this.girl.getDescription() + "ϲ����ѧ";

    }

 

    public void caltulateStuff() {

        System.out.println("��ѧ����!");

    }

}


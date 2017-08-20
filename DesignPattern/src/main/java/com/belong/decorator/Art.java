package com.belong.decorator;

public class Art extends GirlDecorator {

 

    private Girl girl;

 

    public Art(Girl girl){

        this.girl = girl;

    }

 

    @Override

    public String getDescription() {

        return this.girl.getDescription() + "+ϲ������";

    }

 

    public void draw() {

        System.out.println("draw pictures!");

    }

}

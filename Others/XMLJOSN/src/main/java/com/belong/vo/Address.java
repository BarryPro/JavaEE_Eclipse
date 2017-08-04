package com.belong.vo;

import java.io.Serializable;

public class Address implements Serializable{  
    private static final long serialVersionUID = 1L;  
      
    private String province;  
    private String city;  
    private String street;  
    private String post;  
      
    public Address()  
    {  
        super();  
    }  
      
    public Address(String province, String city, String street, String post)  
    {  
        super();  
        this.province = province;  
        this.city = city;  
        this.street = street;  
        this.post = post;  
    }  
  
    public String getCity()  
    {  
        return city;  
    }  
  
    public void setCity(String city)  
    {  
        this.city = city;  
    }  
  
    public String getPost()  
    {  
        return post;  
    }  
  
    public void setPost(String post)  
    {  
        this.post = post;  
    }  
  
    public String getProvince()  
    {  
        return province;  
    }  
  
    public void setProvince(String province)  
    {  
        this.province = province;  
    }  
  
    public String getStreet()  
    {  
        return street;  
    }  
  
    public void setStreet(String street)  
    {  
        this.street = street;  
    }  
      
}  
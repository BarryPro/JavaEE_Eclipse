package com.belong.introspector;


import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;


/**
 * The type Bean info util.
 */
public class BeanInfoUtil {

    /**
     * Sets property by introspector.
     *
     * @param userInfo the user info
     * @param userName the user name
     * @throws Exception the exception
     */
    public static void setPropertyByIntrospector(UserInfo userInfo,String userName)throws Exception{
        BeanInfo beanInfo=Introspector.getBeanInfo(UserInfo.class);
        PropertyDescriptor[] proDescrtptors=beanInfo.getPropertyDescriptors();
        if(proDescrtptors!=null&&proDescrtptors.length>0){
            for(PropertyDescriptor propDesc:proDescrtptors){
                if(propDesc.getName().equals(userName)){
                    Method methodSetUserName=propDesc.getWriteMethod();
                    methodSetUserName.invoke(userInfo, "alan");
                    System.out.println("set userName:"+userInfo.getUserName());
                    break;
                }
            }
        }
    }

    /**
     * Gets property by introspector.
     *
     * @param userInfo the user info
     * @param userName the user name
     * @throws Exception the exception
     */
    public static void getPropertyByIntrospector(UserInfo userInfo,String userName)throws Exception{
        BeanInfo beanInfo=Introspector.getBeanInfo(UserInfo.class);
        PropertyDescriptor[] proDescrtptors=beanInfo.getPropertyDescriptors();
        if(proDescrtptors!=null&&proDescrtptors.length>0){
            for(PropertyDescriptor propDesc:proDescrtptors){
                if(propDesc.getName().equals(userName)){
                    Method methodGetUserName=propDesc.getReadMethod();
                    Object objUserName=methodGetUserName.invoke(userInfo);
                    System.out.println("get userName:"+objUserName.toString());
                    break;
                }
            }
        }
    }

    public static void getProperty(UserInfo userInfo, String userName) {
    }

    public static void setProperty(UserInfo userInfo, String userName) {
    }
}

package com.belong.introspector;
/**
 * @Author: belong.
 * @Description:
 * @Date: 2017/4/14.
 */
public class BeanInfoTest {

    /**
     * @param args
     */
    public static void main(String[] args) {
        UserInfo userInfo=new UserInfo();
        userInfo.setUserName("pei da");
        try {
            BeanInfoUtil.getProperty(userInfo, "userName");

            BeanInfoUtil.setProperty(userInfo, "userName");

            BeanInfoUtil.getProperty(userInfo, "userName");

            BeanInfoUtil.setPropertyByIntrospector(userInfo, "userName");

            BeanInfoUtil.getPropertyByIntrospector(userInfo, "userName");

            BeanInfoUtil.setProperty(userInfo, "age");

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}

package com.belong.string;

import java.security.MessageDigest;

/**
 * Created by belong on 2016/12/9.
 */
public class MD5 {
    private final static String[] hexArray = { "0", "1", "2", "3", "4", "5",
            "6", "7", "8", "9", "a", "b", "c", "d", "e", "f" }; // 存储十六进制值的数组
    /** 根据指定的字符串，创建加密后的字符串 */
    public static String createEncrypPassword(String string) {//dencryp
        return encrypByMD5(string);
    }
    /** 检验输入的密码是否正确 */
    public static boolean verificationPassword(String password, String string) {
        return password.equals(encrypByMD5(string));
    }
    /** 对指定的字符串进行MD5加密 */
    private static String encrypByMD5(String originString) {
        if (originString != null) {
            try {
                // 创建具有MD5算法的信息摘要
                MessageDigest md = MessageDigest.getInstance("MD5");
                // 使用指定的字节数组对摘要进行最后更新，然后完成摘要计算
                byte[] results = md.digest(originString.getBytes());
                // 将得到的字节数组变成字符串返回
                String resultString = byteArrayToHex(results);
                return resultString.toUpperCase();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return null;
    }
    /** 将字节数组转换成16进制，并以字符串的形式返回 */
    private static String byteArrayToHex(byte[] b) {
        StringBuffer resultSb = new StringBuffer();
        for (int i = 0; i < b.length; i++) {
            resultSb.append(byteToHex(b[i]));
        }
        return resultSb.toString();
    }
    /** 将一个字节转换成16进制，并以字符串的形式返回 */
    private static String byteToHex(byte b) {
        int n = b;
        if (n < 0)
            n = 256 + n;
        int d1 = n / 16;
        int d2 = n % 16;
        return hexArray[d1] + hexArray[d2];
    }
    public static void main(String[] args) {
        String password = MD5.createEncrypPassword("1");
        System.out.println("对password=hahaxiao1984使用MD5算法加密后的字符串如下：\n  "
                + password);
        String string = "hahaxiao1999";
        System.out.println("hahaxiao1999是正确的密码吗？"
                + MD5.verificationPassword(password, string));
        string = "hahaxiao1984";
        System.out.println("hahaxiao1984是正确的密码吗？"
                + MD5.verificationPassword(password, string));
    }
}


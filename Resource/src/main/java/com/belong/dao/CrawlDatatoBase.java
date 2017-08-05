package com.belong.dao;

import org.apache.commons.dbcp.BasicDataSourceFactory;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;

/**
 * Created by belong on 2017/4/12.
 */
public class CrawlDatatoBase {
    static Connection conn;
    /**
     * 将数据插入数据库
     */
    public static boolean InsertProduct(ArrayList<String> datalist){
        try{
            Date now = new Date();
            //获取当前日期
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
            //通过指定格式实例化日期转化为字符串模板
            String redate = dateFormat.format(now);
            //用模板将Date类型日期格式化成字符串
            datalist.add(redate);       //将日期加入datalist集合
            String insql = "INSERT INTO review(Vtitle,Vtime,Vdirector,Vactor,Vamount,Vredate) VALUES(?,?,?,?,?,?)";
            //定义将执行插入操作的insql语句
            PreparedStatement ps = conn.prepareStatement(insql);
            //实例化PreparedStatement对象，预处理insql语句
            int i;
            for(i=0;i<datalist.size();i++){
                String strvalue = datalist.get(i);
                //获取datalist集合中的每一条数据
                ps.setString(i+1, strvalue);
                //循环取得datalist中的数据并设置进VALUES中的？里面
            }
            int result = ps.executeUpdate();
            //执行insql语句，若成功，则返回一个正数，否则返回0
            ps.close();
            //关闭PreparedStatement对象
            if(result>0){
                //result大于0说明插入操作成功
                return true;
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }
    public static void setConn(){
        //调用getConnection方法连接数据库，增加安全性
        conn = getConnection();
    }
    public static void closeConn(){
        //关闭数据库连接
        try{
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    public static Connection getConnection(){
        Connection conn = null;
        InputStream is = null;
        DataSource ds = null;
        Properties pro = new Properties();
        is = CrawlDatatoBase.class.getClassLoader().getResourceAsStream("dbcp.ini");
        try {
            pro.load(is);
            ds = BasicDataSourceFactory.createDataSource(pro);
            conn = ds.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(is !=null){
                try {
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return conn;
    }
}

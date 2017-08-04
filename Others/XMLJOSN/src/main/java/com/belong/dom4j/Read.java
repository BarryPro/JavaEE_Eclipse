package com.belong.dom4j;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.List;

import org.dom4j.DocumentHelper;
import org.dom4j.Element;

public class Read {
	public static void main(String[] args) {
		new Read().read();
	}
	public void read(){
		//加载与类所在同一级的的资源文件
		InputStream is = Read.class.getClassLoader().getResourceAsStream("student.xml");
		//缓冲字节流
		BufferedReader reader = new BufferedReader(new InputStreamReader(is));
		String n = null;//长度不可变的
		StringBuffer buffer = new StringBuffer();//长度可变的字符串
		try {
			while((n=reader.readLine())!=null){//读出来的资源文件不为空
				buffer.append(n.trim());
			}
			//System.out.println(buffer);
			//得到xml文件中的根标签
			Element root = DocumentHelper.parseText(buffer.toString()).getRootElement();
			System.out.println(root.getName());
			List<Element> list = root.elements("student");//得到根标签下的子标签的集合
			for(Element e: list){
				System.out.println(e.getName());
				Element name = e.element("name");//element就是得到子标签
				String id = name.attributeValue("id");
				System.out.println(id);
				Element hao = e.element("id");
				System.out.println(hao.getName());
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

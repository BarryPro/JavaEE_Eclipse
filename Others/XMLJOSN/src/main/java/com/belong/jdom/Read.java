package com.belong.jdom;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

public class Read {
	public static void main(String[] args) {
		new Read().read();
	}
	public void read(){
		//得到资源文件的位置
		InputStream is = Read.class.getClassLoader().getResourceAsStream("student.xml");
		SAXBuilder sax = new SAXBuilder();//因为jdom本身没有解析器
		try {
			Document doc = sax.build(is);//把文件变成Document来进行操作
			Element root = doc.getRootElement();
			System.out.println(root.getName());
			List<Element> list = root.getChildren();//得到子标签
			for(Element e:list){
				System.out.println(e.getName());
				Element name = e.getChild("name");
				System.out.println(name.getAttributeValue("id"));
				System.out.println(name.getText());
			}
			
		} catch (JDOMException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

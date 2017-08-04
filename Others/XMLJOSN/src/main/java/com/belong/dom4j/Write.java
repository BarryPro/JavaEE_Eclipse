package com.belong.dom4j;

import java.io.File;
import java.io.FileOutputStream;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;

public class Write {
	public static void main(String[] args) {
		new Write().write();
	}
	public void write(){
		String filepath = Write.class.getResource("").getPath()+"db.xml";
		File file = new File(filepath);
		try (FileOutputStream fos = new FileOutputStream(file)){
			OutputFormat of = OutputFormat.createPrettyPrint();//定义输出xml文件的的格式的
			of.setEncoding("utf-8");//可以存中文
			of.setIndentSize(4);
			XMLWriter writer = new XMLWriter(fos,of);//创建xml文档写入流
			Document doc = DocumentHelper.createDocument();
			Element root = doc.addElement("students");//添加标签
			Element son = root.addElement("student");
			son.addAttribute("name", "belong");
			Element url = son.addElement("url");
			url.addText("http://www.belong.com");//添加体
			System.out.println(doc.asXML());//把写好的xml文档写到内存中
			writer.write(doc);
			writer.flush();
			writer.close();
			System.out.println("ok");
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
		}
	}
}

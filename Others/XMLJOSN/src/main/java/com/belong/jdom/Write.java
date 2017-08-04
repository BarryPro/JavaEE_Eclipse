package com.belong.jdom;

import java.io.File;
import java.io.FileOutputStream;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.XMLOutputter;

public class Write {
	public static void main(String[] args) {
		new Write().write();
	}
	public void write(){
		//得到运行时类在项目的位置+要存的文件名
		String filepath = Write.class.getResource("").getPath()+"dd.xml";
		File file = new File(filepath);
		try {
			Element root = new Element("students");
			Element student = new Element("student");
			Element id = new Element("id");
			student.setAttribute("name", "belong");
			student.setText("I'm a student");
			root.addContent(student);
			student.addContent(id);
			Document doc = new Document(root);
			XMLOutputter output = new XMLOutputter();//定义xml文档
			FileOutputStream fos = new FileOutputStream(file);
			output.output(doc, fos);
			System.out.println(output.outputString(doc));//把生成文件送入内存中
			System.out.println("ok");
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
		}
	}
}

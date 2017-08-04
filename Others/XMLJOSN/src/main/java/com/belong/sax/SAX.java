package com.belong.sax;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Result;
import javax.xml.transform.Transformer;
import javax.xml.transform.sax.SAXTransformerFactory;
import javax.xml.transform.sax.TransformerHandler;
import javax.xml.transform.stream.StreamResult;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;
import org.xml.sax.helpers.DefaultHandler;

public class SAX extends DefaultHandler{//驱动式解析
	@Override
	public void startDocument() throws SAXException {
		// TODO Auto-generated method stub
		System.out.println("开始文档");
	}
	@Override
	public void endDocument() throws SAXException {
		// TODO Auto-generated method stub
		System.out.println("结束文档");
	}
	@Override
	public void startElement(String arg0, String arg1, String arg2, Attributes arg3) throws SAXException {
		// TODO Auto-generated method stub
		System.out.println("开始元素"+arg2);
		System.out.println(arg3.getValue("id")!=null?arg3.getValue("id"):"");
	}
	@Override
	public void endElement(String arg0, String arg1, String arg2) throws SAXException {
		// TODO Auto-generated method stub
		System.out.println("结束元素"+arg2);
	}
	@Override
	public void characters(char[] arg0, int arg1, int arg2) throws SAXException {
		// TODO Auto-generated method stub
		System.out.println(new String(arg0,arg1,arg2));
	}
	public void readXML(){
		SAXParserFactory spf = null;
		InputStream is = SAX.class.getClassLoader().getResourceAsStream("student.xml");//读出xml文件
		try {
			//实例化sax工厂
			spf = SAXParserFactory.newInstance();//(类似单子模式)
			SAXParser sp = spf.newSAXParser();//得到sax转换器
			sp.parse(is, new SAX());//开始解析
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
		}
	}
	public void writeXML(){
		try {
			//sax转换工厂
			SAXTransformerFactory spf = (SAXTransformerFactory) SAXTransformerFactory.newInstance();
			//得到转换句柄
			TransformerHandler th =  spf.newTransformerHandler();
			//得到转换器
			Transformer tf = th.getTransformer();
			//设置编辑完的xml文件的属性
			tf.setOutputProperty(OutputKeys.ENCODING, "utf-8");
			tf.setOutputProperty(OutputKeys.INDENT, "yes");
			FileOutputStream fos = new FileOutputStream(new File("D://db.xml"));
			//将编辑好的xml文件都以输出到fos所指的文件中去
			Result result = new StreamResult(fos);
			//用句柄来调用
			th.setResult(result);
			th.startDocument();
			//实例化属性
			AttributesImpl ai = new AttributesImpl();
			th.startElement("", "", "students",ai);
			ai.addAttribute("", "", "id", "", "01");
			th.startElement("", "", "student",ai);
			th.endElement("", "", "student");
			ai.addAttribute("", "", "id", "", "02");
			th.startElement("", "", "student",ai);
			th.endElement("", "", "student");
			th.endElement("", "", "students");
			//结束文档
			th.endDocument();
			fos.flush();
			fos.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
		}
	}
	public static void main(String[] args) {
		new SAX().writeXML();
	}
}

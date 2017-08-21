package com.belong.net.xml.parse;

import java.io.IOException;
import java.io.InputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.belong.net.xml.bean.Address;
import com.belong.net.xml.bean.ReadXmlFileStream;
/**
 * @Description: <p>DOM（JAXP<Java API for XML Processing,XML处理的Java API> Crimson解析器）</p> 
 * 
 * DOM是用与平台和语言无关的方式表示XML文档的官方W3C标准。
 * DOM是以层次结构组织的节点或信息片断的集合。这个层次结构允许开发人员在树中寻找 特定信息。
 * 分析该结构通常需要加载整个文档和构造层次结构，然后才能做任何工作。由于它是基于信息层次的，
 * 因而DOM被认为是基于树或基于对象的。DOM 以及广义的基于树的处理具有几个优点。首先，由于
 * 树在内存中是持久的，因此可以修改它以便应用程序能对数据和结构作出更改。它还可以在任何时候
 * 在树中上下 导航，而不是像SAX那样是一次性的处理。DOM使用起来也要简单得多
 * 
 * @Author : belong
 * @Date : 2017年8月21日
 */
public class DOMParseXml {
	private static Address address = new Address();

	public static void main(String[] args) {
		long lasting = System.currentTimeMillis();
		try {
			InputStream in = ReadXmlFileStream.getXmlFileStream(); // 读取要解析的xml文件
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document document = builder.parse(in);
			Element root = document.getDocumentElement();
			NodeList valueNode = root.getElementsByTagName("value");
			System.out.println("addresses:" + root + root.getChildNodes() + " "+valueNode.getLength());
			for (int i = 0; i < valueNode.getLength(); i++) {
				System.out.println(i);
				address.setNo(root.getElementsByTagName("no").item(i).getFirstChild().getNodeValue());
				address.setAddr(root.getElementsByTagName("addr").item(i).getFirstChild().getNodeValue());
				System.out.println(address);
			}
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println("运行时间：" + (System.currentTimeMillis() - lasting)+ " 毫秒");
	}
}

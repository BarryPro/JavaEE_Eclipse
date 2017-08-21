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
 * @Description: <p>DOM(Document Object Model)Crimson解析器）</p> 
 * 
 * DOM是html和xml的应用程序接口(API)，以层次结构（类似于树型）来组织节点和信息片段，
 * 映射XML文档的结构，允许获取和操作文档的任意部分，是W3C的官方标准
 *  【优点】
 *		①允许应用程序对数据和结构做出更改。
 *		②访问是双向的，可以在任何时候在树中上下导航，获取和操作任意部分的数据。
 *	【缺点】
 *		①通常需要加载整个XML文档来构造层次结构，消耗资源大。
 *	【解析详解】
 *		①构建Document对象：
 *			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
 * 			DocumentBuilder db = bdf.newDocumentBuilder();
 *			InputStream is = Thread.currentThread().getContextClassLoader().getResourceAsStream(xml文件);
 *			Document doc = bd.parse(is);
 *		②遍历DOM对象
 *			Document：	XML文档对象，由解析器获取
 *			NodeList：	节点数组
 *			Node：		节点(包括element、#text)
 *			Element：	元素，可用于获取属性参数
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

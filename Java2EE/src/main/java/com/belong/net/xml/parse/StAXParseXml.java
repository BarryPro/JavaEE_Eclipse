package com.belong.net.xml.parse;

import java.io.InputStream;

import javax.xml.stream.XMLEventReader;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.events.StartElement;
import javax.xml.stream.events.XMLEvent;

import com.belong.net.xml.bean.Address;
import com.belong.net.xml.bean.ReadXmlFileStream; 
/**
 * @Description: <p>StAX(The Streaming API for XML)</p>
 * 
 * 流(事件流)模型中的“拉”模型分析方式。提供基于指针和基于迭代器两种方式的支持,JDK1.6新特性
 *	【和推式解析相比的优点】
 *		①在拉式解析中，事件是由解析应用产生的，因此拉式解析中向客户端提供的是解析规则，而不是解析器。
 *		②同推式解析相比，拉式解析的代码更简单，而且不用那么多库。
 *		③拉式解析客户端能够一次读取多个XML文件。
 *		④拉式解析允许你过滤XML文件和跳过解析事件。
 *	【简介】
 *		StAX API的实现是使用了Java Web服务开发（JWSDP）1.6，并结合了Sun Java流式XML分析器(SJSXP)-它位于
 *		javax.xml.stream包中。XMLStreamReader接口用于分析一个XML文档，而XMLStreamWriter接口用于生成一个
 *		XML文档。XMLEventReader负责使用一个对象事件迭代子分析XML事件-这与XMLStreamReader所使用的光标机制
 *		形成对照。
 * 
 * @Author : belong
 * @Date : 2017年8月21日
 */
public class StAXParseXml {
	private static Address address = new Address();

	public static void main(String[] args) {
		long lasting = System.currentTimeMillis();
		try {
			InputStream in = ReadXmlFileStream.getXmlFileStream();
			XMLInputFactory xmlif = XMLInputFactory.newInstance();
			// 用于解析 XML 事件的顶层接口
			XMLEventReader reader = xmlif.createXMLEventReader(in);
			// 处理标记事件的基础事件接口
			XMLEvent event = null;
			while (reader.hasNext()) {
				event = reader.nextEvent();
				if (event.isStartElement()) { // 起始元素
					StartElement startElt = event.asStartElement();
					if (startElt.getName().getLocalPart().equals("no")) {
						address.setNo(reader.getElementText());
					} else if (startElt.getName().getLocalPart().equals("addr")) {
						address.setAddr(reader.getElementText());
						System.out.println(address);
					}
				} else if (event.isCharacters()) { // 文本内容
					// 相邻标记之间都是文本内容
					System.out.println("解析的是文本内容:" + event.asCharacters().getData());
				} else if (event.isEndElement()) { // 结束元素
					System.out.println("解析的是结束标记:" + event.asEndElement().getName());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("运行时间：" + (System.currentTimeMillis() - lasting) + " 毫秒");
	}
}

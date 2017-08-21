package com.belong.net.xml.parse;

import java.io.InputStream;

import javax.xml.stream.XMLEventReader;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.events.StartElement;
import javax.xml.stream.events.XMLEvent;

import com.belong.net.xml.bean.Address;
import com.belong.net.xml.bean.ReadXmlFileStream; 
/**
 * @Description: <p></p>
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

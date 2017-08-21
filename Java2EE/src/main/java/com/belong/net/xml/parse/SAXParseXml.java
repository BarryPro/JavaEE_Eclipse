package com.belong.net.xml.parse;

import java.io.InputStream;
import java.util.Stack;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import com.belong.net.xml.bean.Address;
import com.belong.net.xml.bean.ReadXmlFileStream; 
/**
 * @Description: <p>SAX(Simple API forXML)</p>
 * 
 * 流（事件流）模型中的"推"模型分析方式。通过事件驱动，每发现一个节点就引发一个事件，事件推给事件处理器，
 * 通过回调方法完成解析工作，解析XML文档的逻辑需要应用程序完成
 *	【优势】
 * 		①不需要等待所有数据都被处理，分析就能立即开始。
 *		②只在读取数据时检查数据，不需要保存在内存中。
 *		③可以在某个条件得到满足时停止解析，不必解析整个文档。
 *		④效率和性能较高，能解析大于系统内存的文档。
 *	【缺点】
 *		①需要应用程序自己负责tag的处理逻辑（例如维护父/子关系等），文档越复杂程序就越复杂。
 *		②单向导航，无法定位文档层次，很难同时访问同一文档的不同部分数据，不支持XPath。
 *	【原理】
 *		简单的说就是对文档进行顺序扫描，当扫描到文档(document)开始与结束、元素(element)开始与结束时通知事件
 *		处理函数(回调函数)，进行相应处理，直到文档结束
 *	【事件处理器类型】
 *		①访问XML DTD：DTDHandler
 *		②低级访问解析错误：ErrorHandler
 *		③访问文档内容：ContextHandler
 *	【DefaultHandler类】
 *		SAX事件处理程序的默认基类，实现了DTDHandler、ErrorHandler、ContextHandler和EntityResolver接口，通常
 *		做法是，继承该基类，重写需要的方法，如startDocument()
 *	【创建SAX解析器】
 *		SAXParserFactory saxf = SAXParserFactory.newInstance();
 *		SAXParser sax = saxf.newSAXParser();
 *	注：关于遍历
 *		①深度优先遍历(Depthi-First Traserval)
 *		②广度优先遍历(Width-First Traserval)
 * 
 * @Author : belong
 * @Date : 2017年8月21日
 */
public class SAXParseXml extends DefaultHandler {
	private static Address address = new Address();
	private Stack tags = new Stack();

	public SAXParseXml() {}

	@Override
	public void characters(char[] ch, int start, int length) throws SAXException {
		String tag = (String) tags.peek();
		if (tag.equals("no")) {
			address.setNo(new String(ch, start, length));
			System.out.println(address.getNo());
		}
		if (tag.equals("addr")) {
			address.setAddr(new String(ch, start, length));
			System.out.println(address.getAddr());
		}
	}

	@Override
	public void startElement(String uri, String localName, String qName, Attributes attrs) throws SAXException {
		tags.push(qName);
	}

	public static void main(String[] args) {
		long lasting = System.currentTimeMillis();
		try {
			SAXParserFactory factory = SAXParserFactory.newInstance();
			SAXParser sp = factory.newSAXParser(); // 创建解析器
			SAXParseXml reader = new SAXParseXml();
			InputStream in = ReadXmlFileStream.getXmlFileStream();
			sp.parse(new InputSource(in), reader);
			System.out.println("运行时间：" + (System.currentTimeMillis() - lasting) + " 毫秒");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

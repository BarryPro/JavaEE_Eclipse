package com.belong.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.XMLOutputter;

public class XMLWriteService implements IWrite{
	private Map<String,String> jmap = new HashMap<String,String>(); 
    private Map<String,String> cmap = new HashMap<String,String>(); 
    private Map<String,String> mmap = new HashMap<String,String>(); 
    private Map<String,String> omap = new HashMap<String,String>(); 
    public XMLWriteService(){
    	jmap.put("thread", "线程");
    	jmap.put("io","流");
    	mmap.put("select", "查询");
    	mmap.put("procedure", "存储过程");
    }
	@Override
	public String write(String lan) {
		Element root = new Element("tecs");
		switch (lan) {
		case "java":			
			Set <Entry<String,String>> ss = jmap.entrySet();//把map变成set
			Iterator<Entry<String,String>> it = ss.iterator();//得到遍历器
			while(it.hasNext()){
				Entry<String,String> e = it.next();
				Element tec = new Element("tec");
				Element name = new Element("name");
				name.setText(e.getValue());
				Element no = new Element("no");
				no.setText(e.getKey());
				tec.addContent(name);
				tec.addContent(no);
				root.addContent(tec);
			}
			break;
		case "mysql":
			Set <Entry<String,String>> ss1 = mmap.entrySet();//把map变成set
			Iterator<Entry<String,String>> it1 = ss1.iterator();//得到遍历器
			while(it1.hasNext()){
				Entry<String,String> e = it1.next();
				Element tec = new Element("tec");
				Element name = new Element("name");
				name.setText(e.getValue());
				Element no = new Element("no");
				no.setText(e.getKey());
				tec.addContent(name);
				tec.addContent(no);
				root.addContent(tec);
			}
			break;
		default:
			break;
		}
		Document doc = new Document(root);//变成xml文档来存存传输
		XMLOutputter out = new XMLOutputter();
		return out.outputString(doc);//返回xml文档
	}
	public static void main(String[] args) {
		new XMLWriteService().write("java");
	}
}



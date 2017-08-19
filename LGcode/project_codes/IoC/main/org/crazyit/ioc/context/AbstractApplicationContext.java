package org.crazyit.ioc.context;

import java.lang.reflect.Method;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import IoC.main.org.crazyit.ioc.context.exception.BeanCreateException;
import IoC.main.org.crazyit.ioc.xml.DocumentHolder;
import IoC.main.org.crazyit.ioc.xml.ElementLoader;
import IoC.main.org.crazyit.ioc.xml.ElementLoaderImpl;
import IoC.main.org.crazyit.ioc.xml.ElementReader;
import IoC.main.org.crazyit.ioc.xml.ElementReaderImpl;
import IoC.main.org.crazyit.ioc.xml.XmlDocumentHolder;
import IoC.main.org.crazyit.ioc.xml.autowire.Autowire;
import IoC.main.org.crazyit.ioc.xml.autowire.ByNameAutowire;
import IoC.main.org.crazyit.ioc.xml.autowire.NoAutowire;
import IoC.main.org.crazyit.ioc.xml.construct.DataElement;
import IoC.main.org.crazyit.ioc.xml.construct.RefElement;
import IoC.main.org.crazyit.ioc.xml.construct.ValueElement;
import IoC.main.org.crazyit.ioc.xml.property.PropertyElement;

/**
 * IoC����������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public abstract class AbstractApplicationContext implements ApplicationContext {

	//Ԫ�ؼ��ض���
	protected ElementLoader elementLoader = new ElementLoaderImpl();
	
	//�ĵ����ж���
	protected DocumentHolder documentHolder = new XmlDocumentHolder();
	
	//�����beans
	protected Map<String, Object> beans = new HashMap<String, Object>();
	
	//���Դ�����
	protected PropertyHandler propertyHandler = new PropertyHandlerImpl();
	
	//����bean����Ľӿ�
	protected BeanCreator beanCreator = new BeanCreatorImpl();
	
	//ElementԪ�ض�ȡ��
	protected ElementReader elementReader = new ElementReaderImpl();
	
	
	
	/**
	 * ��ȡxml�ļ�, ������Ԫ�ػ���
	 * @param xmlPaths
	 */
	protected void setUpElements(String[] xmlPaths) {
		try {			
			URL classPathUrl = AbstractApplicationContext.class.getClassLoader().getResource(".");
			String classPath = java.net.URLDecoder.decode(classPathUrl.getPath(),"utf-8");
			for (String path : xmlPaths) {
				Document doc = documentHolder.getDocument(classPath + path);
				elementLoader.addElements(doc);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	/**
	 * �������е�beanʵ��, �ӳټ��صĲ�����
	 */
	protected void createBeans() {
		Collection<Element> elements = elementLoader.getElements();
		for (Element e : elements) {
			boolean lazy = elementReader.isLazy(e);
			//��������ӳټ���, ���ж��Ƿ�̬
			if (!lazy) {
				String id = e.attributeValue("id");
				Object bean = this.getBean(id);
				if (bean == null) {
					//����bean, ����ǵ�̬��, �ӵ�������, �ǵ�̬�򲻴���
					handleSingleton(id);
				}
			}
		}
	}
	
	/**
	 * ����bean, ����ǵ�̬��, ��ӵ�map��, �ǵ�̬, �򴴽�����
	 * @param id
	 * @return
	 */
	protected Object handleSingleton(String id) {
		Object bean = createBean(id);;
		if (isSingleton(id)) {
			//��̬�Ļ�, �ŵ�map��
			this.beans.put(id, bean);
		}
		return bean;
	}
	
	/**
	 * ����һ��beanʵ��, ����Ҳ�����bean��Ӧ�������ļ���Element����, �׳��쳣
	 * @param id
	 * @return
	 */
	protected Object createBean(String id) {
		Element e = elementLoader.getElement(id);
		if (e == null) throw new BeanCreateException("element not found " + id);
		Object result = instance(e);
		System.out.println("����bean: " + id);
		System.out.println("��bean�Ķ�����: " + result);
		//��ֵע��, ���ж��Ƿ��Զ�װ��
		Autowire autowire = elementReader.getAutowire(e);
		if (autowire instanceof ByNameAutowire) {
			//ʹ�������Զ�װ��
			autowireByName(result);
		} else if (autowire instanceof NoAutowire) {
			//���Զ�װ��, ͨ��<property>����
			setterInject(result, e);
		}
		return result;
	}
	
	/**
	 * ʵ����һ��bean, �����bean��������constructor-argԪ��, ��ôʹ�ô������Ĺ�����
	 * @param e
	 * @return
	 */
	protected Object instance(Element e) {
		String className = elementReader.getAttribute(e, "class");
		//�õ�bean�ڵ������constructor-arg�ڵ�
		List<Element> constructorElements = elementReader.getConstructorElements(e);
		//�ж�ʹ��ʲô���������д���(�жϱ�׼ΪbeanԪ�����Ƿ���constructor-arg��Ԫ��)
		if (constructorElements.size() == 0) {
			//û��constructor-arg��Ԫ��, ʹ���޲ι�����
			return beanCreator.createBeanUseDefaultConstruct(className);
		} else {
			//��constructor-arg��Ԫ��, ʹ���в���������, ����ע�����
			List<Object> args = getConstructArgs(e);
			return beanCreator.createBeanUseDefineConstruce(className, args);
		}
	}
		
	/**
	 * ͨ��propertyԪ��Ϊ����obj��������
	 * @param obj
	 * @param e
	 */
	protected void setterInject(Object obj, Element e) {
		List<PropertyElement> properties = elementReader.getPropertyValue(e);
		Map<String, Object> propertiesMap = getPropertyArgs(properties);
		propertyHandler.setProperties(obj, propertiesMap);
	}
	
	/**
	 * ��map����ʽ�õ���Ҫע��Ĳ�������, keyΪsetter������(��Ҫset), valueΪ��������
	 * @param properties
	 * @return
	 */
	protected Map<String, Object> getPropertyArgs(List<PropertyElement> properties) {
		Map<String, Object> result = new HashMap<String, Object>();
		for (PropertyElement p : properties) {
			DataElement de = p.getDataElement();
			if (de instanceof RefElement) {
				//�������еõ�bean��ʵ��, ��������map��
				result.put(p.getName(), this.getBean((String)de.getValue()));
			} else if (de instanceof ValueElement) {
				result.put(p.getName(), de.getValue());
			}
		}
		return result;
	}
	
	/**
	 * �õ�һ��bean�������õĹ������
	 * @param e
	 * @return
	 */
	protected List<Object> getConstructArgs(Element e) {
		List<DataElement> datas = elementReader.getConstructorValue(e);
		List<Object> result = new ArrayList<Object>();
		for (DataElement d : datas) {
			if (d instanceof ValueElement) {
				d = (ValueElement)d;
				result.add(d.getValue());
			} else if (d instanceof RefElement) {
				//���������Ԫ��, ��ֱ�ӵ�getBeanȥ��ȡ(��ȡ�����򴴽�)
				d = (RefElement)d;
				String refId = (String)d.getValue();
				result.add(this.getBean(refId));
			}
		}
		return result;
	}
	
	/**
	 * �Զ�װ��һ������, �õ���bean������setter����, �ٴ������в��Ҷ�Ӧ��bean
	 * ����, ���bean����һ��setSchool(School)����, ��ô��ȥ������Ϊschool��bean, 
	 * �ٵ���setSchool�������������
	 * @param obj
	 */
	protected void autowireByName(Object obj) {
		Map<String, Method> methods = propertyHandler.getSetterMethodsMap(obj);
		for (String s : methods.keySet()) {
			//�õ���Ӧ��beanԪ��
			Element e = elementLoader.getElement(s);
			//û�ж�Ӧ��Ԫ������, ����ѭ��
			if (e == null) continue;
			//����getBean��������bean
			Object bean = this.getBean(s);
			//ִ�ж����setter����
			Method method = methods.get(s);
			propertyHandler.executeMethod(obj, bean, method);
		}
	}
	
	public boolean containsBean(String id) {
		//����ElementLoader����, ����id�õ���Ӧ��Element����
		Element e = elementLoader.getElement(id);
		return (e == null) ? false : true;
	}

	public Object getBean(String id) {
		Object bean = this.beans.get(id);
		//�����ȡ������bean, �򴴽�
		if (bean == null) {
			//�жϴ���̬���߷ǵ�̬��bean
			bean = handleSingleton(id);
		}
		return bean;
	}

	public boolean isSingleton(String id) {
		//ʹ��ElementLoader������ö�Ӧ��Element
		Element e = elementLoader.getElement(id);
		//ʹ��ElementReader�ж��Ƿ�Ϊ��̬
		return elementReader.isSingleton(e);
	}

	public Object getBeanIgnoreCreate(String id) {
		return this.beans.get(id);
	}
}

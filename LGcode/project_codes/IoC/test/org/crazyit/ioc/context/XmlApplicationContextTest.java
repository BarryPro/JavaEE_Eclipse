package org.crazyit.ioc.context;

import IoC.main.org.crazyit.ioc.context.XmlApplicationContext;
import IoC.test.org.crazyit.ioc.context.object.XmlApplicationContextObject1;
import IoC.test.org.crazyit.ioc.context.object.XmlApplicationContextObject2;
import IoC.test.org.crazyit.ioc.context.object.XmlApplicationContextObject3;
import junit.framework.TestCase;

public class XmlApplicationContextTest extends TestCase {

	ApplicationContext ctx;

	protected void setUp() throws Exception {
		ctx = new XmlApplicationContext(new String[]{"/resources/context/XmlApplicationContext1.xml"});
	}

	protected void tearDown() throws Exception {
		ctx = null;
	}

	public void testGetBean() {
		//�õ���һ��, ʹ���޲ι���������
		XmlApplicationContextObject1 obj1 = (XmlApplicationContextObject1)ctx.getBean("test1");
		assertNotNull(obj1);
	}
	
	public void testSingleton() {
		//test1�ǵ�̬bean
		XmlApplicationContextObject1 obj1 = (XmlApplicationContextObject1)ctx.getBean("test1");
		XmlApplicationContextObject1 obj2 = (XmlApplicationContextObject1)ctx.getBean("test1");
		assertEquals(obj1, obj2);
		//test3���ǵ�̬bean
		XmlApplicationContextObject1 obj3 = (XmlApplicationContextObject1)ctx.getBean("test3");
		XmlApplicationContextObject1 obj4 = (XmlApplicationContextObject1)ctx.getBean("test3");
		assertFalse(obj3.equals(obj4));
	}
	
	public void testConstructInjection() {
		XmlApplicationContextObject1 obj1 = (XmlApplicationContextObject1)ctx.getBean("test1");
		//�õ��ڶ���, ʹ�ö��������������
		XmlApplicationContextObject2 obj2 = (XmlApplicationContextObject2)ctx.getBean("test2");
		assertNotNull(obj2);
		assertEquals(obj2.getName(), "yangenxiong");
		assertEquals(obj2.getAge(), 10);
		assertEquals(obj2.getObject1(), obj1);
	}
	
	/*
	 * �����Զ�װ��
	 */
	public void testAutowire() {
		
		XmlApplicationContextObject3 obj1 = (XmlApplicationContextObject3)ctx.getBean("test4");
		assertNotNull(obj1);
		XmlApplicationContextObject1 obj2 = obj1.getObject1();
		assertNotNull(obj2);
		XmlApplicationContextObject1 obj3 = (XmlApplicationContextObject1)ctx.getBean("object1");
		assertEquals(obj2, obj3);
	}
	
	/*
	 * �����Ƿ������bean
	 */
	public void testContainsBean() {
		boolean result = ctx.containsBean("test1");
		assertTrue(result);
		result = ctx.containsBean("test5");
		assertTrue(result);
		result = ctx.containsBean("No exists");
		assertFalse(result);
	}
	
	/*
	 * �����ӳټ���
	 */
	public void testLazyInit() {
		//test5���ӳټ��ص�, û�е��ù�getBean����, ��ô�����оͲ��ᴴ�����bean
		Object obj = ctx.getBeanIgnoreCreate("test5");
		assertNull(obj);
		System.out.println(obj);
		obj = ctx.getBean("test5");
		assertNotNull(obj);
		System.out.println(obj);
	}
	
	/*
	 * ������ֵע��
	 */
	public void testSetProperties() {
		XmlApplicationContextObject3 obj1 = (XmlApplicationContextObject3)ctx.getBean("test6");
		XmlApplicationContextObject1 obj2 = (XmlApplicationContextObject1)ctx.getBean("object1");
		assertEquals(obj1.getName(), "yangenxiong");
		assertEquals(obj1.getAge(), 10);
		assertEquals(obj1.getObject1(), obj2);
	}
}

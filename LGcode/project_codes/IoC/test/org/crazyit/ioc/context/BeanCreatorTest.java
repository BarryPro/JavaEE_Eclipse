package org.crazyit.ioc.context;

import java.util.ArrayList;
import java.util.List;

import IoC.main.org.crazyit.ioc.context.BeanCreator;
import IoC.main.org.crazyit.ioc.context.BeanCreatorImpl;
import IoC.test.org.crazyit.ioc.context.object.BeanCreatorObject1;
import IoC.test.org.crazyit.ioc.context.object.BeanCreatorObject2;
import junit.framework.TestCase;

public class BeanCreatorTest extends TestCase {

	BeanCreator creator;
	
	
	public void setUp() {
		creator = new BeanCreatorImpl();
		
	}
	
	public void tearDown() {
		creator = null;
	}
	
	public void testCreateBeanUseDefaultConstruct() {
		//�޲�������������ʵ��
		String className = "org.crazyit.ioc.context.object.BeanCreatorObject1";
		BeanCreatorObject1 obj = (BeanCreatorObject1)
		creator.createBeanUseDefaultConstruct(className);
		assertNotNull(obj);
		assertNull(obj.getName());
		assertNull(obj.getValue());
		System.out.println(obj);
		System.out.println(obj.getName());
		System.out.println(obj.getValue());
		//�����Ҳ�������
		className = "abc";
		Exception ex = null;
		try {
			obj = (BeanCreatorObject1)
			creator.createBeanUseDefaultConstruct(className);
		} catch (Exception e) {
			ex = e;
		}
		assertNotNull(ex);
	}
	
	public void testCreateBeanUseDefineConstruce() {
		//�в�������������ʵ��
		String className = "org.crazyit.ioc.context.object.BeanCreatorObject2";
		List<Object> args = new ArrayList<Object>();
		args.add("yangenxiong");
		args.add("crazyit");
		
		BeanCreatorObject2 obj = (BeanCreatorObject2)
		creator.createBeanUseDefineConstruce(className, args);
		assertEquals(obj.getName(), "yangenxiong");
		assertEquals(obj.getValue(), "crazyit");
		System.out.println(obj.getName());
		System.out.println(obj.getValue());
		//���Բ������Ͳ�����
		args.removeAll(args);
		args.add(new Integer(1));
		args.add(new Long(1000));
		Exception ex = null;
		try {
			obj = (BeanCreatorObject2)
			creator.createBeanUseDefineConstruce(className, args);
		} catch (Exception e) {
			ex = e;
		}
		assertNotNull(ex);
	}
	
//	public void testFindConstructor() throws Exception {
//		Constructor c = creator.findConstructor(TestImplement.class, new Class[]{Implement.class});
//		assertNotNull(c);
//		c = creator.findConstructor(TestImplement.class, new Class[]{Implement.class, Implement.class});
//		assertNotNull(c);
//	}
}

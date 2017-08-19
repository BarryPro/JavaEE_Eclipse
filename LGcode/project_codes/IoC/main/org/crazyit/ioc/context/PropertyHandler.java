package org.crazyit.ioc.context;

import java.lang.reflect.Method;
import java.util.Map;

/**
 * ���Դ���ӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface PropertyHandler {

	/**
	 * Ϊ����obj��������
	 * @param obj
	 * @param properties ���Լ���
	 * @return
	 */
	Object setProperties(Object obj, Map<String, Object> properties);
	
//	/**
//	 * �����Ի��setter��������
//	 * @param keys
//	 * @return
//	 */
//	List<String> getSetterMethodName(Map<String, Object> properties);
	
	/**
	 * ����һ�������������е�setter����, ��װ��map, keyΪsetter��������Ҫset
	 * @param obj
	 * @return
	 */
	Map<String, Method> getSetterMethodsMap(Object obj);
	
	/**
	 * ִ��һ������
	 * @param object ��Ҫִ�з����Ķ���
	 * @param argBean ������bean
	 * @param method ��������
	 */
	void executeMethod(Object object, Object argBean, Method method);

	
}

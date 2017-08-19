package org.crazyit.ioc.context;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import IoC.main.org.crazyit.ioc.context.exception.BeanCreateException;

/**
 * ���Դ���ʵ����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
@SuppressWarnings("unchecked")
public class PropertyHandlerImpl implements PropertyHandler {

	
	public Object setProperties(Object obj, Map<String, Object> properties) {
		Class clazz = obj.getClass();
		try {
			for (String key : properties.keySet()) {
				String setterName = getSetterMethodName(key);
				Class argClass = getClass(properties.get(key));
				Method setterMethod = getSetterMethod(clazz, setterName, argClass);
				setterMethod.invoke(obj, properties.get(key));
			}
			return obj;
		} catch (NoSuchMethodException e) {
			throw new PropertyException("setter method not found " + e.getMessage());
		} catch (IllegalArgumentException e) {
			throw new PropertyException("wrong argument " + e.getMessage());
		} catch (Exception e) {
			throw new PropertyException(e.getMessage());
		}
	}
	
	/**
	 * ����������Ѱ�Ҳ���������interfaces����һ���ķ���
	 * @param argClass ��������
	 * @param methods ��������
	 * @return
	 */
	private Method findMethod(Class argClass, List<Method> methods) {
		for (Method m : methods) {
			//�жϲ��������뷽���Ĳ��������Ƿ�һ��
			if (isMethodArgs(m, argClass)) {
				return m;
			}
		}
		return null;
	}
	
	/**
	 * �жϲ�������(argClass)�Ƿ��Ǹ÷���(m)�Ĳ�������
	 * @param m
	 * @param argClass
	 * @return
	 */
	private boolean isMethodArgs(Method m, Class argClass) {
		Class[] c = m.getParameterTypes();
		if (c.length == 1) {
			try {
				//����������(argClass)�뷽���еĲ������ͽ���ǿ��ת��, �����쳣���ظ�Method
				argClass.asSubclass(c[0]);
				return true;
			} catch (ClassCastException e) {
				return false;
			}
		}
		return false;
	}
	
	/**
	 * ���ݷ������Ͳ������͵õ�����, ���û�и÷�������null
	 * @param objClass
	 * @param methodName
	 * @param argClass
	 * @return
	 */
	private Method getMethod(Class objClass, String methodName, Class argClass) {
		try {
			Method method = objClass.getMethod(methodName, argClass);
			return method;
		} catch (NoSuchMethodException e) {
			return null;
		}
	}
	
	private Method getSetterMethod(Class objClass, String methodName, 
			Class argClass) throws NoSuchMethodException {
		//ʹ��ԭ���ͻ�÷���, ���û���ҵ��÷���, ��õ�null
		Method argClassMethod = getMethod(objClass, methodName, argClass);
		//����Ҳ���ԭ���͵ķ���, ���Ҹ�������ʵ�ֵĽӿ�
		if (argClassMethod == null) {
			//�õ���������ΪmethodName�ķ���
			List<Method> methods = getMethods(objClass, methodName);
			Method method = findMethod(argClass, methods);
			if (method == null) {
				//�Ҳ����κη���
				throw new NoSuchMethodException(methodName);
			}
			return method;
		} else {
			return argClassMethod;
		}
	}
	
	/**
	 * �õ���������ΪmethodName����ֻ��һ�������ķ���
	 * @param objClass
	 * @param methodName
	 * @return
	 */
	private List<Method> getMethods(Class objClass, String methodName) {
		List<Method> result = new ArrayList<Method>();
		for (Method m : objClass.getMethods()) {
			if (m.getName().equals(methodName)) {
				//�õ����������в���, ���ֻ��һ������, ����ӵ�������
				Class[] c = m.getParameterTypes();
				if (c.length == 1) {
					result.add(m);
				}
			}
		}
		return result;
	}
	
	private List<Method> getSetterMethodsList(Object obj) {
		Class clazz = obj.getClass();
		Method[] methods = clazz.getMethods();
		List<Method> result = new ArrayList<Method>();
		for (Method m : methods) {
			if (m.getName().startsWith("set")) {
				result.add(m);
			}
		}
		return result;
	}
	
	public Map<String, Method> getSetterMethodsMap(Object obj) {
		List<Method> methods = getSetterMethodsList(obj);
		Map<String, Method> result = new HashMap<String, Method>();
		for (Method m : methods) {
			String propertyName = getMethodNameWithOutSet(m.getName());
			result.put(propertyName, m);
		}
		return result;
	}
	
	public void executeMethod(Object object, Object argBean, Method method) {
		try {
			//��ȡ�����Ĳ�������
			Class[] parameterTypes = method.getParameterTypes();
			//�������������Ϊ1����ִ�и÷���
			if (parameterTypes.length == 1) {
				//����������Ͳ�һ��, ��ִ�з���
				if (isMethodArgs(method, parameterTypes[0])) {
					method.invoke(object, argBean);
				}
			}
		} catch (Exception e) {
			throw new BeanCreateException("autowire exception " + e.getMessage());
		}
	}

	/**
	 * ��setter������ԭ, setName��Ϊ����, �õ�name
	 * @param methodName
	 * @return
	 */
	private String getMethodNameWithOutSet(String methodName) {
		String propertyName = methodName.replaceFirst("set", "");
		String firstWord = propertyName.substring(0, 1);
		String lowerFirstWord = firstWord.toLowerCase();
		return propertyName.replaceFirst(firstWord, lowerFirstWord);
	}

	/**
	 * ���һ��Object��class
	 * @param obj
	 * @return
	 */
	private Class getClass(Object obj) {
		if (obj instanceof Integer) {
			return Integer.TYPE;
		} else if (obj instanceof Boolean) {
			return Boolean.TYPE;
		} else if (obj instanceof Long) {
			return Long.TYPE;
		} else if (obj instanceof Short) {
			return Short.TYPE;
		} else if (obj instanceof Double) {
			return Double.TYPE;
		} else if (obj instanceof Float) {
			return Float.TYPE;
		} else if (obj instanceof Character) {
			return Character.TYPE;
		} else if (obj instanceof Byte) {
			return Byte.TYPE;
		}
		return obj.getClass();
	}

//	public List<String> getSetterMethodName(Map<String, Object> properties) {
//		Set<String> keys = properties.keySet();
//		List<String> methodNames = new ArrayList<String>();
//		for (String key : keys) {
//			methodNames.add("set" + upperCaseFirstWord(key));
//		}
//		return methodNames;
//	}
	
	/**
	 * ����һ�����Ե�setter����
	 * @param propertyName
	 * @return
	 */
	private String getSetterMethodName(String propertyName) {
		return "set" + upperCaseFirstWord(propertyName);
	}
	
	/**
	 * ������s������ĸ��Ϊ��д
	 * @param key
	 * @return
	 */
	private String upperCaseFirstWord(String s) {
		String firstWord = s.substring(0, 1);
		String upperCaseWord = firstWord.toUpperCase();
		return s.replaceFirst(firstWord, upperCaseWord);
	}

}

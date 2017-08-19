package org.crazyit.ioc.context;

import java.lang.reflect.Constructor;
import java.util.ArrayList;
import java.util.List;

import IoC.main.org.crazyit.ioc.context.exception.BeanCreateException;

/**
 * Bean����ʵ����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class BeanCreatorImpl implements BeanCreator {

	public Object createBeanUseDefaultConstruct(String className) {
		try {
			Class clazz = Class.forName(className);
			return clazz.newInstance();
		} catch (ClassNotFoundException e) {
			throw new BeanCreateException("class not found " + e.getMessage());
		} catch (Exception e) {
			throw new BeanCreateException(e.getMessage());
		}
	}
	
	/**
	 * ����һ����Ĺ�����
	 * @param clazz ����
	 * @param argsClass �������
	 * @return
	 */
	private Constructor getConstructor(Class clazz, Class[] argsClass) {
		try {
			Constructor constructor = clazz.getConstructor(argsClass);
			return constructor;
		} catch (NoSuchMethodException e) {
			return null;
		}
	}
	
	/**
	 * ����һ����Ĺ�����, һ�����й����������п�����ԭ�����������͵�����
	 * @param clazz
	 * @param argsClass
	 * @return
	 * @throws NoSuchMethodException
	 */
	private Constructor findConstructor(Class clazz, Class[] argsClass)
		throws NoSuchMethodException {
		Constructor constructor = getConstructor(clazz, argsClass);
		if (constructor == null) {
			Constructor[] constructors = clazz.getConstructors();
			for (Constructor c : constructors) {
				//��ȡ�������еĹ�����
				Class[] constructorArgsCLass = c.getParameterTypes();
				//���������빹�����Ĳ���������ͬ
				if (constructorArgsCLass.length == argsClass.length) {
					if (isSameArgs(argsClass, constructorArgsCLass)) {
						return c;
					}
				}
			}
		} else {
			return constructor;
		}
		throw new NoSuchMethodException("could not find any constructor");
	}
	
	/**
	 * �ж������������������Ƿ�ƥ��
	 * @param argsClass
	 * @param constructorArgsCLass
	 * @return
	 */
	private boolean isSameArgs(Class[] argsClass, Class[] constructorArgsCLass) {
		for (int i = 0; i < argsClass.length; i++) {
			try {
				//�����������빹�����еĲ������ͽ���ǿ��ת��
				argsClass[i].asSubclass(constructorArgsCLass[i]);
				//ѭ�������һ����û�г���, ��ʾ�ù���������
				if (i == (argsClass.length - 1)) {
					return true;
				}
			} catch (Exception e) {
				//��һ���������Ͳ�����, ������ѭ��
				break;
			}
		}
		return false;
	}
	
	public Object createBeanUseDefineConstruce(String className,
			List<Object> args) {
		Class[] argsClass = getArgsClasses(args);
		try {
			Class clazz = Class.forName(className);
			Constructor constructor = findConstructor(clazz, argsClass);
			return constructor.newInstance(args.toArray());
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			throw new BeanCreateException("class not found " + e.getMessage());
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
			throw new BeanCreateException("no such constructor " + e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			throw new BeanCreateException(e.getMessage());
		}
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
	
	/**
	 * �õ�����������
	 * @param args
	 * @return
	 */
	private Class[] getArgsClasses(List<Object> args) {
		List<Class> result = new ArrayList<Class>();
		for (Object arg : args) {
			result.add(getClass(arg));
		}
		Class[] a = new Class[result.size()];
		return result.toArray(a);
	}

}

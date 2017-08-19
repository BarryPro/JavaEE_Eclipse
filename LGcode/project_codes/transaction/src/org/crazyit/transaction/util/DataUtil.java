package org.crazyit.transaction.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;


public class DataUtil {

	//��rs�е�ֵ��װ��һ������
	public static Collection getDatas(Collection result, ResultSet rs, Class clazz) {
		try {
			while (rs.next()) {
				//�������ʵ��
				Object vo = clazz.newInstance();
				//��ȡ�����������
				Field[] fields = clazz.getDeclaredFields();
				//��ȡ���������
				Field[] superFields = clazz.getSuperclass().getDeclaredFields();
				//��������Ժ��Լ����������
				Field[] allFields = addFields(superFields, fields);
				//�������е�����
				for (Field field : allFields) {
					//���setter�����ķ�����
					String setterMethodName = getSetterMethodName(field.getName());
					//���setter����
					Method setterMethod = clazz.getMethod(setterMethodName, field.getType());
					invokeMethod(rs, field, vo, setterMethod);
				}
				result.add(vo);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
			throw new DataException(e.getMessage());
		}
		return result;
	}
	
	//ִ��һ������, ��ResultSet�л�ȡһ���ֶε�����, ����vo��setter����
	private static void invokeMethod(ResultSet rs, Field field, Object vo, 
			Method setterMethod) {
		try {
			//��ʹ��ResultSet��ȡĳ���ֶε�ʱ��, ���û�и��ֶ�, �����SQLException, ��������Ը��쳣
			String value = rs.getString(field.getName());
			if (!"null".equals(value)) {
				//��ResultSet�л�ȡ��ö���������һ�µ��ֶ�, ��ִ��setter����
				setterMethod.invoke(vo, value);
			}
		} catch (Exception e) {
			//�����쳣
		}
	}
	
	//�������������setter�����ķ�����
	private static String getSetterMethodName(String fieldName) {
		String begin = fieldName.substring(0, 1).toUpperCase();
		String end = fieldName.substring(1, fieldName.length());
		String methodName = "set" + begin + end;
		return methodName;
	}
	
	//�����������
	private static Field[] addFields(Field[] f1, Field[] f2) {
		List<Field> l = new ArrayList<Field>();
		for (Field f : f1) l.add(f);
		for (Field f : f2) l.add(f);
		return l.toArray(new Field[f1.length + f2.length]);
	}

}

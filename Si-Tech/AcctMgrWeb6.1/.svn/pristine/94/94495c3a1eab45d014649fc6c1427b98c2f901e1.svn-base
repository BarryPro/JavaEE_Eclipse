package com.sitech.acctmgr.common.utils;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

import com.sitech.common.utils.StringUtils;

/**
 * 给类赋默认值
 * 
 * @author liuhl_bj
 *
 */
public class InstantiationUtils {
	public static Object reflect(Object obj) throws Exception {
		Class<?> cls = Class.forName(obj.getClass().getName());
		Field[] fields = cls.getDeclaredFields();
		for (Field field : fields) {
			field.setAccessible(true);
			if (field.getType().getName().equals(java.lang.String.class.getName())) {
				// 获取方法
				String upperName = field.getName().substring(0, 1).toUpperCase()  
                        + field.getName().substring(1);  
				Method method = cls.getMethod("get" + upperName);
				String value = (String) method.invoke(obj);
				if (StringUtils.isEmptyOrNull(value)) {
					field.set(obj, "");
				}

			}
			
		}
		return obj;
	}

}

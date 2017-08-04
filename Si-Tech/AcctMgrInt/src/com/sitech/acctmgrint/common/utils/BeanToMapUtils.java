/**   
 * File：BigDecimalUtils.java   
 *   
 * Version：   
 * Date：2015-5-20     
 * Copyright Clarify:   
 *   
 */

package com.sitech.acctmgrint.common.utils;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.sitech.common.utils.StringUtils;

/**
 * 名称：实体转化成Map
 * 
 * @author liuhl_bj
 *
 */

public class BeanToMapUtils {

	public static Map<String, Object> beanToMap(Object bean) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			BeanInfo beanInfo = Introspector.getBeanInfo(bean.getClass());
			PropertyDescriptor[] descriptors = beanInfo.getPropertyDescriptors();
			for (PropertyDescriptor des : descriptors) {
				String fieldName = des.getName();

				Method getter = des.getReadMethod();
				Object fieldValue = getter.invoke(bean, new Object[] {});

				if (!fieldName.equalsIgnoreCase("class")) {

					Pattern p = Pattern.compile("[A-Z]");
					Matcher m = p.matcher(fieldName);

					while (m.find()) {
						fieldName = fieldName.replace(m.group(), "_" + m.group());

					}
					// System.err.println(fieldName + ">>>>>>>>>>" + fieldValue);
					if (StringUtils.isNotEmptyOrNull(fieldValue)) {
						result.put(fieldName.toUpperCase(), fieldValue);
					}

				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
}

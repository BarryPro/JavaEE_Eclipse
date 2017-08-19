package org.crazyit.book.service;

import java.util.Collection;

/**
 * �鱾����ҵ��ӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface TypeService {

	/**
	 * �������е�����
	 * @return ��������ֵ���󼯺�
	 */
	Collection<Type> getAll();
	
	/**
	 * ������������ģ����������
	 * @param name ��������
	 * @return ���ҵĽ����
	 */
	Collection<Type> query(String name);
	
	/**
	 * ����һ���鱾����
	 * @param type ��Ҫ�����Ķ���
	 * @return ��������������
	 */
	Type add(Type type);
	
	/**
	 * �޸�һ���鱾����
	 * @param type ��Ҫ�޸ĵĶ���
	 * @return �޸ĺ�Ķ���
	 */
	Type update(Type type);
	
	/**
	 * ������������һ������
	 * @param id
	 * @return
	 */
	Type get(String id);
}

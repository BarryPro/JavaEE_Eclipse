package org.crazyit.book.dao;

import java.util.Collection;

/**
 * �鱾����DAO�ӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface TypeDao {

	/**
	 * �������е�����
	 * @return ����ļ���
	 */
	Collection<Type> find();
	
	/**
	 * ��������ģ����������
	 * @param name ��������
	 * @return
	 */
	Collection<Type> findByName(String name);
	
	/**
	 * ����id��������
	 * @param id ����id
	 * @return �����ֵ����
	 */
	Type find(String id);
	
	/**
	 * ���һ������
	 * @param type ��Ҫ��ӵ�����
	 */
	String add(Type type);
	
	/**
	 * �޸�һ������
	 * @param type �޸ĵ�����
	 */
	String update(Type type);
	
}

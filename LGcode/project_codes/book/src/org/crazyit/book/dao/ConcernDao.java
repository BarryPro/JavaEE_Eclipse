package org.crazyit.book.dao;

import java.util.Collection;

/**
 * ������DAO�ӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface ConcernDao {

	/**
	 * ����ȫ���ĳ�����
	 * @return
	 */
	Collection<Concern> findAll();
	
	/**
	 * ����ID���ҳ�����
	 * @param id
	 * @return
	 */
	Concern find(String id);
	
	/**
	 * ���һ��������
	 * @param concern 
	 * @return
	 */
	String add(Concern concern);
	
	/**
	 * �޸�һ��������
	 * @param concern
	 * @return
	 */
	String update(Concern concern);
	
	/**
	 * ��������ģ�����ҳ�����
	 * @param name
	 * @return
	 */
	Collection<Concern> findByName(String name);
}

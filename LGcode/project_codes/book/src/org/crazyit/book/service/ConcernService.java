package org.crazyit.book.service;

import java.util.Collection;

/**
 * ������ҵ��ӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface ConcernService {

	/**
	 * ��ȡȫ���ĳ�����
	 * @return
	 */
	Collection<Concern> getAll();
	
	/**
	 * ����id����һ��������
	 * @param id ������id
	 * @return
	 */
	Concern find(String id);
	
	/**
	 * ���һ��������
	 * @param c
	 * @return
	 */
	Concern add(Concern c);
	
	/**
	 * �޸�һ��������
	 * @param c
	 * @return
	 */
	Concern update(Concern c);
	
	/**
	 * ���ݳ���������ģ������
	 * @param name
	 * @return
	 */
	Collection<Concern> query(String name);
}

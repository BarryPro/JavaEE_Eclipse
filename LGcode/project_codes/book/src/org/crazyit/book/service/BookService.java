package org.crazyit.book.service;

import java.util.Collection;

/**
 * �鱾ҵ��ӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface BookService {

	/**
	 * ����ȫ������
	 * @return
	 */
	Collection<Book> getAll();
	
	/**
	 * ����id��ȡ��
	 * @param id
	 * @return
	 */
	Book get(String id);
	
	/**
	 * ����һ����
	 * @param book
	 * @return
	 */
	Book add(Book book);
	
	/**
	 * �޸�һ����
	 * @param book
	 * @return
	 */
	Book update(Book book);
	
	/**
	 * ��������ģ����ѯ
	 * @param name
	 * @return
	 */
	Collection<Book> find(String name);
}

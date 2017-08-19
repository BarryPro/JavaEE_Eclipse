package org.crazyit.book.dao;

import java.util.Collection;

/**
 * �鱾DAO�ӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface BookDao {

	/**
	 * ����ȫ�����鱾
	 * @return
	 */
	Collection<Book> findAll();
	
	/**
	 * �����鱾ID��ȡ��
	 * @param id
	 * @return
	 */
	Book find(String id);
	
	/**
	 * ���һ����, ��������Ӻ����id
	 * @param book
	 * @return
	 */
	String add(Book book);
	
	/**
	 * �޸�һ����, �������id
	 * @param book
	 * @return
	 */
	String update(Book book);
	
	/**
	 * ����������ģ��������
	 * @param name
	 * @return
	 */
	Collection<Book> findByName(String name);
	
	/**
	 * �޸���Ŀ��
	 * @param b
	 */
	void updateRepertory(Book b);
	
}

package org.crazyit.book.dao;

import java.util.Collection;

/**
 * ����¼DAO�ӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface InRecordDao {

	/**
	 * �������������������¼
	 * @param begin ��ʼ���ڵ��ַ���
	 * @param end �������ڵ��ַ�
	 * @return
	 */
	Collection<InRecord> findByDate(String begin, String end);
	
	/**
	 * ��������¼id�������¼����
	 * @param id
	 * @return
	 */
	InRecord findById(String id);
	
	/**
	 * ����һ������¼
	 * @param r
	 * @return
	 */
	String save(InRecord r);
}

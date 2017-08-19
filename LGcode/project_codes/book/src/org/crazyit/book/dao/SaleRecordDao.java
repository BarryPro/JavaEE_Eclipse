package org.crazyit.book.dao;

import java.util.Collection;

/**
 * ���ۼ�¼DAO�ӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface SaleRecordDao {

	/**
	 * ������������, ������������֮��Ľ��׼�¼
	 * @param begin ��ʼ���ڵ��ַ���, ��ʽΪyyyy-MM-dd
	 * @param end �������ڵ��ַ���, ��ʽΪyyyy-MM-dd
	 * @return
	 */
	Collection<SaleRecord> findByDate(String begin, String end);
	
	/**
	 * ����id�������ۼ�¼
	 * @param id
	 * @return
	 */
	SaleRecord findById(String id);
	
	/**
	 * ����һ�����ۼ�¼
	 * @param record
	 * @return
	 */
	String save(SaleRecord record);
	
}

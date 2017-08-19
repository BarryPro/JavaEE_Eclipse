package org.crazyit.book.dao;

import java.util.Collection;

/**
 * �鱾���ۼ�¼DAO�ӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface BookSaleRecordDao {

	/**
	 * �������ۼ�¼id��ȡ�����ۼ�¼�����е�������ۼ�¼
	 * @param saleRecordId
	 * @return
	 */
	Collection<BookSaleRecord> findBySaleRecord(String saleRecordId);

	/**
	 * ����һ��������ۼ�¼
	 * @param record
	 * @return
	 */
	String saveBookSaleRecord(BookSaleRecord record);
	
}

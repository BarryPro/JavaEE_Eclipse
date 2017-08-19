package org.crazyit.book.service;

import java.util.Collection;
import java.util.Date;

/**
 * ����ҵ��ӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface SaleRecordService {

	/**
	 * ����һ�����ۼ�¼
	 * @param record
	 */
	void saveRecord(SaleRecord record);
	
	/**
	 * �������ڻ�ȡ�����ڶ�Ӧ�����ۼ�¼
	 * @param date
	 * @return
	 */
	Collection<SaleRecord> getAll(Date date);
	
	/**
	 * ����id��ȡ���ۼ�¼
	 * @param id
	 * @return
	 */
	SaleRecord get(String id);
	
}

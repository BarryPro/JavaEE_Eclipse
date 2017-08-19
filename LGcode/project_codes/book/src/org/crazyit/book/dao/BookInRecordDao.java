package org.crazyit.book.dao;

import java.util.Collection;

/**
 * �鱾����¼DAO�ӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface BookInRecordDao {

	/**
	 * ��������¼����ȫ�����������¼
	 * @param inRecordId
	 * @return
	 */
	Collection<BookInRecord> findByInRecord(String inRecordId);
	
	/**
	 * ����һ���������¼, �����ظü�¼��id
	 * @param r
	 * @return
	 */
	String save(BookInRecord r);
}

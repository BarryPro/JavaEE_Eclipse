package org.crazyit.book.service;

import java.util.Collection;
import java.util.Date;

/**
 * ����¼ҵ��ӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface InRecordService {

	/**
	 * ����һ������¼
	 * @param r
	 */
	void save(InRecord r);
	
	/**
	 * �������ڲ��Ҷ�Ӧ������¼
	 * @param date
	 * @return
	 */
	Collection<InRecord> getAll(Date date);
	
	/**
	 * ����id�������¼
	 * @param id
	 * @return
	 */
	InRecord get(String id);
}

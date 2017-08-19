package org.crazyit.book.dao.impl;

import java.util.Collection;
import java.util.Vector;

/**
 * �鱾���DAOʵ����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class BookInRecordDaoImpl extends CommonDaoImpl implements
		BookInRecordDao {

	@Override
	public Collection<BookInRecord> findByInRecord(String inRecordId) {
		String sql = "SELECT * FROM T_BOOK_IN_RECORD r WHERE r.T_IN_RECORD_ID_FK='" + 
		inRecordId + "'";
		return getDatas(sql, new Vector(), BookInRecord.class);
	}

	@Override
	public String save(BookInRecord r) {
		String sql = "INSERT INTO T_BOOK_IN_RECORD VALUES (ID, '" + r.getBook().getID() + 
		"', '" + r.getT_IN_RECORD_ID_FK() + "', '" + r.getIN_SUM() + "')";
		return String.valueOf(getJDBCExecutor().executeUpdate(sql));

	}

}

package org.crazyit.transaction.dao;

import java.util.List;

public interface LogDao {

	/**
	 * ����һ����־
	 * @param log
	 */
	void save(Log log);
	
	/**
	 * ��������id������־
	 * @param transactionId
	 * @return
	 */
	List<Log> find(String transactionId);
}

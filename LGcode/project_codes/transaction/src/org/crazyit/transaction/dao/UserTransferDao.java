package org.crazyit.transaction.dao;

import java.util.List;

import transaction.src.org.crazyit.transaction.model.UserTransfer;

/**
 * ����ת����¼
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface UserTransferDao {

	/**
	 * ����һ��ת����¼
	 * @param ut
	 */
	void save(UserTransfer ut);
	
	/**
	 * �����û�����ת��������ת����¼
	 * @param userId
	 * @return
	 */
	List<UserTransfer> find(String userId);
}

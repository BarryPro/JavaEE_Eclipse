package org.crazyit.transaction.dao;

import java.util.List;

public interface UserDao {

	/**
	 * �����û�������������û�
	 * @param userName
	 * @param passwd
	 * @return
	 */
	User findUser(String userName, String passwd);
	
	/**
	 * ����ȫ�����û�
	 * @return
	 */
	List<User> findUsers();
	
	/**
	 * �������û�
	 * @param user
	 */
	void save(User user);
	
	/**
	 * �����û��������û�
	 * @param userName
	 * @return
	 */
	User findUser(String userName);
	
	/**
	 * �޸��û�
	 * @param user
	 */
	void delete(String id);
	
	/**
	 * �����û���
	 * @return
	 */
	int getUserCount();
	
	/**
	 * �����û�ģ�������û�
	 * @param userName
	 * @return
	 */
	List<User> query(String realName);
	
	/**
	 * ����ID�����û�
	 * @param id
	 * @return
	 */
	User find(String id);
}

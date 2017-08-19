package org.crazyit.transaction.service;

import java.util.List;

public interface UserService {

	/**
	 * �û���¼
	 * @param userName
	 * @param passwd
	 */
	void login(String userName, String passwd);
	
	/**
	 * ����ȫ�����û�
	 * @return
	 */
	List<User> getUsers();
	
	/**
	 * ���һ���û�
	 * @param user
	 */
	void addUser(User user);
	
	/**
	 * ɾ���û�
	 * @param id
	 */
	void delete(String id);
	
	/**
	 * ��ѯ�û�
	 * @param realName
	 * @return
	 */
	List<User> query(String realName);
}

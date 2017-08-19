package org.crazyit.transaction.dao;

import java.util.List;

public interface RoleDao {

	/**
	 * ����ID���ҽ�ɫ
	 * @param id
	 * @return
	 */
	Role find(String id);
	
	/**
	 * ����ȫ���Ľ�ɫ
	 * @return
	 */
	List<Role> findRoles();
}

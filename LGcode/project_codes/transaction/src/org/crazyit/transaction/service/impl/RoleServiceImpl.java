package org.crazyit.transaction.service.impl;

import java.util.List;

import transaction.src.org.crazyit.transaction.dao.RoleDao;
import transaction.src.org.crazyit.transaction.service.RoleService;

public class RoleServiceImpl implements RoleService {

	private RoleDao roleDao;
	
	public RoleServiceImpl(RoleDao roleDao) {
		this.roleDao = roleDao;
	}

	public List<Role> getRoles() {
		return this.roleDao.findRoles();
	}
	
	
}

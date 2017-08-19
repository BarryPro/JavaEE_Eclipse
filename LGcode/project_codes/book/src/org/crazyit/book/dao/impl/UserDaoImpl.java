package org.crazyit.book.dao.impl;

import java.util.ArrayList;
import java.util.List;

/**
 * �û�DAOʵ����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class UserDaoImpl extends CommonDaoImpl implements UserDao {

	@Override
	public User getUser(String name, String password) {
		String sql = "SELECT * FROM T_USER user WHERE user.USER_NAME='" + name + "' and user.USER_PASSWORD='" + 
		password + "'";
		List<User> datas = (List<User>)getDatas(sql, new ArrayList(), User.class);
		return (datas.size() == 1) ? datas.get(0) : null;
	}

}

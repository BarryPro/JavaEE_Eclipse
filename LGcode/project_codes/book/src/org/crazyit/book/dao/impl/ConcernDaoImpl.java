package org.crazyit.book.dao.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Vector;

/**
 * ������DAOʵ����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class ConcernDaoImpl extends CommonDaoImpl implements ConcernDao {

	@Override
	public String add(Concern c) {
		//���ó��������ƴװSQL
		String sql = "INSERT INTO T_PUBLISHER VALUES (ID, '" + 
		c.getPUB_NAME() + "', '" + c.getPUB_TEL() + "', '" + c.getPUB_LINK_MAN() + 
		"', '" + c.getPUB_INTRO() + "')";
		//����JDBCExecutor��executeUpdate�����������������ݵ�����
		String id = String.valueOf(getJDBCExecutor().executeUpdate(sql));
		return id;
	}

	@Override
	public Concern find(String id) {
		String sql = "SELECT * FROM T_PUBLISHER pub WHERE pub.ID = '" + id + "'";
		List<Concern> datas = (List<Concern>)getDatas(sql, new ArrayList(), Concern.class);
		return (datas.size() == 1) ? datas.get(0) : null;
	}

	@Override
	public Collection<Concern> findAll() {
		String sql = "SELECT * FROM T_PUBLISHER pub ORDER BY pub.ID DESC";
		return getDatas(sql, new Vector(), Concern.class);
	}

	@Override
	public String update(Concern c) {
		String sql = "UPDATE T_PUBLISHER pub SET pub.PUB_NAME='" + c.getPUB_NAME() + 
		"', pub.PUB_TEL='" + c.getPUB_TEL() + "', pub.PUB_LINK_MAN='" + c.getPUB_LINK_MAN() + 
		"', pub.PUB_INTRO='" + c.getPUB_INTRO() + "' WHERE pub.ID='" + c.getID() + "'";
		getJDBCExecutor().executeUpdate(sql);
		return c.getID();
	}

	@Override
	public Collection<Concern> findByName(String name) {
		String sql = "SELECT * FROM T_PUBLISHER pub WHERE pub.PUB_NAME like '%" + 
		name + "%' ORDER BY pub.ID DESC";
		return getDatas(sql, new Vector(), Concern.class);
	}

	
}

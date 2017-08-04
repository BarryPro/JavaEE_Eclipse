package com.sitech.acctmgrint.atom.busi.intface.comm;

import com.sitech.acctmgrint.common.BaseBusi;
import com.sitech.jcf.core.SessionContext;
import com.sitech.jcf.ijdbc.SqlBasic;
import com.sitech.jcf.ijdbc.SqlChange;
import com.sitech.jcf.ijdbc.SqlFind;
import com.sitech.jcf.ijdbc.sql.SqlParameter;
import com.sitech.jcf.ijdbc.sql.SqlTypes;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Title 使用JDBC操作数据库类
 * @Description:使用JDBC操作数据库，支持长连接。
 * @author KONGLJ
 * @date 20150327
 * @mod  20150807
 */
public class JdbcConn extends BaseBusi {
	
	private SqlChange    sqlChange;
	private SqlFind      sqlFind;
	private SqlBasic     sqlBasic;
	private boolean      selectFlag;//区分是查询还是更新
	private Connection   connection;
	private String       sqlBuffer;
	
	/*-------------
	 JdbcConn用例：
		//初始化
		JdbcConn jc = new JdbcConn(baseDao.getConnection());
		//查询一次
		jc.setSqlBuffer("select phone_no from ur_user_info where id_no = ?");
		jc.addParam("ID_NO", "220191000000005907");
		List<Map<String, Object>> list = jc.select();//NO COMMIT
		System.out.println("-----------1-------list[0]="+list.get(0));
		//查询二次
		jc.setSqlBuffer("select id_no from ur_user_info where phone_no = ?");
		jc.addParam("PHONE_NO", "18962000008");
		list = jc.select();
		System.out.println("-----------2-------list[0]="+list.get(0));
		//执行删除操作
		jc.setSqlBuffer("update ur_userdead_info set open_time = sysdate where id_no = ?");
		jc.addParam("ID_NO", "220420120018096200", SqlTypes.JLONG);
		int ret_exec = jc.execuse();
		System.out.println("-----------3-------ret_exec="+ret_exec);
		//执行二次删除操作
		jc.setSqlBuffer("update ur_userdead_info set open_time = sysdate where id_no = ?");
		jc.addParam("ID_NO", "220480200001319800");
		ret_exec = jc.execuse();
		System.out.println("-----------4-------ret_exec="+ret_exec);
	 -------------*/
	
	public JdbcConn() {
		setSqlBasic(null);
		setSqlChange(new SqlChange());
		setSqlFind(new SqlFind());
		setSqlBuffer(null);
		setConnection(baseDao.getConnection());
	}
	
	public JdbcConn(Connection conn) {
		setSqlBasic(null);
		setSqlBuffer(null);
		setSqlChange(new SqlChange());
		setSqlFind(new SqlFind());
		setConnection(conn);
	}
	
	/**
	 * Title 构造方法
	 * @param sDbid 数据库标识，目前只支持A1/A2
	 */
	public JdbcConn(String sDbid) {
		setSqlBasic(null);
		setSqlFind(new SqlFind());
		setSqlChange(new SqlChange());
		setSqlBuffer(null);

		//获取数据库连接
		SessionContext.setDbLabel(sDbid);
		setConnection(baseDao.getConnection());
	}
	
	/**
	 * Title  执行Insert/Update/Delete操作的Sql语句
	 * @description 执行Insert/Update/Delete操作，返回操作行数
	 * @param sqlBuffer
	 * @param sqlChange
	 * @return
	 */
	public int execuse() {
		
		int iRow = 0;
		if (sqlBuffer.length() == 0) {
			System.out.println("JdbcConn:sqlBuffer 是空的，请先赋值执行的语句模板！");
			return iRow;
		}
		if (sqlChange == null) {
			System.out.println("JdbcConn:sqlChange 是空的，请先赋值！");
			return iRow;
		}
		try {
			/*执行 sSqlDataBuf 处理数据*/
			/*获得DB_ID和配置数据源的映射关系*/
			iRow = sqlChange.execute(connection, sqlBuffer);
			System.out.println("--EXECUTE--操作数据["+iRow+"]行.");
			
		} catch(Exception e){
			System.out.println("----execute the sqlbuffer error,please check!----");
			//执行语句若报错，为联调问题，暂不记录异常
			
			e.printStackTrace();
		}
		
		return iRow;
	}
	
	/**
	 * Title  执行Select型Sql语句
	 * Description 注意：Sql语句必须是拼装好的。
	 * @param inQrySql
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> select() {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			sqlFind.setListElementAsMap(true);
			list = sqlFind.findList(connection, sqlBuffer);
			
		} catch(Exception e){
			this.close();
			e.printStackTrace();
			return null;
		}
		
		return list;
	}
	
	public void commit() {
		try {
			connection.commit();
		} catch (SQLException e) {
			System.out.println("JdbcConn:connection commit error,please check it!");
			e.printStackTrace();
		}
	}
	
	public void close() {
		try {
			if (!connection.isClosed()) {
				connection.close();
			}
		} catch (SQLException e) {
			System.out.println("JdbcConn:connection close error,please check it!");
			e.printStackTrace();
		}
	}
	
	public int execAndComm() {
		int i = execuse();
		commit();
		return i;
	}
	
	public void setAutoCommit(Boolean bcomm) {
		try {
			connection.setAutoCommit(bcomm);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * Title 插入参数，注意顺序
	 * @param Key
	 * @param SqlTypes 使用Jdbc框架SqlTypes定义，如SqlTypes.VARCHAR
	 * @param KeyVal
	 */
	public void addParam(String Key, int SqlTypes, String keyVal) {
		if (isSelectFlag())
			setSqlBasic(sqlFind);
		else
			setSqlBasic(sqlChange);
		sqlBasic.addParam(new SqlParameter(Key, SqlTypes, keyVal));
	}

	/**
	 * 按顺序绑定参数，默认String型参数
	 * @param keyName
	 * @param keyValue
	 */
	public void addParam(String keyName,String keyValue) {
		if (isSelectFlag())
			setSqlBasic(sqlFind);
		else
			setSqlBasic(sqlChange);
		sqlBasic.addParam(new SqlParameter(keyName, SqlTypes.JSTRING, keyValue));
	}
	
	/**
	 * 按顺序绑定参数，注意一定要按照顺序绑定
	 * @param keyName 参数名
	 * @param keyValue 参数值
	 * @param keyType 建议只取 SqlTypes.JSTRING/JLONG/DATE/JINT/JDOUBLE/BLOB，其他默认String
	 */
	public void addParam(String keyName,String keyValue, int sqlTypes) {
		//设置操作类型
		if (isSelectFlag())
			setSqlBasic(sqlFind);
		else
			setSqlBasic(sqlChange);
		
		if (SqlTypes.JLONG == sqlTypes) {
			sqlBasic.addParam(new SqlParameter(keyName, SqlTypes.JLONG, Long.parseLong(keyValue)));
		} else if (SqlTypes.DATE == sqlTypes) {
			try {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				Date date = sdf.parse(keyValue);
				sqlBasic.addParam(new SqlParameter(keyName, SqlTypes.DATE, date));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		} else if (SqlTypes.JINT == sqlTypes) {
			sqlBasic.addParam(new SqlParameter(keyName, SqlTypes.JINT, Integer.parseInt(keyValue)));
		} else if (SqlTypes.JDOUBLE == sqlTypes) {
			sqlBasic.addParam(new SqlParameter(keyName, SqlTypes.JDOUBLE, Double.parseDouble(keyValue)));
		}else if (SqlTypes.BLOB == sqlTypes) {
			sqlBasic.addParam(new SqlParameter(keyName, SqlTypes.BLOB, keyValue.getBytes()));
		} else {
			sqlBasic.addParam(new SqlParameter(keyName, SqlTypes.JSTRING, keyValue));
		}
	}
	
	public Connection getConnection() {
		return connection;
	}

	public void setConnection(Connection connection) {
		this.connection = connection;
	}

	public void initSqlChg() {
		setSqlChange(new SqlChange());
	}

	/**
	 * 设置语句模板
	 * @param sqlBuffer
	 */
	public void setSqlBuffer(String sqlBuffer) {
		if (null == sqlBuffer)
			return ;
		judgeSelectFlag(sqlBuffer);
		this.sqlBuffer = sqlBuffer;
	}
	/************************private function************************/
	/**
	 * 判断语句类型，并重置sqlFind/sqlChange
	 * @param sqlBuffer
	 * @return
	 */
	private boolean judgeSelectFlag(String sqlBuffer) {
		if (0 == sqlBuffer.trim().toLowerCase().indexOf("select ")) {
			sqlFind.reset();
			setSelectFlag(true);
			return true;
		} else {
			sqlChange.reset();
			setSelectFlag(false);
			return false;
		}
	}

	public String getSqlBuffer() {
		return sqlBuffer;
	}
	
	private SqlChange getSqlChange() {
		return sqlChange;
	}

	private void setSqlChange(SqlChange sqlChange) {
		this.sqlChange = sqlChange;
	}
	
	private SqlFind getSqlFind() {
		return sqlFind;
	}

	private void setSqlFind(SqlFind sqlFind) {
		this.sqlFind = sqlFind;
	}

	private boolean isSelectFlag() {
		return selectFlag;
	}

	private void setSelectFlag(boolean selectFlag) {
		this.selectFlag = selectFlag;
	}

	private SqlBasic getSqlBasic() {
		return sqlBasic;
	}

	private void setSqlBasic(SqlBasic sqlBasic) {
		this.sqlBasic = sqlBasic;
	}
	
}

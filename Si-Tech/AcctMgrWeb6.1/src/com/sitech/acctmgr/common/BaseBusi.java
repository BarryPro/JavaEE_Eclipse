package com.sitech.acctmgr.common;

import com.sitech.jcf.core.dao.IBaseDao;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
*
* <p>Title: 实体层基类</p>
* <p>Description: 实体层基类，封装dao句柄、日志句柄、错误码等功能</p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author zhangjp
* @version 1.0
*/
public abstract class BaseBusi {

	protected Logger log = LoggerFactory.getLogger(this.getClass());
	protected IBaseDao baseDao;
	
	/**
	 * @param baseDao
	 *            the baseDao to set
	 */
	public void setBaseDao(IBaseDao baseDao){
		String packageName = this.getClass().getPackage().getName();
		//使用StringUtils.split性能更高
		String[] str = StringUtils.split(packageName, "\\.");
		if(str[3].equals("atom") || str[3].equals("app")){
			this.baseDao = baseDao;
		}
	}

	public IBaseDao getBaseDao() {
		return baseDao;
	}
	
	
}

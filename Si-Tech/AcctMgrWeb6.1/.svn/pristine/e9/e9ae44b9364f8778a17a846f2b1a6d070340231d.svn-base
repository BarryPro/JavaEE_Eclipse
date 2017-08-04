package com.sitech.acctmgr.atom.entity.inter;

import com.sitech.acctmgr.atom.domains.base.LoginEntity;

/**
 *
 * <p>
 * Title: 工号类
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author zhangjp
 * @version 1.0
 */
public interface ILogin {

	/**
	 * 获取工号信息
	 * 
	 * @param sLoginNo
	 *            : 工号<br/>
	 * @param provinceId
	 *            : 省份代码<br/>
	 * @return GROUP_ID : 工号归属group_id<br/>
	 *         LOGIN_NAME : 工号名称<br/>
	 *         LOGIN_TYPE : 0：CRM 1：客服 2：服务开通 3：ESOP<br/>
	 *         POWER_RIGHT : 工号级别<br/>
	 *         LOGIN_PASSWORD
	 * @throws Exception
	 * @author qiaolin
	 * @version 1.0
	 */
	LoginEntity getLoginInfo(String sLoginNo, String provinceId);

	/**
	 * 获取工号信息
	 * 
	 * @param sLoginNo
	 * @param provinceId
	 * @param flag
	 *            true:表示查询错误时抛出异常
	 * @return
	 */
	LoginEntity getLoginInfo(String sLoginNo, String provinceId, boolean flag);

	/**
	 * 获取工号归属地市(供发票使用)
	 * 
	 * @author liuhl_bj
	 * @param loginNo
	 * @param provinceId
	 * @return
	 */
	String getRegionCode(String loginNo, String provinceId);

}
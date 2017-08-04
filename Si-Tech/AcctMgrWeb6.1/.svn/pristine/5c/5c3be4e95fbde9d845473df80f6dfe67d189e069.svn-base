package com.sitech.acctmgr.atom.entity.inter;

import java.util.List;

import com.sitech.acctmgr.atom.domains.query.RemindOpenEntity;

public interface IRemind {

	/**
	 * @Description 80%短信提醒权限判断，count>0,表示有权限，count=0，无权限
	 * @param phoneNo
	 * @return
	 */
	public int queryShortRemindAuth(String phoneNo);

	public List<RemindOpenEntity> queryRemindOpenOrOff(String phoneNo);

	/**
	 * 查询用户的余额提醒阀值
	 * 
	 * @param idNo
	 * @param awokeDay
	 * @param validFlag
	 * @return
	 */
	long qryAwokeFee(long idNo, int awokeDay, String validFlag);

}

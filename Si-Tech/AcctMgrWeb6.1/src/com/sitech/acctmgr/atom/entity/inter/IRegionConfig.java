package com.sitech.acctmgr.atom.entity.inter;

import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.balance.MkYxzfactEntity;
import com.sitech.acctmgr.atom.domains.balance.SignAutoPayEntity;
import com.sitech.acctmgr.atom.domains.base.LoginBaseEntity;
import com.sitech.acctmgr.atom.domains.pay.UserSignInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;

/**
 * @Description: 检测地市配置记录
 * @author: hanfule
 * @version:
 * @createTime: 2016-1-22 下午14:46:18
 */
public interface IRegionConfig {


	/**
	* 名称：判断地市是否有配置记录
	* @param  regionCode 地市
	* @param  opCode opCode
	* @return 
	*/
	public boolean isRegion(String regionCode,String opCode);

	/**
	 * 名称：地市
	 * 
	 * @author hanfule
	 */
	Integer saveMkYxzfact(MkYxzfactEntity mkyxz);

	/**
	 * 名称：查询地市配置信息
	 */
	public List<MkYxzfactEntity> getMkYxzfactInfo(String workNo,String regionCode,String provinceId);
	
	
	/**
	 * 名称：删除表中对应数据
	 */
	public abstract boolean deleteMkYxzfactInfo(String loginNo,String regionCode,String opCode,Long loginAccept);

}

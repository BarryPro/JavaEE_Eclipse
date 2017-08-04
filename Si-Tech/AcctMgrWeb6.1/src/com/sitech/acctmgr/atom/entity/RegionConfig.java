package com.sitech.acctmgr.atom.entity;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.domains.balance.MkYxzfactEntity;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.pay.UserSignInfoEntity;
import com.sitech.acctmgr.atom.domains.query.GroupInfoEntity;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IRegionConfig;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.common.utils.StringUtils;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class RegionConfig extends BaseBusi implements IRegionConfig {
	
	 private IGroup group;
	    private ILogin login;
	    private IControl control;

	@Override
	public boolean isRegion(String regionCode, String opCode) {
		Map<String , Object> inMap = new HashMap<String, Object>();
		inMap.put("REGION_CODE", regionCode);
		inMap.put("OP_CODE", opCode);
		Integer result = (Integer) baseDao.queryForObject("bal_mk_yxzfact.qCnt", inMap);
		if(result != null && result >0){
			return true;
		}
		return false;
	}

	@Override
	public Integer saveMkYxzfact(MkYxzfactEntity mkyxz) {
		Integer result = (Integer)baseDao.insert("bal_mk_yxzfact.inMkYxzfact",mkyxz);
		return result;
	}

	@Override
	public List<MkYxzfactEntity> getMkYxzfactInfo(String workNo, String regionCode,String provinceId) {

		Map<String, Object> inMap = new HashMap<String, Object>();
		
	    if (StringUtils.isNotEmpty(workNo)) {
            safeAddToMap(inMap, "WORK_NO", workNo);
        }
	    if (StringUtils.isNotEmpty(regionCode)) {
            safeAddToMap(inMap, "REGION_CODE", regionCode);
        }
		inMap.put("PROVINCE_ID", provinceId);
		
		List<MkYxzfactEntity>  list = (List<MkYxzfactEntity>)baseDao.queryForList("bal_mk_yxzfact.qMkYxzfactInfo", inMap);
		
		return list;
	}

	@Override
	public boolean deleteMkYxzfactInfo(String loginNo, String regionCode, String opCode,Long loginAccept) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("LOGIN_NO", loginNo);
		inMap.put("REGION_CODE", regionCode);
		inMap.put("OP_CODE", opCode);
		//baseDao.insert("bal_signautopay_his.iAutoPayHis", inMap);
		
		Map<String, Object> delMap = new HashMap<String, Object>();
		delMap.put("LOGIN_NO", loginNo);
		delMap.put("REGION_CODE", regionCode);
		delMap.put("OP_CODE", opCode);
		delMap.put("LOGIN_ACCEPT", loginAccept);
		baseDao.delete("bal_mk_yxzfact.delMkYxzfactInfo", delMap);
		
		return true;
	}

	/**
	 * @return the group
	 */
	public IGroup getGroup() {
		return group;
	}

	/**
	 * @return the login
	 */
	public ILogin getLogin() {
		return login;
	}

	/**
	 * @return the control
	 */
	public IControl getControl() {
		return control;
	}

	/**
	 * @param group the group to set
	 */
	public void setGroup(IGroup group) {
		this.group = group;
	}

	/**
	 * @param login the login to set
	 */
	public void setLogin(ILogin login) {
		this.login = login;
	}

	/**
	 * @param control the control to set
	 */
	public void setControl(IControl control) {
		this.control = control;
	}
	
	

	
}

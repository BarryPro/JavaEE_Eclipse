package com.sitech.acctmgr.atom.entity.hlj;

import com.sitech.acctmgr.atom.entity.Agent;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.util.DateUtil;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class AgentHLJ extends Agent{

	
	public boolean isKcAgentPhone(String phoneNo, String contractNo){
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("PHONE_NO", phoneNo);
		inMap.put("CONTRACT_NO", contractNo);
		int cnt = (Integer)baseDao.queryForObject("dagtbasemsg.qCnt", inMap);
		if(cnt > 0){
			return true;
		}else{
			return false;
		}
	}


	
	/**
	 * 	EXEC SQL SELECT a.contract_no,b.group_name,b.group_id,b.is_active
		INTO   :tContract_No,:vAgtName,:vGroupId,:vIsActive
		FROM   dAgtBaseMsg a,dChnGroupMsg b
		WHERE  a.agt_phone=:iAgt_Phone
			and a.status='Y'
	    AND a.agt_id=b.group_id;
	 * */
	public Map<String, Object> getAgentInfo(String phoneNo){
		
		return null;
	};
	

	public Map<String, Object> getDistrictAgentList(String districtGroupId, int pageNum , String provinceId, String flag){
		
        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("PROVINCE_ID", provinceId);
        inMap.put("DISTRICT_GROUPID", districtGroupId);
        if(flag.equals("1")){
        	 inMap.put("NOT_AGENTCHECK", "NOT");
        }
        Map<String, Object> outMap = baseDao.queryForPagingList("dagtbasemsg.qryByGroupId", inMap, pageNum, 20);
        return outMap;
	}
	
}

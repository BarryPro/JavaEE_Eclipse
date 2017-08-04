package com.sitech.acctmgr.atom.impl.query;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.query.FeiDouQryEntity;
import com.sitech.acctmgr.atom.dto.query.S8073QryInfoInDTO;
import com.sitech.acctmgr.atom.dto.query.S8073QryInfoOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAdj;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.query.I8073;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;


@ParamTypes({ @ParamType(m = "qryInfo", c = S8073QryInfoInDTO.class, oc = S8073QryInfoOutDTO.class)})
public class S8073 extends AcctMgrBaseService 
							implements I8073{
	
	private IAdj adj;
	

	@Override
	public OutDTO qryInfo(InDTO inParam) {
		// TODO Auto-generated method stub
		
		S8073QryInfoInDTO inDto = (S8073QryInfoInDTO)inParam;
		
		String phoneNo = inDto.getPhoneNo();
		String beginTime = inDto.getBeginTime();
		String endTime = inDto.getEndTime();
		
		/* 取用户办理飞豆业务信息 */
		Map<String, Object> inCfmMap = new HashMap<String, Object>();
		List<FeiDouQryEntity>  feiDouList = new ArrayList<FeiDouQryEntity>();
		inCfmMap.put("PHONE_NO", phoneNo);
		inCfmMap.put("BEGIN_TIME", beginTime);
		inCfmMap.put("END_TIME", endTime);
		//1为飞豆记录历史表，0为飞豆记录表
		inCfmMap.put("STATUS", "0");
		
		List<Map<String, Object>> mapList= adj.queryFDBusiRecd(inCfmMap);
		for(Map<String, Object> outCfmMap:mapList){
			String opTime = outCfmMap.get("OP_TIME").toString();
			String outPhoneNo = outCfmMap.get("PHONE_NO").toString();
			long chargeSum = Long.valueOf(outCfmMap.get("CHARGE_SUM").toString());
			FeiDouQryEntity feiDouEnt = new FeiDouQryEntity();
			feiDouEnt.setChargeSum(chargeSum);
			feiDouEnt.setPhoneNo(outPhoneNo);
			feiDouEnt.setOpTime(opTime);
			feiDouList.add(feiDouEnt);
		}
		
		S8073QryInfoOutDTO outDto = new  S8073QryInfoOutDTO();
		outDto.setLenFeiDouList(feiDouList.size());
		outDto.setFeiDouList(feiDouList);
		return outDto;
	}


	public IAdj getAdj() {
		return adj;
	}


	public void setAdj(IAdj adj) {
		this.adj = adj;
	}
	
	

}

package com.sitech.acctmgr.comp.impl.query;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.eclipse.jetty.util.log.Log;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.sitech.acctmgr.atom.domains.balance.ActEntity;
import com.sitech.acctmgr.atom.domains.balance.ImeiFileMsgInfoEntity;
import com.sitech.acctmgr.atom.dto.query.S8430CompQueryInDTO;
import com.sitech.acctmgr.atom.dto.query.S8430CompQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.query.I8430Co;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.service.client.ServiceUtil;
import com.sitech.jcfx.util.DateUtil;


@ParamTypes({ 
	@ParamType(c = S8430CompQueryInDTO.class,oc=S8430CompQueryOutDTO.class, m = "query")
	})
public class S8430Comp extends AcctMgrBaseService implements I8430Co {
	
	private IUser user;

	@Override
	public OutDTO query(InDTO inParam) {
		// 获取入参信息
		S8430CompQueryInDTO inDto = (S8430CompQueryInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		String startMonth = inDto.getStartMonth();
		String endMonth = inDto.getEndMonth();
		
		
		String sCurDate = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String sCurYm = sCurDate.substring(0, 6);
		
		if(Integer.parseInt(startMonth) > Integer.parseInt(sCurYm) 
				|| Integer.parseInt(endMonth) > Integer.parseInt(sCurYm)){
			log.debug("当前年月：" +sCurYm +"开始年月："+startMonth + "结束年月："+endMonth);
			throw new BusiException(AcctMgrError.getErrorCode("8430", "00001"), "查询月份不可超过当月!" );
		}
		
		String lastMonth = DateUtil.toStringPlusMonths(sCurYm, -6,"yyyyMM");
		
		if(Integer.parseInt(lastMonth) > Integer.parseInt(startMonth)){
			throw new BusiException(AcctMgrError.getErrorCode("8430", "00002"), "只允许查询六个月内 的信息!" );
		}
		
		String opType  = "5"; 
		MBean inMbean = new MBean(inDto.getMbean().toString());
		
		inMbean.addBody("BUSI_INFO.OP_TYPE",opType);
		
		String interfaceName = "com_sitech_market_comp_inter_IChnMktActOrderSvc_mktOrderQry";
		
		String outString = ServiceUtil.callService(interfaceName, inMbean.toString());
		
		Log.debug("用户号码的营销案办理情况查询完成:" + outString);
		
		MBean mb = new MBean(outString);
		
		String jsonStr = JSON.toJSONString(mb.getBodyObject("OUT_DATA"));
		JSONObject bodyJson = (JSONObject) JSONObject.parse(jsonStr);
		
		List<ActEntity> infoList = new  ArrayList<ActEntity>();
		Map<String ,Object> actMap = bodyJson;
		List<Map<String,Object>> list =  (List<Map<String, Object>>) actMap.get("ACT_LIST");
		
		for (Map<String ,Object> map : list) {
	
			Map<String ,Object > map1 = (Map<String, Object>) map.get("ACT_INFO");
			String jsonMap =JSON.toJSONString(map1);
			infoList.add(JSON.parseObject(jsonMap, ActEntity.class));
		}
		log.debug("infoList" + infoList.toString());
		
		List<ImeiFileMsgInfoEntity> imeiFileMsgInfoList =  user.getImeiFileMsgInfo(phoneNo, startMonth, endMonth);
		
		String unPackTypeFlag = "";
		String phone1 = "";
		String phone2 = "";
		String opCode = "";
		
		for(ImeiFileMsgInfoEntity imeiFileMsgInfoEnt: imeiFileMsgInfoList ){
			unPackTypeFlag = imeiFileMsgInfoEnt.getUnpackTypeFlag();
			phone1 = imeiFileMsgInfoEnt.getPhone1();
			phone2 = imeiFileMsgInfoEnt.getPhone2();
			opCode = imeiFileMsgInfoEnt.getOpCode();
			
			if("0".equals(unPackTypeFlag)){
				imeiFileMsgInfoEnt.setUnPackTypeFlagValue("拆包");
			}else{
				imeiFileMsgInfoEnt.setUnPackTypeFlagValue("刷码");
			}
			
			if(!"0".equals(phone1)){
				phone1 = phone1.substring(0, 3)+"****"+phone1.substring(7);
				imeiFileMsgInfoEnt.setPhone1(phone1);
			}
			log.debug("电话号码1："+phone1);
			
			if(!"0".equals(phone2)){
				phone2 = phone2.substring(0, 3)+"****"+phone2.substring(7);
				imeiFileMsgInfoEnt.setPhone2(phone2);	
			}
			log.debug("电话号码2："+phone2);
			
			if(opCode.length() > 4 ){
				imeiFileMsgInfoEnt.setOpName("营销管理平台终端营销案");		
				}
			if("9999".equals(opCode)){
				imeiFileMsgInfoEnt.setOpName("二码合一");	
				}
			imeiFileMsgInfoEnt.setPhoneNo(phoneNo);
		}
		
		S8430CompQueryOutDTO outDto =new S8430CompQueryOutDTO();
		outDto.setActList(infoList);
		outDto.setImeiFileMsgList(imeiFileMsgInfoList);
		return outDto;
	}

	/**
	 * @return the user
	 */
	public IUser getUser() {
		return user;
	}

	/**
	 * @param user the user to set
	 */
	public void setUser(IUser user) {
		this.user = user;
	}

	
}

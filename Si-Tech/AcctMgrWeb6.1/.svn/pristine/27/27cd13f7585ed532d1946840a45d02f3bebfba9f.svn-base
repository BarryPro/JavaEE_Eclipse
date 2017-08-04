package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.domains.user.FamilyEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * <p>Title: 家庭业务缴费用户信息查询出参DTO  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8000FamilyQueryOutDTO extends CommonOutDTO{

	private static final long serialVersionUID = 1602506002335626468L;

	@ParamDesc(path="CNT",cons=ConsType.CT001,type="long",len="10",desc="家庭用户链表个数",memo="略")
	protected int iCnt;
	
	@ParamDesc(path="USERINFO_LIST",cons=ConsType.QUES,type="compx",len="1",desc="家庭成员信息",memo="略")
	private	List<FamilyEntity> userInfoList = new ArrayList<FamilyEntity>();
	
	public S8000FamilyQueryOutDTO(){

	}
	
	public S8000FamilyQueryOutDTO(String sJson){
		MBean mBean = new MBean(sJson);
		this.iCnt = mBean.getBodyInt("OUT_DATA.CNT");
		List<Map<String, Object>> userInfo = (List<Map<String, Object>>)mBean.getBodyList("OUT_DATA.USERINFO_LIST");
		for(Map<String, Object> mapTmp : userInfo){
			String jsonStr = JSON.toJSONString(mapTmp);
			this.userInfoList.add(JSON.parseObject(jsonStr, FamilyEntity.class));
		}
	}
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setBody("CNT", iCnt);
		result.setBody("USERINFO_LIST", userInfoList);
		return result;
	}

	
	
	/**
	 * @return the iCnt
	 */
	public int getiCnt() {
		return iCnt;
	}

	/**
	 * @param iCnt the iCnt to set
	 */
	public void setiCnt(int iCnt) {
		this.iCnt = iCnt;
	}

	/**
	 * @return the userInfoList
	 */
	public List<FamilyEntity> getUserInfoList() {
		return userInfoList;
	}

	/**
	 * @param userInfoList the userInfoList to set
	 */
	public void setUserInfoList(List<FamilyEntity> userInfoList) {
		this.userInfoList = userInfoList;
	}

}

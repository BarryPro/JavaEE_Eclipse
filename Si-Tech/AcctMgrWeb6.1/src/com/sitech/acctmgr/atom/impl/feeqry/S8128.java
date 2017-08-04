package com.sitech.acctmgr.atom.impl.feeqry;

import com.sitech.acctmgr.atom.domains.query.Query8128Entity;
import com.sitech.acctmgr.atom.domains.user.ExpireOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserExpireEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.feeqry.S8128QueryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S8128QueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBase;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.feeqry.I8128;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ParamTypes({ @ParamType(c = S8128QueryInDTO.class, oc = S8128QueryOutDTO.class, m = "query") })
public class S8128 implements I8128 {

	protected IUser user; // 用户在网信息
	protected IBase base;

	@Override
	public OutDTO query(InDTO inParam) {
		Map<String,Object> inMap = null;
		Map<String,Object> outMap = null;
		List <Query8128Entity> queryList = new ArrayList<Query8128Entity>();
		
		String sPhoneNo = "";
		
		//入参
		S8128QueryInDTO inParamDto = (S8128QueryInDTO) inParam;
		sPhoneNo = inParamDto.getPhoneNo();
		
		//取id,开户时间
		long lIdNo = 0;
		String sOpenTime = "";
		UserInfoEntity uie = user.getUserInfo(sPhoneNo);
		lIdNo = uie.getIdNo();
		sOpenTime = uie.getOpenTime();
		
		//检查用户是有效期用户
		if(!user.isUserExpire(lIdNo, 0)) {
			throw new BusiException(AcctMgrError.getErrorCode("8243","00002"), "用户不是有效期用户，无法进行业务操作！");
		}
				
		//根据id，取用户有效期表,上次到期时间,到期时间,用户所属期限（到期天数）
		String sOldExpire = "";
		String sExpireTime = "";
		int iDays = 0;
		UserExpireEntity uee = user.getUserExpireInfo(lIdNo);
		sOldExpire = uee.getOldExpire();
		sExpireTime = uee.getExpireTime();
		iDays = Integer.parseInt(uee.getExpireDays());
		
		
		List<ExpireOprEntity> userList = new ArrayList<ExpireOprEntity>();		
		userList = user.getExpireOprList(lIdNo);
		
		for(ExpireOprEntity tempEnity : userList ){
					
			//根据id，取用户变更记录表，取延长时间，操作功能名称（通过op_code），操作工号，操作时间，操作备注
			int iDays1 = 0;
			String sOpCode = "";
			String sLoginNo = "";
			String sOpTime = "";
			String sRemark = "";			
			
			iDays1 = tempEnity.getDays();
			sOpCode = tempEnity.getOpCode();
			sLoginNo = tempEnity.getLoginNo();
			sOpTime = tempEnity.getOpTime();
			sRemark = tempEnity.getRemark();
			
			//如果延长天数小于0，则跳过
			if(iDays1 < 0 ) {
				continue;
			}
					
			String funcName = base.getFunctionName(sOpCode);
				
			Query8128Entity query8128 = new Query8128Entity();
			query8128.setDays(iDays1);
			query8128.setFunctionName(funcName);
			query8128.setLoginNo(sLoginNo);
			query8128.setOpTime(sOpTime);
			query8128.setRemark(sRemark);
			queryList.add(query8128);
			
		}
				
		S8128QueryOutDTO outParamDto = new S8128QueryOutDTO();
		outParamDto.setPhoneNo(sPhoneNo);
		outParamDto.setFinishFlag("Y");
		outParamDto.setStatus("有效期");
		outParamDto.setOldExpire(sOldExpire);
		outParamDto.setExpireTime(sExpireTime);
		outParamDto.setOpTime(sOpenTime);
		outParamDto.setDays(iDays);
		outParamDto.setOutParamList(queryList);
		return outParamDto;
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

	/**
	 * @return the base
	 */
	public IBase getBase() {
		return base;
	}

	/**
	 * @param base the base to set
	 */
	public void setBase(IBase base) {
		this.base = base;
	}
	
	
	
}

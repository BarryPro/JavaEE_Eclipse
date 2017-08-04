package com.sitech.acctmgr.atom.impl.pay;

import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.user.UserDetailEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.pay.SCheckConCheckRemainFeeInDTO;
import com.sitech.acctmgr.atom.dto.pay.SCheckConCheckRemainFeeOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.pay.ICheckCon;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
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
 * @author qiaolin
 * @version 1.0
 */
@ParamTypes({ 
	@ParamType(c = SCheckConCheckRemainFeeInDTO.class, oc=SCheckConCheckRemainFeeOutDTO.class,m = "checkRemainFee")
})
public class SCheckCon extends AcctMgrBaseService implements ICheckCon {

	private IUser 		user;
	private IRemainFee	reFee;
	
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.inter.pay.ICheckCon#checkRemainFee(com.sitech.jcfx.dt.in.InDTO)
	 */
	@Override
	public OutDTO checkRemainFee(InDTO inParam) {
		
		//1.入参处理
		SCheckConCheckRemainFeeInDTO inDto = (SCheckConCheckRemainFeeInDTO)inParam;
		
		log.info("SCheckCon checkRemainFee begin" + inDto.getMbean());
		
		/*取当前年月和当前时间*/
		String sCurDate = DateUtil.format(new Date(), "yyyyMMdd");
		String sCurYm = sCurDate.substring(0, 6);
		
		/*
		 * 获取用户信息，用户状态
		 * */
		UserInfoEntity userEntity = user.getUserEntity(null, inDto.getPhoneNo(), null, true);
		long idNo = userEntity.getIdNo();
		long contractNo = userEntity.getContractNo();
		
		UserDetailEntity userDetailEntity = user.getUserdetailEntity(idNo);
		String runCode = userDetailEntity.getRunCode();
		
		if(runCode.equals("I") || runCode.equals("J")){
			
			throw new BusiException(AcctMgrError.getErrorCode("8000","00013"), "用户预销户!");
			
		}else if(!runCode.equals("A")){
			
			throw new BusiException(AcctMgrError.getErrorCode("8000","00014"), "用户停机!");
		}
		
		/*
		 * 获取余额，校验余额
		 * */
		OutFeeData outFee = reFee.getConRemainFee(contractNo);
		long commonRemainFee = outFee.getCommonRemainFee();
		if(commonRemainFee < inDto.getCheckFee()){
			
			throw new BusiException(AcctMgrError.getErrorCode("8000","00015"), "通信账户余额不足!");
		}
		
		SCheckConCheckRemainFeeOutDTO outDto = new SCheckConCheckRemainFeeOutDTO();
		outDto.setPhoneNo(inDto.getPhoneNo());
		outDto.setCommonRemainFee(commonRemainFee);
		
		return outDto;
		
	}


	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IRemainFee getReFee() {
		return reFee;
	}

	public void setReFee(IRemainFee reFee) {
		this.reFee = reFee;
	}

}

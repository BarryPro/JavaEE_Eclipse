package com.sitech.acctmgr.atom.busi.pay;

import java.util.Map;

import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.pay.PayBookEntity;
import com.sitech.acctmgr.atom.domains.pay.PayUserBaseEntity;
import com.sitech.acctmgr.atom.domains.user.UserDetailEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.entity.inter.IUser;

/**
 *
 * <p>Title: 黑龙江开机个性化业务实现  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class PayOpenerHLJ extends PayOpener{
	
	private IUser user = getUser();
	private IRemainFee remainFee = getRemainFee();

	protected void sepBusiInfo(Map<String, Object> Header, PayUserBaseEntity userBase, PayBookEntity inBook, String provinceId){
		
		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;
		
		/*黑龙江实现主副卡开机功能
		 *主卡缴费，需要判断副卡余额如果满足条件则为副卡开机
		 *副卡缴费，如果主卡状态正常则直接开机
		 */
		if(!userBase.isPhoneFlag()){
			
			return;
		}
		
		String inPhone = userBase.getPhoneNo();
		
		char flag = user.isPimaryOrSecondaryCard(inPhone);
		
		//主卡缴费
		if('a' == flag){
			
			long secondCardId = user.getCardId(inPhone, "b");

			UserInfoEntity userEntity = user.getUserEntity(secondCardId, null, null, true);
			long secondCardIdConNo = userEntity.getContractNo();
			
			OutFeeData outFee = remainFee.getConRemainFee(userBase.getContractNo());
			if (outFee.getRemainFee() > 0) {

				onePhoneOpen(secondCardId, secondCardIdConNo, Header, inBook, provinceId);
			}

		}else if('b' == flag){		//副卡缴费
			
			long pimaryCardId = user.getCardId(inPhone, "a");
			//取主卡状态，如果主卡状态正常则直接开机
			UserDetailEntity userDetailEntity = user.getUserdetailEntity(pimaryCardId);
			String runCode = userDetailEntity.getRunCode();
			if(runCode.equals("A")){
				
				onePhoneOpen(pimaryCardId, userBase.getContractNo(), Header, inBook, provinceId);
			}
		}else{
			return;
		}
	}
	
}

package com.sitech.acctmgr.atom.impl.feeqry;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.pay.PayMentEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.feeqry.SPayMoreQryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SPayMoreQryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.feeqry.IPayMoreQry;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

@ParamTypes({ 
	@ParamType(c = SPayMoreQryInDTO.class,oc=SPayMoreQryOutDTO.class, m = "query")
	})
public class SPayMoreQry extends AcctMgrBaseService implements IPayMoreQry{

	protected IUser user;
	protected IRecord record;
	protected IBill bill;
	
	@Override
	public OutDTO query(InDTO inParam) {
		// TODO Auto-generated method stub
		SPayMoreQryInDTO inDto = (SPayMoreQryInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		
		String opTime ="";
		long payMoney=0;
		long consumeFee=0;
		
		//取当前年月
		String sCurYm = DateUtil.format(new Date(), "yyyyMM");
		String lastYm = DateUtil.toStringMinusMonths(sCurYm, 1, "yyyyMM");
		
		//取默认账户
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long contractNo = uie.getContractNo();
		
		//取最近半年缴费记录
		for(int i=0;i<6;i++) {
			String yearMonth = DateUtil.toStringMinusMonths(sCurYm, i, "yyyyMM");
			
			Map<String, Object> inMap = new HashMap<String, Object>();
			inMap.put("SUFFIX", yearMonth);
			inMap.put("CONTRACT_NO", contractNo);
			inMap.put("PAY_TYPE_IN", new String[]{"0","d"});
			inMap.put("DESC", "DESC");
			
			List<PayMentEntity> payMentList = record.getPayMentList(inMap);
			for(PayMentEntity pmeTemp :payMentList) {				
				if(pmeTemp.getPayFee()==0){					
					continue;
				}else {
					opTime=pmeTemp.getOpTime().substring(0, 6);
					payMoney=pmeTemp.getPayFee();
					log.info("opTime=="+opTime+"payMoney=="+payMoney);
					break;
				}
			}
			if(StringUtils.isNotEmpty(opTime)&&payMoney!=0) {
				break;
			}
		}
		
		//取上月消费
		consumeFee=bill.getPayedOweRealFee(null, contractNo, Integer.parseInt(lastYm));
		
		SPayMoreQryOutDTO outDto = new SPayMoreQryOutDTO();
		outDto.setConsumeFee(consumeFee);
		outDto.setOpTime(opTime);
		outDto.setPayMoney(payMoney);
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

	/**
	 * @return the record
	 */
	public IRecord getRecord() {
		return record;
	}

	/**
	 * @param record the record to set
	 */
	public void setRecord(IRecord record) {
		this.record = record;
	}

	/**
	 * @return the bill
	 */
	public IBill getBill() {
		return bill;
	}

	/**
	 * @param bill the bill to set
	 */
	public void setBill(IBill bill) {
		this.bill = bill;
	}
	
}

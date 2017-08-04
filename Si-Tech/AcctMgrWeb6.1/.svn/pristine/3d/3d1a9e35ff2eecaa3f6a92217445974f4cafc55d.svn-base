package com.sitech.acctmgr.atom.impl.feeqry;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.query.ClassifyPreEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.feeqry.SClassifyPreInitInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SClassifyPreInitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.feeqry.IClassifyPreQry;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

@ParamTypes({ 
	@ParamType(m = "query", c = SClassifyPreInitInDTO.class, oc = SClassifyPreInitOutDTO.class)
})
public class SClassifyPreQry extends AcctMgrBaseService implements IClassifyPreQry{

	protected IUser user;
	protected IRemainFee remainFee;
	protected IBalance balance;
	
	@Override
	public OutDTO query(InDTO inParam) {
		// TODO Auto-generated method stub
		List<ClassifyPreEntity> validList = new ArrayList<ClassifyPreEntity>();
		List<ClassifyPreEntity> willValidList = new ArrayList<ClassifyPreEntity>();
		List<ClassifyPreEntity> resultList = new ArrayList<ClassifyPreEntity>();
		SClassifyPreInitInDTO inDto = (SClassifyPreInitInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		String payType = inDto.getPayType();
		String qryFlag = inDto.getQueryFlag();
		
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long idNo = uie.getIdNo();
		long contractNo = uie.getContractNo();
		
		//取当前时间
		long sCurTime = Long.parseLong(DateUtil.format(new Date(), "yyyyMMddHHmmss"));
		String sCurMonth = String.valueOf(sCurTime).substring(0,6);
		int lastMonth = DateUtils.addMonth(Integer.valueOf(sCurMonth), -1);
		
		List<ClassifyPreEntity> detailList = remainFee.getClassifyPreInfo(contractNo);
		/*
		for (ClassifyPreEntity cpe : detailList) {
			long sEffDate = Long.parseLong(cpe.getBeginDate());
			long sExpDate = Long.parseLong(cpe.getEndDate());
			
			if (sCurTime >= sEffDate && sCurTime <= sExpDate) {
				validList.add(cpe);
			} else {
				willValidList.add(cpe);
			}
			
		}
		
		for (ClassifyPreEntity cpe : validList) {
			String payTypeTemp = cpe.getPayType();
			long prepayFee = cpe.getPrepayFee();
			long prepayFee1 = 0;
			int returnMonths = 0;
			String returnDay = "";
			String endTime = cpe.getEndDate();
			
			for (ClassifyPreEntity cpeWill : willValidList) {
				if (payTypeTemp.equals(cpeWill.getPayType())) {
					prepayFee1 = prepayFee1 + cpeWill.getPrepayFee();
					returnMonths++;
					endTime = cpeWill.getEndDate();
				}
			}
			
			prepayFee = prepayFee + prepayFee1;
			
			if (cpe.getPrepayFee() < prepayFee) {
				returnDay = "1";
			}
			if (payTypeTemp.equals("T")) {
				returnDay = "5";
			}
			if (cpe.getPrepayFee() == prepayFee) {
				returnDay = "null";
			}
			
			//取拆包标志
			String saleFlag = "";
			String disFlag = balance.getDisassembleFlag(idNo, lastMonth);
			if(disFlag.endsWith("1")) {
				saleFlag = "拆包";
			}else {
				saleFlag = "未拆包";
			}
			
			ClassifyPreEntity cpeResult = new ClassifyPreEntity();
			cpeResult.setBeginDate(cpe.getBeginDate());
			cpeResult.setEndDate(endTime);
			cpeResult.setLeftMonths(returnMonths);
			cpeResult.setOrderCode(cpe.getOrderCode());
			cpeResult.setPayName(cpe.getPayName());
			cpeResult.setPayType(cpe.getPayType());
			cpeResult.setPrepayFee(prepayFee);
			cpeResult.setReturnDay(returnDay);
			cpeResult.setSaleFlag(saleFlag);
			cpeResult.setTransFee(cpe.getTransFee());
			cpeResult.setTransFlag(cpe.getTransFlag());
			
		}
		*/
		SClassifyPreInitOutDTO outDto = new SClassifyPreInitOutDTO();
		outDto.setReturnList(detailList);
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
	 * @return the balance
	 */
	public IBalance getBalance() {
		return balance;
	}

	/**
	 * @param balance the balance to set
	 */
	public void setBalance(IBalance balance) {
		this.balance = balance;
	}

	/**
	 * @return the remainFee
	 */
	public IRemainFee getRemainFee() {
		return remainFee;
	}

	/**
	 * @param remainFee the remainFee to set
	 */
	public void setRemainFee(IRemainFee remainFee) {
		this.remainFee = remainFee;
	}
	
}

package com.sitech.acctmgr.atom.impl.feeqry;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.balance.BatchpayInfoEntity;
import com.sitech.acctmgr.atom.domains.query.OnlyFareEntity;
import com.sitech.acctmgr.atom.domains.query.OnlyShareFareEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.feeqry.SGiveReturnQryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SGiveReturnQryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.feeqry.IGiveReturn;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

@ParamTypes({
    @ParamType(c = SGiveReturnQryInDTO.class, m = "query", oc = SGiveReturnQryOutDTO.class)
})
public class SGiveReturnQry extends AcctMgrBaseService implements IGiveReturn{

	private IUser user;
	private IRecord record;
	
	@Override
	public OutDTO query(InDTO inParam) {

		String phoneNo = "";
		// 入参DTO
		SGiveReturnQryInDTO in = (SGiveReturnQryInDTO) inParam;
		phoneNo = in.getPhoneNo();
		long t1 = System.currentTimeMillis();

		// 取用户信息
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long idNo = uie.getIdNo();
		long contractNo = uie.getContractNo();

		List<OnlyFareEntity> onlyfavList = new ArrayList<OnlyFareEntity>();
		List<BatchpayInfoEntity> favList = record.getBatchPayInfoByCon(contractNo);
		for (BatchpayInfoEntity favent : favList) {
			
			OnlyFareEntity onlyFav = new OnlyFareEntity();
			
			String productName = favent.getPayName();
			String favUsedSum = String.valueOf(favent.getPayFee());
			String effDate = favent.getBeginTime();
			String expDate = favent.getEndTime();
			
			onlyFav.setProductName(productName);
			onlyFav.setFavUsedSum(favUsedSum);
			onlyFav.setEffDate(effDate);
			onlyFav.setExpDate(expDate);
			
			Map<String, Object> inMap = new HashMap<String, Object>();
			inMap.put("CONTRACT_NO", contractNo);
			inMap.put("ID_NO", idNo);
			inMap.put("BEGIN_TIME", effDate);
			inMap.put("END_TIME", expDate);
			inMap.put("PAY_TYPE_NAME", productName);
			
			List<OnlyShareFareEntity> shareList = new ArrayList<OnlyShareFareEntity>();
			// 取当前年月
			String sCurYm = DateUtil.format(new Date(), "yyyyMM");
			int iCurYm = Integer.parseInt(sCurYm);
			// 取6个月前年月
			String sEndYm = DateUtil.toStringMinusMonths(sCurYm, 5, "yyyyMM");
			int iEndYm = Integer.parseInt(sEndYm);
			
			for (int iOneYm = iEndYm; iOneYm <= iCurYm; iOneYm = Integer.parseInt(DateUtil.toStringMinusMonths(String.valueOf(iOneYm), -1, "yyyyMM"))) {
				
				String Ym = String.valueOf(iOneYm);
				inMap.put("OP_YM", Ym);
				
				List<Map<String, Object>> shareList1 = record.getBatchPayByTime(inMap);
				for (Map<String, Object> share : shareList1) {
					OnlyShareFareEntity shareL = new OnlyShareFareEntity();
					String ReturnFeeName = share.get("RETRUNFEENAME").toString();
					String returnFee = share.get("RETURN_FEE").toString();
					String ReturnTime = share.get("RETURN_TIME").toString();
					String status = share.get("STATUS").toString();
					
					shareL.setReturnFeeName(ReturnFeeName);
					shareL.setReturnFee(returnFee);
					shareL.setReturnTime(ReturnTime);
					shareL.setStatus(status);
					
					shareList.add(shareL);
				}
			}
			onlyFav.setShareList(shareList);
			onlyfavList.add(onlyFav);
			
		}

		SGiveReturnQryOutDTO out = new SGiveReturnQryOutDTO();
		out.setFavList(onlyfavList);
		long t2= System.currentTimeMillis();

		return out;
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

	
}

package com.sitech.acctmgr.atom.impl.query;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.bill.RealTimeBillDetailEntity;
import com.sitech.acctmgr.atom.domains.cust.CtCustContactEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserDeadEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.feeqry.S8424QryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S8424QryOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8428QueryInDTO;
import com.sitech.acctmgr.atom.dto.query.S8428QueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.query.I8428;
import com.sitech.billing.effectty.support.mdb.transaction.BaseDao;
import com.sitech.jcf.core.exception.BaseException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(c = S8428QueryInDTO.class,oc=S8428QueryOutDTO.class, m = "query")
	})
public class S8428 extends AcctMgrBaseService implements I8428 {
	
	private IUser user;
	private IBill bill;
	private IGroup group;
	private ICust cust;
	private IControl control;

	@Override
	public OutDTO query(InDTO inParam) {
		// 获取入参信息
		S8428QueryInDTO inDto = (S8428QueryInDTO)inParam;
		String pageNum = inDto.getPageNum();
		String regionGroup = inDto.getRegionGroup();
		String districtGroup = inDto.getDistrictGroup();
		String countYm = inDto.getCountYm();//统计年月
		countYm = countYm.substring(0,4) + countYm.substring(5,7);
		
		//获取所在地市
		ChngroupRelEntity groupRelEntity = group.getRegionDistinct(regionGroup, "2", "230000");
		String regionId = groupRelEntity.getRegionCode();
		
		Map<String,Object> inMap = new HashMap<String,Object>();
		inMap.put("COUNT_YM", countYm);
		inMap.put("REGION_ID", regionId);
		inMap.put("DISTRICT_GROUP", districtGroup);
		
		long querySn = 0;
		if(Integer.parseInt(pageNum) == 1){
			if(inDto.getQuerySn() == null || inDto.getQuerySn().equals("")){
				querySn = control.getSequence("SEQ_SYSTEM_SN");
			}
			querySn = Long.parseLong(inDto.getQuerySn());
		}else{
			querySn = Long.parseLong(inDto.getQuerySn());
		}
		inMap.put("QUERY_SN", querySn);
		Map<String,Object> outMap = bill.getBillDetailInfo(inMap,Integer.parseInt(pageNum));
		List<RealTimeBillDetailEntity> BillDetailEnt = (List<RealTimeBillDetailEntity>) outMap.get("result");
		int totalSum = (int) outMap.get("sum");
		if(BillDetailEnt.size() == 0){
			throw new BaseException(AcctMgrError.getErrorCode("8428", "00001"),"无相关数据信息");
		}
		
		List<RealTimeBillDetailEntity> outBillDetailEnt = new ArrayList<RealTimeBillDetailEntity>();
		for(RealTimeBillDetailEntity billDetailEnt:BillDetailEnt){
			log.info("实时欠费实体信息："+billDetailEnt);
			long idNo = billDetailEnt.getIdNo();
			//获取用户客户信息及联系信息
			String userPhoneNo = null;
			long custId = 0;
			UserInfoEntity userEnt;
			try {
				userEnt = user.getUserEntityByIdNo(idNo, true);
				userPhoneNo = userEnt.getPhoneNo();
				custId = userEnt.getCustId();
			} catch (Exception e) {
				List<UserDeadEntity> userDeadEnt = user.getUserdeadEntity(null, idNo, null);
				userPhoneNo = userDeadEnt.get(0).getPhoneNo();
				custId = userDeadEnt.get(0).getCustId();
			}
			CtCustContactEntity custEnt = cust.getContactEnt(custId);
			String contactPhone = "";
			String bluleContactName = "";
			String contactName = "";
			String custName = "";
			if(custEnt!=null){
				log.info("客户联系信息"+custEnt.toString());
				contactName = custEnt.getContactName();
				contactPhone = custEnt.getContactPhone();
				bluleContactName = control.pubEncryptData(contactName, 2);
			}
			if(custId != 0){
				try {
					CustInfoEntity custInfoEnt = cust.getCustInfo(custId, null);
					custName = custInfoEnt.getBlurCustName();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			billDetailEnt.setContactPhone(contactPhone);;
			billDetailEnt.setCustName(custName);
			billDetailEnt.setContactName(bluleContactName);
			billDetailEnt.setPhoneNo(userPhoneNo);
			billDetailEnt.setQuerySn(String.valueOf(querySn));
			log.error("qiaolin test: " + billDetailEnt.getPhoneNo() + "SB:" + billDetailEnt.toString());
			outBillDetailEnt.add(billDetailEnt);
		}
		
		S8428QueryOutDTO outDto = new S8428QueryOutDTO();
		outDto.setRealTimeOwefeeList(outBillDetailEnt);
		outDto.setTotalNum(totalSum);
		outDto.setQuerySn(String.valueOf(querySn));
		
		log.info("outDto------->"+outBillDetailEnt.toString());
		
		return outDto;
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

	/**
	 * @return the group
	 */
	public IGroup getGroup() {
		return group;
	}

	/**
	 * @param group the group to set
	 */
	public void setGroup(IGroup group) {
		this.group = group;
	}

	/**
	 * @return the control
	 */
	public IControl getControl() {
		return control;
	}

	/**
	 * @param control the control to set
	 */
	public void setControl(IControl control) {
		this.control = control;
	}

	/**
	 * @return the cust
	 */
	public ICust getCust() {
		return cust;
	}

	/**
	 * @param cust the cust to set
	 */
	public void setCust(ICust cust) {
		this.cust = cust;
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

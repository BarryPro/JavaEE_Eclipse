package com.sitech.acctmgr.atom.busi.invoice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.invoice.inter.IPreInvHeader;
import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.account.ContractDeadInfoEntity;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.invoice.BaseInvoiceDispEntity;
import com.sitech.acctmgr.atom.domains.user.ServAddNumEntity;
import com.sitech.acctmgr.atom.domains.user.UserBrandEntity;
import com.sitech.acctmgr.atom.domains.user.UserDeadEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.VirtualGrpEntity;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IBase;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IProd;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;

@SuppressWarnings("unchecked")
public class PreInvHeader extends BaseBusi implements IPreInvHeader {
	protected final static int CUST_ACCT = 1; // cust_id查询账户
	protected final static int ICCID_ACCT = 2; // 身份证查询账户
	protected final static int UNIT_ACCT = 0; // 集团编码查询账户
	private IInvoice invoice;
	private IUser user;
	private ICust cust;
	private IControl control;
	private IAccount account;
	private IProd prod;
	private IGroup group;
	private IRemainFee reFee;
	// liuhl_bj add
	private IBase base;
	private ILogin login;

	@Override
	public BaseInvoiceDispEntity queryBaseInvInfo(Map<String, Object> inParam) {
		String opCode = "";
		String opName = "";
		String groupName = "";
		String loginName = "";
		String brandName = "";
		String brandId = "";
		String remark = "";
		int printType;// 1：月结发票 2：预存发票
		String kdPhone = "";

		int userFlag = ValueUtils.intValue(inParam.get("USER_FLAG"));
		long idNo = ValueUtils.longValue(inParam.get("ID_NO"));
		long contractNo = ValueUtils.longValue(inParam.get("CONTRACT_NO"));
		String phoneNo = inParam.get("PHONE_NO").toString();
		printType = ValueUtils.intValue(inParam.get("PRINT_TYPE").toString());

		if (inParam.get("OP_CODE") != null) {
			opCode = inParam.get("OP_CODE").toString();
			// 查询opName
			// 如果是8005发票补打，转换成普通缴费
			String opCodeTrans = opCode;
			if (opCode.equals("8005")) {
				opCodeTrans = "8000";
			}
			opName = base.getFunctionName(opCodeTrans);
			if (opCode.equals("8005")) {
				opName = "补打" + opName;
			}
		}

		String loginNo = inParam.get("LOGIN_NO").toString();
		String groupId = inParam.get("GROUP_ID").toString();
		BaseInvoiceDispEntity baseInvoice = new BaseInvoiceDispEntity();
		String custName = "";
		long custId = 0;
		
		String printDate = "";
		// 获取打印日期
		int curDate = DateUtils.getCurDay();
		printDate = curDate / 10000 + "年" + curDate % 10000 / 100 + "月" + curDate % 100 + "日";
		log.debug("printDate:" + printDate);

		if (userFlag == CommonConst.IN_NET) {
			// 获取在网用户的用户信息
			// UserInfoEntity userInfo = user.getUserInfo(phoneNo);
			UserInfoEntity userInfo = user.getUserEntity(0l, phoneNo, contractNo, false);
			if (userInfo != null) {
				phoneNo = userInfo.getPhoneNo();
				idNo = userInfo.getIdNo();
				UserBrandEntity userBrand = user.getUserBrandRel(idNo);
				brandId = userBrand.getBrandId();
				brandName = userBrand.getBrandName();
			} else {
				phoneNo = "";
				idNo = 0;
			}

			if (printType == 2) {
				// 预存发票上展示的客户名称为账户的客户名称，所以查询账户的cust_id
				// 查询账户的custId
				ContractInfoEntity contractInfo = account.getConInfo(contractNo);
				custId = contractInfo.getCustId();
			} else if (printType == 1) {

				custId = userInfo.getCustId();
			}

			// 新增需求，如果用户品牌为车务通，品牌打印为“社区矫正”
			boolean flag=user.isTrafficFlux(idNo, "23B200381", "451002");
			if(flag){
				brandName = "社区矫正";
			}
			// 查询宽带号码
			if(brandId.equals("2330kf") || brandId.equals("2330ki") || brandId.equals("2330kg") || brandId.equals("2330kh")||brandId.equals("233005") || brandId.equals("2310WK") || brandId.equals("2330ke") || brandId.equals("2310JD")
					|| brandId.equals("2330kd")) {
				ServAddNumEntity addNumEnt = user.getAddNumInfo(phoneNo, "", "02");
				if (addNumEnt != null) {
					kdPhone = addNumEnt.getAddServiceNo();
				}

			}
		} else {
			// 获取离网用户信息
			List<UserDeadEntity> userDeadInfoList = user.getUserdeadEntity(phoneNo, idNo, contractNo);
			if (userDeadInfoList != null && userDeadInfoList.size() > 0) {
				phoneNo = userDeadInfoList.get(0).getPhoneNo();
				idNo = userDeadInfoList.get(0).getIdNo();
				if (printType == 2) {
					ContractDeadInfoEntity contractDeadInfo = account.getConDeadInfo(contractNo);
					custId = contractDeadInfo.getCustId();
				} else if (printType == 1) {
					custId = userDeadInfoList.get(0).getCustId();
				}

			} else {
				throw new BusiException(AcctMgrError.getErrorCode("0000", "01000"), "查询离网用户信息出错");
			}

		}

		// 根据custId查询客户名称
		CustInfoEntity custInfo = cust.getCustInfo(custId, "");
		custName = custInfo.getCustName();

		// 查询营业厅名称
		Map<String, Object> groupInfo = group.getCurrentGroupInfo(groupId, inParam.get("PROVICE_ID").toString());
		if (groupInfo != null) {
			groupName = (String) groupInfo.get("GROUP_NAME");
		}
		// 根据工号查询工号名称
		LoginEntity loginInfo = login.getLoginInfo(loginNo, inParam.get("PROVICE_ID").toString());
		loginName = loginInfo.getLoginName();

		// 获取备注信息
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("GROUP_ID", groupId);
		inMap.put("OP_CODE", opCode);
		remark = invoice.getInvRemark(inMap);

		baseInvoice.setPhoneNo(phoneNo);
		baseInvoice.setContractNo(contractNo);
		baseInvoice.setCustName(custName);
		baseInvoice.setOpName(opName);
		baseInvoice.setLoginNo(loginNo);
		baseInvoice.setGroupName(groupName);
		baseInvoice.setLoginName(loginName);
		baseInvoice.setBrandName(brandName);
		baseInvoice.setCustId(custId);
		baseInvoice.setOpCode(opCode);
		baseInvoice.setRemark(remark);
		baseInvoice.setPrintDate(printDate);
		baseInvoice.setIdNo(idNo);
		baseInvoice.setBrandId(brandId);
		baseInvoice.setKdPhone(kdPhone);
		// baseInvoice.setInvNo(inParam.get("INV_NO").toString());
		return baseInvoice;
	}

	@Override
	public BaseInvoiceDispEntity queryBaseInvInfoOfGrp(Map<String, Object> inMap) {
		BaseInvoiceDispEntity baseInvoice = new BaseInvoiceDispEntity();
		int curDate = DateUtils.getCurDay();
		String printDate = curDate / 10000 + "年" + curDate % 10000 / 100 + "月" + curDate % 100 + "日";
		log.debug("printDate:" + printDate);

		baseInvoice.setPrintDate(printDate);
		baseInvoice.setInvNo(inMap.get("INV_NO").toString());
		baseInvoice.setCustName(inMap.get("CUST_NAME") + "");
		baseInvoice.setOpName("集团发票开具");
		baseInvoice.setUnitNo(inMap.get("UNIT_ID").toString());
		if (StringUtils.isNotEmptyOrNull(inMap.get("PRINT_ITEM"))) {
			baseInvoice.setPrintItem(inMap.get("PRINT_ITEM").toString());
		}
		String groupName = "";
		String loginName = "";
		// 查询营业厅名称
		Map<String, Object> groupInfo = group.getCurrentGroupInfo(inMap.get("GROUP_ID").toString(), inMap.get("PROVICE_ID").toString());
		if (groupInfo != null) {
			groupName = (String) groupInfo.get("GROUP_NAME");
		}
		// 根据工号查询工号名称
		LoginEntity loginInfo = login.getLoginInfo(inMap.get("LOGIN_NO").toString(), inMap.get("PROVICE_ID").toString());
		loginName = loginInfo.getLoginName();

		baseInvoice.setGroupName(groupName);
		baseInvoice.setLoginAccept(ValueUtils.longValue(inMap.get("PRINT_SN").toString()));
		baseInvoice.setLoginNo(inMap.get("LOGIN_NO").toString());
		baseInvoice.setLoginName(loginName);
		return baseInvoice;
	}

	@Override
	public List<VirtualGrpEntity> getUserInfoByVtrBloc(long unitId, String phoneNo) {

		Map<String, Object> inParam = new HashMap<String, Object>();

		if (unitId != 0) {
			inParam.put("UNIT_ID", unitId);
		}

		if (StringUtils.isNotEmptyOrNull(phoneNo)) {
			inParam.put("PHONE_NO", phoneNo);
		}

		List<VirtualGrpEntity> userList = (List<VirtualGrpEntity>) baseDao.queryForList("bal_grpuser_rel.qry", inParam);

		for (VirtualGrpEntity virEnt : userList) {
			if(!virEnt.getGrpPhoneNo().equals("0")) {
				UserInfoEntity userEnt = user.getUserInfo(virEnt.getGrpPhoneNo());
				virEnt.setIdNo(userEnt.getIdNo());
			}
		}

		return userList;
	}

	@Override
	public String getVirtualName(long unitId) {

		Map<String, Object> inParam = new HashMap<String, Object>();

		inParam.put("UNIT_ID", unitId);

		VirtualGrpEntity vge = (VirtualGrpEntity) baseDao.queryForObject("bal_virtualgrp_info.qryName", inParam);

		if (vge == null) {
			// 10111109800001029
			throw new BusiException(AcctMgrError.getErrorCode("0000", "01029"), "虚拟集团帐号不存在！");
		}

		return vge.getUnitName();
	}

	public IInvoice getInvoice() {
		return invoice;
	}

	public void setInvoice(IInvoice invoice) {
		this.invoice = invoice;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public ICust getCust() {
		return cust;
	}

	public void setCust(ICust cust) {
		this.cust = cust;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

	public IAccount getAccount() {
		return account;
	}

	public void setAccount(IAccount account) {
		this.account = account;
	}

	public IProd getProd() {
		return prod;
	}

	public void setProd(IProd prod) {
		this.prod = prod;
	}

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
	}

	public IRemainFee getReFee() {
		return reFee;
	}

	public void setReFee(IRemainFee reFee) {
		this.reFee = reFee;
	}

	public IBase getBase() {
		return base;
	}

	public void setBase(IBase base) {
		this.base = base;
	}

	public ILogin getLogin() {
		return login;
	}

	public void setLogin(ILogin login) {
		this.login = login;
	}

}

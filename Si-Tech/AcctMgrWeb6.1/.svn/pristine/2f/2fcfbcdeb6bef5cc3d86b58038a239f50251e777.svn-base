package com.sitech.acctmgr.atom.impl.invoice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.invoice.inter.IInvFee;
import com.sitech.acctmgr.atom.busi.invoice.inter.IInvPrint;
import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.invoice.AcrossFieldInvEntity;
import com.sitech.acctmgr.atom.domains.invoice.InvBillCycleEntity;
import com.sitech.acctmgr.atom.domains.invoice.MonthInvoiceDispEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.invoice.SAcrossFieldPrintCfmInDTO;
import com.sitech.acctmgr.atom.dto.invoice.SAcrossFieldPrintCfmOutDTO;
import com.sitech.acctmgr.atom.dto.invoice.SAcrossFieldQryInvoInDTO;
import com.sitech.acctmgr.atom.dto.invoice.SAcrossFieldQryInvoOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.invoice.IAcrossFieldInvo;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(c = SAcrossFieldQryInvoInDTO.class, oc = SAcrossFieldQryInvoOutDTO.class, m = "qryInvo"),
		@ParamType(c = SAcrossFieldPrintCfmInDTO.class, oc = SAcrossFieldPrintCfmOutDTO.class, m = "printCfm") })
public class SAcrossFieldInvo extends AcctMgrBaseService implements IAcrossFieldInvo {

	private IUser user;
	private ICust cust;
	private IControl control;
	private IRemainFee remainFee;
	private IInvFee invFee;
	private IInvoice invoice;
	private IInvPrint invPrint;

	@Override
	public OutDTO qryInvo(InDTO inParam) {
		SAcrossFieldQryInvoInDTO inDto = (SAcrossFieldQryInvoInDTO) inParam;
		Map<String, Object> inMap = new HashMap<String, Object>();

		String phoneNo = inDto.getIdValue();
		int beginYm = inDto.getBeginDate();
		int endYm = inDto.getEndDate();

		// 获取客户名称
		UserInfoEntity userInfo = user.getUserInfo(phoneNo);
		long custId = userInfo.getCustId();
		long contractNo = userInfo.getContractNo();
		CustInfoEntity custInfo = cust.getCustInfo(custId, "");
		String custName = custInfo.getCustName();

		// 获取账期及发票金额列表
		// 直接在服务里面判断打印账期须小于当前月
		if (endYm >= DateUtils.getCurYm() || beginYm >= DateUtils.getCurYm()) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "70001"), "打印账期必须小于当前账期！");
		}
		// 判断是否有欠费，如果有欠费不予许打印月结发票，提示：用户当前欠费%.2f元,不允许打印月结发票
		long oweFee = remainFee.getConRemainFee(contractNo).getOweFee();
		if (oweFee > 0) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "70002"), "用户当月欠费" + oweFee / 100.0 + "元，不允许打印月结发票");
		}
		List<AcrossFieldInvEntity> acrossFieldList = new ArrayList<AcrossFieldInvEntity>();
		inMap.put("CONTRACT_NO", contractNo);
		for (int billCycle = beginYm; billCycle <= endYm; billCycle = DateUtils.addMonth(billCycle, 1)) {
			inMap.put("BILL_CYCLE", billCycle);
			Map<String, Object> feeMap = invFee.getMonthInvoiceFee(inMap);

			MonthInvoiceDispEntity monthInvDisp = (MonthInvoiceDispEntity) feeMap.get("MONTH_INVOICE_DISP");
			AcrossFieldInvEntity acrossField = new AcrossFieldInvEntity();
			acrossField.setBillCycle(billCycle);
			acrossField.setPrintFee(monthInvDisp.getPrintFee());
			acrossFieldList.add(acrossField);
		}

		SAcrossFieldQryInvoOutDTO outDto = new SAcrossFieldQryInvoOutDTO();
		outDto.setCustName(custName);
		outDto.setInvEnti(acrossFieldList);
		return outDto;
	}

	@Override
	public OutDTO printCfm(InDTO inParam) {
		SAcrossFieldPrintCfmInDTO inDto = (SAcrossFieldPrintCfmInDTO) inParam;
		// System.err.println();
		String idType = inDto.getIdType();
		String loginNo = inDto.getHandlingNum();
		String groupId = inDto.getGroupId();
		String opCode = inDto.getOpCode();
		String phoneNo = "";
		List<AcrossFieldInvEntity> acrossFieldList = inDto.getInvList();
		if (idType.equals("01")) {
			phoneNo = inDto.getIdValue();
		}
		// 根据服务号码查询用户信息
		UserInfoEntity userInfo = user.getUserInfo(phoneNo);
		long contractNo = userInfo.getContractNo();

		List<InvBillCycleEntity> billcycleList = new ArrayList<InvBillCycleEntity>();
		for (AcrossFieldInvEntity acrossField : acrossFieldList) {
			InvBillCycleEntity invBillCycle = new InvBillCycleEntity();
			invBillCycle.setBillCycle(ValueUtils.intValue(acrossField.getMonth()));
			invBillCycle.setInvNo(acrossField.getInvNo());
			billcycleList.add(invBillCycle);
		}

		Map<String, Object> inMap = new HashMap<String, Object>();

		inMap.put("CONTRACT_NO", contractNo);
		inMap.put("PHONE_NO", phoneNo);
		inMap.put("LOGIN_NO", loginNo);
		inMap.put("GROUP_ID", groupId);
		inMap.put("OP_CODE", opCode);
		inMap.put("PRINT_TYPE", "1");
		inMap.put("PROVICE_ID", inDto.getProvinceId());
		inMap.put("PRINT_SEQ", "1");
		inMap.put("IS_COMBINE", false);
		inMap.put("INV_BILLCYCLE_LIST", billcycleList);
		// 直接在服务里面判断打印账期须小于当前月
		for (InvBillCycleEntity invBillCycle : billcycleList) {
			if (invBillCycle.getBillCycle() >= DateUtils.getCurYm()) {
				throw new BusiException(AcctMgrError.getErrorCode("8224", "00001"), "打印账期必须小于当前账期！");
			}
		}

		// 判断是否有欠费，如果有欠费不予许打印月结发票，提示：用户当前欠费%.2f元,不允许打印月结发票
		long oweFee = remainFee.getConRemainFee(contractNo).getOweFee();
		if (oweFee > 0) {
			throw new BusiException(AcctMgrError.getErrorCode("8224", "00002"), "用户当月欠费" + oweFee / 100.0 + "元，不允许打印月结发票");
		}

		inMap.put("IS_PRINT_XML", false);
		log.debug("一级boss月结发票打印调用打印的参数：" + inMap);
		long printSn = invoice.getPrintSn();
		inMap.put("PRINT_SN", printSn);
		invPrint.printMonthInvoice(inMap);


		SAcrossFieldPrintCfmOutDTO outDto = new SAcrossFieldPrintCfmOutDTO();
		return outDto;
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

	public IRemainFee getRemainFee() {
		return remainFee;
	}

	public void setRemainFee(IRemainFee remainFee) {
		this.remainFee = remainFee;
	}

	public IInvFee getInvFee() {
		return invFee;
	}

	public void setInvFee(IInvFee invFee) {
		this.invFee = invFee;
	}

	public IInvPrint getInvPrint() {
		return invPrint;
	}

	public void setInvPrint(IInvPrint invPrint) {
		this.invPrint = invPrint;
	}

	public IInvoice getInvoice() {
		return invoice;
	}

	public void setInvoice(IInvoice invoice) {
		this.invoice = invoice;
	}

}

package com.sitech.acctmgr.atom.impl.invoice;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.invoice.InvPrint;
import com.sitech.acctmgr.atom.busi.pay.inter.IPreOrder;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.invoice.InvNoOccupyEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.dto.invoice.S8068PrintInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8068PrintOutDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8068QueryInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8068QueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.invoice.I8068Invoice;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

@ParamTypes({ @ParamType(c = S8068PrintInDTO.class, m = "print", oc = S8068PrintOutDTO.class),
		@ParamType(c = S8068QueryInDTO.class, m = "query", oc = S8068QueryOutDTO.class) })
public class S8068Invoice extends AcctMgrBaseService implements I8068Invoice {
	private InvPrint invPrint;
	private IInvoice invoice;
	private IRecord record;
	private IPreOrder preOrder;
	private IGroup group;

	@Override
	public OutDTO query(InDTO inParam) {
		S8068QueryInDTO inDTO = (S8068QueryInDTO) inParam;
		long contractNo = inDTO.getContractNo();
		Map<String, Object> outMap = invoice.getLastPay("8068", contractNo, DateUtils.getCurYm());
		S8068QueryOutDTO outDto = new S8068QueryOutDTO();
		outDto.setPaySn(ValueUtils.longValue(outMap.get("PAY_SN")));
		outDto.setTotalDate(ValueUtils.intValue(outMap.get("TOTAL_DATE")));
		return outDto;
	}

	@Override
	public OutDTO print(InDTO inParam) {
		S8068PrintInDTO inDto = (S8068PrintInDTO) inParam;

		long paySn = inDto.getPaySn();
		int yearMonth = inDto.getYearMonth();
		String loginNo = inDto.getLoginNo();
		String groupId = inDto.getGroupId();
		String proviceId = inDto.getProvinceId();
		// String opCode = inDto.getOpCode();
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("PAY_SN", paySn);
		inMap.put("YEAR_MONTH", yearMonth);
		inMap.put("GROUP_ID", groupId);
		inMap.put("PROVICE_ID", proviceId);
		inMap.put("LOGIN_NO", loginNo);
		// 获取发票上的流水
		long printSn = invoice.getPrintSn();
		inMap.put("PRINT_SN", printSn);
		Map<String, Object> outMap=new HashMap<String,Object>();
		outMap = invPrint.print8068Accept(inMap);
		InvNoOccupyEntity invNoOccupy=(InvNoOccupyEntity) outMap.get("INV_NO_OCCUPY");
		String phoneNo = outMap.get("PHONE_NO").toString();

		// 记录工号操作记录表
		LoginOprEntity loe = new LoginOprEntity();
		loe.setLoginGroup(inDto.getGroupId());
		loe.setLoginNo(inDto.getLoginNo());
		loe.setLoginSn(printSn);
		loe.setTotalDate(DateUtils.getCurDay());
		loe.setIdNo(0);
		loe.setBrandId("xx");
		loe.setPayType("00");
		loe.setPayFee(0);
		loe.setOpCode(inDto.getOpCode());
		loe.setRemark(inDto.getLoginNo() + "给空中充值代理商用户缴费打印收据");
		record.saveLoginOpr(loe);

		// 同步CRM统一接触
		ChngroupRelEntity cgre = group.getRegionDistinct(groupId, "2", inDto.getProvinceId());
		Map<String, Object> oprCnttMap = new HashMap<String, Object>();
		oprCnttMap.put("Header", inDto.getHeader());
		oprCnttMap.put("PAY_SN", printSn);
		oprCnttMap.put("LOGIN_NO", inDto.getLoginNo());
		oprCnttMap.put("GROUP_ID", inDto.getGroupId());
		oprCnttMap.put("OP_CODE", inDto.getOpCode());
		oprCnttMap.put("REGION_ID", cgre.getRegionCode());
		oprCnttMap.put("OP_NOTE", inDto.getLoginNo() + "给空中充值代理商用户缴费打印收据");
		oprCnttMap.put("TOTAL_FEE", 0);
		oprCnttMap.put("CUST_ID_TYPE", "1");
		oprCnttMap.put("CUST_ID_VALUE", phoneNo);
		// 取系统时间
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		oprCnttMap.put("OP_TIME", sCurTime);
		preOrder.sendOprCntt(oprCnttMap);
		S8068PrintOutDTO outDto = new S8068PrintOutDTO();
		outDto.setXmlStr(invNoOccupy.getXmlStr());
		return outDto;
	}

	public IRecord getRecord() {
		return record;
	}

	public void setRecord(IRecord record) {
		this.record = record;
	}

	public InvPrint getInvPrint() {
		return invPrint;
	}

	public void setInvPrint(InvPrint invPrint) {
		this.invPrint = invPrint;
	}

	public IInvoice getInvoice() {
		return invoice;
	}

	public void setInvoice(IInvoice invoice) {
		this.invoice = invoice;
	}

	public IPreOrder getPreOrder() {
		return preOrder;
	}

	public void setPreOrder(IPreOrder preOrder) {
		this.preOrder = preOrder;
	}

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
	}

}

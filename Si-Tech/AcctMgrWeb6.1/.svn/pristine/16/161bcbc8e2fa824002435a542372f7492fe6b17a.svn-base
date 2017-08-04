package com.sitech.acctmgr.atom.impl.invoice;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.invoice.inter.IPreInvHeader;
import com.sitech.acctmgr.atom.busi.invoice.inter.IPrintDataXML;
import com.sitech.acctmgr.atom.busi.pay.inter.IPreOrder;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.invoice.BalInvprintInfoEntity;
import com.sitech.acctmgr.atom.domains.invoice.BalInvprintdetInfo;
import com.sitech.acctmgr.atom.domains.invoice.BaseInvoiceDispEntity;
import com.sitech.acctmgr.atom.domains.invoice.InvNoOccupyEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.dto.invoice.S8076InvoicePrintInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8076InvoicePrintOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.common.utils.BeanToMapUtils;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.invoice.I8076Invoice;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

/**
 * 名称：催缴打印发票
 * 
 * @author liuhl_bj
 *
 */
@ParamTypes({ @ParamType(c = S8076InvoicePrintInDTO.class, oc = S8076InvoicePrintOutDTO.class, m = "print") })
public class S8076Invoice extends AcctMgrBaseService implements I8076Invoice {

	private IPreInvHeader preInvHeader;
	private IRecord record;
	private IControl control;
	private IPrintDataXML printDataXML;
	private IInvoice invoice;
	private IPreOrder preOrder;
	private IGroup group;

	@Override
	public OutDTO print(InDTO inParam) {
		S8076InvoicePrintInDTO inDto = (S8076InvoicePrintInDTO) inParam;
		long contractNo = inDto.getContractNo();
		String phoneNo = inDto.getPhoneNo();
		int userFlag = CommonConst.NO_NET;
		String opCode = inDto.getOpCode();
		String loginNo = inDto.getLoginNo();
		String groupId = inDto.getGroupId();
		String proviceId = inDto.getProvinceId();
		String invNo = inDto.getInvNo();
		String invCode = inDto.getInvCode();
		// int billCycle = DateUtils.getCurYm();
		long paySn = inDto.getPaySn();
		// int printSeq = 1;

		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("CONTRACT_NO", contractNo);
		inMap.put("USER_FLAG", userFlag);
		inMap.put("OP_CODE", opCode);
		inMap.put("LOGIN_NO", loginNo);
		inMap.put("GROUP_ID", groupId);

		inMap.put("PAY_SN", paySn);
		inMap.put("PHONE_NO", phoneNo);
		inMap.put("PRINT_TYPE", "2");
		inMap.put("PROVICE_ID", proviceId);

		// 用户查询发票上的用户记录
		BaseInvoiceDispEntity baseInvoice = preInvHeader.queryBaseInvInfo(inMap);
		inMap.put("LOGIN_ACCEPT", paySn);
		Map<String, Object> outMap = record.getPayedFee(inMap);
		if (outMap == null) {
			throw new BusiException(AcctMgrError.getErrorCode("8076", "00000"), "无缴费记录");
		}

		long printFee = ValueUtils.longValue(outMap.get("CASH_PAY"));
		String bigMoney = ValueUtils.transYuanToChnaBig(ValueUtils.transFenToYuan(printFee));
		Map<String, Object> xmlMap = BeanToMapUtils.beanToMap(baseInvoice);

		// 获取打印流水
		long printSn = control.getSequence("SEQ_SYSTEM_SN");

		xmlMap.put("LOGIN_ACCEPT", printSn);
		xmlMap.put("BIG_MONEY", bigMoney);
		xmlMap.put("PRINT_FEE", ValueUtils.transFenToYuan(printFee));
		xmlMap.put("OP_CODE", opCode);
		xmlMap.put("PRINT_TYPE", "2nn");
		
		log.debug("xmlMap" + xmlMap);
		String xmlStr = printDataXML.getPrintXml(xmlMap);

		// 记录发票打印记录表
		BalInvprintInfoEntity balInvprintInfo = new BalInvprintInfoEntity();
		balInvprintInfo.setPrintSn(printSn);
		balInvprintInfo.setPrintArray(1);
		balInvprintInfo.setPhoneNo(baseInvoice.getPhoneNo());
		balInvprintInfo.setCustId(baseInvoice.getCustId());
		balInvprintInfo.setIdNo(baseInvoice.getIdNo());
		balInvprintInfo.setContractNo(baseInvoice.getContractNo());
		// balInvprintInfo.setRelContractNo(baseInvoice.getContractNo());
		balInvprintInfo.setInvType(CommonConst.YCFP_TYPE);
		balInvprintInfo.setState(CommonConst.NORMAL_STATUS);// 1:打印正常发票
		balInvprintInfo.setLoginNo(baseInvoice.getLoginNo());
		balInvprintInfo.setGroupId(groupId);
		balInvprintInfo.setOpCode(baseInvoice.getOpCode());
		balInvprintInfo.setTotalDate(DateUtils.getCurDay());
		balInvprintInfo.setInvCode(invCode);
		balInvprintInfo.setInvNo(invNo);
		balInvprintInfo.setPaySn(paySn);
		balInvprintInfo.setTotalFee(printFee);
		balInvprintInfo.setPrintFee(printFee);
		balInvprintInfo.setTaxFee(0l);
		balInvprintInfo.setTaxRate(0d);
		balInvprintInfo.setPrintNum(1);
		balInvprintInfo.setRemark("预存发票打印");
		balInvprintInfo.setBeginYmd(DateUtils.getCurDay() + "");
		balInvprintInfo.setEndYmd(DateUtils.getCurDay() + "");
		balInvprintInfo.setBillCycle(DateUtils.getCurYm());
		balInvprintInfo.setPrintSeq(1);

		List<BalInvprintInfoEntity> balInvprintInfoList = new ArrayList<BalInvprintInfoEntity>();
		balInvprintInfoList.add(balInvprintInfo);
		invoice.iBalInvprintInfo(balInvprintInfoList);
		// 记录发票打印明细表
		BalInvprintdetInfo balInvprintdetInfo = new BalInvprintdetInfo();
		balInvprintdetInfo.setPrintSn(printSn);
		balInvprintdetInfo.setPhoneNo(baseInvoice.getPhoneNo());
		balInvprintdetInfo.setIdNo(baseInvoice.getIdNo());
		balInvprintdetInfo.setContractNo(baseInvoice.getContractNo());
		long orderSn = control.getSequence("SEQ_ORDER_ID");
		balInvprintdetInfo.setOrderSn(orderSn);
		balInvprintdetInfo.setInvCode(invCode);
		balInvprintdetInfo.setInvNo(invNo);
		balInvprintdetInfo.setShowOrder(6);
		balInvprintdetInfo.setShowName("发票金额：");
		balInvprintdetInfo.setYearMonth(DateUtils.getCurYm() + "");

		balInvprintdetInfo.setAmount(1);
		balInvprintdetInfo.setPrintData(xmlStr.getBytes());
		balInvprintdetInfo.setPrintArray(1);
		balInvprintdetInfo.setUnitePrice(printFee);
		balInvprintdetInfo.setTotalFee(printFee);

		List<BalInvprintdetInfo> balInvprintDetInfoList = new ArrayList<BalInvprintdetInfo>();
		balInvprintDetInfoList.add(balInvprintdetInfo);
		invoice.iBalInvprintdetInfo(balInvprintDetInfoList);

		// 记录工号操作记录表
		LoginOprEntity loe = new LoginOprEntity();
		loe.setLoginGroup(inDto.getGroupId());
		loe.setLoginNo(inDto.getLoginNo());
		loe.setLoginSn(printSn);
		loe.setTotalDate(DateUtils.getCurDay());
		loe.setIdNo(0);
		loe.setPhoneNo(phoneNo);
		loe.setBrandId("xx");
		loe.setPayType("00");
		loe.setPayFee(0);
		loe.setOpCode(inDto.getOpCode());
		loe.setRemark(inDto.getLoginNo() + "给用户打印催缴发票");
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
		oprCnttMap.put("OP_NOTE", inDto.getLoginNo() + "给用户打印催缴发票");
		oprCnttMap.put("TOTAL_FEE", 0);
		oprCnttMap.put("CUST_ID_TYPE", "1");
		oprCnttMap.put("CUST_ID_VALUE", phoneNo);
		// 取系统时间
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		oprCnttMap.put("OP_TIME", sCurTime);
		preOrder.sendOprCntt(oprCnttMap);

		S8076InvoicePrintOutDTO outDto = new S8076InvoicePrintOutDTO();
		InvNoOccupyEntity occupy = new InvNoOccupyEntity();
		occupy.setInvCode(invCode);
		occupy.setInvNo(invNo);
		occupy.setFee(printFee);
		occupy.setXmlStr(xmlStr);
		outDto.setInvNoOccupy(occupy);
		return outDto;
	}

	public IPreInvHeader getPreInvHeader() {
		return preInvHeader;
	}

	public void setPreInvHeader(IPreInvHeader preInvHeader) {
		this.preInvHeader = preInvHeader;
	}

	public IRecord getRecord() {
		return record;
	}

	public void setRecord(IRecord record) {
		this.record = record;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

	public IPrintDataXML getPrintDataXML() {
		return printDataXML;
	}

	public void setPrintDataXML(IPrintDataXML printDataXML) {
		this.printDataXML = printDataXML;
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

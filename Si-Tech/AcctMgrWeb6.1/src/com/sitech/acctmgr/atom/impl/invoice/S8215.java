package com.sitech.acctmgr.atom.impl.invoice;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.invoice.inter.IPrintDataXML;
import com.sitech.acctmgr.atom.busi.pay.inter.IPreOrder;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.invoice.BalInvprintInfoEntity;
import com.sitech.acctmgr.atom.domains.invoice.BalInvprintdetInfo;
import com.sitech.acctmgr.atom.domains.invoice.InvNoOccupyEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.dto.invoice.S8215PrintInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8215PrintOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.invoice.I8215;
import com.sitech.common.utils.StringUtils;
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
@ParamTypes({ @ParamType(c = S8215PrintInDTO.class, oc = S8215PrintOutDTO.class, m = "print") })
public class S8215 extends AcctMgrBaseService implements I8215 {

	private IControl control;
	private IPrintDataXML printDataXML;
	private IInvoice invoice;
	private IGroup group;
	private ILogin login;
	private IPreOrder preOrder;
	private IRecord record;

	@Override
	public OutDTO print(InDTO inParam) {
		S8215PrintInDTO inDto = (S8215PrintInDTO) inParam;
		long contractNo = inDto.getContractNo();
		String phoneNo = inDto.getPhoneNo();
		String opCode = inDto.getOpCode();
		String loginNo = inDto.getLoginNo();
		String groupId = inDto.getGroupId();
		String proviceId = inDto.getProvinceId();
		String invNo = inDto.getInvNo();
		String invCode = inDto.getInvCode();
		String item1 = inDto.getItem1();
		String item2 = inDto.getItem2();
		String item3 = inDto.getItem3();
		String remark = inDto.getRemark();
		String unitName = inDto.getUnitName();
		String checkNo = inDto.getCheckNo();
		long printFee = inDto.getPrintFee();

		// 获取打印流水
		long printSn = control.getSequence("SEQ_SYSTEM_SN");
		// 查询工号名称和营业厅名称
		String groupName = "";
		String loginName = "";
		Map<String, Object> groupInfo = group.getCurrentGroupInfo(groupId, proviceId);
		if (groupInfo != null) {
			groupName = (String) groupInfo.get("GROUP_NAME");
		}
		// 根据工号查询工号名称
		LoginEntity loginInfo = login.getLoginInfo(loginNo, proviceId);
		loginName = loginInfo.getLoginName();

		Map<String, Object> xmlMap = new HashMap<String, Object>();
		xmlMap.put("LOGIN_ACCEPT", printSn);
		xmlMap.put("BIG_MONEY", ValueUtils.transYuanToChnaBig(ValueUtils.transFenToYuan(printFee)));
		xmlMap.put("PRINT_FEE", ValueUtils.transFenToYuan(printFee));
		xmlMap.put("OP_CODE", opCode);
		xmlMap.put("PRINT_TYPE", "2nn");
		xmlMap.put("PHONE_NO", phoneNo);
		xmlMap.put("UNIT_NAME", unitName);
		xmlMap.put("OP_NAME", "集团发票打印");
		xmlMap.put("CONTRACT_NO", contractNo);
		xmlMap.put("CHECK_NO", checkNo);
		xmlMap.put("ITEM1", item1);
		xmlMap.put("ITEM2", item2);
		xmlMap.put("ITEM3", item3);
		xmlMap.put("ITEM3", remark);
		xmlMap.put("INV_NO", invNo);
		xmlMap.put("TOTAL_DATE", DateUtils.getCurDay());
		xmlMap.put("LOGIN_NAME", loginName);
		xmlMap.put("GROUP_NAME", groupName);
		xmlMap.put("LOGIN_NO", loginNo);
		xmlMap.put("REMARK", inDto.getRemark());

		log.debug("xmlMap" + xmlMap);
		String xmlStr = printDataXML.getPrintXml(xmlMap);

		// 记录发票打印记录表
		BalInvprintInfoEntity balInvprintInfo = new BalInvprintInfoEntity();
		balInvprintInfo.setPrintSn(printSn);
		balInvprintInfo.setPrintArray(1);
		balInvprintInfo.setCustId(0l);
		balInvprintInfo.setIdNo(0l);
		balInvprintInfo.setPhoneNo(phoneNo);
		balInvprintInfo.setContractNo(contractNo);
		// balInvprintInfo.setRelContractNo(contractNo);
		balInvprintInfo.setInvType(CommonConst.YCFP_TYPE);
		balInvprintInfo.setState(CommonConst.NORMAL_STATUS);// 1:打印正常发票
		balInvprintInfo.setLoginNo(loginNo);
		balInvprintInfo.setGroupId(groupId);
		balInvprintInfo.setOpCode(opCode);
		balInvprintInfo.setTotalDate(DateUtils.getCurDay());
		balInvprintInfo.setInvCode(invCode);
		balInvprintInfo.setInvNo(invNo);
		balInvprintInfo.setPaySn(0l);
		balInvprintInfo.setTotalFee(printFee);
		balInvprintInfo.setPrintFee(printFee);
		balInvprintInfo.setTaxFee(0l);
		balInvprintInfo.setTaxRate(0d);
		balInvprintInfo.setPrintNum(1);
		balInvprintInfo.setRemark("集团打印发票");
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
		balInvprintdetInfo.setPhoneNo(phoneNo);
		balInvprintdetInfo.setContractNo(contractNo);
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

		// 同步CRM统一接触
		ChngroupRelEntity cgre = group.getRegionDistinct(groupId, "2", inDto.getProvinceId());
		Map<String, Object> oprCnttMap = new HashMap<String, Object>();
		oprCnttMap.put("Header", inDto.getHeader());
		oprCnttMap.put("PAY_SN", printSn);
		oprCnttMap.put("LOGIN_NO", inDto.getLoginNo());
		oprCnttMap.put("GROUP_ID", inDto.getGroupId());
		oprCnttMap.put("OP_CODE", inDto.getOpCode());
		oprCnttMap.put("REGION_ID", cgre.getRegionCode());
		oprCnttMap.put("OP_NOTE", "打印集团手工发票");
		oprCnttMap.put("TOTAL_FEE", 0);
		if (StringUtils.isNotEmpty(phoneNo)) {
			oprCnttMap.put("CUST_ID_TYPE", "1");
			oprCnttMap.put("CUST_ID_VALUE", phoneNo);
		} else {
			oprCnttMap.put("CUST_ID_TYPE", "3");
			oprCnttMap.put("CUST_ID_VALUE", contractNo);
		}

		// 取系统时间
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		oprCnttMap.put("OP_TIME", sCurTime);
		preOrder.sendOprCntt(oprCnttMap);

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
		loe.setOpCode("8215");
		loe.setRemark(loginNo + "打印集团手工发票");
		record.saveLoginOpr(loe);

		S8215PrintOutDTO outDto = new S8215PrintOutDTO();
		InvNoOccupyEntity occupy = new InvNoOccupyEntity();
		occupy.setInvCode(invCode);
		occupy.setInvNo(invNo);
		occupy.setFee(printFee);
		occupy.setXmlStr(xmlStr);
		outDto.setInvNoOccupy(occupy);
		return outDto;
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

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
	}

	public ILogin getLogin() {
		return login;
	}

	public void setLogin(ILogin login) {
		this.login = login;
	}

	public IPreOrder getPreOrder() {
		return preOrder;
	}

	public void setPreOrder(IPreOrder preOrder) {
		this.preOrder = preOrder;
	}

	public IRecord getRecord() {
		return record;
	}

	public void setRecord(IRecord record) {
		this.record = record;
	}

}

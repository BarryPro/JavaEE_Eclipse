package com.sitech.acctmgr.atom.impl.invoice;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.invoice.inter.IPrintDataXML;
import com.sitech.acctmgr.atom.busi.pay.inter.IPreOrder;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditAdjEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.invoice.S8157PrintInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8157PrintOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBase;
import com.sitech.acctmgr.atom.entity.inter.ICredit;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.invoice.I8157Print;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

/**
 * 名称：8157打印免填单
 * 
 * @author liuhl_bj
 *
 */
@ParamTypes({ @ParamType(c = S8157PrintInDTO.class, oc = S8157PrintOutDTO.class, m = "print") })
public class S8157Print extends AcctMgrBaseService implements I8157Print {
	private IUser user;
	private ICust cust;
	private IBase base;
	private IRecord record;
	private ILogin login;
	private IPrintDataXML printDataXml;
	private ICredit credit;
	private IPreOrder preOrder;
	private IGroup group;

	@Override
	public OutDTO print(InDTO inParam) {
		S8157PrintInDTO inDto = (S8157PrintInDTO) inParam;

		long loginAccept = inDto.getLoginAccept();
		int oprTime = inDto.getOprTime();

		// 根据流水查询备注、操作时间
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("SUFFIX", oprTime / 100);
		inMap.put("LOGIN_ACCEPT", loginAccept);
		LoginOprEntity loginOpr = record.getLoginOpr(inMap);

		String phoneNo = loginOpr.getPhoneNo();
		// String oprLoginNo = loginOpr.getLoginNo();
		// 根据服务号码查询用户信息
		UserInfoEntity userInfo = new UserInfoEntity();

		userInfo = user.getUserInfo(phoneNo);
		long custId = userInfo.getCustId();

		// 根据cust_id查询客户信息
		CustInfoEntity custInfo = cust.getCustInfo(custId, "");
		String custName = custInfo.getCustName();
		String custAddress = custInfo.getCustAddress();
		String idIccid = custInfo.getIdIccid();

		// 根据流水和id_no查询信用度修改资料
		inMap = new HashMap<String, Object>();
		inMap.put("ID_NO", userInfo.getIdNo());
		inMap.put("LOGIN_ACCEPT", loginAccept);
		CreditAdjEntity creditInfo = credit.getCreditAdj(inMap);
		
		long oldLimit = creditInfo.getOldLimitOwe();
		long newLimit = creditInfo.getNewLimitOwe();

		// 根据op_code查询业务名称
		String opCode = inDto.getOpCode();
		String opName = base.getFunctionName(opCode);

		// 根据工号查询工号名称
		String loginNo = inDto.getLoginNo();
		LoginEntity loginInfo = login.getLoginInfo(loginNo, inDto.getProvinceId().toString());
		String loginName = loginInfo.getLoginName();

		String opTime = loginOpr.getOpTime();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
		String printDate = df.format(new Date());

		Map<String, Object> outMap = new HashMap<String, Object>();
		outMap.put("PRINT_TYPE", "0nn");
		outMap.put("OP_CODE", opCode);

		outMap.put("PRINT_DATE", printDate);
		outMap.put("LOGIN_INFO", loginNo + " " + loginName);
		outMap.put("FIRST_LINE", "手机号码：" + phoneNo);
		outMap.put("SECOND_LINE", "客户名称：" + custName);
		outMap.put("THIRD_LINE", "客户地址：" + custAddress);
		outMap.put("FORTH_LINE", "证件号码：" + idIccid);
		outMap.put("FIFTH_LINE", "业务类型：" + opName);
		outMap.put("SIXTH_LINE", "业务办理前信誉度：" + ValueUtils.transFenToYuan(oldLimit));
		outMap.put("SEVENTH_LINE", "业务办理后信誉度：" + ValueUtils.transFenToYuan(newLimit));
		outMap.put("EIGTH_LINE", "流水：" + loginAccept);
		outMap.put("NINTH_LINE", loginName);
		outMap.put("TEN_LINE", opTime);
		outMap.put("ELEVEN_LINE", opName);
		outMap.put("TWELVE_LINE", loginOpr.getRemark());

		String xmlStr = printDataXml.getPrintXml(outMap);

		S8157PrintOutDTO outDto = new S8157PrintOutDTO();
		outDto.setXmlStr(xmlStr);
		// 记录营业员操作日志
		LoginOprEntity in = new LoginOprEntity();
		in.setIdNo(userInfo.getIdNo());
		in.setBrandId(userInfo.getBrandId());
		in.setPhoneNo(phoneNo);
		in.setPayType("");
		in.setPayFee(0);
		in.setLoginSn(loginAccept);
		in.setLoginNo(inDto.getLoginNo());
		in.setLoginGroup(inDto.getGroupId());
		in.setOpCode(inDto.getOpCode());
		in.setTotalDate(DateUtils.getCurDay());
		in.setRemark(loginNo + "修改信誉度后打印免填单");
		record.saveLoginOpr(in);

		// 同步CRM统一接触
		ChngroupRelEntity cgre = group.getRegionDistinct(inDto.getGroupId(), "2", inDto.getProvinceId());
		Map<String, Object> oprCnttMap = new HashMap<String, Object>();
		oprCnttMap.put("Header", inDto.getHeader());
		oprCnttMap.put("PAY_SN", loginAccept);
		oprCnttMap.put("LOGIN_NO", inDto.getLoginNo());
		oprCnttMap.put("GROUP_ID", inDto.getGroupId());
		oprCnttMap.put("OP_CODE", inDto.getOpCode());
		oprCnttMap.put("REGION_ID", cgre.getRegionCode());
		oprCnttMap.put("OP_NOTE", loginNo + "修改信誉度后打印免填单");
		oprCnttMap.put("TOTAL_FEE", 0);
		oprCnttMap.put("CUST_ID_TYPE", "1");
		oprCnttMap.put("CUST_ID_VALUE", phoneNo);
		// 取系统时间
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		oprCnttMap.put("OP_TIME", sCurTime);
		preOrder.sendOprCntt(oprCnttMap);
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

	public IBase getBase() {
		return base;
	}

	public void setBase(IBase base) {
		this.base = base;
	}

	public IRecord getRecord() {
		return record;
	}

	public void setRecord(IRecord record) {
		this.record = record;
	}

	public ILogin getLogin() {
		return login;
	}

	public void setLogin(ILogin login) {
		this.login = login;
	}

	public IPrintDataXML getPrintDataXml() {
		return printDataXml;
	}

	public void setPrintDataXml(IPrintDataXML printDataXml) {
		this.printDataXml = printDataXml;
	}

	public ICredit getCredit() {
		return credit;
	}

	public void setCredit(ICredit credit) {
		this.credit = credit;
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

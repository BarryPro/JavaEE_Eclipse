package com.sitech.acctmgr.atom.busi.invoice;

import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.dom4j.tree.DefaultAttribute;

import com.sitech.acctmgr.atom.busi.invoice.inter.IPrintDataXML;
import com.sitech.acctmgr.atom.domains.invoice.InvoiceDispEntity;
import com.sitech.acctmgr.atom.domains.invoice.InvoiceEntity;
import com.sitech.acctmgr.atom.domains.invoice.PreInvoiceDispEntity;
import com.sitech.acctmgr.atom.domains.invoice.PrtXmlEntity;
import com.sitech.acctmgr.atom.domains.pub.PubCodeDictEntity;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.common.utils.RandomUtils;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.dt.MBean;

//import oracle.sql.BLOB;

/**
 *
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author
 * @version 1.0 qSequence
 */
@SuppressWarnings({ "unchecked", "rawtypes", "unused" })
public class PrintDataXML extends BaseBusi implements IPrintDataXML {

	// private static Log log = LogFactory.getLog(PrintModelUtil.class);
	protected IInvoice invoice;
	private IControl control;

	@Override
	public String getPrintXml(InvoiceDispEntity invoiceDisp, int userFlag, String userType) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		Map<String, Object> feeMap = new HashMap<String, Object>();
		long printFee = 0;

		/* 拼接发票xml报文 */
		log.debug("基本信息：" + invoiceDisp.getBaseInvoice());
		inMap.put("PRINT_DATE", invoiceDisp.getBaseInvoice().getPrintDate());
		inMap.put("INV_NO_NAME", invoiceDisp.getBaseInvoice().getInvNoName());
		log.debug("invoiceDisp.getBaseInvoice().getOpCode():" + invoiceDisp.getBaseInvoice().getOpCode());
		inMap.put("OP_CODE", invoiceDisp.getBaseInvoice().getOpCode());
		inMap.put("OP_NAME", invoiceDisp.getBaseInvoice().getOpName());
		inMap.put("INV_NUM", invoiceDisp.getBaseInvoice().getInvNo());
		inMap.put("CUST_NAME", invoiceDisp.getBaseInvoice().getCustName());
		inMap.put("PHONE_NO", invoiceDisp.getBaseInvoice().getPhoneNo());
		inMap.put("BRAND_NAME", invoiceDisp.getBaseInvoice().getBrandName());
		inMap.put("CONTRACT_NO", invoiceDisp.getBaseInvoice().getContractNo());
		inMap.put("TOTAL_DATE", invoiceDisp.getBaseInvoice().getPrintDate());
		// 预存发票
		inMap.put("BILL_CYCLE", invoiceDisp.getPreInvoice().getBillCycle());
		inMap.put("COMPACT_NO", invoiceDisp.getPreInvoice().getCompactNo());
		inMap.put("CHECK_NO", invoiceDisp.getPreInvoice().getCheckNo());
		inMap.put("UNIT_CONTRACT_NO", invoiceDisp.getBaseInvoice().getUnitNo());
		inMap.put("REMARK", invoiceDisp.getBaseInvoice().getRemark());
		inMap.put("KD_PHONE", invoiceDisp.getBaseInvoice().getKdPhone());
		int random = RandomUtils.getRandom();
		inMap.put("RANDOM", random);
		feeMap = adjFeeGrad(invoiceDisp, 2, userFlag);
		// 获取费用名称
		long codeClass = 1100;
		Map<String, Object> feeNameMap = new HashMap<String, Object>();
		List<PubCodeDictEntity> pubcodeList = control.getPubCodeList(codeClass, "", "", "");
		for (PubCodeDictEntity pubCode : pubcodeList) {
			feeNameMap.put(pubCode.getCodeValue(), pubCode.getCodeName());
		}
		if (userFlag == CommonConst.NO_NET) {
			feeNameMap.remove("BALANCE_NAME");
			feeNameMap.remove("UNBILL_NAME");
			feeNameMap.remove("REMAIN_NAME");
			feeNameMap.put("OWE_NAME", "本次交欠费：");
		} else {
			// 判断是否为微信支付，如果是微信支付
			Map<String, Object> judgeWechatMap = new HashMap<String, Object>();
			boolean flag=false;
			if (invoiceDisp.getPreInvoice().getPayMethod().equals("i")) {
				flag = true;
			}
			if (flag) {
				feeNameMap.remove("CASH_NAME");
			} else {
				feeNameMap.remove("WCHAT_NAME");
			}
			if (invoiceDisp.getBaseInvoice().getOpCode().equals("8008")) {
				feeNameMap.remove("BALANCE_NAME");
				feeNameMap.remove("UNBILL_NAME");
				feeNameMap.remove("REMAIN_NAME");
			}
			feeNameMap.remove("DELAY_NAME");
			feeNameMap.remove("BILL_NAME");
		}
		inMap.put("FEE_NAME", feeNameMap);
		inMap.put("FEE_INFO", feeMap);
		inMap.put("PRINT_TYPE", dealPrintType("2"));
		if (userType.equals(CommonConst.USERTYPE_WLW)) {
			inMap.put("PRINT_TYPE", "20n");
		}
		if (userType.equals(CommonConst.USERTYPE_GRP) && !invoiceDisp.getBaseInvoice().getOpCode().equals("8074")) {
			inMap.put("PRINT_TYPE", "21n");
		}
		if (userType.equals(CommonConst.USERTYPE_BROADBAND)) {
			inMap.put("PRINT_TYPE", "200");
		}
		if (userType.equals(CommonConst.USERTYPE_TTBROAD)) {
			inMap.put("PRINT_TYPE", "201");
		}
		inMap.put("LOGIN_NAME", invoiceDisp.getBaseInvoice().getLoginName());
		inMap.put("GROUP_NAME", invoiceDisp.getBaseInvoice().getGroupName());
		inMap.put("LOGIN_NO", invoiceDisp.getBaseInvoice().getLoginNo());
		inMap.put("PRINT_DATE", invoiceDisp.getBaseInvoice().getPrintDate());
		inMap.put("PRINT_SN", "" + invoiceDisp.getBaseInvoice().getLoginAccept());

		String xmlStr = getfinalPrtInfo(inMap);

		return xmlStr;
	}

	private String dealPrintType(String printType) {
		String printTypeFinal = printType.concat("nn");
		return printTypeFinal;
	}

	/**
	 * 获取发票打印报文
	 * 
	 * @author liuhl
	 * 
	 * @param inParam
	 * @return
	 */

	private String getfinalPrtInfo(Map<String, Object> inParam) {

		log.debug(inParam + "**********************");
		List<PrtXmlEntity> prtInfo = new ArrayList<PrtXmlEntity>();
		String sModelId = "";
		String sModelStr = "";

		if (PrintModelUtil.getInstance() == null) {
			PrintModelUtil.getInstance(invoice);
		}
		log.debug("inParam = " + inParam);
		/* 判断是否有发票模板号 */

		/* 重新加载发票模板号IDMap */
		log.debug("op_code=" + inParam.get("OP_CODE"));
		log.debug("print_type=" + inParam.get("PRINT_TYPE"));
		sModelId = PrintModelUtil.refreshPrintModelRela(inParam.get("OP_CODE").toString(), inParam.get("PRINT_TYPE").toString());

		log.debug("sModelId" + sModelId);
		/* 查询发票报文XML */

		/* 重新加载发票模板Map */
		sModelStr = PrintModelUtil.refreshPrintModel(sModelId);

		MBean invInfoBean = new MBean();
		invInfoBean.setBody("MODEL_ID", sModelId);
		Iterator<String> it = inParam.keySet().iterator();
		for (Map.Entry<String, Object> entry : inParam.entrySet()) {
			log.debug("key= " + entry.getKey() + " and value= " + entry.getValue());
			/* if (entry.getKey().equals("DETAIL_FEE")) { continue; } */
			invInfoBean.setBody(entry.getKey(), entry.getValue());
		}

		invInfoBean.setBody("PRINT_MODEL", sModelStr);
		log.debug("invInfoBean=" + invInfoBean.toString());
		PrintXmlParser printParse = new PrintXmlParser();

		log.debug("invInfoBean=" + invInfoBean);
		String printXmlStr = printParse.doXmlParser(invInfoBean);
		printXmlStr = printXmlStr.replaceAll("\\n|\\r", "");
		printXmlStr = printXmlStr.replaceAll("UTF-8", "GB2312");

		return printXmlStr;

	}

	/**
	 * 名称：调整发票格式，发票费用转化为元，大写金额
	 * 
	 * @param invoice
	 * @param invoiceType
	 * @return
	 */
	private Map<String, Object> adjFeeGrad(InvoiceDispEntity invoice, int invoiceType, int userFlag) {
		Map<String, Object> feeMap = new HashMap<String, Object>();
		List<Map<String, Object>> outList = new ArrayList<Map<String, Object>>();
		if (invoiceType == 2) {
			// 预存发票
			PreInvoiceDispEntity invoPre = invoice.getPreInvoice();
			feeMap.put("PRINT_FEE", ValueUtils.transFenToYuan(invoPre.getPrintFee()));
			feeMap.put("BIG_MONEY", ValueUtils.transYuanToChnaBig(feeMap.get("PRINT_FEE")));
			feeMap.put("CASH_MONEY", ValueUtils.transFenToYuan(invoPre.getCashMoney()));
			feeMap.put("CHECK_MONEY", ValueUtils.transFenToYuan(invoPre.getCheckMoney()));
			feeMap.put("POS_MONEY", ValueUtils.transFenToYuan(invoPre.getPosMoney()));
			feeMap.put("CAPTIAL_FEE", ValueUtils.transFenToYuan(invoPre.getBillFee()));
			feeMap.put("DELAY_FEE", ValueUtils.transFenToYuan(invoPre.getDelayFee()));
			feeMap.put("BALANCE_FEE", ValueUtils.transFenToYuan(invoPre.getBalanceFee()));
			feeMap.put("UNBILL_FEE", ValueUtils.transFenToYuan(invoPre.getUnbillFee()));
			feeMap.put("REMAIN_FEE", ValueUtils.transFenToYuan(invoPre.getRemainFee()));
			feeMap.put("LAST_FEE", ValueUtils.transFenToYuan(invoPre.getRemainFee() - invoPre.getPrintFee()));
			if (userFlag == CommonConst.NO_NET) {
				feeMap.remove("BALANCE_FEE");
				feeMap.remove("UNBILL_FEE");
				feeMap.remove("REMAIN_FEE");
			} else {
				if (invoice.getBaseInvoice().getOpCode().equals("8008")) {
					feeMap.remove("BALANCE_FEE");
					feeMap.remove("UNBILL_FEE");
					feeMap.remove("REMAIN_FEE");
				}
				feeMap.remove("CAPTIAL_FEE");
				feeMap.remove("DELAY_FEE");
			}
		}
		return feeMap;
	}

	/**
	 * 获得发票模板信息
	 * 
	 * @param inParam
	 * @param seXMLFlag
	 * @return
	 */
	private List<PrtXmlEntity> getFinalPrtInfo(Map<String, Object> inParam) {
		log.debug(inParam + "**********************");
		List<PrtXmlEntity> prtInfo = new ArrayList<PrtXmlEntity>();
		String sModelId = "";
		String sModelStr = "";

		if (PrintModelUtil.getInstance() == null) {
			PrintModelUtil.getInstance(invoice);
		}
		log.debug("inParam = " + inParam);
		/* 判断是否有发票模板号 */

		/* 重新加载发票模板号IDMap */
		System.out.println("op_code=" + inParam.get("OP_CODE"));
		System.out.println("print_type=" + inParam.get("PRINT_TYPE"));
		sModelId = PrintModelUtil.refreshPrintModelRela(inParam.get("OP_CODE").toString(), inParam.get("PRINT_TYPE").toString());

		log.debug("sModelId" + sModelId);
		/* 查询发票报文XML */

		/* 重新加载发票模板Map */
		sModelStr = PrintModelUtil.refreshPrintModel(sModelId);

		MBean invInfoBean = new MBean();
		invInfoBean.setBody("MODEL_ID", sModelId);
		invInfoBean.setBody("PHONE_NO", inParam.get("PHONE_NO"));
		invInfoBean.setBody("CONTRACT_NO", inParam.get("CONTRACT_NO").toString());
		invInfoBean.setBody("COMPACT_NO", inParam.get("COMPACT_NO"));
		invInfoBean.setBody("BILL_CYCLE", inParam.get("BILL_CYCLE"));
		invInfoBean.setBody("CHECK_NO", inParam.get("CHECK_NO"));
		invInfoBean.setBody("UNIT_CONTRACT_NO", inParam.get("UNIT_CONTRACT_NO"));
		invInfoBean.setBody("GROUP_NAME", inParam.get("GROUP_NAME"));
		invInfoBean.setBody("CUST_NAME", inParam.get("CUST_NAME"));
		invInfoBean.setBody("OP_NAME", inParam.get("OP_NAME"));
		invInfoBean.setBody("LOGIN_NO", inParam.get("LOGIN_NO"));
		invInfoBean.setBody("LOGIN_NAME", inParam.get("LOGIN_NAME"));
		invInfoBean.setBody("INV_NUM", inParam.get("INV_NUM").toString());
		invInfoBean.setBody("PRINT_DATE", inParam.get("PRINT_DATE"));
		invInfoBean.setBody("PRINT_SN", inParam.get("PRINT_SN"));
		invInfoBean.setBody("BRAND_NAME", inParam.get("BRAND_NAME").toString());
		// invInfoBean.setBody("PAY_METHOD_NAME",
		// inParam.get("PAY_METHOD_NAME").toString());
		MBean invBean = new MBean(invInfoBean.toString());

		invInfoBean.setBody("PRINT_MODEL", sModelStr);
		log.debug("invInfoBean=" + invInfoBean.toString());
		PrintXmlParser printParse = new PrintXmlParser();
		for (Map<String, Object> feeInfo : (List<Map<String, Object>>) inParam.get("DETAIL_LIST")) {
			// 取出发票模板
			invInfoBean.setBody("FEE_INFO", feeInfo.get("FEE_INFO"));
			invBean.setBody("FEE_INFO", feeInfo.get("FEE_INFO"));
			log.debug("invInfoBean=" + invInfoBean);
			String printXmlStr = printParse.doXmlParser(invInfoBean);
			printXmlStr = printXmlStr.replaceAll("\\n|\\r", "");
			printXmlStr = printXmlStr.replaceAll("UTF-8", "GB2312");

			Map<String, String> prtMap = new HashMap<String, String>();

			prtMap.put("PRINT_XML", printXmlStr);
			PrtXmlEntity prtEnty = new PrtXmlEntity();
			prtEnty.setPrtXml(printXmlStr);

			prtInfo.add(prtEnty);
		}

		return prtInfo;
	}

	/* 查询发票打印模板的函数 */
	protected String getFinalPrintInfo(Map<String, Object> inParam) {
		String sModelId = "";
		String sModelStr = "";
		// PrintModelUtil.setInstance(null);
		if (PrintModelUtil.getInstance() == null) {
			PrintModelUtil.getInstance(invoice);
		}

		/* 判断是否有发票模板号 */
		// if(PrintModelUtil.printModelRelaMap.containsKey(inParam.get("OP_CODE").toString()+"_"+inParam.get("PRINT_TYPE").toString())){
		// sModelId =
		// PrintModelUtil.printModelRelaMap.get(inParam.get("OP_CODE").toString()+"_"+inParam.get("PRINT_TYPE").toString());
		// }else{
		/* 重新加载发票模板号IDMap */
		sModelId = PrintModelUtil.refreshPrintModelRela(inParam.get("OP_CODE").toString(), inParam.get("PRINT_TYPE").toString());
		// }
		log.debug("sModelId=" + sModelId);
		/* 查询发票报文XML */
		// if(PrintModelUtil.printModelMap.containsKey(sModelId)){
		// System.out.println("testPrintModelId="+PrintModelUtil.printModelRelaMap.get(inParam.get("OP_CODE").toString()+"_"+inParam.get("PRINT_TYPE").toString()));
		// sModelStr = PrintModelUtil.printModelMap.get(sModelId);
		// }else{
		/* 重新加载发票模板Map */
		sModelStr = PrintModelUtil.refreshPrintModel(sModelId);
		// }

		MBean invInfoBean = new MBean();
		invInfoBean.setBody("PRINT_MODEL", sModelStr);
		invInfoBean.setBody("PHONE_NO", inParam.get("PHONE_NO"));
		invInfoBean.setBody("CONTRACT_NO", inParam.get("CONTRACT_NO").toString());
		invInfoBean.setBody("CUST_NAME", inParam.get("CUST_NAME"));
		invInfoBean.setBody("LOGIN_NO", inParam.get("LOGIN_NO"));
		if (inParam.containsKey("INV_NUM")) {
			invInfoBean.setBody("INV_NUM", inParam.get("INV_NUM").toString());
		}
		invInfoBean.setBody("PRINT_DATE", inParam.get("PRINT_DATE"));
		invInfoBean.setBody("PRINT_SN", inParam.get("PRINT_SN"));
		invInfoBean.setBody("PAY_TIME", inParam.get("PAY_TIME"));
		invInfoBean.setBody("TYPE_NAME", inParam.get("TYPE_NAME"));
		invInfoBean.setBody("UNIT_NAME", inParam.get("UNIT_NAME"));
		invInfoBean.setBody("PHONE_NO", inParam.get("PHONE_NO"));
		invInfoBean.setBody("CONTRACT_NO", inParam.get("CONTRACT_NO"));
		invInfoBean.setBody("BRAND_NAME", "");
		invInfoBean.setBody("ITEM_NAME", inParam.get("ITEM_NAME"));
		invInfoBean.setBody("INVOICE_FEE", inParam.get("INVOICE_FEE"));
		invInfoBean.setBody("BIG_MONEY", inParam.get("BIG_MONEY"));
		if (inParam.containsKey("PRINT_FEE")) {
			invInfoBean.setBody("PRINT_FEE", inParam.get("PRINT_FEE"));
			invInfoBean.setBody("BILL_CYCLE", inParam.get("BILL_CYCLE"));
			invInfoBean.setBody("BIG_MONEY", inParam.get("BIG_MONEY"));
		}
		if (inParam.containsKey("PAY_SN")) {
			invInfoBean.setBody("PAY_SN", inParam.get("PAY_SN"));
		}
		if (inParam.containsKey("DETAIL_LIST")) {
			invInfoBean.setBody("DETAIL_LIST", inParam.get("DETAIL_LIST"));
		}

		/* 解析发票模板 */
		PrintXmlParser printParse = new PrintXmlParser();
		String printXmlStr = printParse.doXmlParser(invInfoBean);
		printXmlStr = printXmlStr.replaceAll("\\n|\\r", "");
		printXmlStr = printXmlStr.replaceAll("UTF-8", "GB2312");
		return printXmlStr;
	}



	/**
	 *
	 * <p>
	 * Title: 发票模板组装工具类
	 * </p>
	 * <p>
	 * Description: 对发票模板和数据的组装，输出组装好的字符串
	 * </p>
	 * <p>
	 * Copyright: Copyright (c) 2014
	 * </p>
	 * <p>
	 * Company: SI-TECH
	 * </p>
	 * 
	 * @author fanck
	 * @version 1.0
	 */
	class PrintXmlParser {
		public int busiSeq = 10000;
		/* public String billType = "";//提取子模板使用 public String regionId = "";//提取子模板使用 public boolean isHead = false;//防止子报文中包含子报文 public boolean isTail = false;//防止子报文中包含子报文 */
		public MBean totalBean = null;

		/* 根据名字的长度，调整发票模板，换行 */
		public void cutName(MBean invInfoBean) {
			String custName = invInfoBean.getBodyStr("CUST_NAME");
			String sModelStr = invInfoBean.getBodyStr("PRINT_MODEL");

			if (custName == null)
				return;
			if (sModelStr == null)
				return;

			String inStr1 = new String();
			String inStr2 = new String();

			log.debug("!!!!!!!!!!!!!!=" + invInfoBean.getBodyStr("CUST_NAME"));

			int curLen = custName.length();
			int num = 0;
			while (curLen > 0) {
				String tempStr = "";
				// 每行支持15个汉字
				if (curLen > 15) {
					curLen -= 15;
					tempStr = custName.substring(num * 15, (num + 1) * 15);

				} else {
					curLen = 0;
					tempStr = custName.substring(num * 15);
				}

				invInfoBean.setBody("CUST_NAME_SUB" + num, tempStr);// CUST_NAME_SUB1~n
				log.debug("!!!!!!!!!!!!!!tempStr=" + tempStr);

				num++;
			}

			/* 调整发票模板 */
			if (num == 1)
				return; // 1行不需要处理
			else { // 最多支持折2行，多余的扔掉. 客户姓名前台限制30个汉字
				int n = sModelStr.indexOf("VarName=\"CUST_NAME\"");
				if (n < 0)
					return; // 此模板没有cust_name字段

				String preStr = sModelStr.substring(0, n);
				String lastStr = sModelStr.substring(n);

				n = preStr.lastIndexOf("<Text");
				preStr = preStr.substring(0, n);

				n = lastStr.indexOf("/>");
				lastStr = lastStr.substring(n + 2);

				String TempStr = preStr
						+ "<Text IsModifier=\"N\" ElType=\"text\" FontSize=\"8\" Left=\"420\" Top=\"15\" Width=\"300\" Height=\"55\" PrintCondition=\"1\" FontWeight=\"bold\" PrintContent=\"$()\" PrintContentDesc=\"\" VarName=\"CUST_NAME_SUB0\" VarSrc=\"xml\" FontName=\"宋体\"/> "
						+ "<Text IsModifier=\"N\" ElType=\"text\" FontSize=\"8\" Left=\"420\" Top=\"45\" Width=\"300\" Height=\"55\" PrintCondition=\"1\" FontWeight=\"bold\" PrintContent=\"$()\" PrintContentDesc=\"\" VarName=\"CUST_NAME_SUB1\" VarSrc=\"xml\" FontName=\"宋体\"/>"
						+ lastStr;
				invInfoBean.setBody("PRINT_MODEL", TempStr);
			}

			log.debug("!!!!!!!!!!!!!!=" + invInfoBean.getBodyStr("PRINT_MODEL"));
			return;
		}

		public void cutNameColl(MBean invInfoBean) {
			String custName = invInfoBean.getBodyStr("COLL_INFO.BANK_NAME_COLL");
			String sModelStr = invInfoBean.getBodyStr("PRINT_MODEL");

			if (custName == null)
				return;
			if (sModelStr == null)
				return;

			log.debug("!!!!!!!!!!!!!!=" + invInfoBean.getBodyStr("COLL_INFO.BANK_NAME_COLL"));

			int curLen = custName.length();
			int num = 0;
			while (curLen > 0) {
				String tempStr = "";
				// 每行支持10个汉字
				if (curLen > 10) {
					curLen -= 10;
					tempStr = custName.substring(num * 10, (num + 1) * 10);

				} else {
					curLen = 0;
					tempStr = custName.substring(num * 10);
				}

				invInfoBean.setBody("COLL_INFO.BANK_NAME_COLL_SUB" + num, tempStr);// CUST_NAME_SUB1~n
				log.debug("!!!!!!!!!!!!!!tempStr=" + tempStr);

				num++;
			}

			/* 调整发票模板 */
			if (num == 1)
				return; // 1行不需要处理
			else if (num == 2) { // 最多支持折3行
				int n = sModelStr.indexOf("VarName=\"COLL_INFO.BANK_NAME_COLL\"");
				if (n < 0)
					return; // 此模板没有cust_name字段

				String preStr = sModelStr.substring(0, n);
				String lastStr = sModelStr.substring(n);

				n = preStr.lastIndexOf("<Text");
				preStr = preStr.substring(0, n);

				n = lastStr.indexOf("/>");
				lastStr = lastStr.substring(n + 2);

				String TempStr = preStr
						+ "<Text IsModifier=\"N\" ElType=\"text\" FontSize=\"8\" Left=\"1080\" Top=\"5\" Width=\"600\" Height=\"35\" PrintCondition=\"1\" FontWeight=\"bold\" PrintContent=\"$()\" VarName=\"COLL_INFO.BANK_NAME_COLL_SUB0\" VarSrc=\"xml\" PrintContentDesc=\"\" FontName=\"宋体\"/> "
						+ "<Text IsModifier=\"N\" ElType=\"text\" FontSize=\"8\" Left=\"1080\" Top=\"35\" Width=\"600\" Height=\"35\" PrintCondition=\"1\" FontWeight=\"bold\" PrintContent=\"$()\" VarName=\"COLL_INFO.BANK_NAME_COLL_SUB1\" VarSrc=\"xml\" PrintContentDesc=\"\" FontName=\"宋体\"/>"
						+ lastStr;
				invInfoBean.setBody("PRINT_MODEL", TempStr);
			} else { // 最多支持折3行，多余的扔掉. 客户姓名前台限制30个汉字
				int n = sModelStr.indexOf("VarName=\"COLL_INFO.BANK_NAME_COLL\"");
				if (n < 0)
					return; // 此模板没有cust_name字段

				String preStr = sModelStr.substring(0, n);
				String lastStr = sModelStr.substring(n);

				n = preStr.lastIndexOf("<Text");
				preStr = preStr.substring(0, n);

				n = lastStr.indexOf("/>");
				lastStr = lastStr.substring(n + 2);

				String TempStr = preStr
						+ "<Text IsModifier=\"N\" ElType=\"text\" FontSize=\"8\" Left=\"1080\" Top=\"0\" Width=\"600\" Height=\"65\" PrintCondition=\"1\" FontWeight=\"bold\" PrintContent=\"$()\" VarName=\"COLL_INFO.BANK_NAME_COLL_SUB0\" VarSrc=\"xml\" PrintContentDesc=\"\" FontName=\"宋体\"/> "
						+ "<Text IsModifier=\"N\" ElType=\"text\" FontSize=\"8\" Left=\"1080\" Top=\"25\" Width=\"600\" Height=\"65\" PrintCondition=\"1\" FontWeight=\"bold\" PrintContent=\"$()\" VarName=\"COLL_INFO.BANK_NAME_COLL_SUB1\" VarSrc=\"xml\" PrintContentDesc=\"\" FontName=\"宋体\"/>"
						+ "<Text IsModifier=\"N\" ElType=\"text\" FontSize=\"8\" Left=\"1080\" Top=\"50\" Width=\"600\" Height=\"65\" PrintCondition=\"1\" FontWeight=\"bold\" PrintContent=\"$()\" VarName=\"COLL_INFO.BANK_NAME_COLL_SUB2\" VarSrc=\"xml\" PrintContentDesc=\"\" FontName=\"宋体\"/>"
						+ lastStr;
				invInfoBean.setBody("PRINT_MODEL", TempStr);
			}

			log.debug("!!!!!!!!!!!!!!=" + invInfoBean.getBodyStr("PRINT_MODEL"));
			return;
		}

		public String doXmlParser(MBean invInfoBean) {
			String printModelInstanceStr = "";
			totalBean = invInfoBean;
			SAXReader reader = new SAXReader();

			cutName(invInfoBean);
			cutNameColl(invInfoBean);

			try {
				Document doc = reader.read(new StringReader(invInfoBean.getBodyStr("PRINT_MODEL")));
				// 获取XML根元素
				Element root = doc.getRootElement();

				getElementList(root, invInfoBean);

				// 删除VarSrc,VarName属性
				delElementList(root);

				printModelInstanceStr = doc.asXML();

				// 删除子模板的根节点
				printModelInstanceStr.replaceAll("<ChildModel>", "");
				printModelInstanceStr.replaceAll("</ChildModel>", "");

			} catch (DocumentException e) {
				e.printStackTrace();
			}

			log.debug("!!!!!!!!!!!!!!=" + printModelInstanceStr);
			return printModelInstanceStr;
		}

		/**
		 * 递归遍历方法
		 * 
		 * @param element
		 */
		private void getElementList(Element element, MBean invInfoBean) {

			List<Element> elements = (List<Element>) element.elements();
			if (!elements.isEmpty()) {
				// 有子元素
				Iterator<Element> it = elements.iterator();
				while (it.hasNext()) {
					Element elem = (Element) it.next();
					// 递归遍历属性
					getNoteAttribute(elem, invInfoBean);
					// 递归遍历节点
					getElementList(elem, invInfoBean);
				}
			}
		}

		private void delElementList(Element element) {
			List<Element> elements = element.elements();
			if (!elements.isEmpty()) {
				// 有子元素
				Iterator<Element> it = elements.iterator();
				while (it.hasNext()) {
					Element elem = (Element) it.next();
					// 递归遍历属性
					delNoteAttribute(elem);
					// 递归遍历节点
					delElementList(elem);
				}

			}

		}

		private void delNoteAttribute(Element element) {
			DefaultAttribute e = null;
			List<Element> list = element.attributes();
			// 删除VarSrc,VarName
			for (int i = 0; i < list.size(); i++) {
				e = (DefaultAttribute) list.get(i);
				if ("VarSrc".equals(e.getName())) {
					element.remove(e);
					i--;
				}
				if ("VarName".equals(e.getName())) {
					element.remove(e);
					i--;
				}
			}
		}

		/**
		 * 获取节点所有属性值,根据属性条件填充模板
		 * 
		 * @param element
		 * @return
		 */
		private void getNoteAttribute(Element element, MBean invInfoBean) {
			DefaultAttribute e = null;
			List<Element> list = element.attributes();
			String varSrc = "";
			String varName = "";
			int modulusInt = 0;
			MBean childBean = null;
			int busiContentPos = 0;
			// MBean busiContent = new MBean();
			// JSONObject json = JSON.parseObject(busiStr);
			// busiContent.setBody(json);

			// 替换子报文:报文头和报文尾
			/* if("include".equals(element.getName())){ for (int i = 0; i < list.size(); i++) { e = (DefaultAttribute) list.get(i); if("src".equals(e.getName()) && "head".equals(e.getText()) && !isHead){ isHead = true; try { String printModelHeadId = ConfCacheUtil .getPrintModelRela(billType+Constants.SPLIT_STR+e.getText ()+Constants.SPLIT_STR+regionId); String printModelHeadStr = ConfCacheUtil.getPrintModel(printModelHeadId); SAXReader readerInclude = new SAXReader(); Document docInclude =
			 * readerInclude.read(new StringReader(printModelHeadStr));
			 * 
			 * // 获取XML根元素 Element rootInclude = docInclude.getRootElement(); getElementList(rootInclude,busiStr); //替换当前元素 List elepar = element.getParent().content(); elepar.set(elepar.indexOf(element),rootInclude); } catch (AppException e1) { e1.printStackTrace(); }catch (DocumentException e2) { e2.printStackTrace(); } } if("src".equals(e.getName()) && "tail".equals(e.getText()) && !isTail){ isTail = true; try { String printModelTailId = ConfCacheUtil
			 * .getPrintModelRela(billType+Constants.SPLIT_STR+e.getText ()+Constants.SPLIT_STR+regionId); String printModelTailStr = ConfCacheUtil.getPrintModel(printModelTailId); SAXReader readerInclude = new SAXReader(); Document docInclude = readerInclude.read(new StringReader(printModelTailStr)); // 获取XML根元素 Element rootInclude = docInclude.getRootElement(); getElementList(rootInclude,busiStr); //替换当前元素 List elepar = element.getParent().content();
			 * elepar.set(elepar.indexOf(element),rootInclude); } catch (AppException e1) { e1.printStackTrace(); }catch (DocumentException e2) { e2.printStackTrace(); } } } } */
			// xattribute +="["+e.getName()+"="+e.getText()+"]";
			// System.out.println("[xattribute]:"+xattribute);
			// 提取VarSrc,VarName
			for (int i = 0; i < list.size(); i++) {
				e = (DefaultAttribute) list.get(i);

				if ("VarSrc".equalsIgnoreCase(e.getName())) {
					varSrc = e.getText();
				}
				if ("VarName".equalsIgnoreCase(e.getName())) {
					varName = e.getText();
					varName = varName.replace("/", ".");
				}
				if ("Modulus".equalsIgnoreCase(e.getName())) {
					modulusInt = (new Integer(e.getText())).intValue();
				}
			}
			// 提取PrintContent
			for (int i = 0; i < list.size(); i++) {
				e = (DefaultAttribute) list.get(i);
				if ("PrintContent".equals(e.getName())) {
					/* if(varSrc!=null && !"".equals(varSrc) && "prog".equals(varSrc)){ e.setValue(e.getValue().replace("$()", ((Object)busiSeq).toString())); busiSeq++; }else */
					if (varSrc != null && !"".equals(varSrc) && ("json".equalsIgnoreCase(varSrc) || "xml".equalsIgnoreCase(varSrc))) {
						String varNameTemp = invInfoBean.getBodyStr(varName);
						if (varNameTemp != null && !"".equals(varNameTemp)) {// 可以把对空串的去掉
							e.setValue(e.getValue().replace("$()", varNameTemp));
						} else {
							/* 从总信息中取出 */
							varNameTemp = totalBean.getBodyStr(varName);
							if (varNameTemp != null && !"".equals(varNameTemp)) {
								e.setValue(e.getValue().replace("$()", varNameTemp));
							} else {
								/* 赋值空串，替换$() */
								e.setValue(e.getValue().replace("$()", ""));
							}
						}
					}
					break;
				}
			}
			// 判断是否isCycle=Y,如果是,克隆一份添加到和当前节点平级,去除isCycle节点
			Element isCycleObjTr = null;
			for (int m = 0; m < list.size(); m++) {
				e = (DefaultAttribute) list.get(m);
				if ("IsCycle".equals(e.getName()) && "Y".equals(e.getText())) {

					List<Map> busiContentList = invInfoBean.getBodyList(varName, Map.class);
					// 当前元素的打印属性已经替换完成,此循环处理要克隆的节点的打印内容的替换
					// 当前元素子元素
					if (busiContentList != null && busiContentList.size() > 0) {

						if (busiContentList.size() / modulusInt > 0) {
							// 循环克隆次数,是否多出的TD不够一次时多循环一次
							Element cycleElemTemp = (Element) element.clone();
							int trCount = busiContentList.size() % modulusInt == 0 ? 0 : 1;
							for (int t = 0; t < busiContentList.size() / modulusInt + trCount % modulusInt; t++) {
								if (t > 0) {
									/* 第2,3,4...次 */
									isCycleObjTr = (Element) cycleElemTemp.clone();
									// 对TR下的TD循环替换值,业务值由业务循环节点循环输入
									List<Element> elementTd = isCycleObjTr.elements();
									Iterator<Element> itTd = elementTd.iterator();
									while (itTd.hasNext()) {
										Element elemTd = (Element) itTd.next();
										if (busiContentPos < busiContentList.size()) {
											Map<String, Object> busiContentMap = (Map<String, Object>) busiContentList.get(busiContentPos);
											busiContentPos++;
											childBean = new MBean();
											childBean.setBody(busiContentMap);
											getElementList(elemTd, childBean);
										} else {
											// 如果TD总数超出业务节点总数,删除TD
											isCycleObjTr.remove(elemTd);
										}
									}
									element.getParent().add(isCycleObjTr);
								} else {
									// 首次循环,直接在当前节点下替换值
									List<Element> elementTd = element.elements();
									Iterator<Element> itTd = elementTd.iterator();
									while (itTd.hasNext()) {
										Element elemTd = (Element) itTd.next();
										if (busiContentPos < busiContentList.size()) {
											Map<String, Object> busiContentMap = (Map<String, Object>) busiContentList.get(busiContentPos);
											busiContentPos++;
											childBean = new MBean();
											// System.out.println("busiContentMap="+busiContentMap);;
											childBean.setBody(busiContentMap);
											getElementList(elemTd, childBean);
										} else {
											element.remove(elemTd);
										}
									}
								}
							}
						} else {
							// 无需循环,直接在当前节点下替换值
							List<Element> elementTd = element.elements();
							Iterator<Element> itTd = elementTd.iterator();
							while (itTd.hasNext()) {
								Element elemTd = (Element) itTd.next();
								if (busiContentPos < busiContentList.size()) {
									Map<String, Object> busiContentMap = (Map<String, Object>) busiContentList.get(busiContentPos);
									busiContentPos++;
									childBean = new MBean();
									childBean.setBody(busiContentMap);
									getElementList(elemTd, childBean);
								} else {
									element.remove(elemTd);
								}
							}
						}
					}
				}
			}
		}
	}


	public String dealPrintType(InvoiceEntity invoEntry) {

		String printType = invoEntry.getsPrintType();

		if (StringUtils.isNotEmptyOrNull(invoEntry.getPrintTypeOne())) {
			printType = printType.concat(invoEntry.getPrintTypeOne());
		} else {
			printType = printType.concat("n");
		}

		if (StringUtils.isNotEmptyOrNull(invoEntry.getPrintTypeTwo())) {
			printType = printType.concat(invoEntry.getPrintTypeTwo());
		} else {
			printType = printType.concat("n");
		}

		return printType;
	}

	/** 调整格式 **/
	public List<Map<String, Map>> adjInvGrad(List<List<Map<String, Object>>> detList) {
		/* String sTotalFee=""; Map<String,Object> monMap = null; List<Map<String,Map>> monList = new ArrayList<Map<String,Map>>(); Map<String,Map> zongMap = new HashMap<String,Map>(); for(List<Map<String,Object>> monListTemp:detList){ monMap = new HashMap<String,Object>(); zongMap = new HashMap<String,Map>(); for(Map<String,Object> monMapTemp:monListTemp){ monMap.put("BILL_CYCLE",monMapTemp.get("BILL_CYCLE").toString()); sTotalFee =
		 * ""+ValueUtils.transFenToYuan((Long)monMapTemp.get("TOTAL_FEE")); monMapTemp.put("TOTAL_FEE",sTotalFee); if((Integer)monMapTemp.get("SHOW_ORDER")==6){ monMap.put("PRINT_FEE",monMapTemp.get("TOTAL_FEE").toString()); monMap .put("BIG_MONEY",ValueUtils.transYuanToChnaBig(monMap.get("PRINT_FEE" ))); } } monMap.put("FEE_INFO",monListTemp); zongMap.put("MON_INFO",monMap); monList.add(zongMap); } */
		log.debug("detList=" + detList);
		String sTotalFee = "";
		Map<String, Object> monMap = null;
		List<Map<String, Map>> monList = new ArrayList<Map<String, Map>>();
		Map<String, Map> zongMap = new HashMap<String, Map>();

		for (List<Map<String, Object>> monListTemp : detList) {
			monMap = new HashMap<String, Object>();
			zongMap = new HashMap<String, Map>();
			int order = 0;
			for (Map<String, Object> monMapTemp : monListTemp) {

				sTotalFee = "" + ValueUtils.transFenToYuan((Long) monMapTemp.get("TOTAL_FEE"));
				String name = monMapTemp.get("SHOW_NAME").toString();
				order = ValueUtils.intValue(monMapTemp.get("SHOW_ORDER"));
				switch (order) {
				case 1:
					monMap.put("COMMUNIE_NAME", name);
					monMap.put("COMMUNIE_FEE", sTotalFee);
					break;
				case 2:
					monMap.put("DISCOUNT_NAME", name);
					monMap.put("DISCOUNT_FEE", sTotalFee);
					break;
				case 3:
					monMap.put("TOTAL_NAME", name);
					monMap.put("TOTAL_FEE", sTotalFee);
					break;
				case 4:
					monMap.put("PRINTED_NAME", name);
					monMap.put("PRINTED_FEE", sTotalFee);
					break;
				case 5:
					monMap.put("DISCOUNTSEND_NAME", name);
					monMap.put("DISCOUNTSEND_FEE", sTotalFee);
					break;
				case 6:
					monMap.put("BILL_CYCLE", monMapTemp.get("BILL_CYCLE").toString());
					monMap.put("PRINT_FEE", sTotalFee);
					monMap.put("PRINTFEE_NAME", name);
					monMap.put("BIG_MONEY", ValueUtils.transYuanToChnaBig(monMap.get("PRINT_FEE")));
					monMap.put("ORDER_SN", monMapTemp.get("ORDER_SN"));
					monMap.put("PRINT_SN", monMapTemp.get("PRINT_SN"));
					monMap.put("BILL_BEGIN", monMapTemp.get("BILL_BEGIN").toString());
					monMap.put("BILL_END", monMapTemp.get("BILL_END").toString());
					break;
				case 7:
					monMap.put("PAYOWE_FEE_NAME", name);
					monMap.put("PAYOWE_FEE", sTotalFee);
					break;
				case 8:
					monMap.put("LAST_FEE_NAME", name);
					monMap.put("LAST_FEE", sTotalFee);
					break;
				case 9:
					monMap.put("ACCT_REMIAN_NAME", name);
					monMap.put("ACCT_REMIAN", sTotalFee);
					break;
				}
			}
			// monMap.put("FEE_INFO",monListTemp);
			zongMap.put("MON_INFO", monMap);
			monList.add(zongMap);
		}

		log.debug("monList" + monList);
		return monList;
	}

	@Override
	public String getPrintXml(Map<String, Object> inMap) {
		log.debug("打印免填单的入参：" + inMap);

		String sModelId = "";
		String sModelStr = "";

		if (PrintModelUtil.getInstance() == null) {
			PrintModelUtil.getInstance(invoice);
		}
		/* 判断是否有发票模板号 */
		log.debug("op_code:" + inMap.get("OP_CODE") + "print_type:" + inMap.get("PRINT_TYPE"));
		/* 重新加载发票模板号IDMap */
		sModelId = PrintModelUtil.refreshPrintModelRela(inMap.get("OP_CODE").toString(), inMap.get("PRINT_TYPE").toString());

		log.debug("sModelId" + sModelId);
		/* 查询发票报文XML */

		/* 重新加载发票模板Map */
		sModelStr = PrintModelUtil.refreshPrintModel(sModelId);

		MBean printInfoBean = new MBean();
		printInfoBean.setBody("PRINT_MODEL", sModelStr);
		Iterator<String> it = inMap.keySet().iterator();
		for (Map.Entry<String, Object> entry : inMap.entrySet()) {
			log.debug("key= " + entry.getKey() + " and value= " + entry.getValue());
			printInfoBean.setBody(entry.getKey(), entry.getValue());
		}

		log.debug("printInfoBean:" + printInfoBean.toString());
		PrintXmlParser printParse = new PrintXmlParser();
		String printXmlStr = printParse.doXmlParser(printInfoBean);
		printXmlStr = printXmlStr.replaceAll("\\n|\\r", "");
		printXmlStr = printXmlStr.replaceAll("UTF-8", "GB2312");

		return printXmlStr;
	}

	public IInvoice getInvoice() {
		return invoice;
	}

	public void setInvoice(IInvoice invoice) {
		this.invoice = invoice;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

}

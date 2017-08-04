package com.sitech.acctmgr.atom.busi.invoice;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import com.alibaba.fastjson.JSONObject;
import com.sitech.acctmgr.atom.busi.invoice.inter.IElecInvoice;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.invoice.TaxInvoiceFeeEntity;
import com.sitech.acctmgr.atom.domains.invoice.elecInvoice.EInvPdfEntity;
import com.sitech.acctmgr.atom.domains.invoice.elecInvoice.InvQryParam;
import com.sitech.acctmgr.atom.domains.invoice.elecInvoice.InvoiceDdInfo;
import com.sitech.acctmgr.atom.domains.invoice.elecInvoice.InvoiceDetailInfo;
import com.sitech.acctmgr.atom.domains.invoice.elecInvoice.InvoiceHeaderInfo;
import com.sitech.acctmgr.atom.domains.invoice.elecInvoice.InvoiceInfo;
import com.sitech.acctmgr.atom.domains.invoice.elecInvoice.InvoiceXhfInfo;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.common.utils.BeanToXmlUtils;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.common.utils.InstantiationUtils;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgrint.atom.busi.intface.IBusiMsgSnd;
import com.sitech.acctmgrint.atom.busi.intface.IShortMessage;
import com.sitech.common.CrossEntity;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.dt.MBean;

public class ElecInvoice extends BaseBusi implements IElecInvoice {

	private IControl control;
	private IShortMessage shortMessage;
	private IBusiMsgSnd busiMsgSnd;
	private IInvoice invoice;
	private IUser user;
	private ICust cust;

	@Override
	public Map<String, String> EInvPrintSub(InvoiceInfo eleInvoice, InvoiceXhfInfo xhfInfo, String loginNo, int sendMsgFlag, String chnSource) {
		Map<String, String> outPut = new HashMap<String, String>();
		String requestSn = eleInvoice.getInvoiceHeader().getFpqqlsh();

		String invNo = "";
		String invCode = "";
		String pdf = "";
		// 获取同步异步配置 0 同步 ，1异步
		String asynFlag = "0";
		asynFlag = control.getPubCodeValue(3015, "8000", "0");
		// 调用开具
		Map<String, String> eaiResult = getEleInvoiceIssue(eleInvoice, xhfInfo, asynFlag);

		// 对返回报文转码
		String returnMsgByPd = "";
		if (eaiResult != null) {
			returnMsgByPd = eaiResult.toString();
			log.debug("===> reQuestSn : {},调用开具转码响应结果:{} ", requestSn, returnMsgByPd);
		}

		// 解析返回报文
		String retCode = MapUtils.getString(eaiResult, "returnCode", "8888");
		String returnMsg = "";
		try {
			// 处理返回信息
			if (StringUtils.isNotEmptyOrNull(eaiResult.get("returnMessage"))) {
				returnMsg = new String(eaiResult.get("returnMessage"));
				log.debug("===> reQuestSn : {},调用开具返回信息:{} ", requestSn, returnMsg);
			}

		} catch (Exception e) {
			e.printStackTrace();
			log.error("===> reQuestSn : " + requestSn + ",调用开具returnMsg :" + eaiResult.get("returnMessage"));
		}

		if (!retCode.equals("0000")) {
			log.error("===> reQuestSn : {},航信开具失败，错误代码:{} ，错误信息:{}", requestSn, retCode, returnMsg);
			MapUtils.safeAddToMap(outPut, "RETURN_CODE", "0002");
			MapUtils.safeAddToMap(outPut, "RETURN_MSG", "航信开具失败，错误代码：" + retCode + "，错误信息：" + returnMsg);
			MapUtils.safeAddToMap(outPut, "TIME", eaiResult.get("TIME"));
			return outPut;
		}

		// // 对前面事务提交。如果下面处理content失败，将走异步流程。
		// Connection conn = baseDao.getConnection();
		// try {
		// conn.commit();
		// } catch (SQLException e) {
		// e.printStackTrace();
		// log.error("===> reQuestSn : {},提交失败", requestSn);
		// }

		// 取当前年月时间===>与异步兼容更新发票表数据

		String phoneNo = eleInvoice.getInvoiceHeader().getGhfsj();
		String url = "" + phoneNo + "&seq=" + requestSn;
		log.debug("asynFlag:" + asynFlag.equals("0"));
		if (asynFlag.equals("0")) {
			// 处理eaiResult
			// 解析返回的数据并录入pdf文件表
			Map<String, String> retMap = getRetInfo(eaiResult, loginNo);
			invNo = retMap.get("INV_NO");
			invCode = retMap.get("INV_CODE");
			pdf = retMap.get("PDF");
			// 发送短信
			sendSms(phoneNo, url, chnSource, requestSn, DateUtils.getCurDate(DateUtils.DATE_FORMAT_YYYYMMDDHHMISS));
			// 推送邮箱
			// 获取打印金额和项目名称
			List<InvoiceDetailInfo> xmList = eleInvoice.getInvoiceDetail();
			long xmFee = 0;
			StringBuffer xmmc = new StringBuffer();
			for (InvoiceDetailInfo xm : xmList) {
				xmFee += ValueUtils.transYuanToFen(xm.getXmje());
				xmmc.append(xm.getXmmc() + ";");
			}
			sendMail(requestSn, DateUtils.getCurYm(), phoneNo, chnSource, chnSource, pdf, ValueUtils.transFenToYuan(xmFee) + "", xmmc.toString());
		}

		// 返回map
		MapUtils.safeAddToMap(outPut, "RETURN_CODE", retCode);
		MapUtils.safeAddToMap(outPut, "RETURN_MSG", returnMsg);
		MapUtils.safeAddToMap(outPut, "TIME", eaiResult.get("TIME"));
		MapUtils.safeAddToMap(outPut, "INV_NO", invNo);
		MapUtils.safeAddToMap(outPut, "INV_CODE", invCode);
		return outPut;
	}

	@Override
	public String getInvPdfFile(String requestSn) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("INVOICE_ACCEPT", requestSn);
		List<Map<String, Object>> outList = baseDao.queryForList("bal_einvpdf_info.qryPdfInfo", inMap);
		StringBuffer sb = new StringBuffer();
		for (Map<String, Object> outMap : outList) {
			sb.append(outMap.get("BASE64_PDF").toString());
		}
		String invStr = sb.toString();
		return invStr;
	}

	@Override
	public String getInvFile(String requestSn, String phoneNo, String fileType) {
		// 获取原始PDF文件
		String pdfFile = getInvPdfFile(requestSn);

		if (fileType.equals("0")) {
			return pdfFile;
		}

		// 生成发送报文
		MBean serviceMBean = new MBean();
		String dpi = "150"; // 待转换图像dpi值
		String zipCode = "0"; // 0,1是否压缩
		// String fileType = "1"; //1, 黑白PDF 2， PNG图片 3， PDF&PNG

		String content = "<REQUEST_PDF2IMAGE>" + "<dpi>" + dpi + "</dpi>" + "<zipCode>" + zipCode + "</zipCode>" + "<fileType>" + fileType
				+ "</fileType>" + "<pdfContent>" + pdfFile + "</pdfContent>" + "</REQUEST_PDF2IMAGE>";
		serviceMBean.setBody("content", content);

		// 调用航信接口
		String sEaiServe = "EAI_ElecInvoicePrint_SYNPDF";
		Map<String, String> EaiResult = CrossEntity.callService(sEaiServe, serviceMBean);

		// 对返回报文转码
		String returnMsgByPd = "";
		if (EaiResult != null) {
			try {
				returnMsgByPd = new String(EaiResult.toString().getBytes("GBK"), "UTF-8");
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}
			log.debug("===> reQuestSn : {},调用开具转码响应结果:{} ", requestSn, returnMsgByPd);
		}

		String response = MapUtils.getString(EaiResult, "return", "8888");
		if (response.equals("8888")) {
			log.error("===> reQuestSn : " + requestSn + ",调用黑白打印没有返回结果");
			return "";
		}

		/**
		 * 解析XML <?xml version="1.0" encoding="UTF-8" ?> <RESPONSE_PDF2IMAGE> <returnCode>0000</returnCode> <returnMessage>6L2s5o2i5oiQ5Yqf</returnMessage> <zipCode>0</zipCode> <pdfFile>xxxx</pdfFile> <fileType>1</fileType> <pdfPages size="0"/> <pdfPages size="1"> <pdfPage> <pageIndex>0</pageIndex> <imageContent>编码后PNG文件数据</imageContent> <imageWidth>2539</imageWidth> <imageHeight>1642</imageHeight> </pdfPage> </pdfPages> </RESPONSE_PDF2IMAGE>
		 */
		int beginIndex = 0;
		int endIndex = 0;
		beginIndex = response.indexOf("<returnCode>");
		endIndex = response.indexOf("</returnCode>");
		String retCode = response.substring(beginIndex + 12, endIndex);

		beginIndex = response.indexOf("<returnMessage>");
		endIndex = response.indexOf("</returnMessage>");
		String returnMsg = response.substring(beginIndex + 15, endIndex);

		if (!retCode.equals("0000")) {
			log.error("===> reQuestSn : " + requestSn + ",调用黑白打印错误：" + returnMsg);
			return "";
		}

		beginIndex = response.indexOf("<pdfFile>");
		endIndex = response.indexOf("</pdfFile>");
		String retPdfFile = response.substring(beginIndex + 9, endIndex);

		if (fileType.equals("1")) {
			return retPdfFile;
		}

		beginIndex = response.indexOf("<imageContent>");
		endIndex = response.indexOf("</imageContent>");
		String retPngFile = response.substring(beginIndex + 14, endIndex);

		return retPngFile;

	}

	@Override
	public void sendMail(String requestSn, int printYm, String phoneNo, String kpqd, String khqd, String pdf, String printFee, String xmmc) {

		if (StringUtils.isEmptyOrNull(pdf)) {
			getInvPdfFile(requestSn);
		}

		// TODO：获取客户邮箱地址
		String mailAddress = "13936253381@139.com";
		// Map<String, Object> inMap=new HashMap<String,Object>();
		// 根据requestSN获取打印流水和金额
		if (StringUtils.isEmptyOrNull(xmmc)) {
			List<TaxInvoiceFeeEntity> taxInvoiceFeeList = invoice.getInvoiceFeeList(0, requestSn);
			for (TaxInvoiceFeeEntity taxInvoiceFee : taxInvoiceFeeList) {
				printFee += ValueUtils.longValue(taxInvoiceFee.getInvoiceFee())
						+ ValueUtils.transFenToYuan(ValueUtils.longValue(taxInvoiceFee.getTaxFee()));
				xmmc += taxInvoiceFee.getGoodsName();
			}
		}

		// 根据流水获取服务号码，客户ID，账户号码，工号，操作时间，开票渠道
		UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, true);
		long custId = userInfo.getCustId();

		// 获取客户名称
		CustInfoEntity custInfo = cust.getCustInfo(custId, "");
		String custName = custInfo.getCustName();

		// 获取渠道名称
		String khqdmc = transQd(khqd);
		String kpqdmc = transQd(kpqd);
		long time = System.currentTimeMillis();
		String ywlsh = "DZFP_451_" + phoneNo + "_" + custId + "_" + custName + "_" + time;
		// 封装交互报文
		MBean mail = new MBean();
		String str = "{\"DZFPYJTS_KHXX\":{\"KHSJHM\":\"" + phoneNo + "\"，\"KHBS\":\"" + custId + "\"，\"KHMC\":\"" + custName
				+ "\"，\"KHLX\":\"1\"，\"KHYXDZ\":\"" + mailAddress + "\"，\"KHGSD\":\"" + (custId + "").substring(0, 4) + "\"，\"KHFQQD\":\"" + khqdmc
				+ "\"}，\"DZFPYJTS_FPXX\":{\"KPSJ\":\"" + time + "\"，\"KPQD\":\"" + kpqdmc + "\"，\"FPJE\":\"" + printFee + "\"，\"FPMXPM\":\"" + xmmc
				+ "\"，\"FPPDFWJ\":\"" + pdf + "\"，\"FPJYM\":\"\"，\"SFBS\":\"451\"，\"YWLSH\":\"" + ywlsh + "\"}}";
		mail.addBody("instr", str);
		// 获取同步异步配置 0 同步 ，1异步
		String sEaiServe = "EAI_ElecInvoicePrint_MAIL";

		// 调用PD
		log.debug("===> reQuestSn : {},调用139平台请求报文:{} ", requestSn, mail);
		Map<String, String> EaiResult = CrossEntity.callService(sEaiServe, mail);
		log.debug("===> reQuestSn : {},调用139平台响应结果:{} ", requestSn, EaiResult);

		// 对返回报文转码
		String returnMsgByPd = "";
		if (EaiResult != null) {
			try {
				returnMsgByPd = new String(EaiResult.toString().getBytes("GBK"), "UTF-8");
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
				log.error("===> reQuestSn : {},调用139平台响应结果:{} ", requestSn, EaiResult);
			}
			log.debug("===> reQuestSn : {},调用139平台转码响应结果:{} ", requestSn, returnMsgByPd);
		}

		// 解析返回报文
		String retCode = EaiResult.toString();
		retCode = retCode.replace("=", ":").replace("}", "}}");
		Map<String, Object> outMap = JSONObject.parseObject(retCode);
		retCode = ((Map<String, String>) outMap.get("out")).get("returnCode");
		String returnMsg = "";
		try {
			// 处理返回信息
			if (StringUtils.isNotEmptyOrNull(((Map<String, String>) outMap.get("out")).get("returnMessage"))) {
				returnMsg = new String(((Map<String, String>) outMap.get("out")).get("returnMessage"));
				log.debug("===> reQuestSn : {},调用139平台返回信息:{} ", requestSn, returnMsg);
			}

		} catch (Exception e) {
			e.printStackTrace();
			log.error("===> reQuestSn : " + requestSn + ",调用139平台returnMsg :" + EaiResult.get("returnMessage"));
		}

		if (!retCode.equals("0000")) {
			log.error("===> reQuestSn : {},调用139平台失败，错误代码:{} ，错误信息:{}", requestSn, retCode, returnMsg);
		}
	}

	@Override
	public void sendSms(String phoneNo, String url, String chnSource, String requestSn, String date) {
		// 转义渠道编码
		String chnName = control.getPaypathName(chnSource);
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("url", url);
		data.put("chn_source", chnName);
		data.put("year", date.substring(0, 4));
		data.put("month", date.substring(4, 6));
		data.put("day", date.substring(6, 8));
		data.put("hour", date.substring(8, 10));
		data.put("minute", date.substring(10, 12));
		data.put("requestsn", requestSn);
		MBean inMessage = new MBean();
		inMessage.addBody("TEMPLATE_ID", "311100120001");
		inMessage.addBody("PHONE_NO", phoneNo);
		inMessage.addBody("LOGIN_NO", "system");
		inMessage.addBody("OP_CODE", "0000");
		inMessage.addBody("CHECK_FLAG", true);
		inMessage.addBody("DATA", data);
		inMessage.addBody("SEND_FLAG", 0);
		log.error("======>手机号:" + phoneNo + ",发送短信内容：" + inMessage.toString());
		shortMessage.sendSmsMsg(inMessage);

	}

	@Override
	public void smsSendAgain(String phoneNo, String url, String chnSource, String requestSn, String date) {

		// 根据requestSn 查询URL
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("YEAR_MONTH", requestSn.substring(1, 7));// requestSn以 B20161013形式开头
		inMap.put("REQUEST_SN", requestSn);
		Map<String, Object> urlMap = (Map<String, Object>) baseDao.queryForObject("bal_einvpdf_info.qWebUrlInfo", inMap);

		// 补发短信

		sendSms(phoneNo, url, chnSource, requestSn, date);

		return;
	}

	@Override
	public void saveCrmElecInvoice(Map<String, Object> inParamMap) {
		Map<String, Object> inMap = new HashMap<String, Object>();

		// 插入CRM电子发票记录表
		baseDao.insert("in_einvoiceprint_info.iElecInvPrintInfo", inParamMap);

		// 红票，更新原蓝票的state=4
		if (inParamMap.get("INV_TYPE").toString().equals("2")) { // 红票
			MapUtils.safeAddToMap(inMap, "STATE", "4");
			MapUtils.safeAddToMap(inMap, "REQUEST_SN", inParamMap.get("OLD_REQUEST_SN").toString());
			baseDao.update("in_einvoiceprint_info.upEinvCrmInfo", inMap);
		}

		// 同步接口需要解析content,并处理相关表数据
		if (inParamMap.get("STATE").toString().equals("1")) { // state为1代表同步接口 为0是异步接口
			String content = inParamMap.get("CONTENT").toString();
			if (content == null) {
				throw new BusiException(AcctMgrError.getErrorCode("0000", "01010"), "同步接口content为空");
			}

			try {
				EInvcContentDealCrm(inParamMap, content);
			} catch (Exception e) {
				e.printStackTrace();
				throw new BusiException(AcctMgrError.getErrorCode("0000", "01010"), "处理content内容失败");
			}
		}
	}

	@Override
	public void EInvcContentDealCrm(Map<String, Object> inParamMap, String content) throws Exception {
		Map<String, Object> inMap = null;
		Object invQryParam = null;
		Document doc = null;
		Connection conn = null;
		conn = baseDao.getConnection();

		// 解析contentXML报文，并保存在InvQryParam实体里
		// try {
		doc = DocumentHelper.parseText(content);

		Element rootElt = doc.getRootElement();
		List<Element> listElement = rootElt.elements();
		Class[] cArg = new Class[1];
		cArg[0] = String.class;
		if (listElement != null && listElement.size() > 0) {
			Class clazz = Class.forName("com.sitech.acctmgr.atom.domains.InvQryParam");
			invQryParam = clazz.newInstance();
			for (Element node : listElement) {
				String methodName = "set" + node.getName().substring(0, 1) + node.getName().substring(1).toLowerCase();
				Method func = clazz.getDeclaredMethod(methodName, cArg);
				func.invoke(invQryParam, node.getTextTrim());
			}
		}

		InvQryParam imp = (InvQryParam) invQryParam;

		String sCurTime = DateUtils.getCurDate(DateUtils.DATE_FORMAT_YYYYMMDDHHMISS);
		String sYearMonth = DateUtils.getCurYm() + "";
		String url = "http://www.jl.10086.cn/service/operate/invoice/QryPreInv.jsp?phone=" + inParamMap.get("PHONE_NO").toString() + "&seq="
				+ inParamMap.get("REQUEST_SN").toString();

		// 往BAL_EINVPDF_INFO表插入数据
		inMap = new HashMap<String, Object>();
		inMap.put("YEAR_MONTH", inParamMap.get("REQUEST_SN").toString().substring(1, 7));// requestSn以 B20161013形式开头
		inMap.put("REQUEST_SN", inParamMap.get("REQUEST_SN").toString());
		inMap.put("PDFFILEBYTE", imp.getPdf_file().getBytes());
		baseDao.insert("bal_einvpdf_info.iEinvPdfInfo", inMap);

		// 往BAL_EINVPDF_REL表插入数据
		inMap = new HashMap<String, Object>();
		inMap.put("YEAR_MONTH", inParamMap.get("REQUEST_SN").toString().substring(1, 7));// requestSn以 B20161013形式开头
		inMap.put("REQUEST_SN", inParamMap.get("REQUEST_SN").toString());
		inMap.put("PRINT_SN", inParamMap.get("PRINT_SN").toString());
		inMap.put("PRINT_ARRAY", "1");
		inMap.put("PHONE_NO", inParamMap.get("PHONE_NO").toString());
		inMap.put("INVREQ_TIME", sCurTime);
		inMap.put("REMARK", "syn");
		inMap.put("WEB_URL", url);
		baseDao.insert("bal_einvpdf_info.iEinvPdfRel", inMap);

		// 更新发票代码，发票号码，发票url
		inMap = new HashMap<String, Object>();
		inMap.put("INV_CODE", imp.getFp_dm());
		inMap.put("INV_NO", imp.getFp_hm());
		inMap.put("STATE", "1");
		inMap.put("INVREQ_SN", inParamMap.get("REQUEST_SN").toString());
		inMap.put("PHONE_NO", inParamMap.get("PHONE_NO").toString());
		baseDao.update("in_einvoiceprint_info.upEinvCrmInfoInvc", inMap);

		// 插入hbase
		inMap = new HashMap<String, Object>();
		inMap.put("INVREQ_SN", inParamMap.get("REQUEST_SN").toString());
		inMap.put("PHONE_NO", inParamMap.get("PHONE_NO").toString());
		inMap.put("PDFFILE", imp.getPdf_file());
		try {
			// conn.commit();
			// insertHbase(inMap, conn);
			// conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 发送短信
		// sendSms(inParamMap.get("PHONE_NO").toString(), url,"chnsource",req);

		// 推送139邮箱
		Map<String, Object> mailMap = new HashMap<String, Object>();
		MapUtils.safeAddToMap(mailMap, "REQUEST_SN", inParamMap.get("REQUEST_SN").toString());
		MapUtils.safeAddToMap(mailMap, "YEAR_MONTH", inParamMap.get("REQUEST_SN").toString().substring(1, 7));
		MapUtils.safeAddToMap(mailMap, "PRINT_SN", inParamMap.get("PRINT_SN").toString());
		MapUtils.safeAddToMap(mailMap, "PRINT_ARRAY", "1");
		// sendMail(mailMap);

		// 异步模式，后台程序调用此方法会传ASYN参数。 需要给CRM发送业务工单
		if (inParamMap.get("ASYN") != null) {
			try {
				// 存入发票代码,号码
				MapUtils.safeAddToMap(inParamMap, "INV_CODE", imp.getFp_dm());
				MapUtils.safeAddToMap(inParamMap, "INV_NO", imp.getFp_hm());

				sendOrderToCRM(inParamMap);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	@Override
	public void sendOrderToCRM(Map<String, Object> inmap) throws Exception {
		try {
			log.info("===>准备调用发送给CRM的消息: " + inmap);
			String sCurTime = DateUtils.getCurDate(DateUtils.DATE_FORMAT_YYYYMMDDHHMISS);
			Map<String, Object> oprMap = new HashMap<String, Object>();
			oprMap.put("OP_CODE", "8285");
			oprMap.put("OP_TIME", sCurTime);
			oprMap.put("LOGIN_NO", "system");
			Map<String, Object> sendFee = new HashMap<String, Object>();
			sendFee.put("ELEC_ACCEPT", MapUtils.getString(inmap, "REQUEST_SN"));// 航信流水（C开头的那个）
			sendFee.put("INVC_CODE", MapUtils.getString(inmap, "INV_CODE"));
			sendFee.put("INVOICE_ID", MapUtils.getString(inmap, "INV_NO"));
			sendFee.put("INVC_TYPE", MapUtils.getString(inmap, "INV_TYPE"));// 开票类型
			sendFee.put("BILL_ID", MapUtils.getString(inmap, "PRINT_SN"));// 订单号
			sendFee.put("OP_DATE", sCurTime);
			Map<String, Object> routingMap = new HashMap<String, Object>();
			MapUtils.safeAddToMap(routingMap, "ROUTE_KEY", "10");
			MapUtils.safeAddToMap(routingMap, "ROUTE_VALUE", MapUtils.getString(inmap, "PHONE_NO"));

			MBean sendBusi = new MBean();
			sendBusi.setRoot("ROOT.HEADER.ROUTING", routingMap);
			sendBusi.addBody("OPR_INFO", oprMap);
			sendBusi.addBody("BUSI_INFO", sendFee);
			Map<String, Object> bbMap = new HashMap<String, Object>();
			bbMap.put("LOGIN_ACCEPT", MapUtils.getString(inmap, "PRINT_SN"));
			bbMap.put("CONTACT_ID", null);
			bbMap.put("BUSIID_NO", MapUtils.getString(inmap, "PHONE_NO"));
			bbMap.put("LOGIN_NO", "system");
			bbMap.put("OP_CODE", "8285");
			bbMap.put("OWNER_FLAG", "1");
			bbMap.put("ORDER_ID", "10014");// 与订单系统同步资源信息
			bbMap.put("ODR_CONT", sendBusi);
			busiMsgSnd.opPubOdrSndInter(bbMap);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return;
	}

	@Override
	public Map<String, String> getEleInvoiceIssue(InvoiceInfo eleInvoice, InvoiceXhfInfo xhfInfo, String asynFlag) {

		// 组装报文
		MBean reqBean = null;
		String sEaiServe = "";
		if (asynFlag.equals("0")) { // 同步
			sEaiServe = "EAI_ElecInvoicePrint_SYN";
			reqBean = genReqInfo(eleInvoice, xhfInfo, "ECXML.FPKJ.BC.E_INV_SYN");
		} else { // 异步
			sEaiServe = "EAI_ElecInvoicePrint_ASYN";
			reqBean = genReqInfo(eleInvoice, xhfInfo, "ECXML.FPKJ.BC.E_INV_ASYN");
		}
		String requestSn = eleInvoice.getInvoiceHeader().getFpqqlsh();
		// 调用CRMPD接口
		long HXstart = ValueUtils.longValue(DateUtils.getCurDate("yyyyMMddHHmmssSSS"));
		log.debug("===> reQuestSn : {},调用开具请求报文:{} ", requestSn, reqBean);
		Map<String, String> EaiResult = CrossEntity.callService(sEaiServe, reqBean);
		log.debug("===> reQuestSn : {},调用开具响应结果:{} ", requestSn, EaiResult);
		long HXend = ValueUtils.longValue(DateUtils.getCurDate("yyyyMMddHHmmssSSS"));
		log.error("调用航信开始时间--" + HXstart + "--调用航信结束时间--" + HXend + "--调用航信总用时--" + (HXend - HXstart));
		EaiResult.put("TIME", (HXend - HXstart) + "");
		return EaiResult;
	}

	/**
	 * 生成发送报文
	 * 
	 * @param eleInvoice
	 * @param xhfInfo
	 * @param servName
	 * @return
	 */
	@SuppressWarnings("all")
	private MBean genReqInfo(InvoiceInfo eleInvoice, InvoiceXhfInfo xhfInfo, String servName) {

		// 获取数据交换流水号（唯一） requestCode+8位日期(YYYYMMDD)+9位序列号
		long changerSn = control.getSequence("SEQ_EINVOICE_SN");
		String dataExchangeId = "23" + DateUtils.getCurYm() + changerSn;

		Map<String, Object> tmp = new LinkedHashMap<>();
		tmp.put("terminalCode", "1"); // 终端类型标识代码 0:B/S请求来源 1:C/S请求来源
		tmp.put("appId", "DZFP"); // 应用标识 默认为ZZS_PT_DZFP：增值税普通电子发票
		tmp.put("version", "2.0"); // 接口版本 默认为2.0
		tmp.put("interfaceCode", "ECXML.FPKJ.BC.E_INV_SYN"); // 接口编码
		tmp.put("requestCode", "23"); // 各省区域编码 黑龙江23
		tmp.put("requestTime", DateUtils.getCurDate("yyyy-MM-dd HH:mm:ss SSS")); // 数据交换请求发出时间
		tmp.put("responseCode", "121"); // 数据交换请求接受方代码,由平台提供，企业调用时为空
		tmp.put("dataExchangeId", "2320170601000368020"); // 数据交换流水号（唯一） requestCode+8位日期(YYYYMMDD)+9位序列号
		tmp.put("userName", CommonConst.USERNAME); // 平台编码
		tmp.put("passWord", CommonConst.PASSWORD); // 密码64444842
		tmp.put("taxpayerId", eleInvoice.getInvoiceHeader().getXhfnsrsbh()); // 纳税人识别号eleInvoice.getInvoiceHeader().getXhfnsrsbh()
		tmp.put("authorizationCode", "23111370"); // 纳税人授权码 xhfInfo.getSqm()

		tmp.put("returnCode", "");
		tmp.put("returnMessage", "");
		tmp.put("zipCode", "0");
		tmp.put("encryptCode", "0");
		tmp.put("codeType", "0");

		MBean serviceMBean = new MBean();
		// serviceMBean.setBody("terminalCode", "1"); // 终端类型标识代码 0:B/S请求来源 1:C/S请求来源
		// serviceMBean.setBody("appId", "ZZS_PT_DZFP"); // 应用标识 默认为ZZS_PT_DZFP：增值税普通电子发票
		// serviceMBean.setBody("version", "2.0"); // 接口版本 默认为2.0
		// serviceMBean.setBody("interfaceCode", servName); // 接口编码
		// serviceMBean.setBody("userName", CommonConst.USERNAME); // 平台编码
		// serviceMBean.setBody("passWord", CommonConst.PASSWORD); // 密码
		// serviceMBean.setBody("requestCode", "23"); // 各省区域编码 黑龙江23
		// serviceMBean.setBody("requestTime", DateUtils.getCurDate("yyyy-MM-dd HH:mm:ss SSS")); // 数据交换请求发出时间
		// serviceMBean.setBody("taxpayerId", eleInvoice.getInvoiceHeader().getXhfnsrsbh()); // 纳税人识别号
		// serviceMBean.setBody("authorizationCode", xhfInfo.getSqm()); // 纳税人授权码
		// serviceMBean.setBody("responseCode", ""); // 数据交换请求接受方代码,由平台提供，企业调用时为空
		// serviceMBean.setBody("dataExchangeId", dataExchangeId); // 数据交换流水号（唯一） requestCode+8位日期(YYYYMMDD)+9位序列号
		// serviceMBean.setBody("returnCode", "");
		// serviceMBean.setBody("returnMessage", "");

		// 设置content
		String content = BeanToXmlUtils.trans(eleInvoice);
		content = content.replaceAll("<FPKJXX_XMXXS>", "<FPKJXX_XMXXS class=\"FPKJXX_XMXX;\" size=\"" + eleInvoice.getInvoiceDetail().size() + "\">");
		log.debug("报文内容：" + content);
		tmp.put("content", content);
		serviceMBean.setBody(tmp);

		return serviceMBean;
	}

	@Override
	public InvoiceHeaderInfo getEleInvHeader(InvoiceXhfInfo xhfInfo, String opCode, String custName, String phoneNo, String loginName,
			String loginAccept, long printFee) {
		// 电子发票的头信息
		InvoiceHeaderInfo headInfo = new InvoiceHeaderInfo();
		try {
			InstantiationUtils.reflect(headInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String requestSn = control.getRequestSn();
		// 发票头信息
		headInfo.setFpqqlsh(requestSn);
		headInfo.setPtbm(CommonConst.USERNAME);
		headInfo.setNsrsbh(xhfInfo.getXhfnsrsbh());
		headInfo.setNsrmc(xhfInfo.getXhfmc());
		headInfo.setDkbz("0");
		headInfo.setKpxm(opCode);
		headInfo.setXhfnsrsbh(xhfInfo.getXhfnsrsbh());
		headInfo.setXhfmc(xhfInfo.getXhfmc());
		headInfo.setXhfdz(xhfInfo.getXhfdz());
		headInfo.setXhfdh(xhfInfo.getXhfdh());
		headInfo.setXhfyhzh(xhfInfo.getXhfyhzh());
		headInfo.setGhfmc(custName);
		headInfo.setGhfsf("");
		headInfo.setGhfgddh(phoneNo);
		headInfo.setGhfsj(phoneNo);
		headInfo.setGhfqylx("03");
		headInfo.setKpy(loginName);
		headInfo.setSky(loginName);
		headInfo.setFhr(xhfInfo.getFhr());
		headInfo.setKplx("1");
		headInfo.setCzdm("10");
		headInfo.setKphjje(ValueUtils.transFenToYuan(printFee) + "");
		headInfo.setHjse("0");
		headInfo.setQdbz("0");
		headInfo.setHjbhsje(ValueUtils.transFenToYuan(printFee) + "");
		return headInfo;
	}

	@Override
	public InvoiceDetailInfo getInvoiceItem(long fee, String feeName, String TypeFPHXZ) {
		InvoiceDetailInfo invoiceItem = new InvoiceDetailInfo();
		try {
			invoiceItem = (InvoiceDetailInfo) InstantiationUtils.reflect(invoiceItem);
		} catch (Exception e) {
			e.printStackTrace();
		}

		invoiceItem.setXmmc(feeName);
		invoiceItem.setXmsl("1");
		invoiceItem.setFphxz(TypeFPHXZ);
		invoiceItem.setXmdj(ValueUtils.transFenToYuan(fee) + "");
		invoiceItem.setXmje(ValueUtils.transFenToYuan(fee) * ValueUtils.intValue(invoiceItem.getXmsl()) + "");
		invoiceItem.setSl("0.00");
		invoiceItem.setSe("0.00");
		invoiceItem.setXmdw("");

		return invoiceItem;
	}

	@Override
	public InvoiceDdInfo getOrderInfo(String orderId) {
		InvoiceDdInfo ddInfo = new InvoiceDdInfo();
		try {
			ddInfo = (InvoiceDdInfo) InstantiationUtils.reflect(ddInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ddInfo.setDdh(orderId);
		return ddInfo;
	}

	@Override
	public InvQryParam EInvcContentDeal(String content) {

		Object invQryParam = null;
		Document doc = null;

		// 解析contentXML报文，并保存在InvQryParam实体里
		try {
			doc = DocumentHelper.parseText(content);

			Element rootElt = doc.getRootElement();
			List<Element> listElement = rootElt.elements();
			Class[] cArg = new Class[1];
			cArg[0] = String.class;
			if (listElement != null && listElement.size() > 0) {

				Class clazz = Class.forName("com.sitech.acctmgr.atom.domains.InvQryParam");
				invQryParam = clazz.newInstance();
				for (Element node : listElement) {
					String methodName = "set" + node.getName().substring(0, 1) + node.getName().substring(1).toLowerCase();
					Method func = clazz.getDeclaredMethod(methodName, cArg);
					func.invoke(invQryParam, node.getTextTrim());
				}
			}
			log.debug("返回参数：" + invQryParam.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return (InvQryParam) invQryParam;
	}

	/**
	 * 获取应用集成平台返回的值，并入pdf表
	 * 
	 * @param eaiResult
	 * @return
	 */
	private Map<String, String> getRetInfo(Map<String, String> eaiResult, String loginNo) {
		String interfaceCode = eaiResult.get("interfaceCode");
		String appId = eaiResult.get("");
		String returnMsg = eaiResult.get("RETURNMESSAGE");
		String requestTime = eaiResult.get("requestTime");
		String dataExchangeId = eaiResult.get("dataExchangeId");
		String pdf = eaiResult.get("PDF_FILE");
		String kplx = eaiResult.get("KPLX");
		String returnCode = eaiResult.get("returnCode");
		String responseCode = eaiResult.get("responseCode");
		String requestSn = eaiResult.get("FPQQLSH");
		String invNo = eaiResult.get("FP_HM");
		String invCode = eaiResult.get("FP_DM");
		String printSn = eaiResult.get("DDH");
		String taxFee = eaiResult.get("KPHJSE");
		String expTaxPrintFee = eaiResult.get("HJBHSJE");
		String fwm = eaiResult.get("FWM");
		String encryptCode = eaiResult.get("encryptCode");
		// 插入表
		EInvPdfEntity pdfEnt = new EInvPdfEntity();
		pdfEnt.setInvCode(invCode);
		pdfEnt.setInvNo(invNo);
		pdfEnt.setLoginNo(loginNo);
		pdfEnt.setInvoiceAccept(requestSn);
		pdfEnt.setPdf(pdf);
		pdfEnt.setSplitOrder(1);
		invoice.insertPDFInfo(pdfEnt);
		Map<String, String> outMap = new HashMap<String, String>();
		outMap.put("INV_NO", invNo);
		outMap.put("INV_CODE", invCode);
		outMap.put("PDF", pdf);
		return outMap;
	}

	private String transQd(String chnSource) {
		String qd = "12";
		if (chnSource.equals("01")) {
			qd = "1";// 自有营业厅（老）
		} else if (chnSource.equals("03")) {
			qd = "5";// 网上营业厅（新）
		} else if (chnSource.equals("09")) {
			qd = "6";// wap营业厅（新）
		} else if (chnSource.equals("17")) {
			qd = "3";// 10086热线
		} else if (chnSource.equals("")) {
			qd = "2002";// 移动旗舰店
		} else if (chnSource.equals("")) {
			qd = "2001"; // 微信
		}
		return qd;
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

	public IShortMessage getShortMessage() {
		return shortMessage;
	}

	public void setShortMessage(IShortMessage shortMessage) {
		this.shortMessage = shortMessage;
	}

	public IBusiMsgSnd getBusiMsgSnd() {
		return busiMsgSnd;
	}

	public void setBusiMsgSnd(IBusiMsgSnd busiMsgSnd) {
		this.busiMsgSnd = busiMsgSnd;
	}

}

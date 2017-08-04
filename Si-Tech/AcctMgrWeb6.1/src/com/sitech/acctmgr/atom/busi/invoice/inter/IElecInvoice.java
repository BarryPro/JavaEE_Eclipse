package com.sitech.acctmgr.atom.busi.invoice.inter;

import java.util.Map;

import com.sitech.acctmgr.atom.domains.invoice.elecInvoice.InvQryParam;
import com.sitech.acctmgr.atom.domains.invoice.elecInvoice.InvoiceDdInfo;
import com.sitech.acctmgr.atom.domains.invoice.elecInvoice.InvoiceDetailInfo;
import com.sitech.acctmgr.atom.domains.invoice.elecInvoice.InvoiceHeaderInfo;
import com.sitech.acctmgr.atom.domains.invoice.elecInvoice.InvoiceInfo;
import com.sitech.acctmgr.atom.domains.invoice.elecInvoice.InvoiceXhfInfo;

/**
 * 电子发票
 * 
 * @author liuhl_bj
 *
 */
public interface IElecInvoice {

	/**
	 * 获取pdf文件
	 * 
	 * @param requestSn
	 * @return
	 */
	String getInvPdfFile(String requestSn);
	
	/**
	 * 获取发票文件fileType 0, 原始PDF文件 1, 黑白PDF 2， PNG图片
	 * 
	 * @param requestSn
	 * @param phoneNo
	 * @param fileType
	 * @return
	 */
	String getInvFile(String requestSn, String phoneNo, String fileType);

	/**
	 * 电子发票139邮箱推送
	 * 
	 * @param inParam
	 */
	void sendMail(String requestSn, int printYm, String phoneNo, String kpqd, String khqd, String pdf, String printFee, String xmmc);

	/**
	 * 蓝发票打印，调用CRMPD接口。支持同步和异步方式
	 * 
	 * @param eleInvoice
	 * @param xhfInfo
	 * @param loginNo
	 * @param sendMsgFlag
	 *            短信发送标志 0：发送 1：不发送
	 * @return
	 */
	Map<String, String> EInvPrintSub(InvoiceInfo eleInvoice, InvoiceXhfInfo xhfInfo, String loginNo, int sendMsgFlag, String chnSource);

	/**
	 * 发送短信
	 * 
	 * @param phoneNo
	 * @param url
	 */
	void sendSms(String phoneNo, String url, String chnSource, String requestSn, String date);

	/**
	 * 重发短信
	 * 
	 * @param inParamMap
	 */
	void smsSendAgain(String phoneNo, String url, String chnSource, String requestSn, String date);

	/**
	 * 保存CRM电子发票信息
	 * 
	 * @param inParamMap
	 */
	void saveCrmElecInvoice(Map<String, Object> inParamMap);

	/**
	 * CRM对发票同步打印接口返回的content内容解析，并入相关的表
	 * 
	 * @param inParamMap
	 * @param content
	 * @throws Exception
	 */
	void EInvcContentDealCrm(Map<String, Object> inParamMap, String content) throws Exception;

	/**
	 * 给CRM发送工单
	 * 
	 * @param inmap
	 * @throws Exception
	 */
	void sendOrderToCRM(Map<String, Object> inmap) throws Exception;

	/**
	 * 调用应用集成平台开具电子发票
	 * 
	 * @param eleInvoice
	 * @param xhfInfo
	 * @param asynFlag
	 * @return
	 */
	Map<String, String> getEleInvoiceIssue(InvoiceInfo eleInvoice, InvoiceXhfInfo xhfInfo, String asynFlag);

	/**
	 * 获取发票头信息
	 * 
	 * @param xhfInfo
	 * @param opCode
	 * @param custName
	 * @param phoneNo
	 * @param loginName
	 * @param loginAccept
	 * @param printFee
	 * @return
	 */
	InvoiceHeaderInfo getEleInvHeader(InvoiceXhfInfo xhfInfo, String opCode, String custName, String phoneNo, String loginName, String loginAccept,
			long printFee);

	/**
	 * 获取发票项目信息
	 * 
	 * @param fee
	 * @param feeName
	 * @param TypeFPHXZ
	 * @return
	 */
	InvoiceDetailInfo getInvoiceItem(long fee, String feeName, String TypeFPHXZ);

	/**
	 * 获取订单信息
	 * 
	 * @param orderId
	 * @return
	 */
	InvoiceDdInfo getOrderInfo(String orderId);

	/**
	 * 解析航信返回的报文
	 * 
	 * @param content
	 * @return
	 */
	InvQryParam EInvcContentDeal(String content);

}

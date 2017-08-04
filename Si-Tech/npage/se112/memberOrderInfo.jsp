<%@page contentType="text/html;charset=GBK"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	String memberNo =request.getParameter("memberNo");
	String xml = request.getParameter("xml");
	String type = request.getParameter("type");
	String funds = request.getParameter("funds");
	String sysPay = request.getParameter("sysPay");
	String netCode = request.getParameter("netCode");
	boolean freeFlag = "-1".equals(memberNo);
	MapBean mb = new MapBean();	
%>
<%@ include file="getMapBean.jsp"%>
<%
	List memMapList = mb.getList("OUT_DATA.H15.MEMBER_LIST.MEMBER_INFO");
	List feeMapList = mb.getList("OUT_DATA.H16.FEE_LIST.FEE_INFO");
	if("N/A".equals(feeMapList.get(0)))feeMapList = new ArrayList();
	List addFeeMapList = mb.getList("OUT_DATA.H17.ADDFEE_LIST.ADDFEE_INFO");
	if("N/A".equals(addFeeMapList.get(0)))addFeeMapList = new ArrayList();
	List fundMapList = mb.getList("OUT_DATA.H18.FUND_LIST.FUND_INFO");
	if("N/A".equals(fundMapList.get(0)))fundMapList = new ArrayList();
	List sysPayMapList = mb.getList("OUT_DATA.H19.SYSPAY_LIST.SYSPAY_INFO");
	if("N/A".equals(sysPayMapList.get(0)))sysPayMapList = new ArrayList();
	StringBuffer exStr = new StringBuffer();
	/************************成员号码*******************************/
	StringBuffer memberStr = new StringBuffer();
	memberStr.append("<table>").append("<tr><th>成员号码</th>");
	if(!"B".equals(type)){
		memberStr.append("<th>密码</th>");
	}
	memberStr.append("<th>操作</th></tr>");
	memberStr.append("<tr><td><input type=text' id='memberNo' ");
	if("B".equals(type) && netCode.length() > 0){
		memberStr.append("value='").append(netCode).append("' ");;
	}
	memberStr.append("/></td>");
	if(!"B".equals(type)){
		memberStr.append("<td><input type='password' id='memberPsd'onKeyPress='return isKeyNumberdot(0)'  class='button' prefield='userpwd' filedtype='pwd' maxlength='6' onFocus='showReNumberDialog(document.all.memberPsd)' pwdlength='6' /></td>");
	}
	memberStr.append("<td><input id='button_mem_check' class='b_text' type='button' value='校验' onclick= 'checkMember(\"").append(memberNo).append("\")'/>");
	memberStr.append("<input id='button_mem_save' class='b_text' disabled='disabled' type='button' value='保存' onclick= 'saveMember()'/></td></tr></table>");
	/************************主资费*******************************/
	StringBuffer feeStr = new StringBuffer();
	feeStr.append("<table id='table_fee' style='display:none'>")
		.append("<tr><th>选择主资费</th><th>主资费代码</th><th>主资费名称</th></tr>");
	int feeNum = 0;
	for(int i=0; i<feeMapList.size(); i++){
		Map feeMap = (Map)feeMapList.get(i);
		String memberType = (String)feeMap.get("MEMBER_TYPE");
		if(!type.equals(memberType)){
			continue;
		}
		feeNum ++;
		String feeCode = (String)feeMap.get("PRI_FEE_CODE");
		String feeName = (String)feeMap.get("PRI_FEE_NAME");
		String validFlag = (String)feeMap.get("PRI_FEE_VALID");
		feeStr.append("<tr>")
			.append("<td><input type='radio' name='fee' value='").append(feeCode).append("' size='1' ")
				.append("onclick='sendFeeExtAjax(\"").append(feeCode).append("\")' />")
				.append("<input type='hidden' id='hid_fee_").append(feeCode).append("' value='").append(validFlag).append("' />")
			.append("</td>")
			.append("<td>").append(feeCode).append("</td>")
			.append("<td>").append(feeName).append("</td>")
			.append("</tr>");
	}
	feeStr.append("</table>");
	/************************主资费可选套餐*******************************/
	StringBuffer feeExtStr = new StringBuffer();
	feeExtStr.append("<table id='table_feeExt'  style='display:none'></table>");;
	/************************附加资费*******************************/
	StringBuffer addFeeStr = new StringBuffer();
	int addFeeNum = 0;
	addFeeStr.append("<table id='table_addFee' style='display:none'>")
	.append("<tr><th>选择附加资费</th><th>附加资费代码</th><th>附加资费名称</th><th>消费期限</th></tr>");
	for(int i=0; i<addFeeMapList.size(); i++){
		Map addFeeMap = (Map)addFeeMapList.get(i);
		String addFeeType = (String)addFeeMap.get("ADD_FEE_TYPE");
		if(!type.equals(addFeeType)){
			continue;
		}
		addFeeNum ++;
		String addFeeCdoe = (String)addFeeMap.get("ADD_FEE_CODE");
		String addFeeName = (String)addFeeMap.get("ADD_FEE_NAME");
		String addFeeTime = (String)addFeeMap.get("ADD_FEE_TIME");
		addFeeStr.append("<tr>")
			.append("<td><input type='checkbox' name='addFee' value='").append(addFeeCdoe).append("'  />")
				.append("<input type='hidden' id='hid_addfee_time_").append(addFeeCdoe).append("' value='").append(addFeeTime).append("' />")
			.append("</td>")
			.append("<td>").append(addFeeCdoe).append("</td>")
			.append("<td>").append(addFeeName).append("</td>")
			.append("<td>").append(addFeeTime).append("</td>")
			.append("</tr>");
	}
	/************************专款*******************************/
	StringBuffer fundStr = new StringBuffer();
	int fundNum = 0;
	fundStr.append("<table id='table_fund' style='display:none'><tr>");
	if(freeFlag){
		fundStr.append("<th>分配金额</th>");
	}
	fundStr.append("<th>专款类型</th><th>生效标示</th><th>消费期限</th>")
		.append("<th>返还方式</th></tr>");
	if((!"0".equals(funds)&&fundMapList.size() > 1) || freeFlag){
		String isCoefficientFun = (String)(((Map)fundMapList.get(0)).get("IS_COEFFICIENT"));
		String coefficientFun = "";
		if("Y".equals(isCoefficientFun)){
			coefficientFun = (String)(((Map)fundMapList.get(0)).get("COEFFICIENT"));
			System.out.println("---------1000000000009---------"+coefficientFun);			
		}
		for(int i=1; i<fundMapList.size(); i++){
			Map fundMap = (Map)fundMapList.get(i);
			String memberType = (String)fundMap.get("MEMBER_TYPE");
			if(!type.equals(memberType)){
				continue;
			}
			fundNum++;
			String payType = (String)fundMap.get("PAY_TYPE");
			String validFlag = (String)fundMap.get("VALID_FLAG");
			String consumeTime = (String)fundMap.get("CONSUME_TIME");
			String returnType = (String)fundMap.get("RETURN_TYPE");
			String validFlagStr = "";
			if("0".equals(validFlag)){
				validFlagStr = "立即生效";
			}
			if("1".equals(validFlag)){
				validFlagStr = "下月生效";
			}
			if("2".equals(validFlag)){
				validFlagStr = "自定义时间";
			}
			String returnTypeStr = "";
			if("0".equals(returnType)){
				returnTypeStr = "活动预存";
			}
			if("1".equals(returnType)){
				returnTypeStr = "底线预存";
			}
			fundStr.append("<tr>");
			if(freeFlag){
				fundStr.append("<td><input type='text' id='fund_value_").append(returnType).append("' /></td>");
			}
			fundStr.append("<td>").append(payType).append("</td>")
				.append("<td>").append(validFlagStr).append("</td>")
				.append("<td>").append(consumeTime).append("</td>")
				.append("<td>").append(returnTypeStr).append("</td>")
				.append("</tr>");
			exStr.append("<input type='hidden' id='hid_fund_").append(returnType).append("' value='").append(payType).append("' />");
		}
		if("Y".equals(isCoefficientFun)){
			fundStr.append("<tr><th>分配总金额：</th><td><input type='text' class='text notNegReal'  id='fund_value' onblur='familyMoneyfund()' /></td></tr>");
			fundStr.append(" <input type='hidden' id='hid_CoefficientFun' value='").append(coefficientFun).append("' /> ");
		}
	}
	/************************系统充值*******************************/
	StringBuffer sysPayStr = new StringBuffer();
	int sysPayNum = 0;
	sysPayStr.append("<table id='table_syspay' style='display:none'><tr>");
	if(freeFlag){
		sysPayStr.append("<th>分配金额</th>");
	}
	sysPayStr.append("<th>系统充值类型</th><th>生效标示</th><th>消费期限</th>")
		.append("<th>返还方式</th></tr>");
	if(!"0".equals(sysPay) && sysPayMapList.size() > 1){
		String isCoefficientSys = (String)(((Map)sysPayMapList.get(0)).get("IS_COEFFICIENT"));
		String coefficientSys = "";
		if("Y".equals(isCoefficientSys)){
			coefficientSys=(String)(((Map)sysPayMapList.get(0)).get("COEFFICIENT"));
		}
		for(int i=1; i<sysPayMapList.size(); i++){
			Map sysPayMap = (Map)sysPayMapList.get(i);
			String memberType = (String)sysPayMap.get("MEMBER_TYPE");
			if(!type.equals(memberType)){
				continue;
			}
			sysPayNum++;
			String payType = (String)sysPayMap.get("PAY_TYPE");
			String validFlag = (String)sysPayMap.get("VALID_FLAG");
			String consumeTime = (String)sysPayMap.get("CONSUME_TIME");
			String returnType = (String)sysPayMap.get("RETURN_TYPE");
			String validFlagStr = "";
			if("0".equals(validFlag)){
				validFlagStr = "立即生效";
			}
			if("1".equals(validFlag)){
				validFlagStr = "下月生效";
			}
			if("2".equals(validFlag)){
				validFlagStr = "自定义时间";
			}
			String returnTypeStr = "";
			if("0".equals(returnType)){
				returnTypeStr = "活动预存";
			}
			if("1".equals(returnType)){
				returnTypeStr = "底线预存";
			}
			sysPayStr.append("<tr>");
			if(freeFlag){
				sysPayStr.append("<td><input type='text' id='sysPay_value_").append(returnType).append("' /></td>");
			}
			sysPayStr.append("<td>").append(payType).append("</td>")
				.append("<td>").append(validFlagStr).append("</td>")
				.append("<td>").append(consumeTime).append("</td>")
				.append("<td>").append(returnTypeStr).append("</td>")
				.append("</tr>");
			exStr.append("<input type='hidden' id='hid_sysPay_").append(returnType).append("' value='").append(payType).append("' />");
		}
		if("Y".equals(isCoefficientSys)){
			sysPayStr.append("<tr><th>分配总金额：</th><td><input type='text' class='text notNegReal' id='sysPay_value' onblur='familyMoneySysPay()' /></td></tr>");
			sysPayStr.append(" <input type='hidden' id='hid_coefficientSys' value='").append(coefficientSys).append("' /> ");
		}
	}
	/************************附加订购信息*******************************/
	exStr.append("<input type='hidden' id='memNo' value='").append(memberNo).append("'>");
	exStr.append("<input type='hidden' id='feeNum' value='").append(feeNum).append("'>");
	exStr.append("<input type='hidden' id='addFeeNum' value='").append(addFeeNum).append("'>");
	exStr.append("<input type='hidden' id='fundNum' value='").append(fundNum).append("'>");
	exStr.append("<input type='hidden' id='sysPayNum' value='").append(sysPayNum).append("'>");
	exStr.append("<input type='hidden' id='memType' value='").append(type).append("'>");
	exStr.append(memberStr);
	if(feeNum > 0){
		exStr.append(feeStr);
		exStr.append(feeExtStr);
	}
	if(addFeeNum > 0){
		exStr.append(addFeeStr);
	}
	if(fundNum > 0){
		exStr.append(fundStr);
	}
	if(sysPayNum > 0){
		exStr.append(sysPayStr);
	}
	out.print(exStr);
%>
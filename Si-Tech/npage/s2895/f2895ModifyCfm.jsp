<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.14
 模块:集团订购信息管理(修改)
********************/
%>

<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ page import="com.sitech.util.UnicodeUtil"%>

<%
	String opCode = "2885";
	String opName = "集团订购信息管理(修改)";
	
	//读取用户session信息
	String regCode = (String)session.getAttribute("regCode");
	String workNo   = (String)session.getAttribute("workNo");               //工号
				
	/* 接受输入参数 */
	String custId       = request.getParameter("custId");           //集团客户id
	String idNo         = request.getParameter("idNo");
	String attrCode     = request.getParameter("attrCode");
	String prodCode     = request.getParameter("prodCode");
	String newAttrValue = UnicodeUtil.unescape(request.getParameter("newAttrValue"));    
	String iMonthFee    = request.getParameter("iMonthFee");      
	String unitId = request.getParameter("unitId");
	System.out.println("======: " + idNo.substring(idNo.length()-1,idNo.length()));
	String errCode="";
    String errMsg="";
    String url = "";
 	System.out.println("cfmcfmcfmcfmcfmcfmcfmcfmcfmcfm=="+unitId);
	if (attrCode.equals("58")) {
		String paramsIn[] = new String[13];                           
		paramsIn[0]  = "2911";                                      
		paramsIn[1]  = idNo.substring(idNo.length()-1,idNo.length()); 
		paramsIn[2]  = newAttrValue;                                  
		paramsIn[3]  = workNo;	                                     
		paramsIn[4]  = "2885";                                        
		paramsIn[5]  = idNo;                                          
		paramsIn[6]  = prodCode;                                      
		paramsIn[7]  = attrCode; 
		
		paramsIn[8]  = idNo.substring(idNo.length()-1,idNo.length()); 
		paramsIn[9]  = newAttrValue;  
		paramsIn[10] = iMonthFee;                                       
		paramsIn[11]  = prodCode;    
		paramsIn[12]  = idNo;  
		 
		//acceptList = impl.callService("sDynSqlCfm",paramsIn,"0");    
%>
		<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
		<wtc:param value="<%=paramsIn[0]%>"/>	
		<wtc:param value="<%=paramsIn[1]%>"/>	
		<wtc:param value="<%=paramsIn[2]%>"/>	
		<wtc:param value="<%=paramsIn[3]%>"/>	
		<wtc:param value="<%=paramsIn[4]%>"/>	
		<wtc:param value="<%=paramsIn[5]%>"/>	
		<wtc:param value="<%=paramsIn[6]%>"/>	
		<wtc:param value="<%=paramsIn[7]%>"/>	
		<wtc:param value="<%=paramsIn[8]%>"/>	
		<wtc:param value="<%=paramsIn[9]%>"/>	
		<wtc:param value="<%=paramsIn[10]%>"/>	
		<wtc:param value="<%=paramsIn[11]%>"/>	
		<wtc:param value="<%=paramsIn[12]%>"/>	
		</wtc:service>	
		<wtc:array id="result1"  scope="end"/>
<%
		url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&retMsgForCntt="+retMsg1+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+""+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+unitId+"&contactType=cust";
		errCode=retCode1;                          
	}
   else  {
	       String paramsIn[] = new String[8];
           paramsIn[0] = "288500";
           paramsIn[1] = idNo.substring(idNo.length()-1,idNo.length());
           paramsIn[2] = newAttrValue;
           paramsIn[3] = workNo;	
           paramsIn[4] = "2885";
           paramsIn[5] = idNo;
           paramsIn[6] = prodCode;
           paramsIn[7] = attrCode;
           
	       //acceptList = impl.callService("sDynSqlCfm",paramsIn,"0");
%>	       
			<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1">			
			<wtc:param value="<%=paramsIn[0]%>"/>	
			<wtc:param value="<%=paramsIn[1]%>"/>	
			<wtc:param value="<%=paramsIn[2]%>"/>	
			<wtc:param value="<%=paramsIn[3]%>"/>	
			<wtc:param value="<%=paramsIn[4]%>"/>	
			<wtc:param value="<%=paramsIn[5]%>"/>	
			<wtc:param value="<%=paramsIn[6]%>"/>	
			<wtc:param value="<%=paramsIn[7]%>"/>	
			</wtc:service>	
			<wtc:array id="result2"  scope="end"/>
<%			
			url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode2+"&retMsgForCntt="+retMsg2+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+""+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+custId+"&contactType=grp";
	        errCode=retCode2;
	}
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
	System.out.println("onceCnttInfo Cfm");	
%>
	
var response = new AJAXPacket();
response.data.add("retCode","<%=errCode%>");
response.data.add("flag","10");
core.ajax.receivePacket(response);

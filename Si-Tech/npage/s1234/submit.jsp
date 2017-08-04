<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-04 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<HTML>
</HEAD>
<BODY>
<FORM action="" method=post name="form1">
</FORM>
<BODY>
</HTML>
<%
		String cnttOpCode = request.getParameter("opCode");
		String cnttOpName = request.getParameter("opName");		
		String broadPhone = request.getParameter("broadPhone");
		String activePhone1=request.getParameter("activePhone1");
		String cnttWorkNo = (String)session.getAttribute("workNo");
		System.out.println("###############################################activePhone1->"+activePhone1);
		
		
		String loginAccept = request.getParameter("loginAccept");
		//System.out.println("loginAccept is : " + loginAccept);
		String opCode= request.getParameter("opCode");
		//System.out.println("opCode is : " + opCode);
		String workNo= request.getParameter("workNo");
		//System.out.println("workNo is : " +  workNo);
		String noPass = (String)session.getAttribute("password");
		//System.out.println("noPass is : "+ noPass);
		String orgCode= request.getParameter("orgCode");
		//System.out.println("orgCode is : "+ orgCode);
		String idNo= request.getParameter("idNo");
		//System.out.println("idNo is : "+idNo);
		String payFee= request.getParameter("payFee");
		//System.out.println("payFee is : "+payFee);
		String factPay= request.getParameter("t_handFee");
		//System.out.println("realFee is : "+factPay);
		String sysRemark= "sysRemark";
		//System.out.println("sysRemark is : " + sysRemark);
		String remark="remark";// request.getParameter("remark");
		//System.out.println("remark is : "+remark);
		String ipAdd= request.getParameter("selfIpAddr");
		//System.out.println("ipAddr is : "+ipAdd);
		String opType = request.getParameter("opType");
		//System.out.println("opType is : "+opType);
		String opFlag = request.getParameter("opFlag");
		//System.out.println("opFlag is : "+opFlag);
		String oldPass = request.getParameter("phonePass");
		//System.out.println("oldPass is  : "+oldPass);
		String newPass = request.getParameter("t_new_pass");
		//System.out.println("newPass is : "+newPass);
		String asNotes = request.getParameter("asNotes");
		String strIdenType = request.getParameter("identity_type");
		String strIdenInfo = request.getParameter("identity_info");
		//System.out.println("strIdenType="+strIdenType);
		//System.out.println("strIdenInfo="+strIdenInfo);
		//System.out.println("f1234:::::::::::::::::::::::::::::"+asNotes);
		String ecNewPass = Encrypt.encrypt(newPass);
		String stream=WtcUtil.repNull(request.getParameter("loginAccept"));
		//System.out.println("ecNewPass="+ecNewPass);
		String thework_no=workNo;
		String themob=WtcUtil.repNull(request.getParameter("idNo"));
		String theop_code=opCode;
		
		String iPhoneNo = request.getParameter("cus_id");
    String iChnSource = "01";
    String iUserPwd = "";

%>		
<%
		String paraStr[]=new String[20];
	  paraStr[0] = loginAccept;
		paraStr[1] = iChnSource;
		paraStr[2] = opCode;
		paraStr[3] = workNo;
		paraStr[4] = noPass;
		paraStr[5] = iPhoneNo;
		paraStr[6] = iUserPwd;
		paraStr[7] = orgCode;
		paraStr[8] = opType;
		paraStr[9] = opFlag;
		paraStr[10] = idNo;
		paraStr[11] = oldPass;
		paraStr[12] = ecNewPass;
		paraStr[13] = payFee;
		paraStr[14] = factPay;
		paraStr[15] = sysRemark;
		paraStr[16] = asNotes;
		paraStr[17] = ipAdd;
		paraStr[18] = strIdenType;//验证类型
		paraStr[19] = strIdenInfo;//验证信息
		//String backInfo[] = impl.callService("s1234Cfm", paraStr,"1");
%>
		<wtc:service name="s1234Cfm" routerKey="phone" routerValue="<%=activePhone1%>" retCode="retCode1" retMsg="retMsg1" outnum="1" >
		<wtc:param value="<%=paraStr[0]%>"/>
		<wtc:param value="<%=paraStr[1]%>"/>
		<wtc:param value="<%=paraStr[2]%>"/>
		<wtc:param value="<%=paraStr[3]%>"/>
		<wtc:param value="<%=paraStr[4]%>"/>
		
		<wtc:param value="<%=paraStr[5]%>"/>
		<wtc:param value="<%=paraStr[6]%>"/>
		<wtc:param value="<%=paraStr[7]%>"/>
		<wtc:param value="<%=paraStr[8]%>"/>
		<wtc:param value="<%=paraStr[9]%>"/>
			
		<wtc:param value="<%=paraStr[10]%>"/>
		<wtc:param value="<%=paraStr[11]%>"/>
		<wtc:param value="<%=paraStr[12]%>"/>
		<wtc:param value="<%=paraStr[13]%>"/>
		<wtc:param value="<%=paraStr[14]%>"/>
		<wtc:param value="<%=paraStr[15]%>"/>
		<wtc:param value="<%=paraStr[16]%>"/>
		<wtc:param value="<%=paraStr[17]%>"/>
		<wtc:param value="<%=paraStr[18]%>"/>
		<wtc:param value="<%=paraStr[19]%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end"/>
<%
	 	System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");		
		String cnttActivePhone = activePhone1;
	  String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+cnttOpName+"&workNo="+cnttWorkNo+"&loginAccept="+loginAccept+"&pageActivePhone="+cnttActivePhone+"&opBeginTime="+opBeginTime+"&contactId="+cnttActivePhone+"&contactType=user";
		System.out.println("url->"+url);
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
	 	System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");	
		int returnCode = retCode1==""?999999:Integer.parseInt(retCode1);
		if(returnCode==0){

 	    String statisLoginAccept =  loginAccept; /*流水*/
		String statisOpCode="1235";
		String statisPhoneNo="";	
		String statisIdNo="";	
		String statisCustId=request.getParameter("cus_id");
		String statisUrl = "/npage/public/pubCustSatisIn.jsp"
			+"?statisLoginAccept="+statisLoginAccept
			+"&statisOpCode="+statisOpCode
			+"&statisPhoneNo="+statisPhoneNo
			+"&statisIdNo="+statisIdNo	
			+"&statisCustId="+statisCustId;	
    	System.out.println("@zhangyan~~~~statisLoginAccept="+statisLoginAccept);
    	System.out.println("@zhangyan~~~~statisOpCode="+statisOpCode);
    	System.out.println("@zhangyan~~~~statisPhoneNo="+statisPhoneNo);
    	System.out.println("@zhangyan~~~~statisIdNo="+statisIdNo);
    	System.out.println("@zhangyan~~~~statisCustId="+statisCustId);
    	System.out.println("@zhangyan~~~~statisUrl="+statisUrl);
    	
   		if (statisOpCode.equals("1235"))
		{
		%>
		<jsp:include page="<%=statisUrl%>" flush="true" />	
		
		<%	
		}			
		
		
		
%>
				<script>
						rdShowMessageDialog("操作成功!",2);
						window.location="f1234.jsp?activePhone1=<%=activePhone1%>&opCode=<%=cnttOpCode%>&opName=<%=cnttOpName%>&broadPhone=<%=broadPhone%>";
				</script>
<%
		}else{
%>
				<script>
						rdShowMessageDialog("操作失败 !"+"<%=retMsg1%>");
						window.location="f1234.jsp?activePhone1=<%=activePhone1%>&opCode=<%=cnttOpCode%>&opName=<%=cnttOpName%>&broadPhone=<%=broadPhone%>";
				</script>
<%
		}
%>


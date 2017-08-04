<%
    /********************
     version v2.0
     开发商: si-tech
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String phoneNo = request.getParameter("phoneNo");
	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String op_code = "6945";
	String op_name = "垃圾短信与网管黑名单综合受理";
	String loginaccept = WtcUtil.repNull(request.getParameter("loginaccept"));
	String loginPwd = (String)session.getAttribute("password");
	String paraStr[] = new String[24];
	String seled = request.getParameter("seled"); 
  //System.out.println("seed====="+seled);
	paraStr[0] = "0";
	paraStr[1] = "01";
    paraStr[2] = op_code;
    paraStr[3] = work_no;
    paraStr[4] = loginPwd;
    paraStr[5] = WtcUtil.repNull(request.getParameter("phoneNo"));
    paraStr[6] = "";
    paraStr[7] = WtcUtil.repNull(request.getParameter("opType"));
    paraStr[8] = WtcUtil.repNull(request.getParameter("delayType"));
    paraStr[9] = WtcUtil.repNull(request.getParameter("blackReason"));
	
%>
		<wtc:service name="s7478Cfm" routerKey="phone" retCode="initRetCode" retMsg="initRetMsg" routerValue="<%=phoneNo%>" outnum="3">
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
				<wtc:param value="<%=seled%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%

			if(initRetCode.equals("0")||initRetCode.equals("000000"))
			{
				System.out.println("调用服务s7478Cfm in f6945Cfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%> 
          		<script language="JavaScript">
					rdShowMessageDialog("操作成功!");
					window.location="s6945Login.jsp?opCode=<%=op_code%>&opName=<%=op_name%>";
				</script>
<%
 	        		        	
 	     	}else{
	 			System.out.println("调用服务s7478Cfm in f6945Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
	 			System.out.println(initRetCode+"   initRetCode    "+initRetMsg+"    initRetMsg");
%>   
				<script language="JavaScript">
					rdShowMessageDialog("操作失败!<%=initRetMsg%>");
					window.location="s6945Login.jsp?opCode=<%=op_code%>&opName=<%=op_name%>";
				</script>
<%	
 			}
%>

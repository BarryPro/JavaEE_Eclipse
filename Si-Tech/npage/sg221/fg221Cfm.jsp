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
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	String phoneNo = request.getParameter("single_phoneno1");
	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String op_code = "g221";
	String op_name = "集团成员包年续签";
	String loginaccept = WtcUtil.repNull(request.getParameter("loginaccept"));
	String loginPwd = (String)session.getAttribute("password");
	 String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String paraStr[] = new String[24];
	String seled = request.getParameter("seled"); 
	String ipAddr = (String)session.getAttribute("ipAddr");
  //System.out.println("seed====="+seled);
	paraStr[0] = "0";
	paraStr[1] = "01";
    paraStr[2] = op_code;
    paraStr[3] = work_no;
    paraStr[4] = loginPwd;
    paraStr[5] = WtcUtil.repNull(request.getParameter("single_phoneno1"));
    paraStr[6] = "";
    paraStr[7] = WtcUtil.repNull(request.getParameter("new_offerids"));
    paraStr[8] = WtcUtil.repNull(request.getParameter("id_no"));
    paraStr[9] = WtcUtil.repNull(request.getParameter("sm_code"));
    paraStr[10] = regCode;
    paraStr[11] = ipAddr;
	
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regCode%>"  id="loginAccept" />
		<wtc:service name="s221Cfm" routerKey="phone" retCode="initRetCode" retMsg="initRetMsg" routerValue="<%=phoneNo%>" outnum="3">
			<wtc:param value="<%=loginAccept%>"/>
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
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%

			if(initRetCode.equals("0")||initRetCode.equals("000000"))
			{
				System.out.println("调用服务s221Cfm 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%> 
          		<script language="JavaScript">
					rdShowMessageDialog("操作成功!");
					window.location="fg221.jsp?opCode=<%=op_code%>&opName=<%=op_name%>";
				</script>
<%
 	        		        	
 	     	}else{
	 			System.out.println("调用服务s221Cfm失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
	 			System.out.println(initRetCode+"   initRetCode    "+initRetMsg+"    initRetMsg");
%>   
				<script language="JavaScript">
					rdShowMessageDialog("操作失败!<%=initRetMsg%>");
					window.location="fg221.jsp?opCode=<%=op_code%>&opName=<%=op_name%>";
				</script>
<%	
 			}
%>

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
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String opName = "垃圾短信与网管黑名单综合受理";
	String opCode = "e851";
	String loginaccept = WtcUtil.repNull(request.getParameter("loginaccept"));
	String loginPwd = (String)session.getAttribute("password");
	String paraStr[] = new String[8];
	
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=phoneNo%>" id="printAccept"/>
<%
	
	  paraStr[0] = printAccept;
	  paraStr[1] = "01";
    paraStr[2] = opCode;
    paraStr[3] = work_no;
    paraStr[4] = loginPwd;
    paraStr[5] = phoneNo;
    paraStr[6] = "";
    paraStr[7] = WtcUtil.repNull(request.getParameter("delayType"));
	
%>
		<wtc:service name="se851Cfm" routerKey="phone" retCode="initRetCode" retMsg="initRetMsg" routerValue="<%=phoneNo%>" outnum="3">
			<wtc:param value="<%=paraStr[0]%>"/>
			<wtc:param value="<%=paraStr[1]%>"/>
			<wtc:param value="<%=paraStr[2]%>"/>
			<wtc:param value="<%=paraStr[3]%>"/>
			<wtc:param value="<%=paraStr[4]%>"/>
			<wtc:param value="<%=paraStr[5]%>"/>
			<wtc:param value="<%=paraStr[6]%>"/>
			<wtc:param value="<%=paraStr[7]%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%

			if(initRetCode.equals("000000"))
			{
				System.out.println("调用服务se851Cfm in f6945_netsPhoneNoQryCfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%> 
          		<script language="JavaScript">
					rdShowMessageDialog("操作成功!",2);
					window.location="s6945Login.jsp";
				</script>
<%
 	        		        	
 	    }else{
	 			System.out.println("调用服务se851Cfm in f6945_netsPhoneNoQryCfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
	 			System.out.println(initRetCode+"   initRetCode    "+initRetMsg+"    initRetMsg");
%>   
				<script language="JavaScript">
					rdShowMessageDialog("操作代码：<%=initRetCode%><br>错误信息：<%=initRetMsg%>",0);
					window.location="s6945Login.jsp";
				</script>
<%	
 			}
%>

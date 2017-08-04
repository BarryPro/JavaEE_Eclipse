<%
/********************
 version v2.0
 开发商 si-tech
 create hejwa@2010-1-26 :17:05
********************/
%>
              
          
			
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 

 
<%
	String regionCode = (String)session.getAttribute("regCode");
	String phoneNo = request.getParameter("phoneNo");
	System.out.println("--------------phoneNo-----------------"+phoneNo);
	String workNo = (String)session.getAttribute("workNo");
	String retCodej = "";
	String retMsgj = "";
%>
	<wtc:service name="sCustSatisLimit" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:param value="<%=workNo%>"/>	
	</wtc:service>
<%

	retCodej = retCode;
	retMsgj = retMsg;

System.out.println("------------------retCodej--------------------"+retCodej);
System.out.println("------------------retMsgj---------------------"+retMsgj);
	if (retCodej.equals("000000")||retCodej.equals("0"))
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("客户满意度调查屏蔽成功!",2);
	removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("客户满意度调查屏蔽失败!<br>errCode:<%=retCodej%><br>errMsg:<%=retMsgj%>",0);
	history.go(-1);
</script>
<%}%>

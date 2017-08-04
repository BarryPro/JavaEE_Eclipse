<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-24 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

	String opCode = request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");	

	String regionCode= (String)session.getAttribute("regCode");
	String orgCode =  (String)session.getAttribute("orgCode");
	String workno =  (String)session.getAttribute("workNo");	
	String nopass = (String)session.getAttribute("password");
	
	String TPrintDate = request.getParameter("TPrintDate");
	String dateStr=TPrintDate;
	String yy=dateStr.substring(0,4);
	String mm=dateStr.substring(4,6);
	String dd=dateStr.substring(6,8);

	
	String yearMonth = request.getParameter("SBillDate");
	String beginCon = request.getParameter("TBeginContract");
	String endCon = request.getParameter("TEndContract");
	String postBankCode = request.getParameter("bank1");
	String TNote = request.getParameter("TNote");
	String belongcode = request.getParameter("SDisCode");
	String entercode = request.getParameter("enter_code");
	String opertype = request.getParameter("oper_type");

    	//String[][] result = new String[][]{};
    
	String[] inParas = new String[10];
	
	inParas[0] = yearMonth;
	inParas[1] = belongcode;
	inParas[2] = postBankCode;
	inParas[3] = beginCon;
	inParas[4] = endCon;
	inParas[5] = orgCode;
	inParas[6] = workno;
	inParas[7] = nopass;
	inParas[8] = entercode;
	inParas[9] = opertype;
	//callRemoteResultValue = viewBean.callService("0",null, "s9904Cfm", "3", inParas);
%>
	<wtc:service name="s9904Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3" >
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>		
		<wtc:param value="<%=inParas[5]%>"/>
		<wtc:param value="<%=inParas[6]%>"/>
		<wtc:param value="<%=inParas[7]%>"/>
		<wtc:param value="<%=inParas[8]%>"/>
		<wtc:param value="<%=inParas[9]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
	
<%  
	String errorCode = "";
	String errorMsg = "";
	String file_path = "";
	int resultSize = result.length;
	if (resultSize != 0) {
		errorCode = result[0][0];
		errorMsg = result[0][1];
		file_path = result[0][2];
	}
%>
<%if(resultSize == 0){%>
<script language="JavaScript">
	rdShowMessageDialog("预览失败，托收单数量为0！",0);
	history.go(-1);
</script>
<%}%>

<%if(!errorCode.equals("000000")){%>
<script language="JavaScript">
	rdShowMessageDialog("预览失败，错误代码:<%=errorCode%><%=errorMsg%>。",0);
	history.go(-1);
</script>
<%}else{%>
	<script language="JavaScript">
		rdShowMessageDialog("操作成功,文件位置及名称:<%=file_path%>。",2);
		window.location.href="s9904.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
	</script>
<%}%>
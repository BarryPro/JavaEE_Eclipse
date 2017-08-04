   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-15
********************/
%>
              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gbk"%>
 <%
  	 	String loginNo = (String)session.getAttribute("workNo");
    	String ipAddr = (String)session.getAttribute("ipAddr");

 	String opCode = "5517";
 	String opNote = "";
 	String opType = request.getParameter("opType");
 	String vOpCode = request.getParameter("iOpCode");
 	String vLoginNo= request.getParameter("iLoginNo");
 	String regionCode = (String)session.getAttribute("regCode");
	String[][] result  = null ;
	String serviceName="";
	
	String inParas[] = new String[6];
	inParas[0] = opCode;
	inParas[1] = loginNo;
	inParas[2] = ipAddr;
	inParas[4] = vOpCode;
	inParas[5] = vLoginNo;
	
 	if("a".equals(opType))
 	{
 		opNote = loginNo+"添加["+vOpCode+"]["+vLoginNo+"]|opCode:5517";
 		serviceName = "s5517Add";
 	}
 	else if("d".equals(opType))
 	{
 		opNote = loginNo+"删除["+vOpCode+"]["+vLoginNo+"]|opCode:5517";
 		serviceName = "s5517Del";
 	}
 	inParas[3] = opNote;
 	
 	//value = viewBean.callService("0", null, serviceName, "2", inParas);
%>

    <wtc:service name="<%=serviceName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inParas[0]%>" />
			<wtc:param value="<%=inParas[1]%>" />
			<wtc:param value="<%=inParas[2]%>" />
			<wtc:param value="<%=inParas[3]%>" />
			<wtc:param value="<%=inParas[4]%>" />
			<wtc:param value="<%=inParas[5]%>" />					
		</wtc:service>
		<wtc:array id="result_t" scope="end"/>

<% 	
 	result = result_t;
 	
 	String return_code = result[0][0];
 	String return_msg = result[0][1];

	if (return_code.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("操作成功! ",2);
   window.location="s5517.jsp";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("操作失败!错误代码<%=return_code%>,错误信息<%=return_msg%>",0);
	window.location="s5517.jsp";
</script>
<%}%>
 		
 		
 		

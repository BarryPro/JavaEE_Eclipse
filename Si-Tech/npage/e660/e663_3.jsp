<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
/********************
 version v2.0
开发商: si-tech
*
*e662  模糊查询分页。
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%
		String[] inParas1 = new String[2];
		String opCode = "e663";
		String opName = "手工系统充值随机码绑定及查询";
		String regionCode = (String)session.getAttribute("regCode");
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String ip_Addr =  (String)session.getAttribute("ipAddr");

    String document_accept	= request.getParameter("document_accept") ;
    String busi_flag 				= request.getParameter("busi_flag") ;
    String rand_no 					= request.getParameter("rand_num");
%>

<wtc:service name="sE660_chkRand" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="1">
	<wtc:param value="<%=busi_flag%>"/>
	<wtc:param value="<%=document_accept%>"/>
	<wtc:param value="<%=workno%>"/>
	<wtc:param value="<%=rand_no%>"/>
</wtc:service>
<wtc:array id="result" start="0" length="1" scope="end"/>

<%
	if( ! retCode.equals("000000") )
	{
%>
	<SCRIPT type=text/javascript>
		rdShowMessageDialog("调用sE660_chkRand服务失败。<br>错误代码：'<%=retCode%>'。<br>错误信息：'<%=retMsg%>'。",0);
		history.go(-1);
	</SCRIPT>
<%
	}
%>

	
</script> 
<title>手工系统充值查询</title>
</head>
<BODY onload=""> 
	<form>
		
		<%@ include file="/npage/include/header.jsp" %>  
		
		<div class="title">
			<div id="title_zi">随机码查询</div>
		</div>

  <table cellspacing="0">
  	
    <tr> 
      <td class="blue" width="10%"  align="center"> 
				随机码：<%=rand_no%>　绑定成功！！
      </td>
    </tr>
    
    <tr> 
      <td id="footer"> 
				<input type="button" name="return2" class="b_foot" value="返回" onClick="history.go(-1)" >
				&nbsp;
  
        &nbsp;
		  <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
       </td>
    </tr>
  </table>
</form>

</BODY>
</HTML>
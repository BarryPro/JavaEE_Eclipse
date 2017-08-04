 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	
	String regionCode = (String)session.getAttribute("regCode");
	String error_msg="系统错误，请与系统管理员联系，谢谢!!";
	String error_code="444444";	
  	int valid = 1;	//0:正确，1：系统错误，2：业务错误

  	String procSql = request.getParameter("procSql");
  %>  		
	<wtc:service name="sPubProcCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="5" >
		<wtc:param value="<%=procSql%>"/>
		<wtc:param value="sDBChange"/>		
	</wtc:service>
	<wtc:array id="al" scope="end"/>
  <%

  	//al = s5010.get_spubproccfm( procSql);

 	if( al == null ){ 		
		valid = 1;
	}else{
		error_code=retCode1;
		
		if(!error_code.equals("000000")){
			valid = 2;
			error_msg= retMsg1;
		}else{
			valid = 0;
		}
	}	
%>

<%if( valid == 1){%>
	<script language="JavaScript">
	<!--
		rdShowMessageDialog("系统错误，请与系统管理员联系，谢谢!!",0);
		window.location="f5003.jsp";
	//-->
	</script>

<%}else if( valid == 2){%>
	<script language="JavaScript">
	<!--
		rdShowMessageDialog("<br>业务错误代码:"+"<%=error_code %></br>"+"错误信息:"+"<%=error_msg %>",0);
		window.location="f5003.jsp";
	//-->
	</script>

<%}else{%>
	<script language="JavaScript">
	<!--
		rdShowMessageDialog("操作成功!!",2);
		window.location="f5003.jsp";
	//-->
	</script>
<%}%>









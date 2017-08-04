<%
/********************
 version v2.0
开发商: si-tech /iwebd2/applications/offerManage/WEB-INF/classes
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%> 
<%
	String opCode ="zg59"; 
	String opName = "WLAN暂停恢复"; 
	String phoneNo = request.getParameter("phoneNo");	
	String workno = request.getParameter("workno");	
	String returnCode="";
	String returnMsg="";	
  String errorMsg="";	
	%>
	<wtc:service name="zg59_cfm" routerKey="regionCode"  retcode="scode" retmsg="sret" outnum="2">
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=workno%>"/>
	<wtc:param value="1"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%
		if(result!=null&&result.length>0){
			returnCode=result[0][0];
			returnMsg=result[0][1];
		}
		if(returnCode=="000000"||"000000".equals(returnCode)){	
		
%>
	<wtc:service name="sWlanOpen" routerKey="regionCode"  retcode="return_code" retmsg="return_msg" outnum="2">
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=workno%>"/>
	</wtc:service>
	<wtc:array id="result11" scope="end" />		
<%
System.out.println("return_code----------sWlanOpen--------------"+return_code);
		if(return_code=="000000"||"000000".equals(return_code)){	
%>		
		<script language="javascript">
				rdShowMessageDialog("操作成功！");			
				window.location="zg59_1.jsp";
				//history.go(-1);
		</script>	
<%	
	}else{
%> 
			<wtc:service name="zg59_cfm" routerKey="regionCode"  retcode="scode" retmsg="sret" outnum="2">
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:param value="<%=workno%>"/>
			<wtc:param value="2"/>
			</wtc:service>
			<wtc:array id="result22" scope="end" />		
		
			<script language="javascript">
				rdShowMessageDialog("sWlanOpen执行失败！错误代码"+"<%=return_code%>"+",错误原因:"+"<%=return_msg%>");			
				window.location="zg59_1.jsp";
				//history.go(-1);
			</script>
<%		
		}
%> 

<%	
	}else{
%>   
			<script language="javascript">
				rdShowMessageDialog("zg59_cfm入表执行失败！错误代码"+"<%=returnCode%>"+",错误原因:"+"<%=returnMsg%>");			
				window.location="zg59_1.jsp";
				//history.go(-1);
			</script>
<%
	}
%>
<%
/********************
 version v2.0
开发商: si-tech
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
	String opCode ="zg51"; //"d223";
	String opName = "测试卡限额设定";//"退费统计";
	String configtype = request.getParameter("configtype");	
	String regionCode= (String)session.getAttribute("regCode"); 
	String workno=(String)session.getAttribute("workNo");
	System.out.println("---------------------configtype---------------------"+configtype);


if(configtype.equals("0")){	
 	String eff_date = request.getParameter("eff_date");	
	String exp_date = request.getParameter("exp_date");	
	String ctrl_value = request.getParameter("ctrl_value");	
	String fee_value = request.getParameter("fee_value");	
	String phoneNo = request.getParameter("phoneNo");	

	//String nopass      = (String)session.getAttribute("password");
%>
	<wtc:service name="zg51_new" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="scode" retmsg="sret" outnum="2">
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=phoneNo%>"/> 
		<wtc:param value="<%=eff_date%>"/> 
		<wtc:param value="<%=exp_date%>"/> 
		<wtc:param value="<%=ctrl_value%>"/> 
		<wtc:param value="<%=fee_value%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" /> 
<%
	if((!scode.equals("0"))&& (!scode.equals("000000"))){
%>

		<script language="JavaScript">
			rdShowMessageDialog("新增配置失败！错误代码"+"<%=scode%>"+",错误原因:"+"<%=sret%>");
			//window.location="zg51_1.jsp";
			history.go(-1);
		</script>
			
<%
	}else{
%>   
		<script language="javascript">
				rdShowMessageDialog("新增配置成功");
				window.location="zg51_1.jsp";
			</script>
<%}
}else if(configtype.equals("1")){	
	System.out.println("----------------------单条修改---------------------");

	String remind_instance_id = request.getParameter("remind_instance_id");		
 	String eff_date = request.getParameter("eff_date");	
	String exp_date = request.getParameter("exp_date");	
	String ctrl_value = request.getParameter("ctrl_value");	
	String fee_value = request.getParameter("fee_value");	
	String phoneNo = request.getParameter("phoneNo");	
	String changeType = request.getParameter("changeType");
	String ctrl_value_new = request.getParameter("ctrl_value_new");	
	String fee_value_new = request.getParameter("fee_value_new");	
	//String nopass      = (String)session.getAttribute("password");
		System.out.println("----------------------changeType---------------------"+changeType);
%>
	<wtc:service name="zg51_update1" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="scode" retmsg="sret" outnum="2">
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=phoneNo%>"/> 
		<wtc:param value="<%=eff_date%>"/> 
		<wtc:param value="<%=exp_date%>"/> 
		<wtc:param value="<%=ctrl_value%>"/> 
		<wtc:param value="<%=fee_value%>"/>
		<wtc:param value="<%=remind_instance_id%>"/>
		<wtc:param value="<%=changeType%>"/>
		<wtc:param value="<%=ctrl_value_new%>"/> 
		<wtc:param value="<%=fee_value_new%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" /> 
<%
	if((!scode.equals("0"))&& (!scode.equals("000000"))){
%>

		<script language="JavaScript">
			rdShowMessageDialog("修改配置失败！错误代码"+"<%=scode%>"+",错误原因:"+"<%=sret%>");
			//window.location="zg51_1.jsp";
			history.go(-1);
		</script>
			
<%
	}else{
%>   
		<script language="javascript">
				rdShowMessageDialog("修改配置成功");
				window.location="zg51_1.jsp";
			</script>
<%}
}else{
	System.out.println("----------------------33333333333---------------------");
	System.out.println("----------------------两条修改---------------------");
	
	String remind_instance_id0 = request.getParameter("remind_instance_id0");		
 	String eff_date0 = request.getParameter("eff_date0");	
	String exp_date0 = request.getParameter("exp_date0");	
	String ctrl_value0 = request.getParameter("ctrl_value0");	
	String fee_value0 = request.getParameter("fee_value0");
	
	String remind_instance_id = request.getParameter("remind_instance_id");		
 	String eff_date = request.getParameter("eff_date");	
	String exp_date = request.getParameter("exp_date");	
	String ctrl_value = request.getParameter("ctrl_value");	
	String fee_value = request.getParameter("fee_value");	
	String phoneNo = request.getParameter("phoneNo");	
	String changeType = request.getParameter("changeType");
	String ctrl_value_new = request.getParameter("ctrl_value_new");	
	String fee_value_new  = request.getParameter("fee_value_new");	
%>
	<wtc:service name="zg51_update2" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="scode" retmsg="sret" outnum="2">
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=phoneNo%>"/> 
		<wtc:param value="<%=eff_date0%>"/> 
		<wtc:param value="<%=exp_date0%>"/> 
		<wtc:param value="<%=ctrl_value0%>"/> 
		<wtc:param value="<%=fee_value0%>"/>
		<wtc:param value="<%=remind_instance_id0%>"/>
		<wtc:param value="<%=eff_date%>"/> 
		<wtc:param value="<%=exp_date%>"/> 
		<wtc:param value="<%=ctrl_value%>"/> 
		<wtc:param value="<%=fee_value%>"/>
		<wtc:param value="<%=remind_instance_id%>"/>
		<wtc:param value="<%=changeType%>"/>
		<wtc:param value="<%=ctrl_value_new%>"/> 
		<wtc:param value="<%=fee_value_new%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" /> 
<%
	if((!scode.equals("0"))&& (!scode.equals("000000"))){
%>

		<script language="JavaScript">
			rdShowMessageDialog("修改配置失败！错误代码"+"<%=scode%>"+",错误原因:"+"<%=sret%>");
			//window.location="zg51_1.jsp";
			history.go(-1);
		</script>
			
<%
	}else{
%>   
		<script language="javascript">
				rdShowMessageDialog("修改配置成功");
				window.location="zg51_1.jsp";
		</script>
<%}	
	
	
}
%>
 


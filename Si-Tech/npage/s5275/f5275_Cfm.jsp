   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-17
********************/
%>
              
<%
  String opCode = "5275";
  String opName = "其他参数配置";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>
<%
  String myretFlag="",myretMsg="";//用于判断页面刚进入时的正确性
//读取session信息
	String loginNo = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	
	String region_code = request.getParameter("sales_region");
	String min_pay = request.getParameter("min_pay");
	String max_pay = request.getParameter("max_pay");
	String allow_abackfee = request.getParameter("allow_abackfee");
	String allow_abackhours = request.getParameter("allow_abackhours");
	String allow_abackdays = request.getParameter("allow_abackdays");
	String retMsg = null;
	

	/****************调用  sDemoGetMsg  ***********************/
   
	String[] paraStrIn = new String[8];
	paraStrIn[0] = loginNo;                 //工号
	paraStrIn[1] = nopass;                  //工号密码
	paraStrIn[2] = region_code;             //地市代码
	paraStrIn[3] = min_pay;					//单次充值最小金额
	paraStrIn[4] = max_pay;                 //单次充值最大金额
	paraStrIn[5] = allow_abackfee;          //允许自动返销最大金额
	paraStrIn[6] = allow_abackhours;        //允许自动返销最大小时数
	paraStrIn[7] = allow_abackdays;         //允许人工返销最大天数

	String srvName = "s5275Cfm"; //服务名1
	String outParaNums = "0"; //输出参数个数

	//impl.callFXService(srvName, paraStrIn,outParaNums,"region",regionCode);
%>

    <wtc:service name="s5275Cfm" outnum="4" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraStrIn[0]%>" />
			<wtc:param value="<%=paraStrIn[1]%>" />
			<wtc:param value="<%=paraStrIn[2]%>" />
			<wtc:param value="<%=paraStrIn[3]%>" />
			<wtc:param value="<%=paraStrIn[4]%>" />
			<wtc:param value="<%=paraStrIn[5]%>" />
			<wtc:param value="<%=paraStrIn[6]%>" />
			<wtc:param value="<%=paraStrIn[7]%>" />							
		</wtc:service>

<% 
	String returnCode = code; //错误代码
	String returnMsg = msg; //错误信息
System.out.println("-------------returnCode-------------"+returnCode);
System.out.println("-------------returnMsg-------------"+returnMsg);
	if(returnCode.equals("000000")){
		retMsg = "其他配置设置成功";
		
%>
<script language="JavaScript">
	 rdShowMessageDialog("<%=retMsg%>",2);
    history.go(-1);
</script>

<%		
	}else{
		retMsg = returnMsg;
%>
		<script language="JavaScript">
    rdShowMessageDialog("<%=retMsg%>",0);
    history.go(-1);
</script>

<%		
	}
	
%>

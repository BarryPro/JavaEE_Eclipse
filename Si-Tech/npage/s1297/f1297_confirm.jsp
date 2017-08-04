 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-07 页面改造,修改样式
	********************/
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");	//header.jsp需要的参数  	
	String printAccept =request.getParameter("printAccept");//取得流水号
	System.out.println("**************************************"+printAccept);
	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	
	String sqlStr = "";
	String colNum="4";
	//读取session信息
	String work_no=(String)session.getAttribute("workNo");    //工号 	
	String pass = (String)session.getAttribute("password");
	String paraAray[] = new String[24];
    	String phoneNo = request.getParameter("phoneNo");//服务号码
                                                     //操作代码
                                                     //工号
                                                     //工号密码
    	String bp_name = request.getParameter("bp_name");//机主姓名
    	String eng_chi = request.getParameter("eng_chi");//中英文
    	String bp_title = request.getParameter("bp_title");//称谓
    	String bp_flag = request.getParameter("bp_flag");//bp类型
    	String add_no = request.getParameter("add_no");//附加号码
    	String hand_fee = request.getParameter("hand_fee");//实收手续费
    	String should_hand_fee = request.getParameter("should_hand_fee");//应收手续费
    	String choice_fee = request.getParameter("choice_fee");//实收选号费
    	String should_choice_fee = request.getParameter("should_choice_fee");//应收选号费
    	String begin_time = request.getParameter("begin_time");//开始时间
    	String system_time_flag = request.getParameter("system_time_flag");//当天使用标识
	    String opNote = request.getParameter("opNote");//操作备注
    	String function_code = request.getParameter("function_code_value");//特服代码
    	String favour_month = request.getParameter("favour_month");//优惠月数
    	String function_type = request.getParameter("function_type");//特服类型
    	String fic_no = request.getParameter("fic_no");//虚拟号码
    	String ask_type = request.getParameter("ask_type");//申请类型

    	paraAray[0] = phoneNo ;//服务号码
    	paraAray[1] = "1297";//操作代码
    	paraAray[2] = work_no;//工号
   		paraAray[3] = pass; //工号密码
    	paraAray[4] = bp_name ;//机主姓名
    	paraAray[5] = eng_chi ;//中英文
    	paraAray[6] = bp_title;//称谓
    	paraAray[7] = bp_flag;//bp类型
    	paraAray[8] = add_no;//附加号码
    	paraAray[9] = hand_fee ;//实收手续费
    	paraAray[10] = should_hand_fee ;//应收手续费
    	paraAray[11] = choice_fee ;//实收选号费
    	paraAray[12] = should_choice_fee ;//应收选号费
    	paraAray[13] =  begin_time ;//开始时间
    	paraAray[14] =  system_time_flag ;//当天使用标识
		paraAray[15] =  opNote ;//操作备注
    	paraAray[16] =  function_code ;//特服代码
    	paraAray[17] =  favour_month ;//优惠月数
    	paraAray[18] =  function_type ;//特服类型
    	paraAray[19] =  fic_no  ;//虚拟号码
    	paraAray[20] =  ask_type ;//申请类型
    	//String[] ret = impl.callService("s1297_Apply",paraAray,"2","phone",phoneNo);
	%>
		<wtc:service name="s1297_Apply" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
			
			<wtc:param value="<%=printAccept%>"/>
			<wtc:param value="01"/>		
			<wtc:param value="<%=paraAray[1]%>"/>
			<wtc:param value="<%=paraAray[2]%>"/>
			<wtc:param value="<%=paraAray[3]%>"/>
			<wtc:param value="<%=paraAray[0]%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=paraAray[4]%>"/>	
			<wtc:param value="<%=paraAray[5]%>"/>	
			<wtc:param value="<%=paraAray[6]%>"/>	
			<wtc:param value="<%=paraAray[7]%>"/>	
			<wtc:param value="<%=paraAray[8]%>"/>	
			<wtc:param value="<%=paraAray[9]%>"/>	
			
			<wtc:param value="<%=paraAray[10]%>"/>	
			<wtc:param value="<%=paraAray[11]%>"/>	
			<wtc:param value="<%=paraAray[12]%>"/>	
			<wtc:param value="<%=paraAray[13]%>"/>	
			<wtc:param value="<%=paraAray[14]%>"/>	
			<wtc:param value="<%=paraAray[15]%>"/>	
			<wtc:param value="<%=paraAray[16]%>"/>	
			<wtc:param value="<%=paraAray[17]%>"/>	
			<wtc:param value="<%=paraAray[18]%>"/>	
			<wtc:param value="<%=paraAray[19]%>"/>	
			<wtc:param value="<%=paraAray[20]%>"/>	
			<wtc:param value="<%=printAccept%>"/>
				
		</wtc:service>
		<wtc:array id="result1" scope="end"/>
	<%	
		String errCode="0";
		String errMsg="";
		errCode=retCode1;
		errMsg=retMsg1;				
		
		float fHandFee = Float.parseFloat(hand_fee);
	if ("000000".equals(errCode) )
	{
		if(fHandFee>0)
		{
%>
	<script language="JavaScript">
		   rdShowMessageDialog("12580开户成功! 下面将打印发票！",2);
		   var infoStr="";
		   infoStr+=" "+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+=" "+"|";
		   infoStr+=" "+"|";
		   infoStr+=" "+"|";
		   infoStr+=" "+"|";
		   infoStr+="帐户资料变更。*手续费："+"  "+"*流水号："+"  "+"|";
		   location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/s1297/f1297_login.jsp";
	</script>
<%
		}else
		{
%>
			<script language="JavaScript">
			   rdShowMessageDialog("12580开户成功!",2);
			   history.go(-2);
			</script>
<%
		}
		}else{
%>
		<script language="JavaScript">
			rdShowMessageDialog("12580开户失败!<br>errCode: <%=errCode%><br>errMsg: <%=errMsg%>",0);
			history.go(-1);
		</script>
<%}%>
 <%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+printAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />       

 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>



<%	
	
	String opCode = "1445";
	String opName = "全球通签约计划";
	String op_code = "1445";
	
	String loginAccept = request.getParameter("loginAccept");
	String phoneno = request.getParameter("phoneno");
	String order_code = request.getParameter("temp0");
	String t_sys_remark = request.getParameter("t_sys_remark");
	String beginTime = request.getParameter("temp12");
	String endTime = request.getParameter("temp13");
	String qianyuemode=request.getParameter("qianyuemode");		
	
	String flag_code1=request.getParameter("flag_code1");	
	String rateCode=request.getParameter("rateCode");
	
	String rateFlag = rateCode +"$"+flag_code1+"$"+"&"; 
	
	System.out.println("wwwwwwwww === "+ rateFlag);
	
	String custName=request.getParameter("custName");				 
	String idNo=request.getParameter("idNo");
	String temp14=request.getParameter("temp14");	 //购机款
	String temp15=request.getParameter("temp15");
	String chinaFee="";

	String note="方案名称：（全球通签约计划） 活动购机，购机款不予退还";
	//ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] result = new String[][]{};
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//S1100View callView = new S1100View();
	ArrayList retArray = new ArrayList();
	//String[][] baseInfo = (String[][])arr.get(0);
	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode= (String)session.getAttribute("regCode");
	  
	String pass = (String)session.getAttribute("password");//读取工号密码
	
	String paraAray[] = new String[10];   
	System.out.println("123123123123123123================"+loginAccept);
	paraAray[0] = loginAccept; //流水
	paraAray[1] = work_no;  //操作工号
	paraAray[2] = op_code;	//功能代码
	paraAray[3] = phoneno;	//用户号码
	paraAray[4] = order_code;//签约方案代码
	paraAray[5] = "0"; //交预存金额
	paraAray[6] = beginTime;
	paraAray[7] = endTime;
	paraAray[8] = rateFlag;
	paraAray[9] = t_sys_remark;	//用户备注
	//String[] ret = impl.callService("s1445Cfm",paraAray,"1","phone",phoneno);
	%>
		<wtc:service name="s1445Cfm" routerKey="phone" routerValue="<%=phoneno%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
			<wtc:param value="<%=paraAray[0]%>"/>
			<wtc:param value="<%=paraAray[1]%>"/>
			<wtc:param value="<%=paraAray[2]%>"/>
			<wtc:param value="<%=paraAray[3]%>"/>
			<wtc:param value="<%=paraAray[4]%>"/>
			<wtc:param value="<%=paraAray[5]%>"/>
			<wtc:param value="<%=paraAray[6]%>"/>
			<wtc:param value="<%=paraAray[7]%>"/>
			<wtc:param value="<%=paraAray[8]%>"/>
			<wtc:param value="<%=paraAray[9]%>"/>
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
	<%
	String retCode= retCode1;
	String retMsg = retMsg1;
	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
	String printInfo="";
	//打印发票
		printInfo="64|5|10|0|"+new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())+"|";
		printInfo += "72|5|10|0|"+new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())+"|";
		printInfo += "77|5|10|0|"+new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())+"|";
		printInfo = printInfo + "16|5|9|0|" + work_no + "|";            //工号
		printInfo = printInfo + "24|5|9|0|" + loginAccept + "|";         //流水
		printInfo = printInfo + "35|5|9|0|" + "全球通签约计划折价销售手机购机款" + "|";         //全球通签约计划折价销售手机购机款

	    printInfo = printInfo + "16|8|10|0|" + custName + "|";         //用户名
		printInfo = printInfo + "16|11|10|0|" + phoneno + "|";         //手机号
		printInfo = printInfo + "50|11|10|0|" + idNo + "|"; 		   //协议号码
		/*if((checkNo.trim()).compareTo("zzz") == 0)
		{   checkNo = "";              }
		printInfo = printInfo + "73|11|10|0|" + checkNo + "|"; 		   //支票号码	   */
		printInfo = printInfo + "65|14|10|0|" + WtcUtil.formatNumber(temp14,2) + "|"; //小写		
		try
        {
            //retArray = callView.view_sToChinaFee(temp14);
            %>            	
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3" retmsg="retMsg3" outnum="3" >
		<wtc:param value="<%=temp14%>"/>		
		</wtc:service>
		<wtc:array id="result3" scope="end"/>
            <%
            	
              result=result3;
            //result = (String[][])retArray.get(0);
            chinaFee = result[0][2];           
        }catch(Exception e){
            
        }				
		printInfo = printInfo + "22|14|10|0|" + chinaFee + "|";                       //大写 		
		printInfo = printInfo + "21|24|9|0|备注：    " + note + "|";      								 //备注
		
	   	String printInfo1 = "";
	
	
	String errMsg = retMsg1;
	//String loginAccept = "";
	if (ret != null &&ret.length>0&&retCode.equals("000000")){
	loginAccept = ret[0][0];
%>
	<script language="JavaScript">
		if("<%=qianyuemode%>"=="M"){
			var h=150;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			var path = "../innet/spubPrint_1104.jsp?DlgMsg=" + "全球通签约计划成功！";
			var path = path + "&printInfo=<%=printInfo%>&printInfo1=<%=printInfo1%>&submitCfm=Single";
			var ret=window.showModalDialog(path,"",prop); 			
			location = "s1445.jsp?opCode=1445&opName=<%=opName%>&activePhone=<%=phoneno%>";
		}
	else{
		rdShowMessageDialog("全球通签约计划成功！",2);
		window.location="s1445.jsp?opCode=1445&opName=<%=opName%>&activePhone=<%=phoneno%>";
	}
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("全球通签约计划失败!(<%=errMsg%>",0);
	history.go(-1);
</script>
<%}
%>

<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneno+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />


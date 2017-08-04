 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    	String regionCode=(String)session.getAttribute("regCode");
    	String work_no  = (String)session.getAttribute("workNo");
    	String work_name = (String)session.getAttribute("workName");/*20090325 liyan add */
    	String orgCode = (String)session.getAttribute("orgCode"); /*20090325 liyan add */

    	String card_no  = request.getParameter("card_str");
    	String card_other = request.getParameter("card_str1");//新卡卡号
    	String money_str1 = request.getParameter("money_str1");//新卡单个面值
    	String[] card_other_arr = card_other.split("\\|");
    	int card_other_num = card_other_arr.length;
    	String cardType_name1 = ""; //卡类型
    	for(int i=0;i<card_other_arr.length;i++){
    		String  inParams [] = new String[2];
				inParams[0] = "select b.res_name from dsimres a,srescode b where a.sim_type=b.res_code and a.sim_no=:simno";
				inParams[1] = "simno="+card_other_arr[i];
			%>
				<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
					<wtc:param value="<%=inParams[0]%>"/>
					<wtc:param value="<%=inParams[1]%>"/> 
				</wtc:service>  
				<wtc:array id="ret"  scope="end"/>
			<%
				if("000000".equals(retCode1)){
					if(ret.length>0){
						cardType_name1 += ret[0][0] + ",";
					}
				}
    	}
    	String org_code = request.getParameter("org_code");
    	String op_code   = request.getParameter("op_code");
    	String hand_fee   = request.getParameter("sum_hand_fee");
    	String sysAccept = request.getParameter("sysAccept");/*20090325 liyan add 操作流水*/

		String total_date = "";
		String newloginaccept = "";

    	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	  int inputNumber = 7; /* 20090325 liyan modify */
	  String  outputNumber = "4";
	  String  inputParsm [] = new String[inputNumber];
	  int outCode = 0;
	  String outMsg = "";

	  inputParsm[0] = card_no;
	  inputParsm[1] = card_other;
	  inputParsm[2] = org_code;
	  inputParsm[3] = work_no;
	  inputParsm[4] = op_code;
	  inputParsm[5] = hand_fee;
	  inputParsm[6] = sysAccept; /*20090325 liyan add 操作流水*/

    	//String [] initBack = impl.callService("s3075Cfm",inputParsm,outputNumber);
  %>
  	<wtc:service name="s3075Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="4" >
		<wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value="<%=inputParsm[1]%>"/>
		<wtc:param value="<%=inputParsm[2]%>"/>
		<wtc:param value="<%=inputParsm[3]%>"/>
		<wtc:param value="<%=inputParsm[4]%>"/>
		<wtc:param value="<%=inputParsm[5]%>"/>
		<wtc:param value="<%=inputParsm[6]%>"/>
	</wtc:service>
	<wtc:array id="initBack" scope="end" />
  <%

	//String retCode = initBack[0];
	//String retMsg = impl.getErrMsg();
	String retCode = retCode2;
	String retMsg = retMsg2;
	if(initBack!=null&&initBack.length>0){
		total_date = initBack[0][2];
		newloginaccept = initBack[0][3];
	}
	String outParaNums= "4";
%>
	<wtc:service  name="sToChinaFee" routerKey="region" routerValue="<%=orgCode%>" outnum="<%=outParaNums%>"  retcode="retCode2" retmsg="retMessage2">
			<wtc:param  value="<%=hand_fee%>"/>
	  </wtc:service>
	  <wtc:array id="chinaFee1"  start="2"  length="1" scope="end"/>
<%
	String chinaFee =chinaFee1[0][0];
	System.out.print(chinaFee);

%>



<SCRIPT type=text/javascript>
	function ifprint(){
	     <%  if (retCode.equals("000000"))
	       {%>
     	var handFee= "<%=hand_fee%>";
		if ( Number(handFee) >0 )
		{
		 	rdShowMessageDialog("坏卡换卡成功! 下面将打印发票！");
		 	var infoStr="";
			infoStr+="<%=work_no%>  <%=sysAccept%>"+"       坏卡换卡"+"|";//工号
	 		infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+=" "+" |";
			infoStr+=" "+" |";
			infoStr+=" "+" |";
			infoStr+=" "+" |";//协议号码
			infoStr+=" "+" |";
			infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
			infoStr+="<%=WtcUtil.formatNumber(hand_fee,2)%>"+"|";//小写

			infoStr+="  坏卡号： "+'<%=card_no%>'+"   新卡卡号："+'<%=card_other%>'+"|";
			infoStr+="<%=work_name%>" +"|";//开票人
			 infoStr+=" "+"|";//收款人
			 /*
		 	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/s3070/s3075.jsp?opCode=<%=op_code%>";
		 	//window.location.href="s3074.jsp";
			*/
		var billArgsObj = new Object();
		$(billArgsObj).attr("10001","<%=work_no%>");
		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
	 	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
	 	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10005","");
		$(billArgsObj).attr("10006","坏卡换卡");
		$(billArgsObj).attr("10008","");
		$(billArgsObj).attr("10015","<%=WtcUtil.formatNumber(hand_fee,2)%>");//小写
		$(billArgsObj).attr("10016","<%=WtcUtil.formatNumber(hand_fee,2)%>");//合计金额(大写) 传小写，公共页转换
		$(billArgsObj).attr("10017","*");//现金
		$(billArgsObj).attr("10020","");//入网费
		$(billArgsObj).attr("10021","<%=WtcUtil.formatNumber(hand_fee,2)%>");//手续费
		$(billArgsObj).attr("10022","");//选号费
		$(billArgsObj).attr("10023","");//押金
		$(billArgsObj).attr("10024","");//SIM卡费
		$(billArgsObj).attr("10025","");//预存金额
		$(billArgsObj).attr("10026","");//机器费
		$(billArgsObj).attr("10027","");//其他费
		$(billArgsObj).attr("10030","<%=sysAccept%>");//业务流水
		$(billArgsObj).attr("10036","<%=op_code%>");
		$(billArgsObj).attr("10031","<%=work_name%>");//开票人
			
			var printInfo = "";
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=下面将打印发票！";
			var path = path + "&infoStr="+printInfo+"&loginAccept=<%=sysAccept%>&opCode=<%=op_code%>&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop); 
			location = "/npage/s3070/s3075.jsp?opCode=<%=op_code%>";

    	 }
    	 else
    	 {
		 	rdShowMessageDialog("坏卡换卡成功！",2)
		 	window.location.href="s3075.jsp";
		 }
	    <%}
	    else{%>
		    rdShowMessageDialog("坏卡换卡失败。<br>错误代码：'<%=retCode%>'。<br>错误信息：'<%=retMsg%>'。",0);
		    history.go(-1);
	    <%}%>
	}
</SCRIPT>
<html>
<body onload="ifprint()">
<form action="s3071Print.jsp" name="frm_print_invoice" method="post">
	<INPUT TYPE="hidden" name="workno" value="<%=work_no%>">
	<INPUT TYPE="hidden" name="print_prepay_fee" value="<%=hand_fee%>">
	<INPUT TYPE="hidden" name="opCode" value="<%=op_code%>">
	<INPUT TYPE="hidden" name="total_date" value="<%=total_date%>">
	<INPUT TYPE="hidden" name="payAccept" value="<%=newloginaccept%>">
	<INPUT TYPE="hidden" name="checkNo" value="">
</form>
</body>
</html>
                                                                                                                                                                                                                                                                                                                                                                                                                                                     
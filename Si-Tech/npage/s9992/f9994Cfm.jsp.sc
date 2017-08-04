<%
    /********************
    * 功  能: 手机支付主账户现金充值 9994
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: dujl
    * update：diling@2011/11/2 手机支付主账户充值冲正功能完善需求
    ********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	
		String work_no =(String)session.getAttribute("workNo");
		String work_name =(String)session.getAttribute("workName");
		String cust_name =(String)request.getParameter("custName");
		String phoneNo =(String)request.getParameter("phoneNo");
		
		String fee =(String)request.getParameter("payEd");

		String orgCode =(String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		String pass = (String)session.getAttribute("password");
		String op_code=request.getParameter("opcode");
		String opName=request.getParameter("opName");
		
		String paraAray[] = new String[7];
					
		paraAray[0] = work_no;
		paraAray[1] = op_code;
		paraAray[2] = request.getParameter("phoneNo");
		paraAray[3] = request.getParameter("payEd");
		paraAray[4] = pass;
		paraAray[5] = orgCode;
		paraAray[6] = request.getParameter("loginAccept");

%>

	<wtc:service name="s9994Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>    
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("调用服务s9994Cfm in f9994_1.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode2" retmsg="retMsg2">
		<wtc:param value="<%=WtcUtil.formatNumber(fee,2)%>"/>
	</wtc:service>
	<wtc:array id="result2" scope="end"/>
<script language="JavaScript">
	var prtFlag=0;
	prtFlag = rdShowConfirmDialogPrint("操作成功！是否打印发票？");
	if (prtFlag != 1){
		rdShowMessageDialog("交易完成!",2);
		window.location="f9994_1.jsp?opCode=<%=op_code%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
	}else{
		var infoStr="";
	/*
	infoStr+="<%=work_no%>  <%=work_name%>"+"       手机支付主账户现金充值"+"|";//工号
	infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	infoStr+='<%=cust_name%>'+"|";
	infoStr+=" "+"|";
	infoStr+='<%=phoneNo%>'+"|";
	infoStr+=" "+"|";//协议号码
	infoStr+=" "+"|";
	
	infoStr+="<%=result2[0][2]%>"+"|";//合计金额(大写)
	infoStr+="<%=WtcUtil.formatNumber(fee,2)%>"+"|";//小写
	infoStr+="充值金额：<%=WtcUtil.formatNumber(fee,2)%>元"+"|";
	
	infoStr+="<%=work_name%>"+"|";//开票人
	infoStr+=" "+"|";//收款人
	infoStr+=" "+"|";//收款人
	
	infoStr+="充值备注：手机支付主账户现金充值。"+"|";

	dirtPate = "/npage/s9992/f9994_1.jsp?activePhone=<%=phoneNo%>&opCode=<%=op_code%>&opName=<%=opName%>";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=<%=op_code%>&loginAccept=<%=paraAray[6]%>&dirtPage="+codeChg(dirtPate);
	*/
	
	var  billArgsObj = new Object();
	$(billArgsObj).attr("10001","<%=work_no%>");
	$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10005","<%=cust_name%>");
	$(billArgsObj).attr("10006","手机支付主账户现金充值");
	$(billArgsObj).attr("10008","<%=phoneNo%>");
	$(billArgsObj).attr("10015","<%=WtcUtil.formatNumber(fee,2)%>");//小写
	$(billArgsObj).attr("10016","<%=WtcUtil.formatNumber(fee,2)%>");//合计金额(大写) 传小写，公共页转换
	$(billArgsObj).attr("10017","*");//本次缴费：现金
	$(billArgsObj).attr("10030","<%=paraAray[6]%>");//业务流水
	$(billArgsObj).attr("10036","<%=op_code%>");
	$(billArgsObj).attr("10031","<%=work_name%>");//开票人
	$(billArgsObj).attr("10071","12");//发票模板
	
	var printInfo = "";
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=确实要进行发票打印吗？";
	var path = path + "&infoStr="+printInfo+"&loginAccept=<%=paraAray[6]%>&opCode=<%=op_code%>&submitCfm=submitCfm";
	var ret = window.showModalDialog(path,billArgsObj,prop); 
	location = "/npage/s9992/f9994_1.jsp?activePhone=<%=phoneNo%>&opCode=<%=op_code%>&opName=<%=opName%>";
	}

</script>
<%
	} else {
		System.out.println("调用服务s9994Cfm in f9994Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>   
		<script language="JavaScript">
		rdShowMessageDialog("<%=errCode%><%=errMsg%>");
		window.location="f9994_1.jsp?opCode=<%=op_code%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
		</script>
<%	
	}
%>


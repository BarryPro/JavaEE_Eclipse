<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String org_code = (String)session.getAttribute("orgCode");
  
  
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
 


  
  
  String acceptss=request.getParameter("acceptss");
  String bands=request.getParameter("bands");
  String usernames=request.getParameter("usernames");
  String usericcidtypes=request.getParameter("usericcidtypes");
  String usericcid=request.getParameter("usericcid");
  String moneys=request.getParameter("moneys");
  String phoneno=request.getParameter("phoneno");
  String kuandainos=request.getParameter("kuandainos");
  String belongcode=request.getParameter("belongcode");
  String id_nos=request.getParameter("id_nos");
  String liushui=request.getParameter("liushui");
  String beizhu=workNo+"对宽带号"+kuandainos+"进行押金退还操作，金额["+moneys+"]";

%>


<wtc:service name="sm355Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
	
	<wtc:param value="<%=acceptss%>"/>
  <wtc:param value="01"/>
  <wtc:param value="m355"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=phoneno%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=id_nos%>"/>
  <wtc:param value="<%=moneys%>"/>
	<wtc:param value="<%=bands%>"/>
	<wtc:param value="<%=beizhu%>"/>
	<wtc:param value="<%=belongcode%>"/>
	<wtc:param value="<%=liushui%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
		
<%

	if("000000".equals(retCode)){
		System.out.println(" ======== sm355Cfm 调用成功 ========");
%>	
    <script language="javascript">
 	      rdShowMessageDialog("押金返还操作成功！",2);
 	     
 	    var shuilv = 0.17;
	  	var kdZdFee = "<%=moneys%>";
	  	var danjia = 0;
	  	var shuie = 0;
	  	var  billArgsObj = new Object();
		if(Number(kdZdFee) != 0){
		
		danjia = Number(kdZdFee) - Number(kdZdFee)*shuilv;
		shuie = Number(kdZdFee)*shuilv;

			$(billArgsObj).attr("10001","<%=workNo%>");     //工号
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005","<%=usernames%>");   //客户名称
			$(billArgsObj).attr("10006","<%=opName%>");    //业务类别
			$(billArgsObj).attr("10008","<%=phoneno%>");    //用户号码
			$(billArgsObj).attr("10015", "-"+kdZdFee+"");   //本次发票金额
			$(billArgsObj).attr("10016", "-"+kdZdFee+"");   //大写金额合计
			$(billArgsObj).attr("10017","*");        //本次缴费：现金
			/*10028 10029 不打印*/
		  $(billArgsObj).attr("10028","");   //参与的营销活动名称：
			$(billArgsObj).attr("10029","");	 //营销代码	
			$(billArgsObj).attr("10030","<%=acceptss%>");   //流水号：--业务流水
			$(billArgsObj).attr("10036","<%=opCode%>");   //操作代码
			$(billArgsObj).attr("10042","台");                   //单位
			$(billArgsObj).attr("10043","1");	                   //数量
			$(billArgsObj).attr("10044",kdZdFee+"");	                //单价
			/*10045不打印*/
			$(billArgsObj).attr("10045","");	       //IMEI
			$(billArgsObj).attr("10072","2");	//冲正
			/*型号不打*/
			$(billArgsObj).attr("10061","");	       //型号
			$(billArgsObj).attr("10062",shuilv+"");	//税率
			$(billArgsObj).attr("10063","-"+shuie+"");	//税额	   
	    $(billArgsObj).attr("10071","6");	//税额	
	 		$(billArgsObj).attr("10076","-"+danjia+"");
	 		$(billArgsObj).attr("10077", kdZdFee+""); //宽带终端金额
 			$(billArgsObj).attr("10078", "<%=bands%>"); //宽带品牌	
 			$(billArgsObj).attr("10074","0"); 
	 		$(billArgsObj).attr("10075","0"); 		
 			$(billArgsObj).attr("10083", "<%=usericcidtypes%>"); //证件类型
 			$(billArgsObj).attr("10084", "<%=usericcid%>"); //证件号码
 			$(billArgsObj).attr("10085", "zsj"); //宽带费用收取方式 只弹出打印收据的框
 			$(billArgsObj).attr("10086", ""); //备注
 			$(billArgsObj).attr("10041", "宽带终端押金费用");           //品名规格 实际是宽带终端类型
 			$(billArgsObj).attr("10065", "<%=kuandainos.trim()%>"); //宽带账号
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "确实要进行发票打印吗？";
			var path = path +"&loginAccept=<%=acceptss%>&opCode=m355&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);
			}
			
			window.location="fm355.jsp?opCode=<%=opCode%>&opName=<%=opName%>";		
		
 	  </script>
<%}else{
	  System.out.println(" ======== sm355Cfm 调用失败 ========");
%>
  	<script language="javascript">
 	    rdShowMessageDialog("押金返还操作失败！错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="fm355.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>

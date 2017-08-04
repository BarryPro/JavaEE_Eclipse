<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:
   * 版本: 1.0
   * 日期: 
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/**	0 iLoginAccept 流水
		1 iChnSource  渠道代码
		2 iOpCode    操作代码
		3 iLoginNo    工号
		4 iLoginPwd   工号密码
		5 iPhoneNo   用户手机号码
		6 iUserPwd   用户手机密码
		7 sOfferId    资费代码
		8 sSchool     学校名称
		9 sClass      班级名称
*/

	/*===========获取参数============*/
	
  String cust_name=WtcUtil.repNull(request.getParameter("cust_name"));
	String loginAccept=WtcUtil.repNull(request.getParameter("loginAccept"));
	String cust_addr=WtcUtil.repNull(request.getParameter("cust_addr"));
	String srv_no=WtcUtil.repNull(request.getParameter("srv_no"));
	String user_id=WtcUtil.repNull(request.getParameter("user_id"));
  String op_type=WtcUtil.repNull(request.getParameter("s_optype"));
	String ic_no=WtcUtil.repNull(request.getParameter("ic_no"));
	
	String opCode = "6236";
	String opName = "呼叫等待激活";
  String regionCode = (String)session.getAttribute("regCode");			
  String iopName = 	(String)request.getParameter("iopName");  
  String workNo = (String)session.getAttribute("workNo");
  String noPass = (String)session.getAttribute("password");
  
  String paraStr[]=new String[12];
 	paraStr[0]=loginAccept;		//流水(可以输入，如果不输入则在服务中取流水)                     
	paraStr[1]=opCode;			//功能代码                                                       
	paraStr[2]=workNo;			//操作工号                                                       
	paraStr[3]=noPass;		//经过加密的工号密码                                                 
  paraStr[4]=regionCode;			//操作工号归属                                               
	paraStr[5]=srv_no;			//用户手机号码                                                   
	paraStr[6]=op_type;		    //操作类型(1_增加, 0_	取消)                                      
	paraStr[7]=WtcUtil.repNull(request.getParameter("ys_fewFee"));			//应收           
  paraStr[8]=WtcUtil.repNull(request.getParameter("t_factFee"));			//实收                
  paraStr[9]=WtcUtil.repNull(request.getParameter("t_sys_remark"));		//系统备注           
	paraStr[10]=WtcUtil.repSpac(request.getParameter("t_op_remark")); 			//用户备注                                  
  paraStr[11]=request.getRemoteAddr();			//IP地址    
           
%>
<wtc:service name="s6236Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=paraStr[0]%>" />
		<wtc:param value="<%=paraStr[1]%>" />
		<wtc:param value="<%=paraStr[2]%>" />
		<wtc:param value="<%=paraStr[3]%>" />
		<wtc:param value="<%=paraStr[4]%>" />
		<wtc:param value="<%=paraStr[5]%>" />
		<wtc:param value="<%=paraStr[6]%>" />
		<wtc:param value="<%=paraStr[7]%>" />
		<wtc:param value="<%=paraStr[8]%>" />
		<wtc:param value="<%=paraStr[9]%>" />
		<wtc:param value="<%=paraStr[10]%>" />
		<wtc:param value="<%=paraStr[11]%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
		
<script language="jscript">
function showPrtDlg(printType,DlgMessage,submitCfm){
	var  billArgsObj = new Object();
	$(billArgsObj).attr("10001","<%=workNo%>");       //工号
	$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10005","<%=cust_name%>"); //客户名称
	$(billArgsObj).attr("10006","<%=opName%>"); //业务类别
	$(billArgsObj).attr("10008","<%=srv_no%>" ); //用户号码
	$(billArgsObj).attr("10015", "<%=paraStr[8]%>"); //本次发票金额(小写)￥
	$(billArgsObj).attr("10016", "<%=paraStr[8]%>"); //大写金额合计
	var sumtypes1="*";
	var sumtypes2="";
	var sumtypes3="";
	
			
	$(billArgsObj).attr("10017",sumtypes1); //本次缴费现金
	$(billArgsObj).attr("10018",sumtypes2); //支票
	$(billArgsObj).attr("10019",sumtypes3); //刷卡
	$(billArgsObj).attr("10020","0"); //入网费
	$(billArgsObj).attr("10021","<%=paraStr[8]%>"); //手续费
	$(billArgsObj).attr("10022",""); //选号费
	$(billArgsObj).attr("10024",""); //SIM卡费
	$(billArgsObj).attr("10025",""); //预存话费
	$(billArgsObj).attr("10026",""); //机器费
	$(billArgsObj).attr("10030", "<%=paraStr[0]%>"); //流水号--业务流水
	$(billArgsObj).attr("10036","<%=opCode%>"); //操作代码
	
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + DlgMessage;
	
			//发票项目修改为新路径
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + DlgMessage;
	
	
	var path = path + "&loginAccept="+"<%=paraStr[0]%>"+"&opCode=<%=opCode%>&submitCfm=submitCfm";
	var ret = window.showModalDialog(path,billArgsObj,prop);
 		 
 }
</script>
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("调用服务 s6236Cfm in s6236_conf.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("用户<%=cust_name%>(<%=srv_no%>)呼叫等待业务办理成功！");
		//showPrtDlg("Bill","确认要补打发票吗？","Yes");
		removeCurrentTab();
	</script>
<%
	}else{
		System.out.println("调用服务 s6236Cfm in s6236_conf.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
		removeCurrentTab();
	</script>
<%
	}		
%>	

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String opCode =  request.getParameter("opCode");
  String opName =  request.getParameter("opName");
  String parentPhone = request.getParameter("parentPhone");
  String operPhoneNo = request.getParameter("operPhoneNo");
  String famChg =  request.getParameter("myJSONText");
  String loginAccept = request.getParameter("printAccept");
  String famlicodes = request.getParameter("famlicodes") == null? " ":request.getParameter("famlicodes");
  
  String innetFeeHidd = request.getParameter("innetFeeHidd") == null? "0":request.getParameter("innetFeeHidd");
  String innetrateHidd = request.getParameter("innetrateHidd") == null? " ":request.getParameter("innetrateHidd");
  String innetRateFeeHidd = request.getParameter("innetRateFeeHidd") == null? " ":request.getParameter("innetRateFeeHidd");
  String innetFeeLeftHidd = request.getParameter("innetFeeLeftHidd") == null? " ":request.getParameter("innetFeeLeftHidd");
  
	//hejwa add 幸福家庭跳转到g794的标志  
	String carFlag = ""; //为了不影响其他类型业务的跳转功能
  String familyCode = request.getParameter("familyCode") == null? "":request.getParameter("familyCode");
  if("XFJT".equals(familyCode)&&"e281".equals(opCode)){
  	//幸福家庭下面的创建家庭
  	carFlag = "carFlag";
  }
  /* 获取发票信息 */
  String custName =  request.getParameter("custName");
  String homeEasyVal =  request.getParameter("homeEasyHide") == null? "0":request.getParameter("homeEasyHide");
  String brandAndResVal =  request.getParameter("brandAndResHide");
  String homeEasyPhoneVal =  request.getParameter("homeEasyPhoneHide");
  String imeiVal =  request.getParameter("imeiHide");
  String prepayFee =  request.getParameter("prepayFeeHide") == null? "0":request.getParameter("prepayFeeHide");
  String baseFeeHidd2 =  request.getParameter("baseFeeHidd2") == null? "0":request.getParameter("baseFeeHidd2");//购机款
  if(prepayFee.length() == 0){
  	prepayFee = "0";
  }
  if(baseFeeHidd2.length() == 0){
  	baseFeeHidd2 = "0";
  }
  double v_totalFee =  Double.parseDouble(prepayFee) + Double.parseDouble(baseFeeHidd2);
  v_totalFee = (double) Math.round(v_totalFee*100)/100;  //四舍五入
  String totalFee =  Double.toString(v_totalFee);
  String v_membRoleId = request.getParameter("v_membRoleId");//宽带成员号码
  System.out.println("##############################fe280Cfm.jsp start [" + famChg + "]");
  System.out.println("########## 发票 #########fe280Cfm.jsp--------- start [" + prepayFee + " , " + baseFeeHidd2 + "="+totalFee);
%>
	<wtc:utype name="sE280Cfm" id="retVal" scope="end"  routerKey="region" routerValue="<%=regionCode%>">
		<wtc:uparam value="<%=famChg%>" type="STRING"/>  
	</wtc:utype>
<%
	String retCode = retVal.getValue(0);
	String retMsg = retVal.getValue(1);
	retMsg = retMsg.replaceAll(System.getProperty("line.separator")," ");
	if("0".equals(retCode) || "000000".equals(retCode)){
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=opName%>提交成功！");
			if("<%=famlicodes%>" == "XFJT" && "<%=opCode%>" == "e281"){
				rdShowMessageDialog("家庭创建成功，请到g794页面办理幸福家庭营销案！");
			}
			if('<%=opCode%>' == 'e285') {
				<% if(famlicodes.equals("QQSY") || famlicodes.equals("QQWY") 
							|| famlicodes.equals("KDJT")
							|| famlicodes.equals("QWJT")  || famlicodes.equals("TXJT") || famlicodes.equals("TSJT") || famlicodes.equals("PYJT")|| famlicodes.equals("RHJT")) {%>
			  <%}else {%>
			  	rdShowMessageDialog("请到缴费界面为客户办理预存15元话费，以便支付宜居通业务使用费用。");
			  	<%}%>		
			}
		</script>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" 
			 outnum="3" retcode="retCode1" retmsg="retMsg1">
			<wtc:param value="<%=WtcUtil.formatNumber(totalFee,2)%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end"/>
<%	
		String chinaFee = result1[0][2];   	//大写金额
		System.out.println("~~~~~~~~~~~~chinaFee " + chinaFee);
%>
		<script language="JavaScript">
			function printBill(){
				rdShowMessageDialog("打印发票");
				var infoStr="";
				
				infoStr+="<%=work_no%>  <%=work_name%>"+"       <%=opName%>"+"|";//工号
				infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
				infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
				infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
				infoStr+='<%=custName%>'+"|";//用户名称
				infoStr+=" "+"|";//卡号
				infoStr+='<%=parentPhone%>'+"|";//移动台号
				infoStr+=" "+"|";//8协议号码
				infoStr+=" "+"|";//9支票号
				infoStr+="<%=chinaFee%>"+"|";//10合计金额(大写)
				infoStr+="<%=WtcUtil.formatNumber(totalFee,2)%>"+"|";//11小写
				if("<%=imeiVal%>".trim() == ""){
					infoStr += "退款合计：<%=WtcUtil.formatNumber(totalFee,2)%>元 " + "|";
				}else{
					infoStr+="备注：办理幸福家庭套餐促销活动赠送宜居通固话机一部（含2套传感器和1个遥控器）。" 
									+"~" + "宜居通固话机品牌型号：<%=brandAndResVal%>"
									+"~" + "宜居通固话号码：<%=homeEasyPhoneVal%>"
									+"~" + "IMEI码：<%=imeiVal%>" + "|";
				}
				infoStr+="<%=custName%>"+"|";//开票人
				infoStr+=" "+"|";//收款人
			//	infoStr+="IMEI码：<%=imeiVal%>"+"|";
				infoStr+=" "+"|";
				
				var dirtPage="/npage/se280/fe280.jsp?activePhone=<%=operPhoneNo%><%=carFlag%>";
				location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&dirtPage="+dirtPage+"&op_code=<%=opCode%>&loginAccept=<%=loginAccept%>";
			}
				function goback(){
			//hejwa add 2014年2月14日8:47:59 跳转到购物车的g794模块 标志  
				location="/npage/se280/fe280.jsp?activePhone=<%=operPhoneNo%><%=carFlag%>";
				
			}
			
		function printBillNEW(){
		rdShowMessageDialog("打印发票！");
	  var printInfo="";
    var  billArgsObj = new Object();
		$(billArgsObj).attr("10001","<%=work_no%>");       //工号
 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10005",""); //客户名称
 		$(billArgsObj).attr("10006","<%=opName%>"); //业务类别
 		//$(billArgsObj).attr("10008","<%=parentPhone%>"); //用户号码
 		$(billArgsObj).attr("10008","<%=v_membRoleId%>"); //用户号码：体现为宽带号码
 		$(billArgsObj).attr("10015", "<%=innetFeeHidd%>"); //本次发票金额(小写)￥
 		$(billArgsObj).attr("10016", "<%=innetFeeHidd%>"); //大写金额合计
 		$(billArgsObj).attr("10036","<%=opCode%>"); //操作代码	
 		$(billArgsObj).attr("10030","<%=loginAccept%>"); //流水号--业务流水
 		$(billArgsObj).attr("10065", ""); //宽带账号
 		$(billArgsObj).attr("10066", "<%=innetFeeHidd%>"); //初装费
 		$(billArgsObj).attr("10067", "0"); //宽带套餐预存款
 		$(billArgsObj).attr("10017","*"); //本次缴费现金
 		$(billArgsObj).attr("10031","<%=work_name%>");//开票人
 		$(billArgsObj).attr("10062","<%=innetrateHidd%>");	//税率
		$(billArgsObj).attr("10063","<%=innetRateFeeHidd%>");	//税额	
		$(billArgsObj).attr("10071","8");//模板号
		$(billArgsObj).attr("10079","1");
		$(billArgsObj).attr("10080", "<%=innetFeeLeftHidd%>"); //去税金额
		
		
    var path ="";
		path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "确实要进行发票打印吗？";

	
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		var path = path + "&infoStr="+printInfo+"&loginAccept=<%=loginAccept%>&opCode=<%=opCode%>&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop); 
	  location="/npage/se280/fe280.jsp?activePhone=<%=operPhoneNo%><%=carFlag%>";

}

			if(("<%=famlicodes%>"=="HEJT" || "<%=famlicodes%>"=="HJTA" || "<%=famlicodes%>"=="HJTB") && ("<%=opCode%>"=="e855" || "<%=opCode%>"=="i088")){//和家庭，产品变更+家庭续签
			    if("<%=innetFeeHidd%>"=="0") {
			    	goback();
			    }else {
			      printBillNEW();
			    }
			    
			}
			var printBillFlag = "<%=homeEasyVal%>";
			if(printBillFlag == "1"){
				printBill();
			}else{
				goback();
			}
		</script>
<%
	}else{
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=opName%>提交失败！" + "<%=retCode%>," + "<%=retMsg%>");
			location="/npage/se280/fe280.jsp?activePhone=<%=operPhoneNo%>";
		</script>

<%
	}
%>

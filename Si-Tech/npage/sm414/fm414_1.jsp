<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2016-10-10 10:45:20------------------
 开发省内魔百和单独办理界面的需求
 
 
 -------------------------后台人员：liyang--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo     = (String)session.getAttribute("workNo");
  String workPwd   = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");
  
	String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%> 
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" /> 
<%	
	String custName = "";
	String pp_name  = "";
	String vIdType  = "";
	String id_iccid = "";
	String vIdTypeName  = "";
	
	/*
          查询客户信息公共服务
  */
   String paraAray[] = new String[9];
   paraAray[0]=loginAccept;
   paraAray[1]="01";
   paraAray[2]=opCode;
   paraAray[3]=workNo;
   paraAray[4]=workPwd;
   paraAray[5]=activePhone;
   paraAray[6]="";
   paraAray[7]="";
   paraAray[8]="通过phoneNo[" + activePhone + "]查询客户信息";
%>


	
<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="40" >
      <wtc:param value="<%=paraAray[0]%>"/>
      <wtc:param value="<%=paraAray[1]%>"/>
      <wtc:param value="<%=paraAray[2]%>"/>
      <wtc:param value="<%=paraAray[3]%>"/>
      <wtc:param value="<%=paraAray[4]%>"/>
      <wtc:param value="<%=paraAray[5]%>"/>
      <wtc:param value="<%=paraAray[6]%>"/>
      <wtc:param value="<%=paraAray[7]%>"/>
      <wtc:param value="<%=paraAray[8]%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>
<wtc:array id="result_t2" scope="end" />

<%

String custBrandName = "";
        if("000000".equals(retCode2)){
                if(result_t2.length>0){
                        custName = result_t2[0][5];
                        pp_name  = result_t2[0][38];
                        vIdType  = result_t2[0][12];
                        id_iccid = result_t2[0][13];
                        
                  if (pp_name.equals("gn")) {
										custBrandName = "全球通";
									} else if (pp_name.equals("zn")) {
										custBrandName = "神州行";
									} else if (pp_name.equals("dn")) {
										custBrandName = "动感地带";
									} 
									
									
									
									if("0".equals(vIdType)) {
										vIdTypeName="身份证";
								  }else if("1".equals(vIdType)) {
								  	vIdTypeName="军官证";
								 	}else if("2".equals(vIdType)) {
								 		vIdTypeName="军官证";
								 	}else if("3".equals(vIdType)) {
								 		vIdTypeName="港澳通行证";
								 	}else if("4".equals(vIdType)) {
								 		vIdTypeName="警官证";
								 	}else if("5".equals(vIdType)) {
								 		vIdTypeName="台湾通行证";
								 	}else if("6".equals(vIdType)) {
								 		vIdTypeName="外国公民护照";
								 	}else if("7".equals(vIdType)) {
								 		vIdTypeName="其它";
								 	}else if("8".equals(vIdType)) {
								 		vIdTypeName="营业执照";
								 	}else if("9".equals(vIdType)) {
								 		vIdTypeName="护照";
								 	}else if("A".equals(vIdType)) {
								 		vIdTypeName="组织机构代码";
								 	}else if("B".equals(vIdType)) {
								 		vIdTypeName="单位法人证书";
								 	}else if("C".equals(vIdType)) {
								 		vIdTypeName="单位证明";
								 	}else if("00".equals(vIdType)) {
								 		vIdTypeName="身份证";
								 	}    
									
									
									
									
                }
        }else{
%>
                <script language="JavaScript">
                        rdShowMessageDialog("该用户不是在网用户或状态不正常！");
                        removeCurrentTab();
                </script>
<%              
        }
%>   	
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" />
<SCRIPT language=JavaScript>



//重置刷新页面
function reSetThis(){
	location=location;	
}



/*-------------------------------------------m414-----------------开始------------------------------*/

var public_opCode = "";
function sm414_check_money(){
	if($("#sm414_SaleType").val()=="1"){
		$("#sm414_deposit").val("200");
		$("#sm414_deposit").attr("readOnly","readOnly");
		$("#sm414_deposit").addClass("InputGrey");
	}else{
		$("#sm414_deposit").val("");
		$("#sm414_deposit").removeAttr("readOnly");
		$("#sm414_deposit").removeClass("InputGrey");
	}
	
}
function sm414_go_getAddr(bt){
		if($(bt).val().trim()=="") return;
		
	  var packet = new AJAXPacket("fm414_GetCfmLoginAddr.jsp","请稍后...");
        packet.data.add("cfm_login",$(bt).val().trim());//
    core.ajax.sendPacket(packet,sm414_do_getAddr);
    packet =null;		
}
function sm414_do_getAddr(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//操作成功
    	var retArray =  packet.data.findValueByName("retArray");
    	if(retArray.length==0){
    		rdShowMessageDialog("输入的宽带账号不正确");
    		$("#sm414_BroadbandAccount").val("");
    		$("#sm414_InstalledAddr").val("");
    	}else{
    		$("#sm414_InstalledAddr").val(retArray[0][0]);
    	}
    }
}



//提交函数
function sm414_go_Cfm(){
 		
		if(!checkElement(document.msgFORM.sm414_imei_no)) return;
		if(!checkElement(document.msgFORM.sm414_deposit)) return;
		if(!checkElement(document.msgFORM.sm414_BroadbandAccount)) return;
		if(!checkElement(document.msgFORM.sm414_InstalledAddr)) return;
		
		
		if(parseInt(document.msgFORM.sm414_deposit.value.trim())<0||parseInt(document.msgFORM.sm414_deposit.value.trim())>200){
			document.msgFORM.sm414_deposit.value = "";
			rdShowMessageDialog("押金在0-200元之间，请重新输入");
			return;
		}
 
		
		var ret = sm414_showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
		
		sm414_show_Bill_Prt();
		
		if(rdShowConfirmDialog("确认要提交信息吗？")!=1) return;
		
		
    var packet = new AJAXPacket("fm414_Cfm.jsp","请稍后...");
        packet.data.add("opCode",public_opCode);//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("iImeiCode",$("#sm414_imei_no").val());//
        packet.data.add("iCfmLogin",$("#sm414_BroadbandAccount").val());//
        packet.data.add("iAddress",$("#sm414_InstalledAddr").val());//
        packet.data.add("iDepositFee",$("#sm414_deposit").val());//
        packet.data.add("loginAccept","<%=loginAccept%>");//
        packet.data.add("sm414Pwd",$("#sm414_pwd2").val());//
        packet.data.add("iOpType",$("#sm414_SaleType").val());//
        
    core.ajax.sendPacket(packet,sm414_do_Cfm);
    packet =null;		
}
function sm414_do_Cfm(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//操作成功
	    rdShowMessageDialog("操作成功",2);
    	reSetThis();
    }
}



function sm414_showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框 
	  var h=180;
	  var w=350;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;		   	   
	  var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
	  var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
	  var sysAccept ="<%=loginAccept%>";             	//流水号
	    var printStr = sm414_printInfo(printType);
	  
		                      //调用printinfo()返回的打印内容
	  var mode_code=null;           							  //资费代码
	  var fav_code=null;                				 		//特服代码
	  var area_code=null;             				 		  //小区代码
	  var opCode=public_opCode ;                   			 	//操作代码
	  var phoneNo="<%=activePhone%>";                  //客户电话
	  
	  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	  path+="&mode_code="+mode_code+
	  	"&fav_code="+fav_code+"&area_code="+area_code+
	  	"&opCode="+public_opCode+"&sysAccept="+sysAccept+
	  	"&phoneNo="+phoneNo+
	  	"&submitCfm="+submitCfm+"&pType="+
	  	pType+"&billType="+billType+ "&printInfo=" + printStr;
	  var ret=window.showModalDialog(path,printStr,prop);
	  return ret;
}				
//打印模板id为：122
function sm414_printInfo(printType){
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";
	  
	  cust_info+="手机号码：   "+"<%=activePhone%>"+"|";
	  cust_info+="客户姓名：   "+"<%=custName%>"+"|";
	  
	  
	  opr_info += "业务类型：互联网电视|";
	  opr_info += "操作流水: "+"<%=loginAccept%>" +"|";
	  opr_info += "操作类型：服务订购|";
	  
		note_info1 += "备注："+"订购业务：魔百和-未来-基础包-10元|";
		
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}


//打印发票

function sm414_show_Bill_Prt(){
	 		
			var  billArgsObj = new Object();
			$(billArgsObj).attr("10001","<%=workNo%>");     //工号
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005","<%=custName%>");   //客户名称
			$(billArgsObj).attr("10006","魔百和");    //业务类别
			
			$(billArgsObj).attr("10008","<%=activePhone%>");    //用户号码
			$(billArgsObj).attr("10015", $("#sm414_deposit").val());   //本次发票金额
			$(billArgsObj).attr("10016", $("#sm414_deposit").val());   //大写金额合计
			$(billArgsObj).attr("10017","*");        //本次缴费：现金
			/*10028 10029 不打印*/
		  $(billArgsObj).attr("10028","");   //参与的营销活动名称：
			$(billArgsObj).attr("10029","");	 //营销代码	
			$(billArgsObj).attr("10030","<%=loginAccept%>");   //流水号：--业务流水
			$(billArgsObj).attr("10036",public_opCode);   //操作代码
			/**/

			
			/*型号不打*/
			$(billArgsObj).attr("10061","");	       //型号
			$(billArgsObj).attr("10062","");	//税率
			$(billArgsObj).attr("10063","");	//税额	   
	    $(billArgsObj).attr("10071","6");	//
	 		$(billArgsObj).attr("10076", $("#sm414_deposit").val());
 			
 			$(billArgsObj).attr("10083", "<%=vIdTypeName%>"); //证件类型
 			$(billArgsObj).attr("10084", "<%=id_iccid%>"); //证件号码
 			$(billArgsObj).attr("10086", "尊敬的客户，如您办理业务退订、取消等中止业务使用的操作时，请携带本收据、有效身份证件、办理业务时所得魔百和终端到移动指定自有营业厅办理押金退还手续。"); //备注
 			$(billArgsObj).attr("10065", $("#sm414_BroadbandAccount").val()); //宽带账号
 			$(billArgsObj).attr("10087", $("#sm414_imei_no").val()); //imei号码
 			 
 			
 			$(billArgsObj).attr("10041", "魔百和");//品名规格
 			
			$(billArgsObj).attr("10042","台");                   //单位
			$(billArgsObj).attr("10043","1");	                   //数量
			$(billArgsObj).attr("10044",$("#sm414_deposit").val());	                //单价
			
			 			
 			$(billArgsObj).attr("10085", "zsj"); //宽带费用收取方式 只弹出打印收据的框
 			$(billArgsObj).attr("10072","1"); //1--正常发票  2--冲正类发票  2--退费类发票

 			$(billArgsObj).attr("10088",public_opCode); //收据模块
 			
 			
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "确实要进行发票打印吗？";
			
						//发票项目修改为新路径
			$(billArgsObj).attr("11213","REC");  //新版发票新增票据标志位，默认空位发票 REC == 只有 打印纸质收据
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "确实要进行发票打印吗？";

			var loginAccept = "<%=loginAccept%>";
			var path = path +"&loginAccept="+loginAccept+"&opCode="+public_opCode+"&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);		
}
function checkPwd(){
	var sm414_pwd1=$("#sm414_pwd1").val();
	var sm414_pwd2=$("#sm414_pwd2").val();
	if(sm414_pwd2!=sm414_pwd1){
		rdShowMessageDialog("两次密码不一致请修改!");
		return false;
	}
}


/*-------------------------------------------m414-----------------结束------------------------------*/




/*-------------------------------------------m415-----------------开始------------------------------*/


function sm415_show_Bill_Prt(){
	var iImeiCode  = "";
	var iOldAccept = "";
	var iOldMoney = "";
	var isaletype = "";
	
	var radioObj = $("#sm415_chg_imei_tab input[type='radio']:checked");
	if(radioObj.html()!=null){
		iImeiCode = radioObj.parent().parent().find("td:eq(1)").text().trim();
		iOldAccept = radioObj.parent().parent().find("td:eq(2)").text().trim();
		iOldMoney = radioObj.parent().parent().find("td:eq(4)").text().trim();
		isaletype = radioObj.parent().parent().find("td:eq(5)").text().trim();
	}
			alert(iImeiCode);
			var  billArgsObj = new Object();
			$(billArgsObj).attr("10001","<%=workNo%>");     //工号
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005","<%=custName%>");   //客户名称
			$(billArgsObj).attr("10006","魔百和");    //业务类别
			$(billArgsObj).attr("10087", iImeiCode); //imei号码
			$(billArgsObj).attr("10008","<%=activePhone%>");    //用户号码
			$(billArgsObj).attr("10015", iOldMoney);   //本次发票金额
			$(billArgsObj).attr("10016", iOldMoney);   //大写金额合计
			$(billArgsObj).attr("10017","*");        //本次缴费：现金
			/*10028 10029 不打印*/
		  	$(billArgsObj).attr("10028","");   //参与的营销活动名称：
			$(billArgsObj).attr("10029","");	 //营销代码	
			$(billArgsObj).attr("10030","<%=loginAccept%>");   //流水号：--业务流水
			$(billArgsObj).attr("10036",public_opCode);   //操作代码
			/**/
			alert("public_opCode=["+public_opCode+"]");
			
			/*型号不打*/
			$(billArgsObj).attr("10061","");	       //型号
			$(billArgsObj).attr("10062","");	//税率
			$(billArgsObj).attr("10063","");	//税额	   
	   		$(billArgsObj).attr("10071","6");	//
	 		$(billArgsObj).attr("10076","");
 			
 			$(billArgsObj).attr("10083", ""); //证件类型
 			$(billArgsObj).attr("10084", ""); //证件号码
 			$(billArgsObj).attr("10086", ""); //备注
 			$(billArgsObj).attr("10065", ""); //宽带账号
 			$(billArgsObj).attr("10087",iImeiCode); //imei号码
 			 

			$(billArgsObj).attr("10041", "魔百和终端费用");           //品名规格
			$(billArgsObj).attr("10042","台");                   //单位
			$(billArgsObj).attr("10043","1");	                   //数量
			$(billArgsObj).attr("10044",iOldMoney);	                //单价
			$(billArgsObj).attr("10046",iOldMoney);	                //合计
			
			 			
 			$(billArgsObj).attr("10085", "zsj"); //宽带费用收取方式 只弹出打印收据的框
 			$(billArgsObj).attr("10072","1"); //1--正常发票  2--冲正类发票  2--退费类发票

 			$(billArgsObj).attr("10088",public_opCode); //收据模块
 			
 			
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "确实要进行发票打印吗？";
			
						//发票项目修改为新路径
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "确实要进行发票打印吗？";

			var loginAccept = "<%=loginAccept%>";
			var path = path +"&loginAccept="+loginAccept+"&opCode="+public_opCode+"&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);		
}

function sm415_go_Cfm(){
	
		var iImeiCode  = "";
		var iOldAccept = "";
		var isaletype = "";
		
		var radioObj = $("#sm415_chg_imei_tab input[type='radio']:checked");
		if(radioObj.html()!=null){
			iImeiCode = radioObj.parent().parent().find("td:eq(1)").text().trim();
			iOldAccept = radioObj.parent().parent().find("td:eq(2)").text().trim();
			isaletype = radioObj.parent().parent().find("td:eq(5)").text().trim();
		}
		
		//alert("iImeiCode=["+iImeiCode+"]"+"\n"+"iOldAccept=["+iOldAccept+"]");
		
		if(iImeiCode==""||iOldAccept==""){
			rdShowMessageDialog("请选择要退订的记录");
			treurn;
		}
		
		var ret = sm415_showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
		//alert(isaletype);
		//alert(isaletype=="1");
		if(isaletype=="1"){
			sm415_show_Bill_Prt();
		}
		
		
		if(rdShowConfirmDialog("确认要提交信息吗？")!=1) return;
		
		
		
				
    var packet = new AJAXPacket("fm415_Cfm.jsp","请稍后...");
        packet.data.add("opCode",public_opCode);//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("iImeiCode",iImeiCode);//
        packet.data.add("iOldAccept",iOldAccept);//
        packet.data.add("loginAccept","<%=loginAccept%>");//
    core.ajax.sendPacket(packet,sm415_do_Cfm);
    packet =null;		
}
function sm415_do_Cfm(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg,0);
	    return;
    }else{//操作成功
	    rdShowMessageDialog("操作成功",2);
    	reSetThis();
    }
}






function sm415_showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框 
	  var h=180;
	  var w=350;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;		   	   
	  var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
	  var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
	  var sysAccept =<%=loginAccept%>;             	//流水号
	  
	  var printStr = "";
	  printStr = sm415_printInfo();
	  
		                      //调用printinfo()返回的打印内容
	  var mode_code=null;           							  //资费代码
	  var fav_code=null;                				 		//特服代码
	  var area_code=null;             				 		  //小区代码
	  var opCode=public_opCode;                   			 	//操作代码
	  var phoneNo="<%=activePhone%>";                  //客户电话
	  
	  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	  path+="&mode_code="+mode_code+
	  	"&fav_code="+fav_code+"&area_code="+area_code+
	  	"&opCode="+public_opCode+"&sysAccept="+sysAccept+
	  	"&phoneNo="+phoneNo+
	  	"&submitCfm="+submitCfm+"&pType="+
	  	pType+"&billType="+billType+ "&printInfo=" + printStr;
	  var ret=window.showModalDialog(path,printStr,prop);
	  return ret;
}				

//打印模板id为：122  
function sm415_printInfo(){
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";
	  
	  cust_info+="手机号码：   "+"<%=activePhone%>"+"|";
	  cust_info+="客户姓名：   "+"<%=custName%>"+"|";
	  
  
	  opr_info += "业务类型：互联网电视" + "|";
	  opr_info += "操作流水: "+"<%=loginAccept%>" +"|";
	  opr_info += "操作类型：服务退订|";
	  
	  note_info1 += "备注："+"退订业务：魔百和-未来-基础包-10元|";
	  
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}


//获取已有的imei列表
function sm415_go_getIMEI_list(){
	  var packet = new AJAXPacket("fm415_getImeiList.jsp","请稍后...");
        packet.data.add("opCode",public_opCode);//
        packet.data.add("phoneNo","<%=activePhone%>");//
    core.ajax.sendPacket(packet,sm415_do_getImeiList);
    packet =null;
}

// 回调
function sm415_do_getImeiList(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
			var retArray = packet.data.findValueByName("retArray");
			//获取数组成功，动态拼接列表
			var trObjdStr = "";
			for(var i=0;i<retArray.length;i++){
						trObjdStr += "<tr>"+
														 "<td><input type='radio' name='imei_chg_dio'   /></td>"+ //
														 "<td>"+retArray[i][0]+"</td>"+ //
														 "<td>"+retArray[i][1]+"</td>"+ //
														 "<td>"+retArray[i][2]+"</td>"+ //
														 "<td>"+retArray[i][3]+"</td>"+//
														 "<td id='saletype' style='display:none'>"+retArray[i][4]+"</td>"+//
												 "</tr>";
			}
			if("m415"==public_opCode){
				$("#sm415_chg_imei_tab tr:gt(0)").remove();
				$("#sm415_chg_imei_tab tr:eq(0)").after(trObjdStr);
			}else{
				$("#sm416_chg_imei_tab tr:gt(0)").remove();
				$("#sm416_chg_imei_tab tr:eq(0)").after(trObjdStr);
			}
			
	}else{
		  rdShowMessageDialog("查询失败，"+code+"："+msg,0);
	}
}


/*-------------------------------------------m415-----------------结束------------------------------*/





/*-------------------------------------------m416-----------------开始------------------------------*/


function sm416_go_Cfm(){
		var iOldImeiCode  = "";
		var iOldAccept    = "";
		
		
		var radioObj = $("#sm416_chg_imei_tab input[type='radio']:checked");
		if(radioObj.html()!=null){
			iOldImeiCode = radioObj.parent().parent().find("td:eq(1)").text().trim();
			iOldAccept = radioObj.parent().parent().find("td:eq(2)").text().trim();
		}
		
		//alert("iImeiCode=["+iImeiCode+"]"+"\n"+"iOldAccept=["+iOldAccept+"]");
		
		if(iOldImeiCode==""||iOldAccept==""){
			rdShowMessageDialog("请选择要变更的记录");
			treurn;
		}
		
		if(!checkElement(document.msgFORM.sm416_imei_no)) return;
		
 
		
		
		var ret = sm416_showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
		
		
		if(rdShowConfirmDialog("确认要提交信息吗？")!=1) return;
    var packet = new AJAXPacket("fm416_Cfm.jsp","请稍后...");
        packet.data.add("opCode",public_opCode);//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("iOldImeiCode",iOldImeiCode);//
        packet.data.add("iImeiCode",$("#sm416_imei_no").val().trim());//
        packet.data.add("iOldAccept",iOldAccept);//
         packet.data.add("loginAccept","<%=loginAccept%>");//
    core.ajax.sendPacket(packet,sm416_do_Cfm);
    packet =null;		
}
function sm416_do_Cfm(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg,0);
	    return;
    }else{//操作成功
	    rdShowMessageDialog("操作成功",2);
    	reSetThis();
    }
}





function sm416_showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框 
	  var h=180;
	  var w=350;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;		   	   
	  var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
	  var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
	  var sysAccept =<%=loginAccept%>;             	//流水号
	  
	  var printStr = sm416_printInfo(printType);
	  
		                      //调用printinfo()返回的打印内容
	  var mode_code=null;           							  //资费代码
	  var fav_code=null;                				 		//特服代码
	  var area_code=null;             				 		  //小区代码
	  var opCode=public_opCode;                   			 	//操作代码
	  var phoneNo="<%=activePhone%>";                  //客户电话
	  
	  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	  path+="&mode_code="+mode_code+
	  	"&fav_code="+fav_code+"&area_code="+area_code+
	  	"&opCode="+public_opCode+"&sysAccept="+sysAccept+
	  	"&phoneNo="+phoneNo+
	  	"&submitCfm="+submitCfm+"&pType="+
	  	pType+"&billType="+billType+ "&printInfo=" + printStr;
	  var ret=window.showModalDialog(path,printStr,prop);
	  return ret;
}				

//打印模板id为：122 更改imei
function sm416_printInfo(printType){
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";

		var iOldImeiCode  = "";
		var iOldAccept    = "";
		
		
		var radioObj = $("#sm416_chg_imei_tab input[type='radio']:checked");
		if(radioObj.html()!=null){
			iOldImeiCode = radioObj.parent().parent().find("td:eq(1)").text().trim();
			iOldAccept = radioObj.parent().parent().find("td:eq(2)").text().trim();
		}
		
			  
	  cust_info+="手机号码：   "+"<%=activePhone%>"+"|";
	  cust_info+="客户姓名：   "+"<%=custName%>"+"|";
	  
  
	  opr_info += "办理业务：互联网电视终端变更" + "|";
	  opr_info += "操作流水: "+"<%=loginAccept%>" +"    原IMEI：" +iOldImeiCode+"    终端IMEI："+$("#sm416_imei_no").val().trim()+"|";
	  
	  
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}


/*-------------------------------------------m416-----------------结束------------------------------*/

/*-------------------------------------------m441-----------------开始------------------------------liangyl 2016-12-08 省内魔百和平台点播功能和支付功能开发需求*/

//订购增值包
function sm441_go_order_valueAdded(obj,imei){
	var ret = sm441_showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	if(rdShowConfirmDialog("确认要提交信息吗？")!=1) return;
	var myPacket = new AJAXPacket("fm441_ordervalueAdded.jsp","请稍后...");
	var iLoginAccept = "<%=sysAcceptl%>";
	var iChnSource = "01";
	var iOpCode = "<%=opCode%>";
	var iWorkNo = "<%=workNo%>";
	var iWorkPwd = "<%=workPwd%>";
	var iPhoneNo ="<%=activePhone%>";
	var iUserPwd = "";
	myPacket.data.add("iLoginAccept",iLoginAccept);
	myPacket.data.add("iChnSource",iChnSource);
	myPacket.data.add("iOpCode",iOpCode);
	myPacket.data.add("iWorkNo",iWorkNo);
	myPacket.data.add("iWorkPwd",iWorkPwd);
	myPacket.data.add("iPhoneNo",iPhoneNo);
	myPacket.data.add("iUserPwd",iUserPwd);
			
	myPacket.data.add("sm441_imei",imei);
	myPacket.data.add("sm441_valueadded",$(obj).parent().parent().find("#valueAdded").val());
	core.ajax.sendPacket(myPacket,sm441_do_order_valueAdded);
	myPacket=null;
}

// 回调
function sm441_do_order_valueAdded(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){
		rdShowMessageDialog("订购增值包成功！");
		location=location;
	}else{
		rdShowMessageDialog("订购增值包失败，"+code+"："+msg,0);
	}
}

function sm441_showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框 
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;		   	   
	var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=loginAccept%>;             	//流水号
	
	var printStr = sm441_printInfo(printType);//调用printinfo()返回的打印内容
	var mode_code=null;           							  //资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		  //小区代码
	var opCode=public_opCode;                   			 	//操作代码
	var phoneNo="<%=activePhone%>";                  //客户电话
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	path+="&mode_code="+mode_code+
		"&fav_code="+fav_code+"&area_code="+area_code+
		"&opCode="+public_opCode+"&sysAccept="+sysAccept+
		"&phoneNo="+phoneNo+
		"&submitCfm="+submitCfm+"&pType="+
		pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}				

//打印模板id为：122 更改imei
function sm441_printInfo(printType){
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	var retInfo = "";
	var iOldImeiCode  = "";
	var iOldAccept    = "";
	var radioObj = $("#sm441_chg_imei_tab input[type='radio']:checked");
	if(radioObj.html()!=null){
		iOldImeiCode = radioObj.parent().parent().find("td:eq(1)").text().trim();
		iOldAccept = radioObj.parent().parent().find("td:eq(2)").text().trim();
	}
	cust_info+="手机号码：   "+"<%=activePhone%>"+"|";
	cust_info+="客户姓名：   "+"<%=custName%>"+"|";
	
	opr_info += "业务类型：互联网电视增值包" + "|";
	opr_info += "操作流水： <%=loginAccept%>" + "|";
	opr_info += "操作类型：服务订购" + "|";
	
	note_info1+="备注：增值包 |";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}

//获取已有的imei列表
function sm441_go_getIMEI_list(){
	sm441_go_getvalueAdded_list();
	var packet = new AJAXPacket("fm441_getImeiList.jsp","请稍后...");
	packet.data.add("opCode",public_opCode);//
    packet.data.add("phoneNo","<%=activePhone%>");//
    core.ajax.sendPacket(packet,sm441_do_getImeiList);
    packet =null;
}
var valueAddedList = "";
// 回调
function sm441_do_getImeiList(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
		var retArray = packet.data.findValueByName("retArray");
		//获取数组成功，动态拼接列表
		var trObjdStr = "";
		for(var i=0;i<retArray.length;i++){
			trObjdStr += "<tr align='center'>"+
				"<td>"+retArray[i][0]+"</td>"+
				"<td><select id='valueAdded'>"+valueAddedList+"</select></td>"+
				"<td><input type='button' class='b_foot' value='订购' onclick='sm441_go_order_valueAdded(this,"+retArray[i][0]+")'></td>"+
			"</tr>";
		}
		if("m441"==public_opCode){
			$("#sm441_chg_imei_tab tr:gt(0)").remove();
			$("#sm441_chg_imei_tab tr:eq(0)").after(trObjdStr);
		}
	}else{
		  rdShowMessageDialog("查询失败，"+code+"："+msg,0);
	}
}

//获取增值业务列表
function sm441_go_getvalueAdded_list(){
	valueAddedList="";
	var packet = new AJAXPacket("fm441_getvalueaddedList.jsp","请稍后...");
	//packet.data.add("opCode",public_opCode);
	packet.data.add("phoneNo","<%=activePhone%>");
    core.ajax.sendPacket(packet,sm441_do_getvalueAdded_list);
    packet =null;
}

// 回调
function sm441_do_getvalueAdded_list(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
		var retArray = packet.data.findValueByName("retArray");
		//获取数组成功，动态拼接列表
		for(var i=0;i<retArray.length;i++){
			valueAddedList += "<option value='"+retArray[i][0]+"'>"+retArray[i][1]+"</option>";
		}
	}else{
		  rdShowMessageDialog("查询失败，"+code+"："+msg,0);
	}
}
/*-------------------------------------------m441-----------------结束------------------------------liangyl 2016-12-08 省内魔百和平台点播功能和支付功能开发需求*/

/*-------------------------------------------m439-----------------开始------------------------------liangyl 2016-12-08 省内魔百和平台点播功能和支付功能开发需求*/

//订购增值包
function sm439_go_unSubscribe(imei,valueadded,example){
	var ret = sm439_showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	if(rdShowConfirmDialog("确认要提交信息吗？")!=1) return;
	var myPacket = new AJAXPacket("fm439_unSubscribe.jsp","请稍后...");
	var iLoginAccept = "<%=sysAcceptl%>";
	var iChnSource = "01";
	var iOpCode = "<%=opCode%>";
	var iWorkNo = "<%=workNo%>";
	var iWorkPwd = "<%=workPwd%>";
	var iPhoneNo ="<%=activePhone%>";
	var iUserPwd = "";
	myPacket.data.add("iLoginAccept",iLoginAccept);
	myPacket.data.add("iChnSource",iChnSource);
	myPacket.data.add("iOpCode",iOpCode);
	myPacket.data.add("iWorkNo",iWorkNo);
	myPacket.data.add("iWorkPwd",iWorkPwd);
	myPacket.data.add("iPhoneNo",iPhoneNo);
	myPacket.data.add("iUserPwd",iUserPwd);
			
	myPacket.data.add("sm439_imei",imei);
	myPacket.data.add("sm439_valueAdded",valueadded);
	myPacket.data.add("sm439_example",example);
	core.ajax.sendPacket(myPacket,sm439_do_unSubscribe);
	myPacket=null;
}

// 回调
function sm439_do_unSubscribe(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){
		rdShowMessageDialog("退订增值包成功！");
		location=location;
	}else{
		rdShowMessageDialog("退订增值包失败，"+code+"："+msg,0);
	}
}

function sm439_showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框 
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;		   	   
	var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=loginAccept%>;             	//流水号
	
	var printStr = sm439_printInfo(printType);//调用printinfo()返回的打印内容
	var mode_code=null;           							  //资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		  //小区代码
	var opCode=public_opCode;                   			 	//操作代码
	var phoneNo="<%=activePhone%>";                  //客户电话
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	path+="&mode_code="+mode_code+
		"&fav_code="+fav_code+"&area_code="+area_code+
		"&opCode="+public_opCode+"&sysAccept="+sysAccept+
		"&phoneNo="+phoneNo+
		"&submitCfm="+submitCfm+"&pType="+
		pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}				

//打印模板id为：122 更改imei
function sm439_printInfo(printType){
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	var retInfo = "";
	var iOldImeiCode  = "";
	var iOldAccept    = "";
	var radioObj = $("#sm439_chg_imei_tab input[type='radio']:checked");
	if(radioObj.html()!=null){
		iOldImeiCode = radioObj.parent().parent().find("td:eq(1)").text().trim();
		iOldAccept = radioObj.parent().parent().find("td:eq(2)").text().trim();
	}
	cust_info+="手机号码：   "+"<%=activePhone%>"+"|";
	cust_info+="客户姓名：   "+"<%=custName%>"+"|";
	
	opr_info += "业务类型：互联网电视增值包" + "|";
	opr_info += "操作流水： <%=loginAccept%>" + "|";
	opr_info += "操作类型：服务退订" + "|";
	
	note_info1+="备注：增值包 |";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}

//获取已有的imei列表
function sm439_go_getIMEI_list(){
	var packet = new AJAXPacket("fm439_getImeiList.jsp","请稍后...");
	packet.data.add("opCode",public_opCode);//
    packet.data.add("phoneNo","<%=activePhone%>");//
    core.ajax.sendPacket(packet,sm439_do_getImeiList);
    packet =null;
}
// 回调
function sm439_do_getImeiList(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
		var retArray = packet.data.findValueByName("retArray");
		//获取数组成功，动态拼接列表
		var trObjdStr = "";
		for(var i=0;i<retArray.length;i++){
			trObjdStr += "<tr align='center'>"+
				"<td>"+retArray[i][0]+"</td>"+
				"<td>"+retArray[i][3]+"</td>"+
				"<td><input type='button' class='b_foot' value='退订' onclick='sm439_go_unSubscribe("+retArray[i][0]+","+retArray[i][2]+","+retArray[i][1]+")'></td>"+
			"</tr>";
		}
		if("m439"==public_opCode){
			$("#sm439_chg_imei_tab tr:gt(0)").remove();
			$("#sm439_chg_imei_tab tr:eq(0)").after(trObjdStr);
		}
	}else{
		  rdShowMessageDialog("查询失败，"+code+"："+msg,0);
	}
}
/*-------------------------------------------m439-----------------结束------------------------------liangyl 2016-12-08 省内魔百和平台点播功能和支付功能开发需求*/

/*-------------------------------------------m440-----------------开始------------------------------liangyl 2016-12-08 省内魔百和平台点播功能和支付功能开发需求*/
//订购增值包
function sm440_go_updatePwd(obj,imei){
	
	var newPwd1 = $(obj).parent().parent().find("#newPwd1").val();
	var newPwd2 = $(obj).parent().parent().find("#newPwd2").val();
	if(newPwd1.length<6){
		rdShowMessageDialog("新魔百合密码不能小于6位！",0);
		return false;
	}
	if(newPwd2.length<6){
		rdShowMessageDialog("新魔百合密码校验不能小于6位！",0);
		return false;
	}
	
	if(newPwd2/1>0){
	}
	else{
		rdShowMessageDialog("新魔百合密码为纯数字!");
		return;
	}
	
	if(newPwd1!=newPwd2){
		rdShowMessageDialog("两次密码不一致请修改！",0);
		return false;
	}
	
	var ret = sm440_showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	if(rdShowConfirmDialog("确认要提交信息吗？")!=1) return;
	var myPacket = new AJAXPacket("fm440_updatePwd.jsp","请稍后...");
	var iLoginAccept = "<%=sysAcceptl%>";
	var iChnSource = "01";
	var iOpCode = "<%=opCode%>";
	var iWorkNo = "<%=workNo%>";
	var iWorkPwd = "<%=workPwd%>";
	var iPhoneNo ="<%=activePhone%>";
	var iUserPwd = "";
	myPacket.data.add("iLoginAccept",iLoginAccept);
	myPacket.data.add("iChnSource",iChnSource);
	myPacket.data.add("iOpCode",iOpCode);
	myPacket.data.add("iWorkNo",iWorkNo);
	myPacket.data.add("iWorkPwd",iWorkPwd);
	myPacket.data.add("iPhoneNo",iPhoneNo);
	myPacket.data.add("iUserPwd",iUserPwd);
	myPacket.data.add("sm440_imei",imei);
	myPacket.data.add("sm440_pwd",newPwd2);
	core.ajax.sendPacket(myPacket,sm440_do_updatePwd);
	myPacket=null;
}

// 回调
function sm440_do_updatePwd(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){
		rdShowMessageDialog("魔百盒密码重置成功！");
		location=location;
	}else{
		rdShowMessageDialog("魔百盒密码重置失败，"+code+"："+msg,0);
	}
}

function sm440_showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框 
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;		   	   
	var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=loginAccept%>;             	//流水号
	
	var printStr = sm440_printInfo(printType);//调用printinfo()返回的打印内容
	var mode_code=null;           							  //资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		  //小区代码
	var opCode=public_opCode;                   			 	//操作代码
	var phoneNo="<%=activePhone%>";                  //客户电话
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	path+="&mode_code="+mode_code+
		"&fav_code="+fav_code+"&area_code="+area_code+
		"&opCode="+public_opCode+"&sysAccept="+sysAccept+
		"&phoneNo="+phoneNo+
		"&submitCfm="+submitCfm+"&pType="+
		pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}				

//打印模板id为：122 更改imei
function sm440_printInfo(printType){
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	var retInfo = "";
	var iOldImeiCode  = "";
	var iOldAccept    = "";
	var radioObj = $("#sm440_chg_imei_tab input[type='radio']:checked");
	if(radioObj.html()!=null){
		iOldImeiCode = radioObj.parent().parent().find("td:eq(1)").text().trim();
		iOldAccept = radioObj.parent().parent().find("td:eq(2)").text().trim();
	}
	cust_info+="手机号码：   "+"<%=activePhone%>"+"|";
	cust_info+="客户姓名：   "+"<%=custName%>"+"|";
	
	opr_info += "业务类型：互联网电视增值包" + "|";
	opr_info += "操作流水： <%=loginAccept%>" + "|";
	opr_info += "操作类型：密码修改" + "|";
	
	note_info1+="备注：增值包 |";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}

//获取已有的imei列表
function sm440_go_getIMEI_list(){
	var packet = new AJAXPacket("fm440_getImeiList.jsp","请稍后...");
	packet.data.add("opCode",public_opCode);//
    packet.data.add("phoneNo","<%=activePhone%>");//
    core.ajax.sendPacket(packet,sm440_do_getImeiList);
    packet =null;
}
// 回调
function sm440_do_getImeiList(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
		var retArray = packet.data.findValueByName("retArray");
		//获取数组成功，动态拼接列表
		var trObjdStr = "";
		for(var i=0;i<retArray.length;i++){
			trObjdStr += "<tr align='center'>"+
				"<td>"+retArray[i][0]+"</td>"+
				"<td><input type='password' id='newPwd1' name='newPwd1' maxlength='6'></td>"+
				"<td><input type='password' id='newPwd2' name='newPwd2' maxlength='6'></td>"+
				"<td><input type='button' class='b_foot' value='修改' onclick='sm440_go_updatePwd(this,"+retArray[i][0]+")'></td>"+
			"</tr>";
		}
		if("m440"==public_opCode){
			$("#sm440_chg_imei_tab tr:gt(0)").remove();
			$("#sm440_chg_imei_tab tr:eq(0)").after(trObjdStr);
		}
	}else{
		  rdShowMessageDialog("查询失败，"+code+"："+msg,0);
	}
}
/*-------------------------------------------m440-----------------结束------------------------------liangyl 2016-12-08 省内魔百和平台点播功能和支付功能开发需求*/

$(document).ready(function(){
	$("#radio_<%=opCode%>").click();
	if("m415"=="<%=opCode%>"||"m416"=="<%=opCode%>"){
		sm415_go_getIMEI_list();
	}
});

function pub_set_radio(bt,check_opCode){
	$(bt).prev().click();
	public_opCode = check_opCode;
}
function show_p_div(bt,check_opCode){
	$("div[id^=div_show_]").hide();
	$("#div_show_"+$(bt).val()).show();
	public_opCode = check_opCode;
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>

<!----------------------------------------------公共部分-----------------开始----------------------------->
<table cellSpacing="0">
	<tr>
		<td class="blue" align="center">
			<input type="radio"   value="m414" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'m414')" />
			<span style="cursor:hand" id="radio_m414" onclick="pub_set_radio(this,'m414')">m414·魔百合订购</span>
			&nbsp;&nbsp;
			<input type="radio"   value="m415" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'m415'),sm415_go_getIMEI_list();" />
			<span style="cursor:hand" id="radio_m415" onclick="pub_set_radio(this,'m415')">m415·魔百合退订</span>
			&nbsp;&nbsp;
			<input type="radio"  value="m416" name="radio_check" style="cursor:hand"  onclick="show_p_div(this,'m416'),sm415_go_getIMEI_list();" />
			<span style="cursor:hand" id="radio_m416" onclick="pub_set_radio(this,'m416')">m416·魔百和IMEI变更</span>
			&nbsp;&nbsp;
			<input type="radio"  value="m441" name="radio_check" style="cursor:hand"  onclick="show_p_div(this,'m441');sm441_go_getIMEI_list();" />
			<span style="cursor:hand" id="radio_m441" onclick="pub_set_radio(this,'m441')">m441·魔百合增值包订购</span>
			&nbsp;&nbsp;
			<input type="radio"  value="m439" name="radio_check" style="cursor:hand"  onclick="show_p_div(this,'m439'),sm439_go_getIMEI_list()" />
			<span style="cursor:hand" id="radio_m439" onclick="pub_set_radio(this,'m439')">m439·魔百合增值包退订</span>
			&nbsp;&nbsp;
			<input type="radio"  value="m440" name="radio_check" style="cursor:hand"  onclick="show_p_div(this,'m440'),sm440_go_getIMEI_list()" />
			<span style="cursor:hand" id="radio_m440" onclick="pub_set_radio(this,'m440')">m440·魔百合密码重置</span>
		</td>
	</tr>
</table>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">手机号码</td>
		  <td width="35%">
			    <%=activePhone%>
		  </td>
		  <td class="blue" width="15%">客户姓名</td>
		  <td width="35%">
			    <%=custName%>
		  </td>
	</tr>
</table>


<!----------------------------------------------公共部分-----------------结束----------------------------->


<!----------------------------------------------m414-----------------开始----------------------------->
<div id="div_show_m414"> 
	
	
<table cellSpacing="0">
	<tr>
		  <td class="blue" width="15%">互联网电视</td>
		  <td width="35%">
			    <select id="sm414_InternetTV"  >
			    	<option value="未来电视">未来电视</option>
			    </select>
		  </td>
		  <td class="blue" width="15%">IMEI码</td>
		  <td>
			    <input type="text"  value=""  v_minlength="15" v_maxlength="15"  name="sm414_imei_no" id="sm414_imei_no" v_must="1" v_type="0_9"   onblur="checkElement(this)" maxlength="15" />
		  </td>
	</tr>
	<tr>
		  <td class="blue" width="15%">销售模式</td>
		  <td width="35%">
			    <select id="sm414_SaleType" onchange="sm414_check_money()" >
			    	<option value="0" selected = "selected">押金</option>
			    	<option value="1">销售</option>
			    </select>
		  </td>
		  
			<td class="blue" width="15%">押金</td>
		  <td>
			    <input type="text"  value="" name="sm414_deposit" id="sm414_deposit" v_must="1" v_type="money"   onblur="checkElement(this)" maxlength="32" />
			    <font class="orange">0-200元</font>
		  </td>
		
		 
		  
	</tr>
	<tr style="display:none">
		  <td class="blue" width="15%">魔百合密码</td>
		  <td width="35%">
			    <input type="password"  value="0" name="sm414_pwd1" id="sm414_pwd1" v_must="1" v_minlength="6" v_maxlength="6" onblur="checkElement(this)" maxlength="6" />
		  </td>
		  <td class="blue" width="15%">确认密码</td>
		  <td>
			    <input type="password"  value="0" name="sm414_pwd2" id="sm414_pwd2" v_must="1" v_minlength="6" v_maxlength="6" onblur="checkElement(this);checkPwd();" maxlength="6" />
		  </td>
	</tr>
 
	<tr>
		  <td class="blue" width="15%">宽带账号</td>
		  <td width="35%"colspan="3" >
			   <input type="text"  value="" name="sm414_BroadbandAccount" id="sm414_BroadbandAccount" v_must="1" v_type="string"   onblur="checkElement(this),sm414_go_getAddr(this)" maxlength="20" />
		  </td>
	</tr>	  
	<tr>
		  <td class="blue" width="15%">装机地址</td>
		  <td width="35%"colspan="3" >
			    <input type="text"  value="" name="sm414_InstalledAddr" id="sm414_InstalledAddr" v_must="1" v_type="string"   onblur="checkElement(this)"  maxlength="256" size="80"/>
		  </td>
	</tr>
 
 	
</table>


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="确定" onclick="sm414_go_Cfm()"            />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>


</div>
<!----------------------------------------------m414-----------------结束----------------------------->





<!----------------------------------------------m415-----------------开始----------------------------->
<div id="div_show_m415"> 

<table cellSpacing="0" >
	<%-- <tr>
		  <td class="blue" width="15%">销售模式</td>
		  <td width="35%">
			    <select id="sm415_SaleType"  >
			    	<option value="押金">押金</option>
			    </select>
		  </td>
		  <td class="blue" width="15%">&nbsp;</td>
		  <td>
			    &nbsp;
		  </td>
	</tr>--%>
	
</table>
<div class="title"><div id="title_zi">变更列表</div></div>

<table cellSpacing="0" id="sm415_chg_imei_tab">
	<tr>
		<th width="20%">选择</th>
		<th width="20%">IMEI码</th>
		<th width="20%">办理流水</th>
		<th width="20%">办理时间</th>
		<th width="20%">押金</th>
	</tr>
</table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="确定" onclick="sm415_go_Cfm()"            />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>
<table cellSpacing="0">
	<tr>
		  <td> <font class="orange">请去‘g836-押金返还业务’界面进行押金返回</font></td>
	</tr>
</table>
</div>
<!----------------------------------------------m415-----------------结束----------------------------->	






<!----------------------------------------------m416-----------------开始----------------------------->
<div id="div_show_m416"> 

<table cellSpacing="0" >
	<tr>
		 <%--  <td class="blue" width="15%">销售模式</td>
		  <td width="35%">
			    <select id="sm415_SaleType"  >
			    	<option value="押金">押金</option>
			    </select>
		  </td>--%>
		  <td class="blue" width="6%">新IMEI码</td>
		  <td width="35%" colspan="3">
		  	<input type="text"  value="" v_minlength="15" v_maxlength="15"  name="sm416_imei_no" id="sm416_imei_no" v_must="1" v_type="0_9"   onblur="checkElement(this)"  maxlength="15" />
		  </td>
	</tr>
	 
</table>
<div class="title"><div id="title_zi">变更列表</div></div>

<table cellSpacing="0" id="sm416_chg_imei_tab">
	<tr>
		<th width="20%">选择</th>
		<th width="20%">IMEI码</th>
		<th width="20%">办理流水</th>
		<th width="20%">办理时间</th>
		<th width="20%">押金</th>
	</tr>
</table>

	


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="确定" onclick="sm416_go_Cfm()"            />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

</div>
<!----------------------------------------------m416-----------------结束----------------------------->

<!-- liangyl 省内魔百和平台点播功能和支付功能开发需求 -->
<!----------------------------------------------m441魔百合增值包订购-----------------开始---------------------------liangyl 2016-12-08 省内魔百和平台点播功能和支付功能开发需求-->
<div id="div_show_m441"> 
<div class="title"><div id="title_zi">待订购imei列表</div></div>
<table cellSpacing="0" id="sm441_chg_imei_tab">
	<tr>
		<th width="20%">IMEI码</th>
		<th width="20%">增值包</th>
		<th width="20%">订购</th>
	</tr>
</table>
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"/> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"/> 
	 	</td>
	</tr>
</table>
</div>
<!----------------------------------------------m441魔百合增值包订购-----------------结束---------------------------liangyl 2016-12-08 省内魔百和平台点播功能和支付功能开发需求-->


<!-- liangyl 省内魔百和平台点播功能和支付功能开发需求 -->
<!----------------------------------------------m439魔百合增值包退订-----------------开始---------------------------liangyl 2016-12-08 省内魔百和平台点播功能和支付功能开发需求-->
<div id="div_show_m439"> 
<div class="title"><div id="title_zi">变更列表</div></div>
<table cellSpacing="0" id="sm439_chg_imei_tab">
	<tr>
		<th width="20%">IMEI码</th>
		<th width="20%">已订购增值包</th>
		<th width="20%">退订</th>
	</tr>
</table>
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"  /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()" /> 
	 	</td>
	</tr>
</table>
</div>
<!----------------------------------------------m439魔百合增值包退订-----------------结束---------------------------liangyl 2016-12-08 省内魔百和平台点播功能和支付功能开发需求-->


<!-- liangyl 省内魔百和平台点播功能和支付功能开发需求 -->
<!----------------------------------------------m440魔百合密码重置-----------------开始---------------------------liangyl 2016-12-08 省内魔百和平台点播功能和支付功能开发需求-->
<div id="div_show_m440"> 
<div class="title"><div id="title_zi">变更列表</div></div>

<table cellSpacing="0" id="sm440_chg_imei_tab">
	<tr>
		<th width="20%">IMEI码</th>
		<th width="20%">新魔百合密码</th>
		<th width="20%">新魔百合密码校验</th>
		<th width="20%">修改</th>
	</tr>
</table>
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"/> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"/> 
	 	</td>
	</tr>
</table>

</div>
<!----------------------------------------------m440魔百合密码重置-----------------结束---------------------------liangyl 2016-12-08 省内魔百和平台点播功能和支付功能开发需求-->
			
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
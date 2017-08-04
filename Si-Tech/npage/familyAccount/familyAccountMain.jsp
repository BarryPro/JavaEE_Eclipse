<%
/********************
version v2.0
开发商: si-tech
模块：家庭合帐业务
日期：2013-4-27 14:37:32
作者：hejwa
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml"> 
<%@ page contentType= "text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="org.apache.log4j.Logger"%>

<%
request.setCharacterEncoding("GBK");
%>
<head>
	<title>家庭合帐业务</title>
	<%
	String opCode       = request.getParameter("opCode");
	String opName       = request.getParameter("opName");
	String phoneNotype  = request.getParameter("phoneNotype");
	
	String hideStr      = "style=\"display:none\"";      //冲销顺序 费用代码 明细代码 费用比率 费用名称 这几列暂时屏蔽掉，如果还要只需要 hideStr="";
	String loginName    = (String)session.getAttribute("workName");
	String work_no      = (String)session.getAttribute("workNo");
	String org_code     = (String)session.getAttribute("orgCode");
	String wkPassword   = (String)session.getAttribute("password");
	String regionCode   = (String)session.getAttribute("regCode");
	String iRegion_Code = org_code.substring(0,2);
	
	String[][]  temfavStr = (String[][])session.getAttribute("favInfo");
	String[] favStr=new String[temfavStr.length];
	for(int i=0;i<favStr.length;i++)
		favStr[i]=temfavStr[i][0].trim();
	boolean pwrf=false;
	boolean hfrf=false;
	if(WtcUtil.haveStr(favStr,"a272"))
	pwrf=true;
	String [] retStr = null;
	
	String srv_no     = WtcUtil.repNull(request.getParameter("srv_no"));
	String cus_pass   = WtcUtil.repNull(request.getParameter("cus_pass"));
	String[] twoFlag  = new String []{};
	
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone"  routerValue="<%=srv_no%>" id="sLoginAccept"/>
<%
	String sqHf="select hand_fee ,trim(favour_code) from snewFunctionFee where region_code=substr('"+org_code+"',1,2) and FUNCTION_CODE="+opCode;
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="2">
 <wtc:sql><%=sqHf%></wtc:sql>
</wtc:pubselect>
	<wtc:array id="handFeeArr" scope="end"/>
<%
	
	String oriHandFee="0";
	String oriHandFeeFlag="";
	if(handFeeArr.length>0){
		oriHandFee=handFeeArr[0][0];
		oriHandFeeFlag=handFeeArr[0][1];
		if(Double.parseDouble(oriHandFee) < 0.01){
		   hfrf=true;
		}else{
			if(!WtcUtil.haveStr(favStr,oriHandFeeFlag.trim())){
			  hfrf=true;
			}
		}
	}else{
	  hfrf=true;
	}
		String id_no	      = "" ;    // idNo
		String sm_code      = "" ;    // 品牌代码
		String sm_name      = "" ;    // 品牌名称
		String cust_name    = "" ;    // 客户姓名
		String cust_id      = "" ;    // custID
		String owner_grade  = "" ;    // 等级代码
		String grade_name   = "" ;    // 等级名称
		String owner_type   = "" ;    // 用户类型代码
		String type_name    = "" ;    // 用户类型名称
		String totalOwe     = "" ;    // 总欠费
		String totalPrepay  = "" ;    // 总预存
		String accountNo    = "" ;    // 默认帐号
		String functionFee  = "" ;    // 手续费
		String belong_code  = "" ;    // 用户归属
		String isoweFee     = "" ;    // 检验托收帐户欠费
		String custAddr     = "" ;    // 客户地址
		String phoneNo      = "" ;
	%>
		<wtc:service name="sG630Init"  routerKey="region" routerValue="<%=regionCode%>"  retcode="error_code" retmsg="error_msg" outnum="17" >
			<wtc:param value="<%=sLoginAccept%>"/>			
			<wtc:param value="01"/>				
			<wtc:param value="<%=opCode%>"/> 
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=wkPassword%>"/>	
			<wtc:param value="<%=srv_no%>"/>
			<wtc:param value="<%=cus_pass%>"/>	
			<wtc:param value="<%=org_code%>"/>
			<wtc:param value="<%=phoneNotype%>"/>	
		</wtc:service>
		<wtc:array id="result_t"  scope="end"/> 
  <%		
	if(!error_code.equals("000000")){
	%>
	<script language="javascript">
		rdShowMessageDialog('sG630Init服务未能成功!<br>服务代码<%=error_code%><%=error_msg%>',0);
		window.location.href="familyAccountLogin.jsp?activePhone=<%=srv_no%>&opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
	<%
	return;
	}else {
		if(result_t.length>0){
			 id_no	      = result_t[0][0];   // idNo                        
			 sm_code      = result_t[0][1];   // 品牌代码                    
			 sm_name      = result_t[0][2];   // 品牌名称                    
			 cust_name    = result_t[0][3];   // 客户姓名                    
			 cust_id      = result_t[0][4];   // custID                      
			 owner_grade  = result_t[0][5];   // 等级代码                    
			 grade_name   = result_t[0][6];   // 等级名称                    
			 owner_type   = result_t[0][7];   // 用户类型代码                
			 type_name    = result_t[0][8];   // 用户类型名称                
			 totalOwe     = result_t[0][9];   // 总欠费                      
			 totalPrepay  = result_t[0][10];  // 总预存                      
			 accountNo    = result_t[0][11].trim();  // 默认帐号                    
			 srv_no       = result_t[0][12];  // 手续费                      
			 belong_code  = result_t[0][13];  // 用户归属                    
			 isoweFee     = result_t[0][14];  // 检验托收帐户欠费      
			 custAddr     = result_t[0][15];  // 客户地址
			 phoneNo      = srv_no;       
		}
} 

System.out.println("<br>-----------idNo              -------------id_no	    --------------"+id_no	     );
System.out.println("<br>-----------品牌代码          -------------sm_code    --------------"+sm_code     ); 
System.out.println("<br>-----------品牌名称          -------------sm_name    --------------"+sm_name     ); 
System.out.println("<br>-----------客户姓名          -------------cust_name  --------------"+cust_name   ); 
System.out.println("<br>-----------custID            -------------cust_id    --------------"+cust_id     ); 
System.out.println("<br>-----------等级代码          -------------owner_grade--------------"+owner_grade ); 
System.out.println("<br>-----------等级名称          -------------grade_name --------------"+grade_name  ); 
System.out.println("<br>-----------用户类型代码      -------------owner_type --------------"+owner_type  ); 
System.out.println("<br>-----------用户类型名称      -------------type_name  --------------"+type_name   ); 
System.out.println("<br>-----------总欠费            -------------totalOwe   --------------"+totalOwe    ); 
System.out.println("<br>-----------总预存            -------------totalPrepay--------------"+totalPrepay ); 
System.out.println("<br>-----------默认帐号          -------------accountNo  --------------"+accountNo   ); 
System.out.println("<br>-----------手续费            -------------srv_no     --------------"+srv_no      ); 
System.out.println("<br>-----------用户归属          -------------belong_code--------------"+belong_code ); 
System.out.println("<br>-----------检验托收帐户欠费  -------------isoweFee   --------------"+isoweFee    ); 
System.out.println("<br>-----------客户地址          -------------custAddr   --------------"+custAddr    ); 

	String sq1="select trim(fee_code),trim(detail_code),trim(detail_name) from sFeecodedetail order by fee_code,detail_code";
%>
		<wtc:service name="TlsPubSelBoss" outnum="3" routerKey="phone" routerValue="<%=srv_no%>" outnum="3">
			<wtc:param value="<%=sq1%>" />
		</wtc:service>
		<wtc:array id="feeStr" scope="end"/>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="javascript">

var hideStrJs = "style=\"display:none\""; ////冲销顺序 费用代码 明细代码 费用比率 费用名称 这几列暂时屏蔽掉，如果还要只需要 hideStr="";

var opFlag = "a";	
var js_fee = new Array();
//---------显示打印对话框----------------
function printCommit(){
	//getAfterPrompt();
	showPrtDlg("Detail","确定提交？","Yes");
}

function showPrtDlg(printType,DlgMessage,submitCfm){
 		
 		var memPhoneArray  = new Array(); //手机号数组
 		var defContNoArray = new Array(); //默认付费账户 
 		var feeLimitArray  = new Array(); //限额
 		var payorderArray  = new Array(); //冲销顺序
 		var feeFlagArray   = new Array(); //费用代码
 		var detFlagArray   = new Array(); //明细代码
 		var rateFlagArray  = new Array(); //是否明细
 		var stopflagArray  = new Array(); //是否设置
 		var feeratioArray  = new Array(); //费用比率
 		var orderNewArray  = new Array(); //冲销顺序 固定值1
 		//校验成员设置
 		
 		var	exiFlag    = 0; //是否有数据
 		var showHit    = ""; //限额是否填写
 		
 		$("#memberList tr:gt(0)").each(function(i,bt){
 			exiFlag ++ ;
 			//取手机号 如果 td的个数为9就是手机号的行，否则为拼串
			var tdSize = $(bt).find("td").size();
			if(tdSize==9){//含有手机号的 冲销顺序 费用代码 明细代码 费用比率
				var memPhone   = ""; //手机号数组
		 		var defContNo  = ""; //默认付费账户 
		 		var feeLimit   = ""; //限额
		 		var payorder   = ""; //费用比率
		 		var feeFlag    = ""; //费用代码
		 		var detFlag    = ""; //明细代码
	 			var feeratio   = ""; //费用比率
	 			var limiType   = ""; //限额类型
				var rowspanNum = parseInt($(bt).find("td:eq(0)").attr("rowspan"));
						memPhone   = $(bt).find("td:eq(0)").text().trim();
						defContNo  = $(bt).find("td:eq(1)").text().trim();
						feeLimit   = $(bt).find("td:eq(2)").find("input").val().trim();
						limiType   = $(bt).find("td:eq(2)").find("select").val();
				
				if(feeLimit == ""){
					showHit = "请设置付费方式";
					$(bt).find("td:eq(2)").find("input").focus();
					return false;
				}
				
				var t1 = /^\d+$/;
				if(!t1.test(feeLimit)){
					showHit = "限额必须为数组字";
					$(bt).find("td:eq(2)").find("input").val("");
					$(bt).find("td:eq(2)").find("input").focus();
					return false;
				}
				
				if(parseInt(feeLimit)>5000){
					showHit = "家庭为成员每月支付限额不能超过5000元";
					$(bt).find("td:eq(2)").find("input").val("");
					$(bt).find("td:eq(2)").find("input").focus();
					return false;
				}
				
				if(limiType=="0"&&parseInt(feeLimit)==0){
					showHit = "限额付费限额应大于0，请重新输入";
					$(bt).find("td:eq(2)").find("input").val("");
					$(bt).find("td:eq(2)").find("input").focus();
					return false;
				}
				
				payorder += $(bt).find("td:eq(3)").text().trim()+"|";
				feeFlag  += $(bt).find("td:eq(4)").text().trim()+"|";
				detFlag  += $(bt).find("td:eq(5)").text().trim()+"|";
				feeratio += $(bt).find("td:eq(6)").text().trim()+"|";
				
/*				if(payorder == "|"||payorder==""){
					rateFlagArray.push("N");
				}else{
					rateFlagArray.push("Y");
				}*/
				
				//向下找rowspan-1行
				for(var ii=0; ii<rowspanNum-1 ;ii++){
					bt = $(bt).next();
					payorder += $(bt).find("td:eq(0)").text().trim()+"|";
					feeFlag  += $(bt).find("td:eq(1)").text().trim()+"|";
					detFlag  += $(bt).find("td:eq(2)").text().trim()+"|";
					feeratio += $(bt).find("td:eq(3)").text().trim()+"|";
				}
				
				//去掉最后一位的竖线
				payorder  = payorder.substring(0,payorder.length-1);
				feeFlag   = feeFlag.substring(0,feeFlag.length-1);
				detFlag   = detFlag.substring(0,detFlag.length-1);
				feeratio  = feeratio.substring(0,feeratio.length-1);
				
				rateFlagArray.push("N");
				stopflagArray.push("Y");
				orderNewArray.push("1");
				memPhoneArray.push(memPhone);
				defContNoArray.push(defContNo);
				feeLimitArray.push(feeLimit);
				payorderArray.push(payorder);
				feeFlagArray.push(feeFlag);
				detFlagArray.push(detFlag);
				feeratioArray.push(feeratio);
			}
 		});
 		
 		//alert("stopflagArray|"+stopflagArray+"\nmemPhoneArray|"+memPhoneArray+"\ndefContNoArray|"+defContNoArray+"\nfeeLimitArray|"+feeLimitArray+"\npayorderArray|"+payorderArray+"\nfeeFlagArray|"+feeFlagArray+"\ndetFlagArray|"+detFlagArray+"\nrateFlagArray|"+rateFlagArray+"\nfeeratioArray|"+feeratioArray);
 		if(showHit!=""){
 			rdShowMessageDialog(showHit);
 			return;
 		}
 		
 		if(exiFlag<2){//还有一行设置全部
 			rdShowMessageDialog("成员列表为空，请设置成员号码");
 			return;
 		}
 				
 				$("input[name='memPhoneArray']").val(memPhoneArray);
				$("input[name='defContNoArray']").val(defContNoArray);
				$("input[name='feeLimitArray']").val(feeLimitArray);
				$("input[name='payorderArray']").val(payorderArray);
				$("input[name='feeFlagArray']").val(feeFlagArray);
				$("input[name='detFlagArray']").val(detFlagArray);
				$("input[name='rateFlagArray']").val(rateFlagArray);
				$("input[name='stopflagArray']").val(stopflagArray);
				$("input[name='feeratioArray']").val(feeratioArray);
				$("input[name='orderNewArray']").val(orderNewArray);
				$("input[name='opType']").val(opFlag);
				
			var opStr = "新增";
			if(opFlag=="a"){
				 opStr = "新增";
			}else if(opFlag=="u"){
				 opStr = "修改";
			}else if(opFlag=="d"){
				 opStr = "删除";
			}			
		document.all.t_sys_remark.value="用户"+"<%=cust_name%>"+"进行家庭合帐业务操作-"+opStr;
		if(document.all.t_op_remark.value.trim().length==0){
			document.all.t_op_remark.value="操作员<%=work_no%>"+"对用户"+"<%=cust_name%>"+"进行家庭合帐业务操作-"+opStr;
		}
		if(document.all.assuNote.value.trim().length==0){
			document.all.assuNote.value="操作员<%=work_no%>"+"对用户"+"<%=cust_name%>"+"进行家庭合帐业务操作-"+opStr;
		}
		//显示打印对话框
		var h=210;
   	var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
		var pType="subprint";             // 打印类型：print 打印 subprint 合并打印
		var billType="1";               //  票价类型：1电子免填单、2发票、3收据
		var sysAccept="<%=sLoginAccept%>";               // 流水号
		var printStr = printInfo(printType); //调用printinfo()返回的打印内容
		var mode_code=null;               //资费代码
		var fav_code=null;                 //特服代码
		var area_code=null;             //小区代码
		var opCode="<%=opCode%>" ;                   //操作代码
		var phoneNo=<%=phoneNo%>;                  //客户电话
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;

		var ret=window.showModalDialog(path,printStr,prop);

		if(typeof(ret)!="undefined"){
			if((ret=="confirm")&&(submitCfm == "Yes")){
				if(rdShowConfirmDialog('确认要提交家庭合帐业务？')==1){
					conf();
				}
			}
			if(ret=="continueSub"){
				if(rdShowConfirmDialog('确认要提交家庭合帐业务？')==1){
					conf();
				}
			}
		}else{
			if(rdShowConfirmDialog('确认要提交家庭合帐业务？')==1){
				conf();
			}
		}
}


//打印免填单
function printInfo(printType){
	 var cust_info=""; //客户信息
	 var opr_info=""; //操作信息
	 var note_info1=""; //备注1
	 var note_info2=""; //备注2
	 var note_info3=""; //备注3
	 var note_info4=""; //备注4
   var retInfo = "";  //打印内容
   
 	 cust_info+="客户姓名："+document.all.cust_name.value+"|";     
   cust_info+="家庭号码："+document.all.srv_no.value+"|";

	var opStr = "新增";
	if(opFlag=="a"){
		 opStr = "新增";
	}else if(opFlag=="u"){
		 opStr = "修改";
	}else if(opFlag=="d"){
		 opStr = "删除";
	}
	opr_info+="家庭合帐业务："+opStr+"|";
  opr_info+="业务流水："+"<%=sLoginAccept%>|";
  
  var tempOprInfo1 = "";
  
	$("#memberList tr:gt(0)").each(function(i,bt){
 			var tdSize = $(bt).find("td").size();
			if(tdSize==9){//含有手机号的 冲销顺序 费用代码 明细代码 费用比率
				var memPhone   = ""; //手机号数组
		 		var limiType   = ""; //默认付费账户 
		 		var feeLimit   = ""; //限额
		 		
						memPhone   = $(bt).find("td:eq(0)").text().trim();
						limiType  = $(bt).find("select").val();
						feeLimit   = $(bt).find("td:eq(2)").find("input").val().trim();
						if(limiType==0){
							tempOprInfo1 += memPhone+"     限额付费     "+feeLimit+"|";
						}else{
							tempOprInfo1 += memPhone+"     全额付费     "+"|";
						}
			}
 		});  
 		
 	opr_info+="成员号码："+"|";
 	opr_info+=tempOprInfo1+"|";
 		
  opr_info+="系统备注："+document.all.t_sys_remark.value+"|";
	opr_info+="用户备注："+document.all.t_op_remark.value+"|";
	note_info1+="      备注："+"|";
	
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	return retInfo;
}

//---------提交处理函数-------------------
function conf(){
	frm.action="familyAccountCfm.jsp";
	frm.submit();
}
 

//-------3--------实收栏专用函数----------------
function ChkHandFee()
{
	if(document.all.oriHandFee.value.trim().length>=1 && document.all.t_handFee.value.trim().length>=1){
		if(parseFloat(document.all.oriHandFee.value)<parseFloat(document.all.t_handFee.value)){
			rdShowMessageDialog("实收手续费不能大于原始手续费！");
			document.all.t_handFee.value=document.all.oriHandFee.value;
			document.all.t_handFee.select();
			document.all.t_handFee.focus();
			return;
		}
	}
	
	if(document.all.oriHandFee.value.trim().length>=1 && document.all.t_handFee.value.trim().length==0){
		document.all.t_handFee.value="0";
	}
}

function getFew(){
	if(window.event.keyCode==13){
		var fee=document.all.t_handFee;
		var fact=document.all.t_factFee;
		var few=document.all.t_fewFee;
		if(fact.value.trim().length==0){
			rdShowMessageDialog("实收金额不能为空！");
			fact.value="";
			fact.focus();
			return;
		}
		if(parseFloat(fact.value)<parseFloat(fee.value)){
			rdShowMessageDialog("实收金额不足！");
			fact.value="";
			fact.focus();
			return;
		}
		var tem1=((parseFloat(fact.value)-parseFloat(fee.value))*100+0.5).toString();
		var tem2=tem1;
		if(tem1.indexOf(".")!=-1) tem2=tem1.substring(0,tem1.indexOf("."));
		few.value=(tem2/100).toString();
		few.focus();
	}
}

//-------4--------点击操作类型单选框时--------------

function setChangeType(){
	if(opFlag=="a"){
		$("input[vProp='u']").removeAttr("disabled");
		$("#memPhoneIpt").removeAttr("disabled");
	}else if(opFlag=="u"){
		$("#memPhoneIpt").attr("disabled","disabled");
		$("input[vProp='u']").removeAttr("disabled");
	}else if(opFlag=="d"){
		$("input[vProp='u']").attr("disabled","disabled");
		$("#memPhoneIpt").attr("disabled","disabled");
	}
}
function chg_opType(){
	if(document.all.r_acc_opType[0].checked){
		if(opFlag!="a"){
			$("#memberList tr:not(:first):not(:last)").remove();
			$("#memPhoneSel").val("");
			$("#memPhoneIpt").val("");
		}
		opFlag="a";
		
	}else if(document.all.r_acc_opType[1].checked){
		if(parseInt(document.all.ccount.value,10)>0){
			rdShowMessageDialog("您是托收帐户，帐户有欠费不能修改帐户！");
			document.all.r_acc_opType[0].checked=true;
			return;
		}
		if(opFlag!="u"){
			$("#memberList tr:not(:first):not(:last)").remove();
			$("#memPhoneSel").val("");
			$("#memPhoneIpt").val("");
		}
		opFlag="u";
	}else if(document.all.r_acc_opType[2].checked){
		if(parseInt(document.all.ccount.value,10)>0){
			rdShowMessageDialog("您是托收帐户,帐户有欠费不能删除帐户！");
			document.all.r_acc_opType[0].checked=true;
			return;
		}		
		if(opFlag!="d"){
			$("#memberList tr:not(:first):not(:last)").remove();
			$("#memPhoneSel").val("");
			$("#memPhoneIpt").val("");
		}
		opFlag="d";
	}
	
	setChangeType();
}
 
 
 
//选择手机号下拉框
function setMemPhoneIptFuc(bt){
	if($(bt).val()==""){
		$("#memPhoneIpt").val("");
	}else{
		$("#memPhoneIpt").val($(bt).val());
	}
} 
//添加校验按钮
function addMemPhoneSetFunc(){
	if($("#memPhoneIpt").val()==""){
		rdShowMessageDialog("请设置手机号码");
		$("#memPhoneSel").val("");
		$("#memPhoneIpt").focus();
		setMemPhoneIptFuc();
		return;
	}
	
	//查询列表中是否已经存在手机号
	var retFlag = 0;
	$("#memberList tr:gt(0)").each(function(i,bt){
		if($(bt).find("td:eq(0)").text().trim()==$("#memPhoneIpt").val()){
			retFlag = 1;
			return false;
		}
	});
	
	if(retFlag==1){
		rdShowMessageDialog("此号码已经进行了设置");
		$("#memPhoneSel").val("");
		$("#memPhoneIpt").focus();
		setMemPhoneIptFuc();
		return;
	}
	var packet = new AJAXPacket("ajaxChkMemPhone.jsp","请稍后...");
	packet.data.add("memPhoneIpt",$("#memPhoneIpt").val());
	packet.data.add("r_acc_opType",opFlag);
	packet.data.add("sLoginAccept","<%=sLoginAccept%>");
	packet.data.add("opCode","<%=opCode%>");
	packet.data.add("famContractNo","<%=accountNo%>");
	packet.data.add("srv_no","<%=srv_no%>");
	core.ajax.sendPacket(packet,doAjaxChkMemPhone);
	packet =null;
}
function doAjaxChkMemPhone(packet){
	var retCode   = packet.data.findValueByName("retCode");
	var retMsg    = packet.data.findValueByName("retMsg");
	var memPhone  = packet.data.findValueByName("memPhone");
	
	if(retCode=="000000"){
		var isMemFlag     = packet.data.findValueByName("isMemFlag");
		var defContractNo = packet.data.findValueByName("defContractNo");
		var retStrs       = packet.data.findValueByName("retStrs");
		var feeLimit      = packet.data.findValueByName("feeLimit");
		var hitMsg        = packet.data.findValueByName("hitMsg");
		//将号码添加到列表，弹出设置费用页面
		if(isMemFlag == "0"){//是成员
			if(opFlag=="a"){//新增
				addMemPhListTabFunc(memPhone,defContractNo);
			}else{//修改和删除
				addMemPhListByUd(memPhone,defContractNo,retStrs,feeLimit);
			}
		}else{
			rdShowMessageDialog("此号码非此家庭成员，请先添加");
			toAddMember(memPhone,defContractNo);	//调用添加成员页面
		}
	}else{
		rdShowMessageDialog(retCode+"："+retMsg);
		$("#memPhoneSel").val("");
		$("#memPhoneIpt").focus();
		setMemPhoneIptFuc();
		return;
	}
}

//调用产品部的添加成员页面
function toAddMember(memPhone,defContractNo){
	
		var h=300;
		var w=650;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
 	  var custId = $("#cust_id").val();
 	  var path = "addMemberPhone.jsp?opCode=<%=opCode%>&opName=<%=opName%>&memPhone="+memPhone+"&custId="+custId;
    var retInfo = window.showModalDialog(path,"",prop);	
    if(typeof(retInfo)!="undefined"){
    	if(retInfo=="1"){//添加成功
    		ajaxGetMemPhoneList();//刷新下拉框
    		addMemPhListTabFunc(memPhone,defContractNo);
    	}
    }
}

//取成员下拉框列表
function ajaxGetMemPhoneList(){
	var packet = new AJAXPacket("ajaxGetMemPhoneList.jsp","请稍后...");
	packet.data.add("srv_no","<%=srv_no%>");
	packet.data.add("type","1");
	core.ajax.sendPacketHtml(packet,doAjaxGetMemPhoneList);
	packet =null;
}
function doAjaxGetMemPhoneList(data){
	$("#memPhoneSel").html(data);
}

//修改删除时增加到列表
function addMemPhListByUd(memPhone,defContractNo,retStrs,feeLimit){
	var inHtml    = "";               
	var selectObj = ""; 
	var iptText   = "";
	var iptButt1  = "";
	var disaStr   = "";
	var disaStr1  = "";
	
	
	var feeArray  = retStrs.split("|");
	var aLen      = feeArray.length-1;
	for(var i=0;i<aLen;i++){
		var tempArray = feeArray[i].split(",");
		if(opFlag=="d"){//删除无论全额限额均为不可改
			if(feeLimit==0){//全额限额
				selectObj = "<select onchange='setThisTrInpt(this)' style='width:90px' disabled><option value='0'>限额付费</option><option value='1' selected>全额付费</option></select>&nbsp;&nbsp;";
			}else{
				selectObj = "<select onchange='setThisTrInpt(this)' style='width:90px' disabled><option value='0' selected >限额付费</option><option value='1' >全额付费</option></select>&nbsp;&nbsp;";
			}
					iptText = "<input type='text' maxlength='4' style='width:30px' value='"+feeLimit+"' disabled />";
				 iptButt1 = "<input type='button' disabled class='b_text'  vProp='u'  "+hideStrJs+"  value='设置' onclick='setThisFee(this,\""+memPhone+"\",\""+defContractNo+"\","+aLen+")'  />";
		}else{//修改的情况 根据全额限额判断
			if(feeLimit==0){//全额限额
				selectObj = "<select onchange='setThisTrInpt(this)' style='width:90px' ><option value='0'>限额付费</option><option value='1' selected>全额付费</option></select>&nbsp;&nbsp;";
					iptText = "<input type='text' maxlength='4' style='width:30px' value='"+feeLimit+"' disabled />";
				 iptButt1 = "<input type='button' disabled class='b_text'  vProp='u'   "+hideStrJs+" value='设置' onclick='setThisFee(this,\""+memPhone+"\",\""+defContractNo+"\","+aLen+")'  />";
			}else{
				selectObj = "<select onchange='setThisTrInpt(this)' style='width:90px' ><option value='0' selected >限额付费</option><option value='1' >全额付费</option></select>&nbsp;&nbsp;";
					iptText = "<input type='text' maxlength='4' style='width:30px' value='"+feeLimit+"'  />";
				 iptButt1 = "<input type='button'  class='b_text'  vProp='u'   "+hideStrJs+" value='设置' onclick='setThisFee(this,\""+memPhone+"\",\""+defContractNo+"\","+aLen+")'  />";
			}
		}
			
		inHtml += "<tr>";
		if(i==0){//第一行与众不同
			inHtml += "<td rowspan='"+aLen+"'>";
			inHtml += memPhone;
			inHtml += "</td>";
			inHtml += "<td rowspan='"+aLen+"'>"+defContractNo+"</td>";
			inHtml += "<td rowspan='"+aLen+"' align='center'>"+selectObj+iptText+"</td>";
			inHtml += "<td "+hideStrJs+">"+tempArray[0]+"</td>";
			inHtml += "<td "+hideStrJs+">"+tempArray[1]+"</td>";
			inHtml += "<td "+hideStrJs+">"+tempArray[2]+"</td>";
			inHtml += "<td "+hideStrJs+">"+tempArray[3]+"</td>";
			inHtml += "<td "+hideStrJs+">"+getFeeLName(tempArray[2])+"</td>";
			inHtml += "<td rowspan='"+aLen+"'>"+iptButt1+"&nbsp;&nbsp;";
			inHtml += "<input type='button' class='b_text' value='删除' onclick='delThisMem(this,"+aLen+")' /></td>";
		}else{
			inHtml += "<td "+hideStrJs+">"+tempArray[0]+"</td>";
			inHtml += "<td "+hideStrJs+">"+tempArray[1]+"</td>";
			inHtml += "<td "+hideStrJs+">"+tempArray[2]+"</td>";
			inHtml += "<td "+hideStrJs+">"+tempArray[3]+"</td>";
			inHtml += "<td "+hideStrJs+">"+getFeeLName(tempArray[2])+"</td>";
		}
		inHtml += "</tr>";
	}
	$("#memberList tr:first").after(inHtml);
	//setChangeType();
}

//根据费用代码取得费用名称
function getFeeLName(feeCode){
	feeCode = feeCode.trim()+"";
	var temFeeName = "";
  for(var i=0; i<js_fee.length;i++){
  	if(js_fee[i][1]==feeCode){
  		temFeeName = js_fee[i][2];
  		break;
  	}
  }
	return temFeeName;
}


//限额方式onchange事件
function setThisTrInpt(bt){
	if($(bt).val()==0){//限额
		$(bt).parent().parent().find("input[type='text']").val("");
		$(bt).parent().parent().find("input[type='text']").removeAttr("disabled");
		$(bt).parent().parent().find("input[value='设置']").removeAttr("disabled");
	}else{//全额
		var rowspanNum = parseInt($(bt).parent().parent().find("td:eq(0)").attr("rowspan"));
		var	memPhone   = $(bt).parent().parent().find("td:eq(0)").text().trim();
		var	defContNo  = $(bt).parent().parent().find("td:eq(1)").text().trim();
		
		var inHtml  = "";
				inHtml += "<tr><td>";
				inHtml += memPhone;
				inHtml += "</td>";
				inHtml += "<td>"+defContNo+"</td>";
				inHtml += "<td align='center'>";
				inHtml += "<select onchange='setThisTrInpt(this)' style='width:90px'><option value='0'>限额付费</option><option value='1' selected>全额付费</option></select>&nbsp;&nbsp;";
				inHtml += "<input type='text'   maxlength='4'  style='width:30px' value='0'  disabled /></td>";
				inHtml += "<td "+hideStrJs+"></td><td "+hideStrJs+"></td><td "+hideStrJs+"></td><td "+hideStrJs+"></td>";
				inHtml += "<td "+hideStrJs+"></td>";
				inHtml += "<td><input type='button' class='b_text'  "+hideStrJs+" value='设置' disabled vProp='u' onclick='setThisFee(this,\""+memPhone+"\",\""+defContNo+"\",1)' />&nbsp;&nbsp;";
				inHtml += "    <input type='button' class='b_text' value='删除' onclick='delThisMem(this,1)' /></td></tr>";
		
		var trObj = $(bt).parent().parent();	
		for(var i=0;i<rowspanNum;i++){
			trObj = trObj.next();
		}
		trObj.before(inHtml);//这行的前面插入此值就跟没变过一样
		delThisMem(bt,rowspanNum);//删除之前记录
	}
}


//新增时添加手机号到设置费用列表
function addMemPhListTabFunc(mPhoneNo,defContractNo){
	var inHtml  = "";
			inHtml += "<tr><td>";
			inHtml += mPhoneNo;
			inHtml += "</td>";
			inHtml += "<td>"+defContractNo+"</td>";
			inHtml += "<td align='center'>";
			inHtml += "<select onchange='setThisTrInpt(this)' style='width:90px'><option value='0'>限额付费</option><option value='1'>全额付费</option></select>&nbsp;&nbsp;";
			inHtml += "<input type='text'   maxlength='4'  style='width:30px' /></td>";
			inHtml += "<td "+hideStrJs+"></td><td "+hideStrJs+"></td><td "+hideStrJs+"></td><td "+hideStrJs+"></td>";
			inHtml += "<td "+hideStrJs+"></td>";
			inHtml += "<td><input type='button' class='b_text'  "+hideStrJs+" value='设置' vProp='u' onclick='setThisFee(this,\""+mPhoneNo+"\",\""+defContractNo+"\",1)' />&nbsp;&nbsp;";
			inHtml += "    <input type='button' class='b_text' value='删除' onclick='delThisMem(this,1)' /></td></tr>";
	$("#memberList tr:first").after(inHtml);
	setChangeType();
}

//设置此处手机号码的冲销费用
function setThisFee(bt,mPhoneNo,defContractNo,oldAlen){
	var feeLimit = $(bt).parent().parent().find("input[type='text']").val().trim();
	var limiType = $(bt).parent().parent().find("td:eq(2)").find("select").val();
	var t1 = /^\d+$/;
	if(feeLimit!=""){// 如果输入只能输入数字
		if(!t1.test(feeLimit)){
			rdShowMessageDialog("限额只能输入数字");
			$(bt).parent().parent().find("input[type='text']").val("");
			$(bt).parent().parent().find("input[type='text']").focus();
			return;
		}
		if(parseInt(feeLimit)>5000){
			rdShowMessageDialog("家庭为成员每月支付限额不能超过5000元");
			$(bt).parent().parent().find("input[type='text']").val("");
			$(bt).parent().parent().find("input[type='text']").focus();
			return false;
		}
		
		if(limiType=="0"&&parseInt(feeLimit)==0){
			rdShowMessageDialog("限额付费限额应大于0，请重新输入");
			$(bt).parent().parent().find("input[type='text']").val("");
			$(bt).parent().parent().find("input[type='text']").focus();
			return false;
		}
	}
	
	var Fees = "";
	var h=600;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var retInfo=window.showModalDialog("Dlg_s1212Add.jsp?opCode=<%=opCode%>&opName=<%=opName%>&Fees="+Fees,"",prop);
	var feeArray  = new Array();
	var tempArray = new Array();
	
	if(typeof(retInfo)!="undefined"&&retInfo!=""){
		feeArray = retInfo.split("|");
		var inHtml  = "";
		var aLen = feeArray.length-1;
			for(var i=0; i<aLen; i++){
				inHtml += "<tr>";
				tempArray = feeArray[i].split("#");
				if(i==0){//第一行与众不同
					inHtml += "<td rowspan='"+aLen+"'>";
					inHtml += mPhoneNo;
					inHtml += "</td>";
					inHtml += "<td rowspan='"+aLen+"'>"+defContractNo+"</td>";
					inHtml += "<td rowspan='"+aLen+"' align='center'><select onchange='setThisTrInpt(this)' style='width:90px'><option value='0' selected >限额付费</option><option value='1'>全额付费</option></select>&nbsp;&nbsp;<input type='text'  maxlength='4'  style='width:30px' value='"+feeLimit+"'  /></td>";
					inHtml += "<td>"+tempArray[3]+"</td>";
					inHtml += "<td>"+tempArray[0]+"</td>";
					inHtml += "<td>"+tempArray[1]+"</td>";
					inHtml += "<td>"+tempArray[4]+"</td>";
					inHtml += "<td>"+tempArray[2]+"</td>";
					inHtml += "<td rowspan='"+aLen+"'><input type='button' class='b_text'  vProp='u'  value='设置' onclick='setThisFee(this,\""+mPhoneNo+"\",\""+defContractNo+"\","+aLen+")' />&nbsp;&nbsp;";
					inHtml += "<input type='button' class='b_text' value='删除' onclick='delThisMem(this,"+aLen+")' /></td>";
				}else{
					inHtml += "<td>"+tempArray[3]+"</td>";
					inHtml += "<td>"+tempArray[0]+"</td>";
					inHtml += "<td>"+tempArray[1]+"</td>";
					inHtml += "<td>"+tempArray[4]+"</td>";
					inHtml += "<td>"+tempArray[2]+"</td>";
				}
				inHtml += "</tr>";
			}
		//先删除，在插入
		
		var trObj = $(bt).parent().parent();	
		for(var h=0;h<oldAlen;h++){
			trObj = trObj.next();
		}
		//alert(trObj.html());
		trObj.before(inHtml);//这行的前面插入此值就跟没变过一样
		delThisMem(bt,oldAlen);
		//$("#memberList tr:first").after(inHtml); 
		
	}
	setChangeType();
}
//删除此成员 len 向下删除多少行
function delThisMem(bt,len){
	var trArr = new Array();
	var trObj = $(bt).parent().parent();
	trArr.push(trObj);
	for(var i=0;i<len-1;i++){
		trObj = trObj.next();
		trArr.push(trObj); //记录tr
	}
	
	for(var j=0;j<trArr.length;j++){
		trArr[j].remove();
		trArr[j] = ""; //释放内存
	}
}


function allMemSetOFunc(){
	var h=300;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var retInfo=window.showModalDialog("allMemSetOFunc.jsp?opCode=<%=opCode%>&opName=<%=opName%>","",prop);
	if(typeof(retInfo)!="undefined"&&retInfo!=""){
		var selVal = retInfo.split("|")[0];
		var iptVal = retInfo.split("|")[1];
		$("#memberList tr:gt(0)").each(function(i,bt){
			$(bt).find("select").val(selVal);
			$(bt).find("input[type='text']").val(iptVal);
			if(selVal=="1"){
				$(bt).find("input[type='text']").attr("disabled","disabled");
			}else{
				$(bt).find("input[type='text']").removeAttr("disabled");
			}
		});
	}
} 


//设置全部按钮
function allMemSet(){
	//取当前成员列表中的全部手机号，循环赋值
	
	var memPhoneArray  = new Array();
	var defContNoArray = new Array();
	var feeLimitArray  = new Array();
	var limiTyprArray  = new Array();
	var showHit        = "";
	
	$("#memberList tr:gt(0)").each(function(i,bt){
		var tdSize = $(bt).find("td").size();
		
		var memPhone  = "";
		var defContNo = "";
		var feeLimit  = "";
		var limiType  = "";//限额方式下拉框
		
		if(tdSize==9){
				memPhone  = $(bt).find("td:eq(0)").text().trim();
				defContNo = $(bt).find("td:eq(1)").text().trim();
				feeLimit  = $(bt).find("td:eq(2)").find("input").val().trim();
				limiType  = $(bt).find("td:eq(2)").find("select").val();
				
				memPhoneArray.push(memPhone);
				defContNoArray.push(defContNo);
				feeLimitArray.push(feeLimit);
				limiTyprArray.push(limiType);
				
			feeLimit  = $(bt).find("td:eq(2)").find("input").val().trim();
			limiType  = $(bt).find("td:eq(2)").find("select").val();
			var t1 = /^\d+$/;
			if(feeLimit!=""){
				if(!t1.test(feeLimit)){
					showHit = "限额必须为数组字";
					$(bt).find("td:eq(2)").find("input").val("");
					$(bt).find("td:eq(2)").find("input").focus();
					return false;
				}
				
				if(parseInt(feeLimit)>5000){
					showHit = "家庭为成员每月支付限额不能超过5000元";
					$(bt).find("td:eq(2)").find("input").val("");
					$(bt).find("td:eq(2)").find("input").focus();
					return false;
				}
				
				if(limiType=="0"&&parseInt(feeLimit)==0){
					showHit = "限额付费限额应大于0，请重新输入";
					$(bt).find("td:eq(2)").find("input").val("");
					$(bt).find("td:eq(2)").find("input").focus();
					return false;
				}
			}
			
		}
	});
	
		if(showHit!=""){
 			rdShowMessageDialog(showHit);
 			return;
 		}
	
	var h=600;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var retInfo=window.showModalDialog("Dlg_s1212Add.jsp?opCode=<%=opCode%>&opName=<%=opName%>","",prop);
	
	var feeArray  = new Array();
	var tempArray = new Array();
	var inHtml    = "";
	
	if(typeof(retInfo)!="undefined"&&retInfo!=""){
		for(var j = 0; j<memPhoneArray.length; j++){
			feeArray = retInfo.split("|");
			var aLen = feeArray.length-1;
			
				if(limiTyprArray[j]==0){
					for(var i=0; i<aLen; i++){
						inHtml += "<tr>";
						tempArray = feeArray[i].split("#");
						if(i==0){//第一行与众不同
							inHtml += "<td rowspan='"+aLen+"'>";
							inHtml += memPhoneArray[j];
							inHtml += "</td>";
							inHtml += "<td rowspan='"+aLen+"'>"+defContNoArray[j]+"</td>";
							inHtml += "<td rowspan='"+aLen+"' align='center'><select onchange='setThisTrInpt(this)' style='width:90px'><option value='0' selected >限额付费</option><option value='1'>全额付费</option></select>&nbsp;&nbsp;<input type='text'  maxlength='4'  style='width:30px' value='"+feeLimitArray[j]+"'  /></td>";
							inHtml += "<td>"+tempArray[3]+"</td>";
							inHtml += "<td>"+tempArray[0]+"</td>";
							inHtml += "<td>"+tempArray[1]+"</td>";
							inHtml += "<td>"+tempArray[4]+"</td>";
							inHtml += "<td>"+tempArray[2]+"</td>";
							inHtml += "<td rowspan='"+aLen+"'><input type='button' class='b_text'  vProp='u'  value='设置' onclick='setThisFee(this,\""+memPhoneArray[j]+"\",\""+defContNoArray[j]+"\","+aLen+")' />&nbsp;&nbsp;";
							inHtml += "<input type='button' class='b_text' value='删除' onclick='delThisMem(this,"+aLen+")' /></td>";
						}else{
							inHtml += "<td>"+tempArray[3]+"</td>";
							inHtml += "<td>"+tempArray[0]+"</td>";
							inHtml += "<td>"+tempArray[1]+"</td>";
							inHtml += "<td>"+tempArray[4]+"</td>";
							inHtml += "<td>"+tempArray[2]+"</td>";
						}
						inHtml += "</tr>";
					}
			}else{ 
							inHtml += "<tr><td>";
							inHtml += memPhoneArray[j];
							inHtml += "</td>";
							inHtml += "<td>"+defContNoArray[j]+"</td>";
							inHtml += "<td align='center'>";
							inHtml += "<select onchange='setThisTrInpt(this)' style='width:90px'><option value='0'>限额付费</option><option value='1' selected>全额付费</option></select>&nbsp;&nbsp;";
							inHtml += "<input type='text'   maxlength='4'  style='width:30px' value='0' disabled /></td>";
							inHtml += "<td></td><td></td><td></td><td></td>";
							inHtml += "<td></td>";
							inHtml += "<td><input type='button' class='b_text' disabled  value='设置' vProp='u' onclick='setThisFee(this,\""+memPhoneArray[j]+"\",\""+defContNoArray[j]+"\",1)' />&nbsp;&nbsp;";
							inHtml += "    <input type='button' class='b_text' value='删除' onclick='delThisMem(this,1)' /></td></tr>";
			}	
		}
		$("#memberList tr:not(:first):not(:last)").remove();
		$("#memberList tr:first").after(inHtml);
	}	
}

$(document).ready(function(){
	ajaxGetMemPhoneList();
	<%
for(int i=0;i<feeStr.length;i++)
	{
%>
	js_fee[<%=i%>] = new Array();
<%	
		for(int j=0;j<feeStr[i].length;j++)
		{
			%>
			js_fee[<%=i%>][<%=j%>]="<%=feeStr[i][j].trim()%>";
			<%
		}
	}
	%>
});
</script>
</head>
<body>
<form name="frm" method="POST"  ">

<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="cust_name"            id="cust_name"            value="<%=cust_name%>" />
<input type="hidden" name="cust_id"              id="cust_id"              value="<%=cust_id%>" />
<input type="hidden" name="famContractNo"                                  value="<%=accountNo%>" />  
<input type="hidden" name="oriHandFee"           id="oriHandFee"           value="<%=functionFee%>" />
<input type="hidden" name="ccount"               id="ccount"               value="<%=isoweFee%>" />
<input type="hidden" name="sysAccept"            id="sysAccept"            value="<%=sLoginAccept%>" />
<input type="hidden" name="srv_no"               id="srv_no"               value=<%=srv_no%> />
<input type="hidden" name="opCode"                                         value="<%=opCode%>" />
<input type="hidden" name="opName"                                         value="<%=opName%>" />  
<input type="hidden" name="transFeeCode"         id="transFeeCode"         value="" />
<input type="hidden" name="transDetailCode"      id="transDetailCode"      value="" />
<input type="hidden" name="transFeeName"         id="transFeeName"         value="" />
<input type="hidden" name="memPhoneArray"                                  value="" />  
<input type="hidden" name="defContNoArray"                                 value="" />  
<input type="hidden" name="feeLimitArray"                                  value="" />  
<input type="hidden" name="payorderArray"                                  value="" />  
<input type="hidden" name="feeFlagArray"                                   value="" />  
<input type="hidden" name="detFlagArray"                                   value="" />  
<input type="hidden" name="rateFlagArray"                                  value="" />  
<input type="hidden" name="stopflagArray"                                  value="" />  
<input type="hidden" name="feeratioArray"                                  value="" />  
<input type="hidden" name="orderNewArray"                                  value="" />  
<input type="hidden" name="opType"                                         value="" />  




<div class="title">
<div id="title_zi">客户资料</div>
</div>
	<table cellspacing="0">
		<tr>
		
			<td class="blue" nowrap width="18%">大客户标志</td>
			<td nowrap  width="33%"><b><font color="#FF0000"><%=grade_name%></font></b></td>
			<td nowrap class="blue"  width="18%">客户类型</td>
			<td nowrap><%=type_name%></td>
		</tr>
		<tr>
			<td class="blue" nowrap>当前预存</td>
			<td nowrap><%=totalPrepay%></td>
			<td nowrap class="blue">当前欠费</td>
			<td nowrap><%=totalOwe%></td>
		</tr>
		<tr>
			<td class="blue" nowrap>客户名称</td>
			<td nowrap><%=cust_name%></td>
			<td nowrap class="blue">客户地址</td>
			<td nowrap><%=custAddr%></td>
		</tr>
	</table>
</div>

<div id="Operation_Table">
	<div class="title">
  <div id="title_zi">操作信息</div>
 </div>
  <table cellspacing="0">
	<tr>
		<td class="blue"  width="18%">帐号操作类型</td>
		<td   nowrap class="blue">
			<q vType='setNg35Attr'>
			<input type="radio"  id="r_acc_opType"  name="r_acc_opType" checked value="a" onclick="chg_opType()" index="0">
			    增加
			  </q>
			  <q vType='setNg35Attr'>
			<input type="radio" id="r_acc_opType"  name="r_acc_opType" value="u" onclick="chg_opType()"  index="1">
			    修改
			    </q>
			    <q vType='setNg35Attr'>
			<input type="radio" id="r_acc_opType"  name="r_acc_opType" value="d" onclick="chg_opType()" index="2">
		      	删除
		      	</q>
		 </td>
	</tr>
	<tr>
		<td nowrap class="blue" >手机号码</td>
		<td nowrap  >
		 	<select id="memPhoneSel" name="memPhoneSel" onchange="setMemPhoneIptFuc(this)">
		 		<option value="">--请选择--</option>
		 	</select>
		 	&nbsp;&nbsp;
		  <input   type="text"  name="memPhoneIpt" id="memPhoneIpt" maxlength="11"    />
		  &nbsp;&nbsp;
		  
			<input type="button" value="添加&校验" class="b_text" onclick="addMemPhoneSetFunc()" />
		</td>						
				
	</tr>
	
 
   </table>
 </div>																									

<div id="Operation_Table">
	<div class="title">
  <div id="title_zi">成员列表</div>
 </div>
<table id="memberList"  cellspacing="0">
	<tr>
		<th width="25%">手机号码</th>
		<th width="25%">默认付费账户</th>	
		<th>付费方式</th>	
		<th width="8%" <%=hideStr%> >冲销顺序</th>	
		<th width="8%" <%=hideStr%> >费用代码</th>	
		<th width="8%" <%=hideStr%> >明细代码</th>	
		<th width="8%" <%=hideStr%> >费用比率</th>	
		<th width="15%" <%=hideStr%> >费用名称</th>	
		<th width="15%">操作</th>	
 </tr>
 

 
 <tr>
 		<td id="footer" nowrap align="center" colspan="9">
			<input class="b_foot_long" type="button"  vProp='u'  value="设置全部" onclick="allMemSetOFunc()" />
		</td>
 </tr>
 
 
</table>


			<input type="hidden"  name="t_handFee" id="t_handFee"  	value="<%="".equals(functionFee)?"0":functionFee %>" v_type=float <%if(hfrf){%>readonly<%}%>  />
			<input type="hidden"  name="t_factFee" id="t_factFee"    />
			<input type="hidden"  name="t_fewFee" id="t_fewFee"  />
				<input type="hidden"  name="t_sys_remark" id="t_sys_remark" />
				<input type="hidden"  name="t_op_remark" id="t_op_remark" />
			<input  type="hidden"  name="assuNote"  />
			
			
<table>
	<tr>
		<td id="footer" nowrap align="center" colspan="6">
			<input class="b_foot_long" type="button" name="b_print" value="确认&打印" onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()" index="20">
			<input class="b_foot" type="button" name="b_clear" value="清除" onClick="frm.reset();" index="21">
			<input class="b_foot" type="button" name="b_back" value="关闭" onClick="removeCurrentTab()" index="22">
		</td>
	</tr>
 </table>
   </div>
   <input type="hidden" name="cus_pass" value="<%=cus_pass%>" />
	 <%@ include file="/npage/include/footer.jsp" %>
	</form>
</body>
<!-- ningtn 2011-8-3 10:52:18 电子化工单扩大范围 -->
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>

<script language="javascript">
//-------1----------公用函数----------------------
function addSpc(num)
{
	var ret="";
	for(var i=0;i<num;i++)
	ret+=" ";
	return ret;
}

function thinkAdd(str,len)
{
	var existLen=0;
	var one="";
	var ret="";

	for(var i=0;i<str.length;i++)
	{
		existLen++;
		if(str.charCodeAt(i)>127)
		existLen++;
	}

	for(var i=0;i<len-existLen;i++)
	ret+=" ";
	return ret;
}

 
</script>

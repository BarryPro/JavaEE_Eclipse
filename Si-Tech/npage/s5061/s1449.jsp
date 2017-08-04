<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-02-16 页面改造,修改样式
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	
	String opCode = "1449";	
	String opName = "全球通签约计划冲正";	//header.jsp需要的参数  
	String regionCode= (String)session.getAttribute("regCode");

%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 

<html>
<head>
<title>全球通签约计划冲正</title>
<script language=javascript>
<!--
  
	var pwdFlag="false";
	onload=function()
	{
		document.all.phoneno.focus();
	}


//--------3---------验证按钮专用函数-------------
 
	function simChk()
	{
		var myPacket = new AJAXPacket("qryCus_back.jsp","正在查询客户，请稍候......");
		myPacket.data.add("phoneNo",document.all.phoneno.value.trim());
		myPacket.data.add("opCode",document.all.opCode.value.trim());
		myPacket.data.add("backAccept",document.all.backAccept.value.trim());
		core.ajax.sendPacket(myPacket);
		myPacket=null;	
	}
 
 

 //--------4---------doProcess函数---------------- 
 
  function doProcess(packet)
  {
    var vRetPage=packet.data.findValueByName("rpc_page");

    if(vRetPage == "qryCus_back"){
    	var retCode = packet.data.findValueByName("retCode");      	
    	var retMsg = packet.data.findValueByName("retMsg");
    	
	    var idNo = packet.data.findValueByName("idNo");
		var smCode = packet.data.findValueByName("smCode");
		var smName = packet.data.findValueByName("smName");
		var custName = packet.data.findValueByName("custName");
		var userPassword = packet.data.findValueByName("userPassword");
		var runCode = packet.data.findValueByName("runCode");
		var runName = packet.data.findValueByName("runName");
		var ownerGrade = packet.data.findValueByName("ownerGrade");
		var gradeName = packet.data.findValueByName("gradeName");
		var ownerType = packet.data.findValueByName("ownerType");
		var ownerTypeName = packet.data.findValueByName("ownerTypeName");
		var custAddr = packet.data.findValueByName("custAddr");
		var idType = packet.data.findValueByName("idType");
		var idName = packet.data.findValueByName("idName");
		var idIccid = packet.data.findValueByName("idIccid");
		var card_name = packet.data.findValueByName("card_name");
		var totalOwe = packet.data.findValueByName("totalOwe");
		var totalPrepay = packet.data.findValueByName("totalPrepay");
		var firstOweConNo = packet.data.findValueByName("firstOweConNo");
		var firstOweFee = packet.data.findValueByName("firstOweFee");
		var loginAccept = packet.data.findValueByName("loginAccept");
		var orderCode = packet.data.findValueByName("orderCode");
		var orderName = packet.data.findValueByName("orderName");
		var baseFee = packet.data.findValueByName("baseFee");
		var freeFee = packet.data.findValueByName("freeFee");
		var mon_base_fee = packet.data.findValueByName("mon_base_fee");
		var consume_term = packet.data.findValueByName("consume_term");
		var begin_time = packet.data.findValueByName("begin_time");
		var end_time = packet.data.findValueByName("end_time");
	
		if(retCode=="000000"){
	    
		document.all.idNo.value = idNo;
		document.all.smCode.value = smCode;
		document.all.smName.value = smName;
		document.all.custName.value = custName;
		document.all.userPassword.value = userPassword;
		document.all.runCode.value = runCode;
		document.all.runName.value = runName;
		document.all.ownerGrade.value = ownerGrade;
		document.all.gradeName.value = gradeName;
		document.all.ownerType.value = ownerType;
		document.all.ownerTypeName.value = ownerTypeName;
		document.all.custAddr.value = custAddr;
		document.all.idType.value = idType;
		document.all.idName.value = idName;
		document.all.idIccid.value = idIccid;
		document.all.card_name.value = card_name;
		document.all.totalOwe.value = totalOwe;
		document.all.totalPrepay.value = totalPrepay;
		document.all.firstOweConNo.value = firstOweConNo;
		document.all.firstOweFee.value = firstOweFee;
		document.all.loginAccept.value = loginAccept;
		document.all.orderCode.value = orderCode;
		document.all.orderName.value = orderName;
		document.all.baseFee.value = baseFee;
		document.all.freeFee.value = freeFee;
		document.all.mon_base_fee.value = mon_base_fee;
		document.all.consume_term.value = consume_term;
		document.all.begin_time.value = begin_time;
		document.all.end_time.value = end_time;
		document.all.goodbz.value = packet.data.findValueByName("goodbz"	);
		document.all.modedxpay.value = packet.data.findValueByName("modedxpay"	);

		document.all.confirm.disabled=false;
		
		}else
		{
			rdShowMessageDialog("错误:"+ retCode + "->" + retMsg);
			return;
		}
    }       
    
  }

 

	//-------2---------验证及提交函数-----------------
	
	function printCommit(){	
		getAfterPrompt();
		//校验
		//if(!check(s1449)) return false;		
		//打印工单并提交表单
		document.all.remark.value="用户"  + document.all.phoneno.value + "全球通签约计划冲正";
		var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");		
		if((ret=="confirm"))
		{
			if(rdShowConfirmDialog('确认电子免填单吗？')==1){  
			　	s1449.submit();
			}
			
			if(ret=="remark"){
				if(rdShowConfirmDialog('确认要提交信息吗？')==1){
					s1449.submit();
				}
			}
		}else{
			if(rdShowConfirmDialog('确认要提交信息吗？')==1){
				s1449.submit();
			}
		}	
		return true;
	}
	
	function showPrtDlg(printType,DlgMessage,submitCfm)
	{  
		//显示打印对话框 		
		var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
		var billType="1";                      //  票价类型1电子免填单、2发票、3收据
		var sysAccept =document.all.loginAccept.value;                       // 流水号
		var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
		var mode_code=null;                        //资费代码
		var fav_code=null;                         //特服代码
		var area_code=null;                    //小区代码
		var opCode =   "<%=opCode%>";                         //操作代码
		var phoneNo = <%=activePhone%>;                           //客户电话		
		var h=180;
		var w=350;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
		var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);    
	
	}

	function printInfo(printType)
	{
		var cust_info=""; //客户信息
		var opr_info=""; //操作信息
		var retInfo = "";  //打印内容
		var note_info1=""; //备注1
		var note_info2=""; //备注2
		var note_info3=""; //备注3
		var note_info4=""; //备注4 
		
		cust_info+="客户姓名：   " +document.all.custName.value+"|";
		cust_info+="手机号码：   "+document.all.phoneno.value+"|";  
		cust_info+="客户地址：   "+document.all.custAddr.value+"|";
		
		opr_info+="业务类型："+'<%=opName%>'+"|";
		if(document.all.goodbz.value=="Y"){
			opr_info+="流水："+document.all.loginAccept.value+"       底线消费金额："+document.all.modedxpay.value+"元"+"|";
		}else{
			opr_info+="流水："+document.all.loginAccept.value+"|";
		}
		opr_info+="单月底限消费："+document.all.mon_base_fee.value+"|";
		opr_info+="年底限消费："+document.all.baseFee.value+"|";
		opr_info+="活动预存："+document.all.freeFee.value+"|";
		opr_info+="业务执行时间："+document.all.begin_time.value+"至"+document.all.end_time.value+"|";		
		opr_info+="活动期限："+document.all.consume_term.value+"|";
		
		note_info1+=document.all.simBell.value+"备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
		
		retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
		return retInfo;	
	}


	function getRemain(){	
		if(parseFloat(document.s3216.vHandFee.value) < parseFloat(document.s3216.vRealFee.value)){
			rdShowMessageDialog("手续费不能大于"+document.s3216.vHandFee.value);
			return;
		}	
		document.s3216.vPayChange.value=document.s3216.vHandFee.value-document.s3216.vRealFee.value;
	}

	function  modify()
	{
	
		if(document.all.aCurrentPoint.value > document.all.vCurrentPoint.value){
			rdShowMessageDialog("转赠积分不能大于当前积分,请重新操作！");
			document.all.aCurrentPoint.value = "";
			document.all.aCurrentPoint.focus();
			return;
		}
	
		if(document.all.aCurrentPoint.value == 0 || document.all.aCurrentPoint.value < 0)		
		{
			rdShowMessageDialog("转赠积分不能为空或0或小于0,请重新操作！");
			document.all.aCurrentPoint.value = "";
			document.all.aCurrentPoint.focus();
			return;
		}
		if(document.all.t_op_remark.value == 0)		
		{
			document.all.t_op_remark.value = "";
			document.all.t_op_remark.focus();
		}
	
		var t =  parseInt(document.s3216.aCurrentPoint.value,10) ;
		var c= parseInt(document.s3216.pCurrentPoint.value,10)  ;
		
		document.s3216.b.value =  t;
		document.s3216.d.value =  document.s3216.vCurrentPoint.value - document.s3216.aCurrentPoint.value;
		document.s3216.e.value =  t + c;
	}
	function  submitreset()
	{
		s3216.reset();	
		self.location.reload();
		return false;	
	}  
 //-->
</script>

</head>
<body>  
<form action="1449BackCfm.jsp" method="POST" name="s1449"  onKeyUp="chgFocus(s1449)">
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">全球通签约计划冲正</div>
	</div>	
	<input type=hidden name=simBell value="   手机上网可选套餐优惠的GPRS流量仅指CMWAP节点产生的流量.  彩铃下载：1.购彩铃包年卡,送价值88元德赛电池。  2.登陆龙江风采（wap.hljmonternet.com）使用手机上网：体验图铃下载、新闻资讯、网络美文免费体验区下载铃音、时尚屏保,免收信息费！拨打1860开通GPRS 。">
	<input type=hidden name=worldSimBell value="    您办理此业务后，即成为我公司全球通签约客户，在签约期限内使用我公司业务及产品，同时执行月底限消费政策。您交纳的预存款需在消费期限内消费完毕，同时您获赠的积分在积分使用期限后方可使用。       在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。       做为全球通客户，您将享受我公司为您提供的尊贵服务。">
	<input type="hidden" name="opCode" size="16" value="<%=opCode%>" >
	<input type="hidden" name="idNo" value="">
	<input type="hidden" name="smCode" value="">
	<input type="hidden" name="smName" value="">
	<input type="hidden" name="userPassword" value="">
	<input type="hidden" name="runCode" value="">
	<input type="hidden" name="runName" value="">
	<input type="hidden" name="ownerGrade" value="">
	<input type="hidden" name="gradeName" value="">
	<input type="hidden" name="ownerType" value="">
	<input type="hidden" name="custAddr" value="">
	<input type="hidden" name="idType" value="">
	<input type="hidden" name="idName" value="">
	<input type="hidden" name="card_name" value="">
	<input type="hidden" name="totalOwe" value="">
	<input type="hidden" name="firstOweConNo" value="">
	<input type="hidden" name="firstOweFee" value="">
	<input type="hidden" name="ownerTypeName" value="">
	<input type="hidden" name="idIccid" value="">
	<input type="hidden" name="loginAccept" value="">
	<input type="hidden" name="orderName" value="">
	<input type="hidden" name="begin_time" value="">
	<input type="hidden" name="end_time" value="">
	<input type="hidden" name="goodbz" value="">
	<input type="hidden" name="modedxpay" value="">
	
        <table  cellspacing="0">          
		<tr> 
			<td  nowrap width="16%" class="blue"> 用户号码</td>
			<td nowrap  > 
				<input  type="text" size="16" name="phoneno"  v_must=1  v_type="mobphone"  maxlength=11  index="6" value =<%=activePhone%>  readonly class="InputGrey">
			</td>
			<td   nowrap width="16%" class="blue">业务流水</td>
			<td nowrap >
				<input  type="text" size="16" name="backAccept"  v_must="1" v_type = "0_9"   maxlength=14 onBlur="if(this.value!=''){if(checkElement(document.s1449.backAccept)==false){return false;}}" index="8" >
				<input type="button"  class="b_text" value="查询" onClick="simChk()">
			</td>
		</tr>
		<tr> 
			<td   nowrap width="16%" class="blue">用户姓名</td>
			<td  nowrap  width="28%"> 
				<input  type="text" size="16" name="custName"  index="8" readonly class="InputGrey">
			</td>
			<td  nowrap  width="16%" class="blue">方案代码</td>
			<td  nowrap  width="40%"> 
				<input type="text"  name="orderCode" size="16" readonly class="InputGrey">
			</td>
		</tr>
		<tr> 
			<td   nowrap width="16%" class="blue">预 存 款</td>
			<td  nowrap  width="28%"> 
				<input type="text" name="totalPrepay" size="16" readonly tabindex="0" class="InputGrey">		
			</td>
			<td  nowrap  width="16%" class="blue">底线预存</td>
			<td  nowrap  width="40%"> 
				<input type="text" name="baseFee" size="16" readonly class="InputGrey">
			</td>
		</tr>
		<tr> 
			<td   nowrap width="16%" class="blue">活动预存</td>
			<td  nowrap  width="28%">  
				<input type="text"  name="freeFee" size="16" readonly class="InputGrey"tabindex="0">
			</td>
			<td  nowrap  width="16%" class="blue">消费期限</td>
			<td  nowrap  width="40%"> 
				<input type="text"  name="consume_term" size="16" readonly class="InputGrey" tabindex="0">
			</td>
		</tr>
		<tr> 
			<td   nowrap width="16%" class="blue">月 底 线</td>
			<td  nowrap  width="28%"> 
				<input type="text"  name="mon_base_fee" size="16" readonly class="InputGrey" tabindex="0">
			</td>
			<td  nowrap  width="16%"> 
				&nbsp;			
			</td>
			<td  nowrap  width="40%"> 	
				&nbsp;			
			</td>
		</tr>          
		<tr> 
			<td valign="top" class="blue"> 
				系统备注
			</td>
			<td colspan="4" valign="top"> 
				<input type="text" name="remark" id="remark" size="60" readonly class="InputGrey"  maxlength=30>
			</td>
		</tr>
  	</table>
  	
	<table  cellspacing="0">   
		<tr> 			
			<td id="footer"> 
				<input type="button" class="b_foot_long" name="confirm" value="打印&确认" onClick="printCommit()" index="26" disabled >
				<input type=reset class="b_foot" name=back value="清除" onClick="document.all.confirm.disabled=true;" >
				<input type="button" class="b_foot" name="b_back" value="关闭" onClick="removeCurrentTab();" index="28">
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

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
	
	String opCode = "2300";	
	String opName = "红名单管理";	//header.jsp需要的参数  
	String sePhone=request.getParameter("sePhone");	
	String phone ="";
	if(activePhone==null){
		phone=sePhone;
	}else{
		phone=activePhone;
	}
	
	String workNo = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");	
	String[][] favInfo = (String[][])session.getAttribute("favInfo");	
//	int favFlag = 0 ;
//	for(int i = 0 ; i < favInfo.length ; i ++){
//		if(favInfo[i][0].trim().equals("a272")){
//			favFlag = 1;
//		}
//	}
%>
<%
	String org_codeT = (String)session.getAttribute("orgCode");
	String region_codeT =  (String)session.getAttribute("regCode");
	StringBuffer sq1 = new StringBuffer();
		sq1.append("select function_code,hand_fee,favour_code");
		sq1.append("  from sNewFunctionFee ");
		sq1.append(" where region_code='");
		sq1.append(region_codeT);
		sq1.append("' and function_code='2300'");
		System.out.println(sq1.toString());
	//ArrayList arr = F2300Wrapper.getFuncFee(region_codeT);		
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_codeT%>"  retcode="retCode1" retmsg="retMsg1" outnum="3">
		<wtc:sql><%=sq1.toString()%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="fee" scope="end" />
	<%
	System.out.println();
	//[][] fee = (String[][])arr.get(0);   
	System.out.println(fee.length);	
	String tHandFee = "0";
	int feeFlag = 0;
	if(fee.length==0){
		tHandFee="0";
		feeFlag = 0;
	}else{
		tHandFee=fee[0][1];
		for(int i = 0 ; i < favInfo.length ; i ++){
		
			if(favInfo[i][0].trim().equals(fee[0][2]))
			{
				feeFlag = 1;
			}
		}
	}
	
	//comImpl co=new comImpl();
	String  mSqlStr = "select red_code,red_name from sRedCode where region_code = '" + region_codeT +"'";
	System.out.println(mSqlStr);
	//ArrayList redCodeArr = co.spubqry32("2",mSqlStr); 
	%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_codeT%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
			<wtc:sql><%=mSqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="redCodeStr" scope="end" />
	<%
	//String[][] redCodeStr = (String[][])redCodeArr.get(0);

%>
<HTML>
<HEAD>
<TITLE>红名单管理</TITLE>

<script language="javascript">
var printFlag=9;
var flag = 0;
var timeFlag = 0;	
onload=function()
{
	self.status="";
	document.all.phoneNo.focus();		
}

function doProcess(packet){
	
	var backString = packet.data.findValueByName("backString");
	var cfmFlag = packet.data.findValueByName("flag");
	
	if(cfmFlag==1)
	{
		var errCode = packet.data.findValueByName("errCode");
		var errMsg = packet.data.findValueByName("errMsg");
		
		var errCodeInt = parseInt(errCode);
		
		if(errCodeInt==0)
		{
			rdShowMessageDialog("操作成功！",2);
			document.frm.backLoginAccept.value=backString[0][0];
			
			//alert(document.frm.handFee.value);
			if(document.frm.handFee.value!=0){
				printBill();
			}
			
			flag=0;
			
			resett();
		}else
		{
			rdShowMessageDialog(errCode + " : " + errMsg,0);
			resett();
			return;
		}
	}
	if(cfmFlag==9){
		//rdShowMessageDialog("该号码不存在！");
		var errCode = packet.data.findValueByName("errCode");
		var errMsg = packet.data.findValueByName("errMsg");
		rdShowMessageDialog(errCode + " : " + errMsg,0);
		
		document.frm.qry.disabled=false;
		document.frm.phoneNo.disabled=false;
		flag=0;
		return;
	}
	if(cfmFlag==0){
		if(backString=="")
		{
			rdShowMessageDialog("查询失败！",0);
			document.frm.qry.disabled=false;
			document.frm.phoneNo.disabled=false;
			document.frm.phoneNo.value="";
		}else
		{
//		if(document.frm.favFlag.value==1){
//			document.frm.submit.disabled=false;
//		}
			document.frm.customPass.value=backString[0][4];
			document.frm.userId.value=backString[0][0];
			document.frm.runName.value=backString[0][6];
			document.frm.cardType.value=backString[0][15];
			document.frm.gradeName.value=backString[0][8];
			document.frm.custAddress.value=backString[0][11];
			document.frm.idCardNo.value=backString[0][14];
			document.frm.totalPrepay.value=backString[0][17];
			document.frm.totalOwe.value=backString[0][16];
			document.frm.custName.value=backString[0][3];
			document.frm.typeName.value=backString[0][24];
			document.frm.cardName.value=backString[0][25];
			document.frm.expireTime.value="20501231";
			if(backString[0][21]==""){
				
				document.frm.opType.options[0].selected=true;
				
				document.frm.expireTime.disabled=false;
				document.frm.redType.disabled=false;
				document.frm.redReason.disabled=false;
				document.frm.opType.disabled=true;	
			}else{
				document.frm.opType.options[1].selected=true;
				document.frm.expireTime.desabled=true;
				document.frm.expireTime.value=backString[0][23].substring(0,8);
				document.frm.redReason.disabled=true;
				document.frm.redReason.value=backString[0][22];
				document.frm.opType.disabled=true;
				var z = 0 ;
				for(z = 0 ; z < document.frm.redType.length ; z ++){
					if(document.frm.redType.options[z].value==backString[0][21]){
						document.frm.redType.options[z].selected=true;
					}
				}
			
			document.frm.redType.disabled=true;

			}
			
			flag=1;
			document.frm.handFee.disabled=false;
			document.frm.factPay.disabled=false;
			if(backString[0][24]=="一类重要客户")
			{
				document.frm.custName.disabled=true;
				document.frm.typeName.disabled=true;
				document.frm.cardName.disabled=true;
				document.frm.remark.disabled=true;
				document.frm.redReason.disabled=true;
				document.frm.expireTime.disabled=true;
				document.frm.submit.disabled=true;
				document.frm.back.disabled=true;
				document.frm.opType.disabled=true;
				rdShowMessageDialog("用户属性为“一类重要客户”，不允许红名单操作！");
			}
		}
	}
}
	
function submitt(){

	if(document.frm.phoneNo.value==""){
		rdShowMessageDialog("请输入手机号码！");
		return;
	}
	if(!checkElement(document.frm.phoneNo)){
		document.frm.phoneNo.value = "";
		return;
	}
	document.frm.qry.disabled=true;
	document.frm.phoneNo.disabled=true;
	var myPacket = new AJAXPacket("getUserInfo.jsp","正在提交，请稍候......");
	myPacket.data.add("workNo",document.frm.workNo.value);
	myPacket.data.add("phoneNo",document.frm.phoneNo.value);
	myPacket.data.add("opCode",document.frm.opCode.value);
	myPacket.data.add("orgCode",document.frm.orgCode.value);
	
	core.ajax.sendPacket(myPacket);
	myPacket=null;
	if(document.frm.typeName.value=="一类重要客户")
	{
		document.frm.submit.disabled=true;
	}else
	{
		document.frm.submit.disabled=false;
	}
}

function getRemain(){

	if(flag!=1)
	{
		rdShowMessageDialog("请先查询用户信息！");
		return;
	}
	
	if(parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value))
	{
		rdShowMessageDialog("手续费不能大于"+document.frm.handFeeT.value);
		return;
	}
	
	document.frm.remain.value=document.frm.factPay.value-document.frm.handFee.value;
}

function submitCfm()
{
	getAfterPrompt();
	if(flag==1)
	{
		var opTypeI = 0 ;
		var opTypeFin = "";
		for(opTypeI = 0 ; opTypeI < document.frm.opType.length ; opTypeI ++)
		{
			if(document.frm.opType.options[opTypeI].selected)
			{
				opTypeFin = document.frm.opType.options[opTypeI].value;
			}
		}
		var redTypeI = 0 ;
		var redTypeFin = "";
		for(redTypeI = 0 ; redTypeI < document.frm.redType.length ; redTypeI ++)
		{
			if(document.frm.redType.options[redTypeI].selected)
			{
				redTypeFin = document.frm.redType.options[redTypeI].value;
			}
		}
		
		var expireTimeValue = "";
		if(!forDate(document.frm.expireTime))
		{
			return;
		}
		if(document.frm.nowDate.value>=document.frm.expireTime.value)
		{
			rdShowMessageDialog("有效期应该大于当前日期");
			return false;
		}
		
		expireTimeValue=document.frm.expireTime.value+" 00:00:00";
		
		if(document.frm.redReason.value.length==0)
		{
			rdShowMessageDialog("请输入加入红名单原因信息！");
			return;
		}
		
		if(!forReal(document.frm.handFee))
		{
			return;
		}
		if(parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)){
			rdShowMessageDialog("手续费不能大于"+document.frm.handFeeT.value);
			return;
		}
		if(document.frm.remark.value.length==0)
		{
			document.frm.remark.value="红名单管理";
		}
		
		//printCommit();
		//if(printFlag!=1){
		//	return;
		//}
		
		var myPacket = new AJAXPacket("f2300Cfm.jsp?phoneNo=<%=phone%>&redReason="+document.frm.redReason.value+"&sysRemark="+document.frm.sysRemark.value+"&remark="+document.frm.remark.value,"正在提交，请稍候......");
		
		myPacket.data.add("loginAccept",document.frm.loginAccept.value);
		myPacket.data.add("opCode",document.frm.opCode.value);
		myPacket.data.add("workNo",document.frm.workNo.value);
		myPacket.data.add("noPass",document.frm.noPass.value);
		myPacket.data.add("orgCode",document.frm.orgCode.value);
		myPacket.data.add("idNo",document.frm.userId.value);
		myPacket.data.add("opType",opTypeFin);
// dujl 修改 at 20090507 **************************************
		myPacket.data.add("redType",document.frm.redType.value);
		//myPacket.data.add("redType",redTypeFin);
		
		myPacket.data.add("expireTime",expireTimeValue);
		myPacket.data.add("handFee",document.frm.handFeeT.value);
		myPacket.data.add("factPay",document.frm.handFee.value);
		
		myPacket.data.add("ipAdd",document.frm.ipAdd.value);		
		
    	core.ajax.sendPacket(myPacket);
		
    	myPacket=null;
	}else{
		rdShowMessageDialog("请先查询用户信息！");
	}
}
	
function verifyPass()
{
	if(flag==1)
	{
		var m = document.frm.inputPass.value;
		var n = document.frm.customPass.value;
     	var myPacket = new AJAXPacket("verifyPass.jsp","正在提交，请稍候......");
		
		myPacket.data.add("inputPass",m);
		myPacket.data.add("customPass",n);
		
    	core.ajax.sendPacket(myPacket);
		myPacket=null;
		
	}else{
    	rdShowMessageDialog("请先查询用户信息！");
	}
}

function resett()
{
	document.frm.customPass.value="";
	
	document.frm.userId.value="";
	
	document.frm.runName.value="";
	
	document.frm.gradeName.value="";
	
	document.frm.idCardNo.value="";				
	
	document.frm.totalPrepay.value="";				
	
	document.frm.totalOwe.value="";
	
	document.frm.custName.value="";		
	
	document.frm.redReason.value="";
	
	document.frm.redReason.disabled=true;
	
	document.frm.qry.disabled=false;
	
	document.frm.phoneNo.disabled=false;
	
	document.frm.submit.disabled=true;
	
	document.frm.custAddress.value="";
	
	document.frm.expireTime.value="";
	
	document.frm.expireTime.disabled=true;
	
	document.frm.cardType.value="";
	
	document.frm.typeName.value="";
	
	document.frm.cardName.value="";
	
	document.frm.remark.value="";
	
	printFlag=9;
	flag=0;
}

</script>
</HEAD>
<body>
<FORM action="" method=post name="frm" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">红名单管理</div>
	</div>
    <table id=tbs9 cellspacing=0>
    <tbody>
		<tr> 
        	<td width="10%" class="blue"> 服务号码</td>
        	<td width="23%">
          		<input id=Text2 type=text size=17 name=phoneNo v_type="mobphone"  maxlength=11 index="0" onKeyUp="if(event.keyCode==13)submitt()" value =<%=phone%>  readonly class="InputGrey">
        		<input  class="b_text" id=Text2 type=button size=17 name=qry value="查询" onclick="submitt()">
        	</td>
            <td width="10%" class="blue"> 客户名称</td>
            <td  width="23%" > 
              	<input id=Text2 type=text size=17 name=custName disabled >
            </td>
            <td width="10%" class="blue">用户I D</td>
            <td  width="23%" > 
              	<input id=Text2 type=text size=17 name=userId disabled >
            </td>
         </tr>
         <tr>
            <td  width="10%" class="blue">当前状态</td>
            <td  width="19%"> 
              	<input  type=text size=17 name=runName disabled >
            </td>
            <td width="10%" class="blue" > 当前预存</td>
            <td  width="23%" >
              	<input id=Text2 type=text size=17 name=totalPrepay disabled >
            </td>
            <td  width="10%" class="blue">当前欠费</td>
            <td  width="19%"> 
              	<input id=Text2 type=text size=17 name=totalOwe disabled >
            </td>
         </tr>
         <tr> 
            <td  width="10%" class="blue">客户属性</td>
            <td  width="19%"> 
              	<input id=typeName type=text size=17 name=typeName disabled >
            </td>
            <td  width="10%" class="blue">VIP客户属性</td>
            <td  width="19%">
              	<input id=cardName type=text size=17 name=cardName disabled >
            </td>
            <td  width="10%" class="blue"> 操作类型</td>
            <td  width="19%"> 
				<select name=opType >
					<option value="A">增加
					</option>
					<option value="D">删除
					</option>
				</select>
            </td>
         </tr>
         <tr> 
        	<td width="16%" class="blue"> 加入红名单原因</td>
        	<td  width="23%" colspan=3> 
              	<input id=Text2 type=text size=59 name=redReason disabled index="4" >
            </td>
            <td  width="10%" class="blue">有效期</td>
            <td  width="28%"> 
            	<input  type=text size=17 maxlength=8 name=expireTime disabled index="3" v_type="date" v_format="yyyyMMdd">
            </td>
          </tr>
    </TBODY> 
	</TABLE>
		 
    <TABLE cellspacing=0 style="display:none">
    <TBODY> 
		<tr> 
			<td width="10%" class="blue">手续费</td>
			<td  width="23%" > 
				<input id=Text2 type=text size=17  name=handFee <%if(feeFlag==0){%>disabled<%}%> value="<%=tHandFee%>" v_type=float >
			</td>
			<td  width="10%" class="blue">实收</td>
			<td  width="19%" > 
				<input  id=Text2 type=text size=17 name=factPay  disabled onKeyUp="if(event.keyCode==13){getRemain()}">&nbsp;
				<input id=Text2 type=button size=17 name=getUseInfo value="-->" onclick="getRemain()">
			</td>
			<td  width="10%" class="blue">找零</td>
			<td  width="28%">
				<input id=Text2 type=text size=17 name=remain disabled >
			</td>
		</tr>
	</TBODY> 
    </TABLE>
        
    <table cellspacing=0>       
		<tr>
            <td class="blue" width="16%">用户备注</td>
            <td>
 				<input id=Text3 type=text size=60 name=remark value="" index="5" class="button">
 	    	</td>
		</tr>
	</table>        

    <TABLE cellspacing=0>
    <TBODY>
		<TR>
			<TD id="footer">
				<input  name=submit  type=button class="b_foot" value="确认" onclick="submitCfm()"  index="6" onKeyUp="if(event.keyCode==13){submitCfm()}">
				&nbsp;&nbsp; 
				<input  name=back  type=button class="b_foot" value="清除" onclick="resett()">
				&nbsp;&nbsp; 
              	<input  name=back1  type=button class="b_foot" value="关闭" onclick="removeCurrentTab()">     
            </TD>
		</TR>
    </TBODY>
	</TABLE>
    <input  type=hidden size=17 name=gradeName  >
    <input  type=hidden name=cardType  class="InputGrey" >
    <input id=redType type=hidden value="03" name=redType >
  	<input type="hidden" name="phoneE" value =<%=phone%>>
	<input type=hidden name=loginAccept value="0">
	<input type=hidden name=opCode value="2300">
	<input type=hidden name=workNo value=<%=(String)session.getAttribute("workNo")%>>
	<input type=hidden name=noPass value=<%=nopass%>>
	<input type=hidden name=orgCode value=<%= (String)session.getAttribute("orgCode")%>>
	<input type=hidden name=sysRemark value="红名单管理">
	<input type=hidden name=ipAdd value="<%=request.getRemoteAddr()%>">
	<input type=hidden name=handFeeT value="<%=tHandFee%>">
	<input type=hidden name=qryFlagT value="">
	<input type=hidden name=customPass>
	<input type=hidden name=idCardNo>
	<input type=hidden name=custAddress>
	<input type=hidden name=backLoginAccept>
	<input type=hidden name=timeFlag value="0">
	<input type=hidden name=nowDate value="<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%><%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%><%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>">
	
<%@ include file="/npage/include/footer.jsp" %>  
</FORM>

<script>

function printBill()
{		
	 var infoStr="";                                                                         
	 infoStr+=document.frm.idCardNo.value+"|";//身份证号码                                                  
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+=document.frm.phoneNo.value+"|";//移动号码                                                   
	 infoStr+="空缺"+"|";//合同号码                                                          
	 infoStr+=document.frm.custName.value+"|";//用户名称                                                
	 infoStr+=document.frm.custAddress.value+"|";//用户地址                                                
	 infoStr+="详单禁查申请。*手续费："+document.frm.handFee.value+"*流水号："+document.frm.backLoginAccept.value+"|";
	 location="chkPrint.jsp?retInfo="+infoStr+"&dirtPage=f2300.jsp?sePhone=<%=phone%>";                    
}
</script>
</BODY>
</HTML>

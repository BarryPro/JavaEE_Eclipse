<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	//取session信息
	ArrayList arr1 = (ArrayList)session.getAttribute("allArr");
	String workNo = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String activePhone1=request.getParameter("activePhone1");
	String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));	
	String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	
	
	String[][]  favInfo = (String[][])session.getAttribute("favInfo");	
	String org_codeT = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String region_codeT = WtcUtil.repNull((String)session.getAttribute("regCode"));

  //取证件类型、证件名称
  String[] inParamsss01 = new String[1];
	inParamsss01[0] = "select id_type,id_name from sidtype";
	%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_codeT%>" retcode="retCode01ss" retmsg="retMsg01ss" outnum="2">			
	<wtc:param value="<%=inParamsss01[0]%>"/>	
	</wtc:service>	
  <wtc:array id="sIdTypeStr" scope="end" />

<%
//取漫游国家代码、国家名称和号码设定费
  String[] inParamsss1 = new String[2];
	inParamsss1[0] = "select hand_fee, favour_code from sNewFunctionFee where region_code =:reg_scode and function_code = '1223'";
	inParamsss1[1] = "reg_scode="+region_codeT;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_codeT%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="2">			
	<wtc:param value="<%=inParamsss1[0]%>"/>
	<wtc:param value="<%=inParamsss1[1]%>"/>	
	</wtc:service>	
  <wtc:array id="fee" scope="end" />
<%

String tHandFee = "0";
int feeFlag = 0;

//判断是否有变更优惠手续费权限
if(fee.length==0){
	tHandFee="0";
	feeFlag = 0;
}
else{
	tHandFee=fee[0][0];
	for(int i = 0 ; i < favInfo.length ; i ++){
		if(favInfo[i][0].trim().equals(fee[0][1])){
			feeFlag = 1;
		}
	}
}

//取漫游国家代码、国家名称和号码设定费
  String[] inParamsss2 = new String[1];
	inParamsss2[0] = "select country_code, country_name, phone_fee from scountrycode";
	%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_codeT%>" retcode="retCode2ss" retmsg="retMsg2ss" outnum="3">			
	<wtc:param value="<%=inParamsss2[0]%>"/>	
	</wtc:service>	
  <wtc:array id="country" scope="end" />
<%
//取租机漫游方式、名称
  String[] inParamsss3 = new String[1];
	inParamsss3[0] = "SELECT rent_type,rent_name FROM sRentTypeName order by rent_type";
 %>
 	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_codeT%>" retcode="retCode3ss" retmsg="retMsg3ss" outnum="2">			
	<wtc:param value="<%=inParamsss3[0]%>"/>	
	</wtc:service>	
  <wtc:array id="roamTypeArr" scope="end" />
<%
//提取租金方式代码、租金方式名称和单位租金
  String[] inParamsss4 = new String[1];
	inParamsss4[0] = "select distinct rent_code,rent_name,rent_fee from srentcode";
 %>
 	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_codeT%>" retcode="retCode4ss" retmsg="retMsg4ss" outnum="3">			
	<wtc:param value="<%=inParamsss4[0]%>"/>	
	</wtc:service>	
  <wtc:array id="rentTypeArr" scope="end" />
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=region_codeT%>"  id="printAccept" />
<HTML><HEAD>
<TITLE>漫游租机续租</TITLE><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!--
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
-->

<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
</HEAD>
<script language="javascript">
var printFlag=9;
var flag = 0;

onload=function(){
	//document.all.phoneNo.focus();

}

function doProcess(packet){	
	var backString = packet.data.findValueByName("backString");	
	var cfmFlag = packet.data.findValueByName("flag");
	
	
	if(cfmFlag==9){
		var errCode = packet.data.findValueByName("errCode");
		var errMsg = packet.data.findValueByName("errMsg");
		//rdShowMessageDialog(errCode + " : " + errMsg);
		rdShowMessageDialog("错误代码：" + errCode + "，错误信息：" + errMsg,0);
		
		//document.frm.phoneNo.value="";
		document.frm.qry.disabled=false;
		// document.frm.phoneNo.disabled=false;
		
		flag=0;
		return;
	}
	
	if(cfmFlag==1){
			flag=0;
			var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");		
			var errCodeInt = parseInt(errCode,10);

			if(errCodeInt==0){
				rdShowMessageDialog("操作成功！",2);
				document.frm.backLoginAccept.value=backString[0][0];
							
				if(document.frm.handFee.value!=0){
					printBill();
				}                        	
				else
				{
					window.location="f1223.jsp?activePhone1=<%=activePhone1%>&opCode=<%=opCode%>&opName=<%=opName%>";
				}
			}else
			{				
				rdShowMessageDialog(errCode + " : " + errMsg);
				window.location="f1223.jsp?activePhone1=<%=activePhone1%>&opCode=<%=opCode%>&opName=<%=opName%>";
				return;
			}							
	}
	
	if(cfmFlag==0){
			var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");	  		
			var moreString = packet.data.findValueByName("moreString");
			var errCodeInt = parseInt(errCode,10);
			
			if(errCodeInt!=0){				
				rdShowMessageDialog(errCode + " : " + errMsg);
				//document.frm.phoneNo.value="";
				document.frm.qry.disabled=false;
				//document.frm.phoneNo.disabled=false;
				
				flag=0;
				return;
			}
			else{

				document.frm.cust_password.value=backString[0][4];
				document.frm.id_no.value=backString[0][0];
				document.frm.run_code.value=backString[0][6];
				document.frm.cust_grade.value=backString[0][8];				
				document.frm.prepay_fee.value=backString[0][17];				
				document.frm.owe_fee.value=backString[0][16];
				document.frm.cardType.value=backString[0][15];
				document.frm.cust_name.value=backString[0][3];
				document.frm.custAddress.value=backString[0][11];
				document.frm.rent_cost.value=moreString[0][19];
				document.frm.getRentTime.value=moreString[0][4];				
				document.frm.preBackTime.value=moreString[0][5];
				document.frm.preBackTimeT.value=moreString[0][5];
				document.frm.begin_time.value=moreString[0][6];
				document.frm.end_time.value=moreString[0][7];
				document.frm.end_timeT.value=moreString[0][7];
				document.frm.mobile_serial.value=moreString[0][9];
				document.frm.mobile_type.value=moreString[0][8];						
				
				document.frm.asCustName.value=moreString[0][21];
				document.frm.asCustPhone.value=moreString[0][22];
				document.frm.asIdIccid.value=moreString[0][24];
				document.frm.asIdAddress.value=moreString[0][25];
				document.frm.asContractAddress.value=moreString[0][26];
				document.frm.asNotes.value=moreString[0][27];							
				
				document.frm.machine_num.value=moreString[0][10];
				document.frm.perMachine_rent.value=moreString[0][11];
				document.frm.battery_num.value=moreString[0][12];
				document.frm.perBattery_rent.value=moreString[0][13];
				document.frm.charger_num.value=moreString[0][14];
				document.frm.perCharger_rent.value=moreString[0][15];
				document.frm.addition_fee.value=moreString[0][23];					
				document.frm.travelName.value=moreString[0][3];
				document.frm.visaName.value=moreString[0][20];	
				document.frm.accountBook.value=moreString[0][16];	
				document.frm.otherComponent.value=moreString[0][17];
				document.frm.rent_phone.value=moreString[0][2];
				document.frm.machine_rent.value=document.frm.machine_num.value*document.frm.perMachine_rent.value;
				document.frm.battery_rent.value=document.frm.battery_num.value*document.frm.perBattery_rent.value;
				document.frm.charger_rent.value=document.frm.charger_num.value*document.frm.perCharger_rent.value;
				document.frm.all_rent.value=parseFloat(document.frm.charger_rent.value)+parseFloat(document.frm.battery_rent.value)+parseFloat(document.frm.machine_rent.value)+parseFloat(document.frm.addition_fee.value);
			
				//担保人证件类型
				var idI = 0 ;
				for(idI = 0 ; idI < document.frm.asIdType.length ; idI ++){			
					if(document.frm.asIdType.options[idI].value==moreString[0][26]){
						document.frm.asIdType.options[idI].selected=true;
						break;
					}
				}
							
				//漫游国家代码
				var i = 0 ;
				for(i = 0 ; i < document.frm.country_code.length ; i ++){
					var countryValue = document.frm.country_code.options[i].value;
					var divFlag = countryValue.indexOf("|",0);
					var fCountryCode = countryValue.substring(0,divFlag);
					var fPhoneFee = countryValue.substring(divFlag+1,countryValue.length);
					if(fCountryCode==moreString[0][0]){
						document.frm.country_code.options[i].selected=true;
						document.frm.setNo_cost.value=fPhoneFee;
						break;
					}
				}
				
				//申请人类别
				var j = 0 ;
		  		for(j = 0 ; j < document.frm.custtype.length ; j ++){
		  			if(document.frm.custtype.options[j].value==moreString[0][1]){
		  				document.frm.custtype.options[j].selected=true;
		  				break;
		  			}
		  		}
		  		
		  		//租金类型
		  		document.frm.rent_type.disabled=true;
				var k = 0 ;
				for(k = 0 ; k < document.frm.rent_type.length ; k ++){
					var rentValue = document.frm.rent_type.options[k].value;
					var divFlag = rentValue.indexOf("|",0);
					var fRentCode = rentValue.substring(0,divFlag);
					var fRentFee = rentValue.substring(divFlag+1,rentValue.length);							
					
					if(fRentCode==moreString[0][18]){
						document.frm.rent_type.options[k].selected=true;
						document.frm.rent_cost.value=fRentFee;
						break;
					}
				}

				//漫游方式
				var l = 0;
				for(l = 0 ; l < document.frm.roam_type.length ; l ++){
					if(moreString[0][22]==document.frm.roam_type.options[l].value){
						document.frm.roam_type.options[l].selected=true;
						break;
					}
				}
								
				//旅行社取机标志
				var m = 0;
				for(m = 0 ; m < document.frm.travelFlag.length ; m ++){
					if(moreString[0][21]==document.frm.travelFlag.options[m].value){
						document.frm.travelFlag.options[m].selected=true;
						break;
					}
				}
							  	
				flag=1;
				return;
			}
	}
}

//根据服务号码提取租机信息
function submitt(){

      
      if(!checkElement(document.frm.phoneNo)){
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
			myPacket = null;		
}

//获得找零金额
function getRemain(){
	if(flag!=1){
		rdShowMessageDialog("请先查询用户信息！");
		return;
	}

	if(parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)){
		rdShowMessageDialog("手续费不能大于"+document.frm.handFeeT.value);
		return;
	}

	document.frm.remain.value=document.frm.factPay.value-document.frm.handFee.value;
}

//确认处理
function submitCfm(){
	if(flag==1){
		document.frm.systemNote.value="号码"+document.frm.phoneNo.value+"漫游租机变更,手续费:"+document.frm.handFee.value;
		if(document.frm.opNote.value.length==0){
			document.frm.opNote.value=document.frm.phoneNo.value+"办理漫游租机变更,漫游号码为"+document.frm.rent_phone.value;
		}
			
		if(validTotalDate(document.frm.end_time)==false){
			return;
		}
		if(validTotalDate(document.frm.preBackTime)==false){
			return;
		}
		var fDate = to_date(document.frm.end_timeT);
		var bDate = to_date(document.frm.end_time);
		if(bDate<=fDate){
			rdShowMessageDialog("续租业务关闭时间应该迟于初始业务关闭时间");
			return;
		}
		var fDate1 = to_date(document.frm.preBackTimeT);
		var bDate1 = to_date(document.frm.preBackTime);
		if(bDate1<=fDate1){
			rdShowMessageDialog("续租还机时间应该迟于初始还机时间");
			return;
		}		
						

		if(!forFloat(document.frm.handFee)){
			return;
		}

		if(parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)){
			rdShowMessageDialog("手续费不能大于"+document.frm.handFeeT.value);
			return;
		}
		
		printCommit();
		if(printFlag!=1){
			return;
		}
		
		//document.frm.submit.disabled=true;
		var myPacket = new AJAXPacket("f1223Cfm.jsp?asCustName="+document.frm.asCustName.value+"&asCustPhone="+document.frm.asCustPhone.value+"&asIdIccid="+document.frm.asIdIccid.value+"&asIdAddress="+document.frm.asIdAddress.value+"&asContractAddress="+document.frm.asContractAddress.value+"&asNotes="+document.frm.asNotes.value+"&systemNote="+document.frm.systemNote.value+"&opNote="+document.frm.opNote.value,"正在提交，请稍候......");
		myPacket.data.add("loginAccept",document.frm.loginAccept.value);
		myPacket.data.add("opCode",document.frm.opCode.value);
		myPacket.data.add("workNo",document.frm.workNo.value);
		myPacket.data.add("asIdType",document.frm.asIdType.value);
		myPacket.data.add("noPass",document.frm.noPass.value);
		myPacket.data.add("orgCode",document.frm.orgCode.value);
		myPacket.data.add("idNo",document.frm.id_no.value);
		myPacket.data.add("returnTime",document.frm.preBackTime.value);
		myPacket.data.add("closeTime",document.frm.end_time.value);
		myPacket.data.add("chandFee",document.frm.handFeeT.value);
		myPacket.data.add("handFee",document.frm.handFee.value);		
		myPacket.data.add("ipAddr",document.frm.ipAdd.value);
			core.ajax.sendPacket(myPacket);
			myPacket = null;	
    	}
    	else
    	{
    		rdShowMessageDialog("请先查询用户信息！");
    	}
}

//密码验证
function verifyPass(){
	if(flag==1){
		var m = document.frm.inputPass.value;
		var n = document.frm.cust_password.value;
        	
		var myPacket = new AJAXPacket("verifyPass.jsp","正在提交，请稍候......");
		
		myPacket.data.add("inputPass",m);
		myPacket.data.add("customPass",n);
				
			core.ajax.sendPacket(myPacket);
			myPacket = null;
		
	}
	else
	{
    		rdShowMessageDialog("请先查询用户信息！");
	}
}

</script>
<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">

<FORM action="" method=post name="frm" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>  
<div class="title">

	<div id="title_zi">用户信息</div>

</div>			
   
       <table cellspacing=0>

       
              <tr > 
            <td  class="blue">服务号码</td>
            <td colspan="5"> 
              <input class=InputGrey readOnly
            id=Text2 type=text size=13 name=phoneNo  index="0" v_type="mobphone" value=<%=activePhone1%> v_name="移动号码" maxlength=11 onKeyUp="if(event.keyCode==13)submitt()">
            <input class=b_text type=button name=qry value="查询" onclick=submitt()>
            </td>
             
           
          </tr>
          <tr > 
            <td class="blue">用户I D </td>
            <td > 
              <input class=button type="text" name="id_no" disabled >            </td>
            <td class="blue">当前状态</td>
            <td > 
              <input class=button type="text" name="run_code" disabled >            </td>
            <td  class="blue">级别 </td>
            <td  > 
              <input class=button type="text" name="cust_grade" disabled >            </td>
          </tr>
          <tr > 
            <td   class="blue">当前预存 </td>
            <td  > 
              <input class=button type="text" name="prepay_fee" disabled >
            </td>
            <td   class="blue">当前欠费 </td>
            <td  > 
              <input class=button type="text" name="owe_fee" disabled >
            </td>
            <td   class="blue">大客户标志</td>
            <td  > 
              <input class="text_redFat" type=text size=17 name=cardType readonly >
            </td>
          </tr>
          <tr > 
            <td class="blue">客户名称 </td>
            <td  > 
              <input class=button type="text" name="cust_name" disabled >            </td>
            <td colspan="2"  >&nbsp;</td>
            <td colspan="2" >&nbsp;</td>
          </tr>

        </table>
	</div>

<div id="Operation_Table">
<div class="title">
	<div id="title_zi">业务信息</div>
</div>
	  
        <TABLE  cellSpacing=0 >

          <tr > 
            <td  class="blue">漫游国家 </td>
            <td > 
              <select name="country_code" onchange="getPhoneFee()" disabled >
			  	<option value="">请查询</option>
                <%for(int i = 0 ; i < country.length ; i ++){%>
                <option value="<%=country[i][0]%>|<%=country[i][2]%>"><%=country[i][1]%></option>
                <%}%>
              </select>
            </td>
            <td  colspan="2" class="blue">申请人类别 </td>
            <td  colspan="3"> 
              <select name="custtype" disabled >
                <option value="0">个人</option>
                <option value="1">单位</option>
                <option value="2">委托</option>
              </select>
            </td>
          </tr>
          <tr > 
            <td  class="blue">漫游方式 </td>
            <td  > 
              <select name="roam_type" disabled index="3">
			  <option value="">请查询</option>
                <%for(int i = 0 ; i < roamTypeArr.length ; i ++){%>
                <option value="<%=roamTypeArr[i][0]%>"><%=roamTypeArr[i][1]%></option>
                <%}%>
              </select>            </td>
            <td colspan="2" class="blue">漫游号码 </td>
            <td colspan="3" > 
              <div id=rentPhoneDiv> 
                <input class=button name="rent_phone" type=text disabled >
              </div>            </td>
          </tr>
          <tr  id=travelDiv style="display=''"> 
            <td  class="blue">旅行社取机标志 </td>
            <td > 
            <select name=travelFlag disabled >
            <option value=0>否</option>            
            <option value=1>是</option>
            </select>            </td>
            <td colspan="2" class="blue">旅行社名称 </td>
            <td colspan="3" > 
              <input class=button type="text" name="travelName" value="无信息" disabled index="7" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">            </td>
          </tr>
          <tr  style="display=''"> 
            <td class="blue">护照号码： </td>
            <td  colspan="6" > 
              <input class=button type="text" name="visaName" index="7" disabled onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">            </td>
          </tr> 
          <tr > 
            <td class="blue">取机时间 </td>
            <td > 
              <input class=button type="text" name="getRentTime" disabled >
            </td>
            <td  colspan="2" class="blue">预计还机时间 </td>
            <td  colspan="3"> 
              <input class=button type="text" name="preBackTime" disabled>
            </td>
          </tr>
          <tr > 
            <td  class="blue">业务开通时间 </td>
            <td  > 
              <input class=button type="text" name="begin_time" disabled >            </td>
            <td colspan="2" class="blue">业务关闭时间 </td>
            <td colspan="3" > 
              <input class=button type="text" name="end_time" disabled>            </td>
          </tr>
          <tr > 
            <td  class="blue">移动电话序列号 </td>
            <td > 
              <input class=button type="text" name="mobile_serial" value="" disabled >
            </td>
            <td  colspan="2" class="blue">移动电话型号 </td>
            <td  colspan="3"> 
              <input class=button type="text" name="mobile_type" value="" disabled >
            </td>
          </tr>
          <tr > 
            <td  class="blue">机身数量 </td>
            <td  > 
              <input class=button type="text" name="machine_num" disabled >            </td>
            <td class="blue">机身押金/单位 </td>
            <td  > 
              <input class=button type="text" name="perMachine_rent" value="" disabled >            </td>
            <td  class="blue">总计
            </td>
            <td  > 
              <input class=button type="text" name="machine_rent" disabled >            </td>
          </tr>
          <tr > 
            <td  class="blue">电池数量 </td>
            <td > 
              <input class=button type="text" name="battery_num" disabled >
            </td>
            <td  colspan="2" class="blue">电池押金/单位 </td>
            <td > 
              <input class=button type="text" name="perBattery_rent" value="" disabled >
            </td>
            <td  nowrap class="blue">总计 
            </td>
            <td align=left> 
              <input class=button type="text" name="battery_rent" disabled >
            </td>
          </tr>
          <tr > 
            <td  class="blue">充电器数量 </td>
            <td  > 
              <input class=button type="text" name="charger_num" disabled >            </td>
            <td colspan="2"  nowrap class="blue">充电器押金/单位 </td>
            <td > 
              <input class=button type="text" name="perCharger_rent" value="" disabled >            </td>
            <td  nowrap class="blue">总计
            </td>
            <td>
              <input class=button type="text" name="charger_rent" disabled >            </td>
          </tr>
          <tr > 
            <td  class="blue">说明书数量 </td>
            <td  > 
              <input class=button type="text" name="accountBook" disabled >            </td>
            <td  colspan="2"  nowrap class="blue">其他租用附件 </td>
            <td  align=left> 
              <input class=button type="text" name="otherComponent" disabled >            </td>
            <td   class="blue">总计
            </td>          
            <td >
              <input class=button type="text" name="addition_fee" disabled >            </td>             
          </tr>
		  <tr style="display:none">
          <td   nowrap class="blue"> 担保人名称</td>
            <td  > 
              <input class=button 
            id=Text2 type=text size=17 name=asCustName maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
           
            <td   colspan="2" nowrap class="blue">担保人联系电话</td>
            <td  > 
              
              <input class=button 
            id=Text2 type=text size=17 name=asCustPhone maxlength=20  >
            
            </td>
                 
            <td   class="blue">联系地址</td>
            <td   colspan=2> 
              
              <input class=button 
            id=Text2 type=text size=17 name=asContractAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            
            </td>
          </tr>
          <tr  style="display:none"> 
            
            <td  nowrap class="blue"> 担保人证件类型</td>
            <td  > 
              <select size=1 name=asIdType  >
              <%for(int i = 0 ; i < sIdTypeStr.length ; i ++){%>
              <option value="<%=sIdTypeStr[i][0]%>"><%=sIdTypeStr[i][1]%></option>
              <%}%>
              </select>
            </td>
            
            
            <td  colspan="2" nowrap class="blue">证件号码</td>
            <td  > 
              
              <input class=button 
            id=Text2 type=text size=17 name=asIdIccid  maxlength=20>
            
            </td>
           
            <td   nowrap class="blue">证件地址</td>
            <td  colspan=2> 
              
              <input class=button 
            id=Text2 type=text size=17 name=asIdAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            
            </td>
          </tr>
          
          <tr style="display:none"> 
            
            <td  class="blue"> 担保备注</td>
            <td  > 
              <input class=button 
            id=Text2a type=text size=30 name=asNotes  maxlength=30 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>

          </tr>
          <tr > 
            <td class="blue">号码设定费 </td>
            <td  > 
              <input class=button type="text" name="setNo_cost" value="<%=country[0][2]%>" disabled >            </td>
            <td colspan="2"  class="blue">押金合计
            </td>
            <td colspan="3"  > 
              <input class=button type="text" name="all_rent" value=0 disabled >            </td>            
          </tr>
          <tr > 
            <td class="blue">月租类型 </td>
            <td > 
              <select name="rent_type"  disabled >
			  	<option value="">--请查询--</option>
                <%for(int i = 0 ; i < rentTypeArr.length ; i ++){%>
                <option value="<%=rentTypeArr[i][0]%>|<%=rentTypeArr[i][2]%>"><%=rentTypeArr[i][1]%></option>
                <%}%>
              </select>
            </td>
            <td align=left colspan="2" class="blue">单位租金</td>
            <td align=left colspan="3"> 
              <input class=button type="text" name="rent_cost"  value="<%=rentTypeArr[0][2]%>" disabled >
            </td>
          </tr>
          <tr style="display:none" > 
            <td  class="blue">手续费 </td>
            <td > 
              <input class=button type="text" index="4" name="handFee" <%if(feeFlag==0){%>disabled<%}%> value="<%=tHandFee%>" v_type=float v_name="手续费">
            </td>
            <td  class="blue">实收</td>
            <td > 
              <input class=button type="text" index="5" onKeyUp="if(event.keyCode==13){getRemain()}" name="factPay" size=6>
              
            </td>
            <td ><input class=button 
            id=Text2 type=button size=17 name=getUseInfo value="-->" onClick="getRemain()">&nbsp;找零
              <input class=button type="text" name="remain" size=6>
            </td>
            <td  colspan="3">&nbsp;</td>
          </tr>
           <tr style="display:none"> 
            <td colspan="7" class="blue">系统备注 
              <input class=button type="text" name="systemNote" size="60" index="23" onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
          </tr>
		  <tr style="display:none" > 
		   <td  colspan="7" class="blue">操作备注<input class=button 
            id=Text2 type=text size=60 name=opNote  maxlength=30 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
			</tr>
		
          <TR id="footer">

        <TD colspan=6>

          
            <input class="b_foot" name=cancel  type=button value=清除 id=Button2 onClick="window.location='f1223.jsp?activePhone1=<%=activePhone1%>&opCode=<%=opCode%>&opName=<%=opName%>'">

            <input class="b_foot" name=back13  type=button value=关闭 id=Button2 onClick="removeCurrentTab()">

        </TD>

    </TR>
  
  </table>
  <hr size=1 width="100%">
<input type=hidden name=workNo value=<%=loginNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=orgCode value=<%=org_codeT%>>
<input type=hidden name=ipAdd value="<%=request.getRemoteAddr()%>">
<input type=hidden name=loginAccept value="0">
<input type=hidden name=opCode value="<%=opCode%>">
<input type=hidden name=handFeeT value="<%=tHandFee%>">
<input type=hidden name=fRentCode value=<%=rentTypeArr[0][0]%>>
<input type=hidden name=fCountryCode value="<%=country[0][0]%>">
<input type=hidden name=fCustTypeValue value="">
<input type=hidden name=fRoamTypeValue value="">
<input type=hidden name=fRentPhoneValue value="">
<input type=hidden name=cust_password value="">
<input type=hidden name=preBackTimeT value="">
<input type=hidden name=end_timeT value="">
<input type=hidden name=idCardNo>
<input type=hidden name=custAddress>
<input type=hidden name=backLoginAccept>
<%@ include file="../../include/remark.htm" %>

<%@ include file="/npage/include/footer.jsp" %>


</FORM>

<script>

function printCommit()
{          
	// in here form check
	showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");  	 
}

function showPrtDlg(printType,DlgMessage,submitCfn)
{  //显示打印对话框 
   var h=150;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var printStr = printInfo(printType);
/*
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
     var path = "<%=request.getContextPath()%>/npage/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
     var path = path + "&printInfo=" + printStr + "&submitCfn=" + submitCfn;
     var ret=window.showModalDialog(path,"",prop);
   */  
       var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=printAccept%>;             	//流水号
	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=null;           							  //资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		  //小区代码
	var opCode="<%=opCode%>" ;                   			 	//操作代码
	var phoneNo=document.all.phoneNo.value;        //客户电话
	
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
		path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+phoneNo+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);

	ret="confirm";
   if(typeof(ret)!="undefined")
   {
     if((ret=="confirm")&&(submitCfn == "Yes"))
     {
       if(rdShowConfirmDialog('确认要进行此项服务吗吗？')==1)
       {
       	printFlag=1;
       }
     }
   }
}




function printInfo(printType)
{
    var retInfo = "";
    if(printType == "Detail")
    {
    	var cust_info="";  				//客户信息
		var opr_info="";   				//操作信息
		var note_info1=""; 				//备注1
		var note_info2=""; 				//备注2
		var note_info3=""; 				//备注3
		var note_info4=""; 				//备注4
		 retInfo = "";  				//打印内容
  

//	opr_info+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
//	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="手机号码："+document.all.phoneNo.value+"|";
	cust_info+="客户姓名："+document.all.cust_name.value+"|";
	cust_info+="客户地址："+document.all.custAddress.value+"|";
	cust_info+="证件号码："+document.all.idCardNo.value+"|";

		opr_info+="业务类型："+"异制租机续租"+"|";
	opr_info+="手续费："+document.frm.handFee.value+"|";
	opr_info+="流水："+document.frm.backLoginAccept.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	note_info1+=document.all.systemNote.value+"|";
	note_info1+=document.all.opNote.value+"|";

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	

    }  
    if(printType == "Bill")
    {	//打印发票
    }
    return retInfo;	
}
</script>
<script>
function printBill(){
	 var infoStr="";
	 var phondes=document.frm.phoneNo.value;
   var loginaccd =document.frm.backLoginAccept.value;
     
     			var infoStr="";
			 infoStr+='<%=loginNo%>'+"  "+document.frm.backLoginAccept.value+"  "+"异制租机续租"+"|";
			infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
			infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+=document.frm.cust_name.value+"|";//用户名称
			infoStr+=""+"|";//合同号码
			infoStr+=document.frm.phoneNo.value+"|";//移动号码
			infoStr+="document.frm.handFee.value"+"|";
			infoStr+="异制租机续租。手续费："+document.frm.handFee.value+"|";
			
			infoStr+="备注："+"用户 "+document.frm.phoneNo.value+" 打印发票"+"|";
			infoStr+=" "+"|";//小写 
			infoStr+=" "+"|";//收款人  
			infoStr+="<%=loginName%>"+"|";//开票人
			location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=<%=opCode%>&loginAccept="+loginaccd+"&dirtPage=<%=request.getContextPath()%>/npage/s1226/f1223.jsp?activePhone1=<%=activePhone1%>&opCode=<%=opCode%>&opName=<%=opName%>";              
}
</script>
</BODY></HTML>
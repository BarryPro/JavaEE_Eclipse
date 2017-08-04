
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-5
********************/
%>
              
<%
  String opCode = "2417";
  String opName = "用户积分修改";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 


<%@ page contentType= "text/html;charset=gb2312" %>

<%@ page import="com.sitech.boss.f2417.ejb.*"%>
<%@ page import="com.sitech.boss.f2417.wrapper.*"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sitech.boss.pub.util.*" %>

<%
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String nopass = (String)session.getAttribute("password");
	String rightCode = (String)session.getAttribute("rightCode");
	String[][] favInfo = (String[][])session.getAttribute("favInfo");
	String region_codeT = (String)session.getAttribute("regCode");
	String orgCode =(String)session.getAttribute("orgCode");
	String phoneNoGp = (String)request.getParameter("activePhone");
	
	String sqIdtype = "select id_type,id_name from sidtype";
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=region_codeT%>">
  	 <wtc:sql><%=sqIdtype%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>
	 	
	 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=region_codeT%>"  id="seq"/>

<%

//ArrayList sIdTypeArr = co.spubqry32("2",sqIdtype);
String[][] sIdTypeStr = result_t1;

int favFlag = 0 ;
for(int i = 0 ; i < favInfo.length ; i ++){
	if(favInfo[i][0].trim().equals("a272")){
		favFlag = 1;
	}

}

%>
<%

//ArrayList arr = F2417Wrapper.getFuncFee(region_codeT);
String[][]fee = new String [][]{};
String SqlStr = "select function_code, hand_fee from sNewFunctionFee where function_code ='2417' and region_code ='" + region_codeT +"'" ;
System.out.println(SqlStr);
//ArrayList arr = co.spubqry32("2", SqlStr);

%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=region_codeT%>">
  	 <wtc:sql><%=SqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t3" scope="end"/>

<%
if(result_t3 != null)
{
fee = result_t3; 
}  
//System.out.println(fee.length);
String tHandFee = "0";
int feeFlag = 0;
if(fee.length==0){
tHandFee="0";
feeFlag = 0;
}else{
tHandFee=fee[0][1];
}

String[][]high = new String [][]{};
String SqlStr1 = "select count(*) from shighlogin where op_code ='2417' and login_no ='" + workNo +"'" ;
String SqlStr22 = "select add_point from spointmonthcfg where region_code='"+region_codeT+"' ";
String SqlStr221 = "select distinct sum(b.points) from  dloginmsg a, wmarktransopr b where a.login_no = b.login_no and substr(a.org_code,1,2) = '"+region_codeT+"'   and to_char(b.op_time, 'yyyymm') = to_char(sysdate, 'yyyymm') and b.op_code = '2417'";
					
					
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=region_codeT%>">
  	 <wtc:sql><%=SqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>
	 	
	 	<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg31" retcode="code31" routerKey="region" routerValue="<%=region_codeT%>">
  	 <wtc:sql><%=SqlStr22%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t211" scope="end"/>
	 	
	 	<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg312" retcode="code312" routerKey="region" routerValue="<%=region_codeT%>">
  	 <wtc:sql><%=SqlStr221%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t222" scope="end"/>

<%

String regCodegp2="0";
if(result_t222!=null && result_t222.length>0)
{
 regCodegp2 = result_t222[0][0];
}
String regCodegp3="0";
if(result_t211!=null && result_t211.length>0)
{
 regCodegp3 = result_t211[0][0];
}

System.out.println(SqlStr1);
//ArrayList arrhig = co.spubqry32("1", SqlStr1);
if(result_t2!=null)
{
high = result_t2; 
System.out.println("powerpowerpowerpowerpower="+high[0][0]);
}  


String ph_no = request.getParameter("ph_no");

String sql_select2 = "select mark_code,mark_name from dbcustadm.smarktype where mark_flag='0' order by  mark_name desc ";
boolean pwrf = false;
String pubOpCode = opCode;
%>
	<wtc:service name="TlsPubSelBoss" outnum="2">
		<wtc:param value="<%=sql_select2%>"/>
	</wtc:service>
	<wtc:array id="result_type" scope="end"/>
<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>		
<%
/**
		20130219gaopeng修改，新增查询当前输入的手机号码的归属地市与当前登录工号的归属地市，不允许跨地市办理该业务(工号aaa8zy除外)
		start
**/
		String sqlregC= "select trim(b.region_code) from dcustmsg a,dcustdoc b where a.cust_id=b.cust_id and a.phone_no='"+phoneNoGp+"'";
 
%>		
<wtc:service name="TlsPubSelBoss" outnum="1">
		<wtc:param value="<%=sqlregC%>"/>
	</wtc:service>
	<wtc:array id="result_sqlregC" scope="end"/>
		

<%
String regCodegp="00";

if(result_sqlregC.length>0 )
{
		regCodegp=result_sqlregC[0][0];
}
/**
		20130219gaopeng修改，新增查询当前输入的手机号码的归属地市与当前登录工号的归属地市，不允许跨地市办理该业务(工号aaa8zy除外)
		end
**/
%>


<HTML><HEAD>
<TITLE>用户积分修改
</TITLE><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">


<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%@ include file="../../npage/common/pwd_comm.jsp" %>
<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
</HEAD>
<script language="javascript">
var printFlag=9;
var flag = 0;
onload=function(){
	
	self.status="";
	document.all.phoneNo.focus();
	/**
		20130219gaopeng修改，新增查询当前输入的手机号码的归属地市与当前登录工号的归属地市，不允许跨地市办理该业务(工号aaa8zy除外)
		start
	**/
	/*alert("<%=regCodegp%>|haha");*/
	//alert("<%=pwrf%>");
	if("<%=region_codeT%>"!="<%=regCodegp%>" && "aaa8zy"!="<%=workNo%>"&& "200201"!="<%=workNo%>")
	{
		rdShowMessageDialog("跨地市不允许进行积分修改！",0);
		removeCurrentTab();
	}
	
	
	/**
		20130219gaopeng修改，新增查询当前输入的手机号码的归属地市与当前登录工号的归属地市，不允许跨地市办理该业务(工号aaa8zy除外)
		end
	**/
}
function doProcess(packet){
	var backString = packet.data.findValueByName("backString");
	var cfmFlag = packet.data.findValueByName("flag");
	/*alert(backString+"--"+cfmFlag);*/
	
		
	if(cfmFlag==99){
		if(backString==1){
			rdShowMessageDialog("验证成功！",2);
			document.frm.custName.value = document.frm.custNameHide.value;
			document.frm.submit.disabled=false;
			
		}else{
			rdShowMessageDialog("密码不正确！",0);
			document.frm.submit.disabled=true;
		}
	}
	/*调用s2417Cfm回调函数*/
	if(cfmFlag==1){
			var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");
			/*alert(errCode+"--"+errMsg);*/
			var errCodeInt = parseInt(errCode);
			if(errCodeInt==0){
				rdShowMessageDialog("操作成功！",2);
				document.frm.backLoginAccept.value=backString[0][0];
				
			
				if(document.frm.handFee.value!=0){
					printBill();
				}else{
					window.location="f2417.jsp?ph_no="+document.all.phoneNo.value+"&activePhone="+document.all.phoneNo.value;
				}
			}else{
				
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
		//document.frm.phoneNo.value="";
				document.frm.qry.disabled=false;
				document.frm.phoneNo.disabled=false;
				flag=0;
				return;
	}
	if(cfmFlag==0){
	if(backString==""){
		rdShowMessageDialog("查询失败！",0);
		document.frm.qry.disabled=false;
		document.frm.phoneNo.disabled=false;
		document.frm.phoneNo.value="";
	}else{
	if(document.frm.favFlag.value==1){
		document.frm.submit.disabled=false;
	}
		document.frm.customPass.value=backString[0][4];
	
	document.frm.userId.value=backString[0][0];
	
	document.frm.runName.value=backString[0][6];
	
	document.frm.cardType.value=backString[0][15];
	
	document.frm.gradeName.value=backString[0][8];
	
	document.frm.custAddress.value=backString[0][11];
		document.frm.idCardNo.value=backString[0][14];
	
	document.frm.totalPrepay.value=backString[0][18];    //--17
		document.frm.totalOwe.value=backString[0][17]; //--16
	if("<%=pwrf%>"=="true"){
		var custNameA = backString[0][3];
		//alert(custNameA);
		var custNameCut = custNameA.substring(1,custNameA.length);
		var replaceN = "";
		if(custNameA.length - 1 == 1){
			replaceN = "*";
		}
		else if(custNameA.length - 1 == 2){
			replaceN = "**";
		}
		else if(custNameA.length - 1 == 3){
			replaceN = "***";
		}
		else{
			replaceN = "*";
		}
		//alert(replaceN+"---11");
		custNameA = custNameA.replace(custNameCut,replaceN);
		document.frm.custName.value=custNameA;
		document.frm.custNameHide.value=backString[0][3];
	}else if("<%=pwrf%>"=="false"){
			document.frm.custName.value=backString[0][3];
			document.frm.custNameHide.value=backString[0][3];
		}
	
	
	
   	document.frm.initPoint.value=backString[0][21];
   	
   	document.frm.currentPoint.value=backString[0][22];
   	
   	document.frm.yearPoint.value=backString[0][23];
   	
   	document.frm.addPoint.value=backString[0][24];
   	
   	document.frm.totalUsed.value=backString[0][25];
   	
   	document.frm.totalPrize.value=backString[0][26];
   	
   	document.frm.totalPunish.value=backString[0][27];
   	
   	document.frm.lastYearPoint.value=backString[0][28];
   	document.frm.asCustName.value=backString[0][30];
		document.frm.asCustPhone.value=backString[0][31];
		
		
		var idI = 0 ;
		for(idI = 0 ; idI < document.frm.asIdType.length ; idI ++){
			
			if(document.frm.asIdType.options[idI].value==backString[0][32]){
				document.frm.asIdType.options[idI].selected=true;
			}
		}
		document.frm.asIdIccid.value=backString[0][33];
		document.frm.asIdAddress.value=backString[0][34];
		document.frm.asContractAddress.value=backString[0][35];
		//alert(backString[0][36]);
		document.frm.asNotes.value=backString[0][36];
   	document.frm.basePoint.value=backString[0][29];
   	
	flag=1;
	
	document.frm.handFee.disabled=false;
	document.frm.factPay.disabled=false;
	
	}
}
	
}
function submitt(){
      if(document.frm.phoneNo.value==""){
      	rdShowMessageDialog("请输入手机号码！",0);
      	return;
      }
      if(!checkElement(document.frm.phoneNo)){
			document.frm.phoneNo.value = "";
			return;
	}
      if(<%=high[0][0]%> ==0){
      	rdShowMessageDialog("此工号没有操作权限！",0);
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
			myPacket= null;
			
		
}
	function getRemain()
	{

		if(flag!=1){
		rdShowMessageDialog("请先查询用户信息！",0);
		return;
		}
		
		
		if(parseFloat(document.frm.handFee.value) < parseFloat(document.frm.factPay.value)){
			rdShowMessageDialog("手续费不能大于"+document.frm.handFee.value,0);
			return;
		}
		
		document.frm.remain.value=document.frm.factPay.value-document.frm.handFee.value;
	}
function submitCfm(){

	getAfterPrompt();
	if(flag==1){
		if($("#startCust").val().length == 0 || $("#endCust").val().length == 0 ){
			rdShowMessageDialog("请输入开始结束时间！",0);
			return false;
		}
		if(document.frm.remark.value.length==0){
			document.frm.remark.value="用户积分修改";
		}	
		
		if(!forReal(document.frm.handFee)){
				return;
			}
			if(!forNonNegInt(document.frm.inpPoint)){
			return false;
		}
		var inputPoint = parseInt(document.frm.inpPoint.value);
		if(document.frm.inpPoint.value.length==0){
			rdShowMessageDialog("请输入赠送积分.",0);
			return false;
		}
		if(!checkElement(document.frm.inpPoint)){
			return false;
		}
		if(inputPoint == 0){
			rdShowMessageDialog("赠送积分不得为零！",0);
			return false;
		}
		
		/*alert("<%=regCodegp%>---"+"<%=regCodegp2%>---"+"<%=regCodegp3%>");*/
		var monthAddPoints = "<%=regCodegp2%>".length>0 ? "<%=regCodegp2%>" : "0";
		var cfgPoints = "<%=regCodegp3%>".length>0 ? "<%=regCodegp3%>" : "0";
		/*alert(monthAddPoints);*/
		/*alert(cfgPoints);*/
		/*2013/2/22 星期五 10:58:55 gaopeng 新增逻辑判断，工号归属地市的 当月累计修改积分值 加上 当前修改的积分值 之和 与 配置表里的积分值 做对比*/
		if( monthAddPoints != "0" && cfgPoints != "0")
		{
			var regpointAll = parseInt(monthAddPoints);
			var regpointcfg = parseInt(cfgPoints);
			var regpoints = regpointAll + inputPoint;
			if(regpoints-regpointcfg>0)
			{
				rdShowMessageDialog("该地市本月允许修改积分上限为"+regpointcfg+"积分，目前已修改"+regpoints+"积分，已超过积分修改上限不允许办理!",0);
				return false;
			}
			
		}
		var idJ = 0 ;
			var inputIdType = 0;
			for(idJ = 0 ; idJ < document.frm.asIdType.length ; idJ ++){
				if(document.frm.asIdType.options[idJ].selected==true){
					inputIdType = document.frm.asIdType.options[idJ].value;
				}
			}
		if(parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)){
			rdShowMessageDialog("手续费不能大于"+document.frm.handFeeT.value,0);
			return;
		}
			printCommit();
			if(printFlag!=1){
				return;
			}
			document.frm.submit.disabled=true;
			var myPacket = new AJAXPacket("f2417Cfm.jsp?asCustName="+document.frm.asCustName.value+"&asCustPhone="+document.frm.asCustPhone.value+"&asIdIccid="+document.frm.asIdIccid.value+"&asIdAddress="+document.frm.asIdAddress.value+"&asContractAddress="+document.frm.asContractAddress.value+"&asNotes="+document.frm.asNotes.value+"&sysRemark="+document.frm.sysRemark.value+"&remark="+document.frm.remark.value,"正在提交，请稍候......");
			
			myPacket.data.add("loginAccept",document.frm.loginAccept.value);
			myPacket.data.add("opCode",document.frm.opCode.value);
			myPacket.data.add("workNo",document.frm.workNo.value);
			myPacket.data.add("noPass",document.frm.noPass.value);
			myPacket.data.add("asIdType",inputIdType);
			myPacket.data.add("orgCode",document.frm.orgCode.value);
			myPacket.data.add("phoneNo",document.frm.phoneNo.value);
			myPacket.data.add("addPoint",document.frm.inpPoint.value);
			myPacket.data.add("handFee",document.frm.handFeeT.value);
			myPacket.data.add("factPay",document.frm.handFee.value);
			myPacket.data.add("jifentype",document.frm.jifentype.value);
	
			myPacket.data.add("ipAdd",document.frm.ipAdd.value);
			
			
			myPacket.data.add("startCust",document.frm.startCust.value);
			myPacket.data.add("endCust",document.frm.endCust.value);

	    	core.ajax.sendPacket(myPacket);
	    	myPacket = null;
	    	}else{
	    		rdShowMessageDialog("请先查询用户信息！",0);
	    	}
    	
	}
function verifyPass(){
	if(flag==1){
		var m = document.frm.inputPass.value;
		var n = document.frm.customPass.value;
        	var myPacket = new AJAXPacket("verifyPass.jsp","正在提交，请稍候......");
		
		myPacket.data.add("inputPass",m);
		myPacket.data.add("customPass",n);
		
		
    	core.ajax.sendPacket(myPacket);

    	myPacket = null;
		
		
	}else{
    		rdShowMessageDialog("请先查询用户信息！",0);
	}

}
function resett(){
document.frm.asCustName.value="";
document.frm.asCustPhone.value="";
document.frm.asIdType.options[0].selected=true;
document.frm.asIdIccid.value="";
document.frm.asIdAddress.value="";
document.frm.asContractAddress.value="";
document.frm.asNotes.value="";
document.frm.customPass.value="";
document.frm.inputPass.value="";
document.frm.userId.value="";
document.frm.runName.value="";
document.frm.gradeName.value="";
document.frm.idCardNo.value="";				
document.frm.totalPrepay.value="";				
document.frm.totalOwe.value="";
document.frm.custName.value="";
document.frm.qry.disabled=false;
document.frm.phoneNo.disabled=false;
document.frm.submit.disabled=true;
document.frm.custAddress.value="";
   	document.frm.initPoint.value="";
   	document.frm.currentPoint.value="";
   	document.frm.yearPoint.value="";
   	document.frm.addPoint.value="";
   	document.frm.totalUsed.value="";
   	document.frm.totalPrize.value="";
   	document.frm.totalPunish.value="";
   	document.frm.lastYearPoint.value="";
   	document.frm.basePoint.value="";

document.frm.cardType.value="";
printFlag=9;

flag=0;
}
</script>
<body onMouseDown="hideEvent()" onKeyDown="hideEvent()">

<FORM action="" method=post name="frm"  onKeyUp="chgFocus(frm)">

<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi">用户积分修改</div>
	</div>

     
        <table  cellspacing="0">
        <tbody>
              <tr> 
            <td class="blue" width="10%" > 用户号码 </td>
            <td class="blue" width="23%"  align=left>
              <input 
            id=Text2 type=text  name=phoneNo v_type="mobphone" v_name="移动号码" maxlength=11 index="0"  onKeyUp="if(event.keyCode==13)submitt()" value =<%=activePhone!=null?activePhone:ph_no%>  Class="InputGrey" readOnly  Class="InputGrey">
            <input 
            id=Text2 type=button  name=qry value="查询" onclick="submitt()" class="b_text">
            </td>
            <td class="blue" width="10%">用户密码 </td>
            <td class="blue" colspan="3"> 
            <jsp:include page="/npage/common/pwd_one.jsp">
	      <jsp:param name="width1" value="16%"  />
	      <jsp:param name="width2" value="34%"  />
	      <jsp:param name="pname" value="inputPass"  />
	      <jsp:param name="pwd" value="12345"  />
 	      </jsp:include>
 	   
 	   
 	   
 	   <%if(favFlag==0){%>
            
            <input id=Text2 type=button  name=verifyPass1 value="验证密码" onclick="verifyPass()" class="b_text">
            
            <%}else{%>
            <input id=Text2 type=button  name=verifyPass1 value="验证密码" onclick="verifyPass()" disabled class="b_text">
            
            <%}%>
 	   
              </td>
            
            
          </tr>
          <tr> 
            <td class="blue" width="10%" >用户I D</td>
            <td class="blue" align=left width="23%" > 
              <input 
            id=Text2 type=text  name=userId   readOnly  Class="InputGrey" >
            </td>
            <td class="blue"  width="10%">当前状态</td>
            <td class="blue"  width="19%"> 
              <input  type=text  name=runName  readOnly  Class="InputGrey" >
            </td>
            <td class="blue"  width="10%">级别</td>
            <td class="blue"  width="28%"> 
              <input  type=text  name=gradeName   readOnly  Class="InputGrey">
            </td>
          </tr>
              <tr> 
            <td class="blue" width="10%" > 当前预存</td>
            <td class="blue" align=left width="23%" > 
              <input 
            id=Text2 type=text  name=totalPrepay  readOnly  Class="InputGrey" >
            </td>
            <td class="blue"  width="10%">当前欠费</td>
            <td class="blue"  width="19%"> 
              <input 
            id=Text2 type=text  name=totalOwe  readOnly  Class="InputGrey">
            </td>
            <td class="blue"  width="10%">大客户标志</td>
            <td class="blue"  width="28%"> 
              <input  type=text  name=cardType readonly  Class="InputGrey" style="color:red">
            </td>
          </tr>
          <tr> 
            <td class="blue" width="10%" > 客户名称</td>
            <td class="blue" align=left width="23%" > 
              <input  id=Text2 type=text  name=custName   readOnly  Class="InputGrey">
               <input  id="Text222" type="hidden"  name="custNameHide"   readOnly  Class="InputGrey" >
            </td>
            <td class="blue"  width="10%">已使用积分</td>
            <td class="blue"  width="19%"> 
              <input   id=Text2   name=initPoint   type="hidden"  >
			  <input  type=text  name=totalUsed  readOnly  Class="InputGrey">
            </td>
            <td class="blue"  width="10%">当前积分</td>
            <td class="blue"  width="28%"> 
              <input  type=text  name=currentPoint  readOnly  Class="InputGrey" >
            </td>
            
          </tr>
              <input   id=Text2  name=yearPoint   type="hidden">
              <input id=Text2   name=addPoint   type="hidden">
              <input  id=Text2  name=totalPunish   type="hidden">
              <input    name=lastYearPoint   type="hidden">
  
          <tr> 
            <td class="blue" width="14%" > 本月生成积分</td>
            <td class="blue" align=left width="23%" > 
              <input 
            id=Text2 type=text  name=basePoint  readOnly  Class="InputGrey" >
            </td>
          
	        <td class="blue" width="14%" style="display:none"> 总奖励积分</td>
            <td class="blue" align=left width="23%" style="display:none"> 
              <input  id=Text2 type=text  name=totalPrize  >
            </td>	
            </div>	
            <td class="blue"  width="10%">赠送积分</td>
            <td class="blue"  width="19%" > 
              <input id=Text2 type="text"  name="inpPoint" v_type="0_9"  v_name="赠送积分" onblur='checkElement(this)' maxlength=9 index="2">
            </td>
            <td class="blue"  width="10%">积分类型</td>
              <td class="blue"  width="19%" > 
              	<select id=jifentype name=jifentype  >
              	
		  <option value="04">04-促销积分</option>
		  </select>
            </td>
          </tr>
      <tr>
      	<td class="blue">开始时间</td>
				<td>
						<input type="text" id="startCust" v_must="1"  name="startCust" readOnly onclick="WdatePicker({el:'startCust',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y-%M-%d\'}',minDate:'#{%y-6}-01-01'})"/>
							<img id = "imgCustStart" 
								First. onclick="WdatePicker({el:'startCust',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y%M%d\'}',minDate:'#{%y-6}-01-01'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				</td>
			<td class="blue">结束时间</td>
			<td>
				<input type="text" id="endCust" v_must="1"  name="endCust" readOnly onclick="WdatePicker({el:'endCust',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')}'})"/>
							<img id = "imgCustEnd" 
								onclick="WdatePicker({el:'endCust',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')}'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			</td>
	
      </tr>
 		  <tr>
            <td class="blue" >系统备注</td>
            <td>
 			<input id=Text2 type="text" size=40 name="asNotes"  maxlength=128 index="5" onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');"></td>
 			<td colspan="4">
 				<font color="red">最大输入长度128</font>
 			</td>
          </tr>
           <tr style="display:none"> 
            
            <td class="blue" width="10%" > 担保人名称</td>
            <td class="blue" align=left width="23%" > 
              <input id=Text2 type=text  name=asCustName maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
            <td class="blue"  width="10%">担保人联系电话</td>
            <td class="blue"  width="19%"> 
              <input id=Text2 type=text  name=asCustPhone maxlength=20  >
            </td>
            <td class="blue"  width="14%">联系地址</td>
            <td class="blue"  width="21%" colspan=2> 
              <input id=Text2 type=text  name=asContractAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
          </tr>
          <tr style="display:none"> 
            <td class="blue" width="20%" > 担保人证件类型</td>
            <td class="blue" align=left width="23%" > 
              <select size=1 name=asIdType  >
              <%for(int i = 0 ; i < sIdTypeStr.length ; i ++){%>
              <option value="<%=sIdTypeStr[i][0]%>"><%=sIdTypeStr[i][1]%></option>
              <%}%>
              </select>
            </td>
            <td class="blue"  width="20%">证件号码</td>
            <td class="blue"  width="19%"> 
              <input id=Text2 type=text  name=asIdIccid  maxlength=20>
            </td>
            <td class="blue"  width="24%">证件地址</td>
            <td class="blue"  width="19%" colspan=2> 
              <input id=Text2 type=text  name=asIdAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
          </tr>
          <tr style="display:none"> 
            
            <td class="blue" width="10%" > 担保备注</td>
            <td class="blue" align=left width="23%" > 
              <input 
            id=Text2a type=text size=30 name=asNotes1  maxlength=30 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
          </tr>
          </TBODY> 
        </TABLE>
        <TABLE cellSpacing="0"  style="display:none" >
          <TBODY> 
          <tr > 
            <td class="blue" width="10%" >手续费</td>
            <td class="blue" align=left width="23%" > 
              <input id=Text2 type=text  index="3" name=handFee <%if(feeFlag==0){%><%}%> value="<%=tHandFee%>" v_type=float v_name="手续费">
            </td>
            <td class="blue"  width="10%">实收</td>
            <td class="blue"  width="19%" > 
              <input id=Text2 type=text  index="4" name=factPay  onKeyUp="if(event.keyCode==13){getRemain()}">&nbsp;
              <input id=Text2 type=button  name=getUseInfo value="-->" onclick="getRemain()" class="b_text">
            </td>
            <td class="blue"  width="13%">找零</td>
            <td class="blue"  width="28%">
              <input id=Text2 type=text  name=remain  >
            </td>
          </tr>
		  <tr>
            <td class="blue" >系统备注</td>
            <td>
 			<input id="Text3"	 type="text" size="60"  name="remark" value=""  onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');"  readonly  Class="InputGrey">
 						
 						
          </tr>
          </TBODY> 
        </TABLE>

        <TABLE  cellSpacing="0">
          <TBODY>
            <TR >
              <td class="blue" align=middle id="footer">
              	<input name=submit  type=button value="确认" onclick="submitCfm()" index="6" onKeyUp="if(event.keyCode==13){submitCfm()}" class="b_foot">
               &nbsp;&nbsp; 
              <input  name=back  type=button value="清除" onclick="resett()" class="b_foot">
              &nbsp;&nbsp; 
              <input  name=back  type=button value="关闭" onclick="removeCurrentTab()" class="b_foot">
            </TD>
            </TR>
          </TBODY>
        </TABLE>
<input type=hidden name=loginAccept value="<%=seq%>">
<input type=hidden name=opCode value="2417">


<input type=hidden name=workNo value=<%=workNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=orgCode value=<%=orgCode%>>
<input type=hidden name=sysRemark value="用户积分修改">
<input type=hidden name=ipAdd value="<%=request.getRemoteAddr()%>">
<input type=hidden name=handFeeT value="<%=tHandFee%>">
<input type=hidden name=customPass>
<input type=hidden name=idCardNo>
<input type=hidden name=custAddress>
<input type=hidden name=backLoginAccept>
<input type=hidden name=favFlag value="<%=favFlag%>">
<%@ include file="/npage/include/footer.jsp" %>
</FORM>

<script>

function printCommit()
{          
	// in here form check
	showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");  	 
}

function showPrtDlg(printType,DlgMessage,submitCfn)
{  
   document.all.sysRemark.value="用户"+document.all.phoneNo.value+"积分修改";
   if((document.all.asNotes.value).trim().length==0)
   {
	  document.all.asNotes.value="操作员<%=workName%>"+"对用户"+document.all.phoneNo.value+"进行积分修改"
   }
   //显示打印对话框 
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var printStr = printInfo(printType);

    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
     
     
     var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
     var billType="1";                      //  票价类型1电子免填单、2发票、3收据
     var sysAccept =document.frm.loginAccept.value;                       // 流水号
     var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
     var mode_code=null;                        //资费代码
     var fav_code=null;                         //特服代码
     var area_code=null;                        //小区代码
     var opCode =   "<%=opCode%>";                         //操作代码
     var phoneNo = <%=activePhone%>;                            //客户电话
     
   	 var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfn;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.all.phoneNo.value+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	//	alert(path);
	//	return false;
		var ret=window.showModalDialog(path,printStr,prop);   

     
   if(typeof(ret)!="undefined")
   {
	ret="confirm";
     if((ret=="confirm")&&(submitCfn == "Yes"))
     {

       if(rdShowConfirmDialog('确认要进行此项服务吗？')==1)
       {
       	printFlag=1;
       }
     }
   }
}

function printInfo(printType)
{
	
  	var retInfo = "";
	var note_info1 = "";
	var note_info2 = "";
	var note_info3 = "";
	var note_info4 = "";
	var opr_info = "";
	var cust_info = "";
		
    if(printType == "Detail")
    {
      cust_info+="客户姓名：" +document.all.custNameHide.value+"|";
      cust_info+="手机号码："+document.all.phoneNo.value+"|";
      cust_info+="客户地址："+document.all.custAddress.value+"|";
      cust_info+="证件号码："+document.all.idCardNo.value+"|";

      opr_info+="当前积分："+document.frm.currentPoint.value+"|";
      opr_info+="用户积分修改。*手续费："+document.frm.handFee.value+"|";

      note_info1+="备注："+document.all.remark.value+"|";
      note_info1+=""+document.all.asNotes.value+"|"; 

    }  
    if(printType == "Bill")
    {	//打印发票
    }
    
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式

    return retInfo;
}
</script>
<script>
function printBill(){
	  var infoStr="";  
	  var retInfo = "";
	  retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="客户名称：" +document.all.custNameHide.value+"|";
      retInfo+="手机号码："+document.all.phoneNo.value+"|";
      retInfo+="客户地址："+document.all.custAddress.value+"|";
      retInfo+="现金："+document.all.handFee.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+="用户积分修改。*手续费："+document.frm.handFee.value+"*流水号："+document.frm.backLoginAccept.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=document.all.remark.value+"|";
      retInfo+=document.all.asNotes.value+"|"; 
      location="<%=request.getContextPath()%>/npage/innet/chkPrintNew.jsp?retInfo="+retInfo+"&dirtPage=<%=request.getContextPath()%>/npage/s2417/f2417.jsp?activePhone=<%=activePhone%>";
}
</script>
</BODY></HTML>

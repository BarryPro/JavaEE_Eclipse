<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-25 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.RoleManage.wrapper.*"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%
 response.setHeader("Pragma","No-cache");
 response.setHeader("Cache-Control","no-cache");
 response.setDateHeader("Expires", 0);
%>
<%
	System.out.println("<----------------8002 start----------------->");
	String opCode ="8002";
	String opName = "工号管理";
	String cuDate =new SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date()).toString();
	String sWorkNo = (String)session.getAttribute("workNo");	
	String dNopass = (String)session.getAttribute("password");	
	String org_codeT = (String)session.getAttribute("orgCode");
	String region_codeT =  (String)session.getAttribute("regCode");
	String dis_codeT = org_codeT.substring(2,4);	
	String sqlRegion = "select region_code, trim(region_name), login_region from sRegionCode "; 
	System.out.println("liangyl-------------------"+sqlRegion);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_codeT%>" outnum="3">
		<wtc:sql><%=sqlRegion%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="regionCode" scope="end"/>

<%
	String powerCode2=(String)session.getAttribute("powerCode");
	System.out.println("liangyl------------------------"+powerCode2);
	
	comImpl comResult = new comImpl();
	
	
//	ArrayList arr = RoleManageWrapper.getPowerCode1(powerCode2);
	String sql1 = "SELECT power_code,power_name FROM spowercode where power_code like '01%'";
	ArrayList arr = comResult.spubqry32("2",sql1);
	System.out.println("liangyl------------------------"+arr);
	String sql2 = "SELECT power_right,right_name FROM spowervaluecode";
//	ArrayList powerRightArr = RoleManageWrapper.getPowerRight();
	ArrayList powerRightArr = comResult.spubqry32("2",sql2);
	System.out.println("liangyl------------------------"+powerRightArr);
	String sql3 = "SELECT login_flag,flag_name,login_name,config_flag FROM slogintype where config_flag = 'Y'";
//	ArrayList typeArr = RoleManageWrapper.getLoginType();
	ArrayList typeArr = comResult.spubqry32("2",sql3);
	System.out.println("liangyl------------------------"+typeArr);
	String sql4 = "SELECT rpt_right,right_name FROM srptright";
//	ArrayList rptArr = RoleManageWrapper.getRptCode();
	ArrayList rptArr = comResult.spubqry32("2",sql4);
	String[][] powerCode =  (String[][])arr.get(0);
	String[][] powerRight = (String[][])powerRightArr.get(0);
	String[][] loginTypeStr = (String[][])typeArr.get(0);
	String[][] rptCode = (String[][])rptArr.get(0);

	String sql5 = "SELECT region_code,district_code,district_name,login_district FROM sdiscode WHERE region_code='"+region_codeT+"'";
//	ArrayList disArrInit = RoleManageWrapper.getDisCode(region_codeT);
	ArrayList disArrInit = comResult.spubqry32("2",sql5);
	
	String sql6 = "SELECT region_code,district_code,district_name,login_district FROM sdiscode WHERE region_code='"+regionCode[0][0]+"'";
//	ArrayList disArrInit1 = RoleManageWrapper.getDisCode(regionCode[0][0]);
	ArrayList disArrInit1 = comResult.spubqry32("2",sql6);
	String[][] disCodeInit = (String[][])disArrInit.get(0);
	String[][] disCodeInit1 = (String[][])disArrInit1.get(0);
	
	String sql7 = "SELECT town_code,town_name,login_town,region_code,district_code FROM stowncode WHERE district_code='"+region_codeT+"' and and region_code='"+dis_codeT+"'";
//	ArrayList townArrInit = RoleManageWrapper.getTownCode(region_codeT,dis_codeT);
	ArrayList townArrInit = comResult.spubqry32("2",sql7);
	String sql8 = "SELECT town_code,town_name,login_town,region_code,district_code FROM stowncode WHERE district_code='"+regionCode[0][0]+"' and and region_code='"+disCodeInit1[0][1]+"'";
//	ArrayList townArrInit1 = RoleManageWrapper.getTownCode(regionCode[0][0],disCodeInit1[0][1]);
	ArrayList townArrInit1 = comResult.spubqry32("2",sql8);
	
	String[][] townCodeInit = (String[][])townArrInit.get(0);
	String[][] townCodeInit1 = (String[][])townArrInit1.get(0);
	
	/***sunwt add 判断工号类型，对客服工号进行权限限制***/
	String sqlStr =	"select account_type from dLoginMsg where login_no = '"+sWorkNo+"'";
	System.out.println("liangyl------------------------"+sqlStr);
	//String accountType = ((String[][])callView.sPubSelect("1",sqlStr, "region", region_codeT).get(0))[0][0];
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_codeT%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%
	String accountType="";
	if(result!=null&&result.length>0){
		accountType=result[0][0];
	}
	
	String sGrpId =  (String)session.getAttribute("groupId");
	String strSqlAccType = "select account_type, account_name from sAccType where 1 = 1 ";
	System.out.println("liangyl------------------------"+strSqlAccType);
	if((!sGrpId.trim().equals("10014"))&&(!powerCode[0][0].trim().equals("01")))
	{
		strSqlAccType = strSqlAccType + " and account_type != '0'";
	}
	if((!sGrpId.trim().equals("10014"))&&(!accountType.equals("2"))&&(!(sGrpId.trim().equals("340343")&&accountType.equals("0"))))
	{
		strSqlAccType = strSqlAccType + " and account_type !='2'";
	}
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_codeT%>"  retcode="retCode2" retmsg="retMsg2" outnum="3">
		<wtc:sql><%=strSqlAccType%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="acctypeArr" scope="end" />

<%
	//日期
	GregorianCalendar currentTime = new GregorianCalendar();
	GregorianCalendar currentTime2 = new GregorianCalendar();
	SimpleDateFormat fmtrq = new SimpleDateFormat("yyyyMMdd HH:mm:ss",Locale.US); 
	currentTime.add(GregorianCalendar.MONTH,1);
	currentTime2.add(GregorianCalendar.MONTH,3);
	String dateString=fmtrq.format(currentTime.getTime());	
	String dateString2=fmtrq.format(currentTime2.getTime());	
	/*
	GregorianCalendar currentTime = new GregorianCalendar();
	SimpleDateFormat fmtrq = new SimpleDateFormat("yyyyMMdd",Locale.US); 
	String todayString =fmtrq.format(currentTime.getTime());*/	
%>

<HTML>
<HEAD>
<TITLE>工号管理</TITLE>
<script language=javascript>
onload=function()
{	
	<%if(!sWorkNo.substring(0,1).equals("8")){%>
	ycallTownCode();
    <%}%>
}

function creatLoginNo()
{
	var z = 0 ;
	var cTypeCode = 0 ;
	for(z = 0 ; z < document.frm.yloginFlag.length ; z ++)
	{
		if(document.frm.yloginFlag.options[z].selected)
		{
			cTypeCode = document.frm.yloginFlag.options[z].type_value;
		}
	}
	var i = 0;
	var cRegionCode = 0;
	var iRegionCode = 0;
	for(i = 0 ; i < document.frm.yregionCode.length ; i ++)
	{
		if(document.frm.yregionCode.options[i].selected)
		{
			cRegionCode = document.frm.yregionCode.options[i].pvalue;
			iRegionCode = document.frm.yregionCode.options[i].value;
		}
	}
	var j = 0;
	var cDisctrictCode = 0;
	var iDisctrictCode = 0;
	for(j = 0 ; j < document.frm.ydisctrictCode.length ; j ++)
	{
		if(document.frm.ydisctrictCode.options[j].selected)
		{
			cDisctrictCode = document.frm.ydisctrictCode.options[j].pvalue;
			iDisctrictCode = document.frm.ydisctrictCode.options[j].value;
		}
	}
	var k = 0;
	var cTownCode = 0;
	var iTownCode = 0;
	for(k = 0 ; k < document.frm.ytownCode.length ; k ++)
	{
		if(document.frm.ytownCode.options[k].selected)
		{
			cTownCode = document.frm.ytownCode.options[k].pvalue;
			iTownCode = document.frm.ytownCode.options[k].value;
		}
	}

	var noList = cRegionCode+cDisctrictCode+cTownCode;
	var iNoList = iRegionCode + iDisctrictCode+iTownCode;
	if(cTypeCode=="k")
	{
		noList="k";
	}
	//alert('wanghao');
	var myPacket = new AJAXPacket("creatLoginNo.jsp","正在提交，请稍候......");
	myPacket.data.add("noList",noList);
	myPacket.data.add("iNoList",iNoList);
    	core.ajax.sendPacket(myPacket);
   	myPacket=null;
}

function StrAdd(AddType, SrcStr, Value)
{
	//AddType 0值加1， 1:模加1
	var BaseStr ="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	var S = "";
	var CurPos = 0, PrePos = 0, SrcLen=0,BaseLen=0, Index=0;
	var isCarry = 0;

	SrcLen= SrcStr.length;
	BaseLen=BaseStr.length;
	isCarry = Value % BaseLen;

	for(CurPos = SrcLen - 1; CurPos >= 0; CurPos --)
	{
		if (isCarry != 0)
		{
			Index = BaseStr.indexOf(SrcStr.charAt(CurPos)) + isCarry;
			if (Index < -1)
			{
				return "";
			}
			if (Index > BaseLen - 1)
			{
				isCarry = 1;
				S = BaseStr.charAt(Index - BaseLen) + S;
			}
			else
			{
				isCarry = 0;
				S = SrcStr.substring(0, CurPos) + BaseStr.charAt(Index) + S;
				break;
			}
			if (CurPos == 0 && AddType == 0)
				S = BaseStr.charAt(0) + S;
		}
		else
		{
			break;
		}
	}

	return S;
}

function doProcess(packet)
{	//返回处理
	//alert(1);
	var backString = packet.data.findValueByName("backString");
	alert(backString);
	var flag = packet.data.findValueByName("flag");
	//alert(flag);
	if(flag=="12")
	{
		var sloginNo = backString;
		if(sloginNo=="")
		{
			document.frm.AccountNo.value="";
			return;
		}
		document.frm.yloginNo.value=sloginNo;
		document.frm.AccountNo.disabled=true;
		document.frm.chkAccNo.disabled=true;
		document.frm.submitr.disabled=false;
	//	document.frm.FuncNo.disabled = true;
	//	document.frm.chkFuncNo.disabled = true;
		document.frm.addButton.disabled = true;
		var SEQ_MailCode = packet.data.findValueByName("SEQ_MailCode");//20100317 add
		document.frm.MailCodeAddr.value=sloginNo+SEQ_MailCode+"@hl.chinamobile.com";//20100317 add
		document.frm.SEQ_MailCode.value=SEQ_MailCode;//20100317 add
		return;
	}
	if(flag=="11")
	{
		var newMaxNo = StrAdd(1,backString,1);
		document.frm.yorgNo.value=newMaxNo;
		return;
	}
	if(flag=="10")
	{
		var maxNo = packet.data.findValueByName("nott");
		var maxLogin = backString;
		if(maxLogin.length!=6)
		{
			rdShowMessageDialog("'"+maxLogin+"'工号必须改成字母或数字的六位组合！且前四位不允许修改！");
			return;
		}
		var SEQ_MailCode = packet.data.findValueByName("SEQ_MailCode");//20100317 add
		var changeNo = maxLogin.substring(4,6);
		if(changeNo=="zz")
		{
			rdShowMessageDialog("该营业厅工号已满，不能自动生成。请进行手工输入！注意：工号长度共6位且前4位不允许变更！");
		}
		var remainNo = maxLogin.substring(0,4);
		var newMaxNo = StrAdd(1,maxNo,1);
		maxLogin = StrAdd(1,changeNo,1);
		var newNo = remainNo + maxLogin;
		if(changeNo=="zz")
		{
			document.frm.yloginNo.value=remainNo;
			document.frm.yloginNo.disabled = false;
		}
		else
		{
			document.frm.yloginNo.value=newNo;
			document.frm.yloginNo.disabled = true;
			document.frm.MailCodeAddr.value=newNo+SEQ_MailCode+"@hl.chinamobile.com";//20100317 add
			//$("#MailCodeAddr").val(newNo+SEQ_MailCode+"@hl.chinamobile.com");//20100317 add
			//alert(document.all.MailCodeAddr.value);
		}
		document.frm.inValidLoginNo.value=remainNo;
		document.frm.yorgNo.value=newMaxNo;
		document.frm.creatNo.disabled = true;
		document.frm.submitr.disabled=false;
		document.frm.SEQ_MailCode.value=SEQ_MailCode;//20100317 add
		return;
	}
	var temLength = backString.length+1;
	var arr = new Array(temLength);
	for(var i = 0 ; i < backString.length ; i ++)
	{
		arr[i] = "<OPTION value="+backString[i][0]+" pvalue="+backString[i][2]+">" + backString[i][1] + "</OPTION>";
	}
	if(flag=="0")
	{
	//	disCodeDiv.innerHTML = "<select id=disCode size=1 name=disctrictCode onchange=callTownCode()>" + arr.join() + "</SELECT>";
		$("#disCodeDiv").append("<select id=disCode size=1 name=disctrictCode onchange=callTownCode()>" + arr.join() + "</SELECT>");
		callTownCode();
	}
	if(flag=="1")
	{
	  //	townCodeDiv.innerHTML = "<select id=tCode size=1 name=townCode>" + arr.join() + "</SELECT>";
	  	$("#townCodeDiv").append("<select id=tCode size=1 name=townCode>" + arr.join() + "</SELECT>");
	}
	if(flag=="3")
	{
	//	ydisCodeDiv.innerHTML = "<select id=disCode size=1 name=ydisctrictCode onchange=ycallTownCode()>" + arr.join() + "</SELECT>";
		$("#ydisCodeDiv").append("<select id=disCode size=1 name=ydisctrictCode onchange=ycallTownCode()>" + arr.join() + "</SELECT>");
		ycallTownCode();
	}
	if(flag=="4")
	{
	  //	ytownCodeDiv.innerHTML = "<select id=tCode size=1 name=ytownCode onchange=chgTownCode() onmouseover=FixWidth(this)>" + arr.join() + "</SELECT>";
		$("#ytownCodeDiv").append("<select id=tCode size=1 name=ytownCode onchange=chgTownCode() onmouseover=FixWidth(this)>" + arr.join() + "</SELECT>");
	}
	if(flag=="9")
	{
		rdShowMessageDialog(backString[1][0]);
		window.location="f8002.jsp";

		if(backString[0][0]=="000000")
		{
			document.frm.yloginNo.value="";
			document.frm.yloginName.value="";
			document.frm.yloginPass.value="";
			document.frm.ycfmPass.value="";
			document.frm.yallowBegin.value="08:00:00";
			document.frm.yallowEnd.value="18:00:00";
			document.frm.yexpireTime.value="20501230 00:00:00";
			document.frm.ydeptCode.value="";
			document.frm.yremark.value="";
			document.frm.contractPhoneNo.value="";
		}
		document.frm.submitr.disabled=false;
	}
	if(flag=="2")
	{
		var tr1="";
		var tr2="";
		tr2=infoTab.insertRow();
		tr2.insertCell().innerHTML = '<td width="23%" class="blue">工号代码</td>';
		tr2.insertCell().innerHTML = '<td width="23%" class="blue" >工号名称</td>';
		tr2.insertCell().innerHTML = '<td width="23%" class="blue">角色代码</td>';
		tr2.insertCell().innerHTML = '<td width="23%" class="blue">权限值</td>';
		tr2.insertCell().innerHTML = '<td width="23%" class="blue">重复登陆</td>';
		tr2.insertCell().innerHTML = '<td width="23%"></td>';
		tr2.insertCell().innerHTML = '<td width="23%"></td>';
		tr2.insertCell().innerHTML = '<td width="23%"></td>';

		for(var i = 0 ; i < backString.length ; i ++)
		{
			tr1=infoTab.insertRow();
			tr1.id="tr"+i;
			tr1.bgcolor="red";
  			tr1.insertCell().innerHTML = '<td width="23%"><input  id=Text2 type=hidden size=10 name=work_no'+i+' maxlength=6 value='+backString[i][0]+' disabled >'+backString[i][0]+'</td>';
			tr1.insertCell().innerHTML = '<td width="23%"><input  id=Text2 type=hidden size=10 name=login_name'+i+' maxlength=6  disabled  value='+backString[i][1]+'>'+backString[i][1]+'</td>';
			var loginFlagValue="0";
			if(backString[i][5]=="0")
			{
				loginFlagValue="普通工号";
			}
			if(backString[i][5]=="1")
			{
				loginFlagValue="管理工号";
			}
			var loginStatusValue="0";
			if(backString[i][20]=="1")
			{
				loginStatusValue="签到";
			}
			if(backString[i][20]=="2")
			{
				loginStatusValue="签退";
			}
			var maintainFlagValue="0";
			if(backString[i][14]=="0")
			{
				maintainFlagValue="非维护工号";
			}
			if(backString[i][14]=="1")
			{
				maintainFlagValue="维护工号";
			}

			var reloginFlagValue="0";
			if(backString[i][18]=="1")
			{
				reloginFlagValue="不允许";
			}
			if(backString[i][18]=="0")
			{
				reloginFlagValue="允许";
			}

			tr1.insertCell().innerHTML = '<td width="23%"><input  id=Text2 type=hidden size=10 name=login_Flag'+i+' maxlength=6 value='+backString[i][3]+' disabled >'+backString[i][3]+'</td>';
			tr1.insertCell().innerHTML = '<td width="23%"><input  id=Text2 type=hidden size=10 name=login_status'+i+' maxlength=6 value='+backString[i][4]+' disabled >'+backString[i][4]+'</td>';
			tr1.insertCell().innerHTML = '<td width="23%"><input  id=Text2 type=hidden size=10 name=maintain_flag'+i+' maxlength=6 value='+reloginFlagValue+' disabled >'+reloginFlagValue+'</td>';
			tr1.insertCell().innerHTML = '<td><input  type=button class=b_text name=inp'+i+' value="详细信息" onclick="qryInfoDetail('+i+')"></td>';
			tr1.insertCell().innerHTML = '<td><input  type=button class=b_text name=mod'+i+' value="修改" onclick="modifyInfoDetail('+i+')"></td>';
			tr1.insertCell().innerHTML = '<td width="60%"></td>';
			tr1.insertCell().innerHTML = '<input type=hidden name=powerCodeInfo'+i+' value="'+backString[i][3]+'"></input>';
			tr1.insertCell().innerHTML = '<input type=hidden name=powerRightInfo'+i+' value="'+backString[i][4]+'"></input>';
			tr1.insertCell().innerHTML = '<input type=hidden name=loginFlagInfo'+i+' value="'+backString[i][5]+'"></input>';
			tr1.insertCell().innerHTML = '<input type=hidden name=opTimeInfo'+i+' value="'+backString[i][6]+'"></input>';
			tr1.insertCell().innerHTML = '<input type=hidden name=rptRightInfo'+i+' value="'+backString[i][7]+'"></input>';
			tr1.insertCell().innerHTML = '<input type=hidden name=allowBeginInfo'+i+' value="'+backString[i][8]+'"></input>';
			tr1.insertCell().innerHTML = '<input type=hidden name=allowEndInfo'+i+' value="'+backString[i][9]+'"></input>';
			tr1.insertCell().innerHTML = '<input type=hidden name=passTimeInfo'+i+' value="'+backString[i][10]+'"></input>';
			tr1.insertCell().innerHTML = '<input type=hidden name=expireTimeInfo'+i+' value="'+backString[i][11]+'"></input>';
			tr1.insertCell().innerHTML = '<input type=hidden name=tryTimesInfo'+i+' value="'+backString[i][12]+'"></input>';
			tr1.insertCell().innerHTML = '<input type=hidden name=validFlagInfo'+i+' value="'+backString[i][13]+'"></input>';
			tr1.insertCell().innerHTML = '<input type=hidden name=maintainFlagInfo'+i+' value="'+backString[i][14]+'"></input>';
			tr1.insertCell().innerHTML = '<input type=hidden name=orgCodeInfo'+i+' value="'+backString[i][15]+'"></input>';
			tr1.insertCell().innerHTML = '<input type=hidden name=reloginFlagInfo'+i+' value="'+backString[i][18]+'"></input>';
			tr1.insertCell().innerHTML = '<input type=hidden name=deptCodeInfo'+i+' value="'+backString[i][19]+'"></input>';
			tr1.insertCell().innerHTML = '<input type=hidden name=loginStatusInfo'+i+' value="'+backString[i][20]+'"></input>';
			tr1.insertCell().innerHTML = '<input type=hidden name=ipAddressInfo'+i+' value="'+backString[i][21]+'"></input>';
			tr1.insertCell().innerHTML = '<input type=hidden name=runTimeInfo'+i+' value="'+backString[i][22]+'"></input>';
			tr1.insertCell().innerHTML = '<input type=hidden name=contractPhone'+i+' value="'+backString[i][23]+'"></input>';
			tr1.insertCell().innerHTML = '<input type=hidden name=otherFlagInfo'+i+' value="'+backString[i][16]+'"></input>';
		}
		frameDiv.style.display='none';
		loginDiv.style.display='';
	}

	if(flag == "6")
	{
		document.frm.AccountNo.value = backString;
	}
}

//根据地区代码查询地市代码
function callDisCode()
{
	var i = 0;
	var regionCode = 0;
	for(i = 0 ; i < document.frm.regionCode.length ; i ++)
	{
		if(document.frm.regionCode.options[i].selected)
		{
			regionCode = document.frm.regionCode.options[i].value;
		}
	}
    var myPacket = new AJAXPacket("callDisCode.jsp","正在查询，请稍候......");
	myPacket.data.add("region_code",regionCode);

    core.ajax.sendPacket(myPacket);
    myPacket=null;
}

function callTownCode()
{
	var i = 0;
	var regionCode = 0;
	/* for(i = 0 ; i < document.frm.regionCode.length ; i ++)
	{
		if(document.frm.regionCode.options[i].selected)
		{
			regionCode = document.frm.regionCode.options[i].value;
		}
	} */
	regionCode = $("#part13").val()
	var j = 0;
	var disctrictCode = 0;
	/* for(j = 0 ; j < document.frm.disctrictCode.length ; j ++)
	{
		if(document.frm.disctrictCode.options[j].selected)
		{
			disctrictCode = document.frm.disctrictCode.options[j].value;
		}
	} */
	disctrictCode = $("#disCode").val();
    var myPacket = new AJAXPacket("callTownCode.jsp","正在查询，请稍候......");
	myPacket.data.add("region_code",regionCode);
	myPacket.data.add("dis_code",disctrictCode);

    core.ajax.sendPacket(myPacket);
   myPacket=null;
}

function ycallDisCode()
{
	var i = 0;
	var regionCode = 0;
	for(i = 0 ; i < document.frm.yregionCode.length ; i ++){
		if(document.frm.yregionCode.options[i].selected){
			regionCode = document.frm.yregionCode.options[i].value;
		}
	}

	document.frm.submitr.diabled = true;
	document.frm.creatNo.disabled = false;

    var myPacket = new AJAXPacket("ycallDisCode.jsp","正在查询，请稍候......");
	//rdShowMessageDialog("region_code= :" + regionCode);
	myPacket.data.add("region_code",regionCode);
    core.ajax.sendPacket(myPacket);
    myPacket=null;
}

function ycallTownCode()
{
	var i = 0;
	var regionCode = 0;
	/* for(i = 0 ; i < document.frm.yregionCode.length ; i ++)
	{
		if(document.frm.yregionCode.options[i].selected)
		{
			regionCode = document.frm.yregionCode.options[i].value;
		}
	} */
	regionCode = $("select[name=yregionCode]").val();
	var j = 0;
	var disctrictCode = 0;
	/* for(j = 0 ; j < document.frm.ydisctrictCode.length ; j ++)
	{
		if(document.frm.ydisctrictCode.options[j].selected)
		{
			disctrictCode = document.frm.ydisctrictCode.options[j].value;
		}
	} */
	disctrictCode = $("select[name=ydisctrictCode]").val();
	alert(disctrictCode);
//	alert(regionCode);
//	alert(disctrictCode)
//	document.frm.submitr.disabled = true;
//	document.frm.creatNo.disabled = false;

    	var myPacket = new AJAXPacket("ycallTownCode.jsp","正在查询，请稍候......");
	myPacket.data.add("region_code",regionCode);
	myPacket.data.add("dis_code",disctrictCode);
    	core.ajax.sendPacket(myPacket);
   	myPacket=null;
}

function chgTownCode()
{
	document.frm.submitr.disabled = true;
	document.frm.creatNo.disabled = false;
}

function qryLoginNo()
{
	/** sunwt 添加：限制客服工号复位其他工号密码 **/
	if(document.frm.opAccType.value == "2")
	{
		var y = 0;
		for(y = 0 ; y < document.frm.qryItem.length ; y++)
		{
			if(document.frm.qryItem[y].checked)
			{
				if(document.frm.qryItem[y].value=="1")
				{
					rdShowMessageDialog("客服工号管理员只能操作客服工号!");
					return;
				}
				else if(document.frm.qryItem[y].value == "0")
				{
					if(document.frm.work_no.value.substring(0,1) != "8"
							&& document.frm.work_no.value.substring(0,1) != "9")
					{
						rdShowMessageDialog("客服工号管理员只能操作客服工号！");
						return;
					}
				}
				else if(document.frm.qryItem[y].value == "2")
				{
					if(document.frm.acc_no.value.substring(0,1) != "8"
							&& document.frm.acc_no.value.substring(0,1) != "9")
					{
						rdShowMessageDialog("客服工号管理员只能操作客服工号！");
						return;
					}
				}
			}
		}
	}
	var t = 0 ;
	for(t=infoTab.rows.length;t>0;t--)
	{
		infoTab.deleteRow();
	}
	var i = 0;
	var regionCode = 0;
	for(i = 0 ; i < document.frm.regionCode.length ; i ++)
	{
		if(document.frm.regionCode.options[i].selected)
		{
			regionCode = document.frm.regionCode.options[i].value;
		}
	}
	var j = 0;
	var disctrictCode = 0;
	for(j = 0 ; j < document.frm.disctrictCode.length ; j ++)
	{
		if(document.frm.disctrictCode.options[j].selected)
		{
			disctrictCode = document.frm.disctrictCode.options[j].value;
		}
	}
	var k = 0;
	var townCode = 0;
	for(k = 0 ; k < document.frm.townCode.length ; k ++)
	{
		if(document.frm.townCode.options[k].selected)
		{
			townCode = document.frm.townCode.options[k].value;
		}
	}
	var m = 0;
	var validFlag = 0;
	for(m = 0 ; m < document.frm.validFlag.length ; m ++)
	{
		if(document.frm.validFlag.options[m].selected)
		{
			validFlag = document.frm.validFlag.options[m].value;
		}
	}
	var orgCode = regionCode+disctrictCode+townCode;
	var inputLoginNo = document.frm.work_no.value;
	var inputAccNo = document.frm.acc_no.value;
	var inputGroupId = document.frm.grpId.value;
	var qryType = 0;

	var y = 0;

	for(y = 0 ; y < document.frm.qryItem.length ; y++)
	{
		if(document.frm.qryItem[y].checked)
		{
			if(document.frm.qryItem[y].value=="0")
			{
				if(document.frm.work_no.value.length==0)
				{
					rdShowMessageDialog("请输入工号代码！");
					return;
				}
				orgCode="";
				inputAccNo="";
				inputGroupId="";
			}
			if(document.frm.qryItem[y].value=="1")
			{
				inputLoginNo="";
				inputAccNo="";
				inputGroupId="";
			}
			if(document.frm.qryItem[y].value=="2")
			{
				if(document.frm.acc_no.value.length==0)
				{
					rdShowMessageDialog("请输入帐号代码！");
					return;
				}
				orgCode="";
				inputLoginNo="";
				inputGroupId="";
			}
			if(document.frm.qryItem[y].value=="3")
			{
				if(document.frm.grpId.value.length==0)
				{
					rdShowMessageDialog("请选择组织结构！");
					return;
				}
				orgCode="";
				inputLoginNo="";
				inputAccNo="";
			}
		}
	}
	validFlag = document.frm.validFlag.value;
	loginDiv.style.display="none";
    	frameDiv.style.display="";
    	frm.action="getMoreRec.jsp?loginNo="+inputLoginNo+"&orgCode="+orgCode+"&validFlag="+validFlag+"&AccountNo="+inputAccNo+"&groupId="+inputGroupId;
    	frm.target="ifr";
    	frm.submit();
}

//sunwt add function 20080128
function checkAccType()
{
	var i=0;
	alert("aaa");
	
	
}
//sunwt modify function 20080128
function queryLoginchange()
{
	var accountType = "";
	var i = 0;;
	for(i = 0; i < document.frm.rdLoginNo.length; i++)
	{
		if(document.frm.rdLoginNo[i].checked)
		{
			accountType = document.frm.rdLoginNo[i].value;
		}
	}

	var loginNo = "";
	if(accountType == "1")
	{
		loginNo=document.frm.login_no.value;
		if(loginNo=="")
		{
			rdShowMessageDialog("工号不能为空！");
			return false;
		}
	}
	else
	{
		loginNo=document.frm.account_no.value;
		if(loginNo=="")
		{
			rdShowMessageDialog("帐号不能为空！");
			return false;
		}
	}
	frm.action="getchangeInfo.jsp?loginNo="+loginNo+"&accountType="+accountType;
	frm.submit();
}
</script>
<script>

function getDptCode()
{
	if(document.frm.AccountType.value == "2")
	{
		return;
	}
	var regionCode = document.frm.yregionCode.value;
	var townCode = document.frm.ytownCode.value;
	var typeCode = document.frm.yloginFlag.value;
	if(typeCode=="3")
	{
		townCode="005";
		regionCode="00";
	}
	if(regionCode!="0x")
		window.open("../../../callcenter/ccpage/pub/dptTreeToYY.jsp?regionCode="+regionCode+"&townCode="+townCode,"","height=500,width=500,scrollbars=yes");
}


function showInfo()
{
	tabhead1.className="tabnodisp";
	tabhead2.className="tabdisp";
	tabhead3.className="tabdisp";
	tabhead4.className="tabdisp";
	font1.color="3366cc";
	font2.color="000000";
//	font3.color="000000";
	font3.color="000000";
	font4.color="000000";
	
	$("#infoDiv").show();
	$("#newDiv").hide();
	$("#oldDiv").hide();
	$("#PdomDiv").hide();
//	$("#tabBusi").hide();
	
//	infoDiv.style.display="";
//	newDiv.style.display="none";
//	oldDiv.style.display="none";
//	PdomDiv.style.display="none";
//	tabBusi.style.display="none";
}

function showNew()
{
	tabhead1.className="tabdisp";
	tabhead2.className="tabnodisp";
	tabhead3.className="tabdisp";
	tabhead4.className="tabdisp";
	font1.color="000000";
	font2.color="3366cc";
	font3.color="000000";
	font4.color="000000";
	$("#infoDiv").hide();
	$("#newDiv").show();
	$("#oldDiv").hide();
	$("#PdomDiv").hide();
	alert("aaaa");
//	$("#tabBusi").hide();
//	infoDiv.style.display="none";
//	newDiv.style.display="";
//	oldDiv.style.display="none";
//	PdomDiv.style.display="none";
//	tabBusi.style.display="none";
//	frameDiv.style.display="none";
}
function showOld()
{
	tabhead1.className="tabdisp";
	tabhead2.className="tabdisp";
	tabhead3.className="tabnodisp";
	tabhead4.className="tabdisp";
	font1.color="000000";
	font2.color="000000";
	font3.color="3366cc";
	font4.color="000000";
	
	$("#infoDiv").hide();
	$("#newDiv").hide();
	$("#oldDiv").show();
	$("#PdomDiv").hide();
//	$("#tabBusi").hide();
//	infoDiv.style.display="none";
//	newDiv.style.display="none";
//	oldDiv.style.display="";
//	PdomDiv.style.display="none";
	checkAccType();
//	tabBusi.style.display="none";
}
function showPdom()
{
	tabhead1.className="tabdisp";
	tabhead2.className="tabdisp";
	tabhead3.className="tabdisp";
	tabhead4.className="tabnodisp";
	font1.color="000000";
	font2.color="000000";
	font3.color="000000";
	font4.color="3366cc";
	$("#infoDiv").hide();
	$("#newDiv").hide();
	$("#oldDiv").hide();
	$("#PdomDiv").show();
//	$("#tabBusi").hide();
//	infoDiv.style.display="none";
//	newDiv.style.display="none";
//	oldDiv.style.display="none";
//	PdomDiv.style.display="";
}
function qryInfoDetail(i)
{
	var tempWorkNo = "work_no"+i;
	var temWorkNo=document.frm(tempWorkNo).value;
	var tempLoginName="login_name"+i;
	var temLoginName=document.frm(tempLoginName).value;
	var tempPowerCode="powerCodeInfo"+i;
	var temPowerCode=document.frm(tempPowerCode).value;
	var tempPowerRight="powerRightInfo"+i;
	var temPowerRight=document.frm(tempPowerRight).value;
	var tempLoginFlag="loginFlagInfo"+i;
	var temLoginFlag=document.frm(tempLoginFlag).value;
	var tempOpTime="opTimeInfo"+i;
	var temOpTime=document.frm(tempOpTime).value;
	var tempRptRight="rptRightInfo"+i;
	var temRptRight=document.frm(tempRptRight).value;
	var tempAllowBegin="allowBeginInfo"+i;
	var temAllowBegin=document.frm(tempAllowBegin).value;
	var tempAllowEnd="allowEndInfo"+i;
	var temAllowEnd=document.frm(tempAllowEnd).value;
	var tempPassTime="passTimeInfo"+i;
	var temPassTime=document.frm(tempPassTime).value;
	var tempExpireTime="expireTimeInfo"+i;
	var temExpireTime=document.frm(tempExpireTime).value;

	var tempTryTimes="tryTimesInfo"+i;
	var temTryTimes=document.frm(tempTryTimes).value;
	var tempVilidFlag="validFlagInfo"+i;
	var temVilidFlag=document.frm(tempVilidFlag).value;
	var tempMainTainFlag="mainTainFlagInfo"+i;
	var temMainTainFlag=document.frm(tempMainTainFlag).value;
	var tempOrgCode="orgCodeInfo"+i;
	var temOrgCode=document.frm(tempOrgCode).value;
	var tempDeptCode="deptCodeInfo"+i;
	var temDeptCode=document.frm(tempDeptCode).value;
	var tempLoginStatus="loginStatusInfo"+i;
	var temLoginStatus=document.frm(tempLoginStatus).value;
	var tempReloginFlag = "reloginFlagInfo"+i;
	var temReloginFlag=document.frm(tempReloginFlag).value;
	var tempotherloginFlag = "otherFlagInfo"+i;
	var temotherFlag=document.frm(tempotherloginFlag).value;
	var tempIpAddress="ipAddressInfo"+i;
	var temIpAddress=document.frm(tempIpAddress).value;
	var tempRunTime="runTimeInfo"+i;
	var temRunTime=document.frm(tempRunTime).value;
	var tempContractPhone="contractPhone"+i;
	var temContractPhone=document.frm(tempContractPhone).value;
	window.open('qryLoginInfo.jsp?otherFlag='+temotherFlag+'&contractPhone='+temContractPhone+'&reloginFlag='+temReloginFlag+'&workNo='+temWorkNo+'&loginName='+temLoginName+'&powerCode='+temPowerCode+'&powerRight='+temPowerRight+'&loginFlag='+temLoginFlag+'&opTime='+temOpTime+'&rptRight='+temRptRight+'&allowBegin='+temAllowBegin+'&allowEnd='+temAllowEnd+'&passTime='+temPassTime+'&expireTime='+temExpireTime+'&tryTimes='+temTryTimes+'&vilidFlag='+temVilidFlag+'&maintainFlag='+temMainTainFlag+'&orgCode='+temOrgCode+'&deptCode='+temDeptCode+'&loginStatus='+temLoginStatus+'&ipAddress='+temIpAddress+'&runTime='+temRunTime,'','width=800,height=600,left=0,top=0,resizable=yes,scrollbars=yes,status=yes,menubar=yes');
}
function modifyInfoDetail(i)
{
	var tempWorkNo = "work_no"+i;
	var temWorkNo=document.frm(tempWorkNo).value;
	var tempLoginName="login_name"+i;
	var temLoginName=document.frm(tempLoginName).value;
	var tempPowerCode="powerCodeInfo"+i;
	var temPowerCode=document.frm(tempPowerCode).value;
	var tempPowerRight="powerRightInfo"+i;
	var temPowerRight=document.frm(tempPowerRight).value;
	var tempLoginFlag="loginFlagInfo"+i;
	var temLoginFlag=document.frm(tempLoginFlag).value;
	var tempOpTime="opTimeInfo"+i;
	var temOpTime=document.frm(tempOpTime).value;
	var tempRptRight="rptRightInfo"+i;
	var temRptRight=document.frm(tempRptRight).value;
	var tempAllowBegin="allowBeginInfo"+i;
	var temAllowBegin=document.frm(tempAllowBegin).value;
	var tempAllowEnd="allowEndInfo"+i;
	var temAllowEnd=document.frm(tempAllowEnd).value;
	var tempPassTime="passTimeInfo"+i;
	var temPassTime=document.frm(tempPassTime).value;
	var tempExpireTime="expireTimeInfo"+i;
	var temExpireTime=document.frm(tempExpireTime).value;
	var tempTryTimes="tryTimesInfo"+i;
	var temTryTimes=document.frm(tempTryTimes).value;
	var tempVilidFlag="validFlagInfo"+i;
	var temVilidFlag=document.frm(tempVilidFlag).value;
	var tempMainTainFlag="mainTainFlagInfo"+i;
	var temMainTainFlag=document.frm(tempMainTainFlag).value;
	var tempOrgCode="orgCodeInfo"+i;
	var temOrgCode=document.frm(tempOrgCode).value;
	var tempDeptCode="deptCodeInfo"+i;
	var temDeptCode=document.frm(tempDeptCode).value;
	var tempLoginStatus="loginStatusInfo"+i;
	var temLoginStatus=document.frm(tempLoginStatus).value;
	var tempReloginFlag = "reloginFlagInfo"+i;
	var temReloginFlag=document.frm(tempReloginFlag).value;
	var tempotherloginFlag = "otherFlagInfo"+i;
	var temotherFlag=document.frm(tempotherloginFlag).value;

	var tempIpAddress="ipAddressInfo"+i;
	var temIpAddress=document.frm(tempIpAddress).value;
	var tempRunTime="runTimeInfo"+i;
	var temRunTime=document.frm(tempRunTime).value;
	var tempContractPhone="contractPhone"+i;
	var temContractPhone=document.frm(tempContractPhone).value;
	window.open('modifyLoginInfo.jsp?otherFlag='+temotherFlag+'&contractPhone='+temContractPhone+'&reloginFlag='+temReloginFlag+'&workNo='+temWorkNo+'&loginName='+temLoginName+'&powerCode='+temPowerCode+'&powerRight='+temPowerRight+'&loginFlag='+temLoginFlag+'&opTime='+temOpTime+'&rptRight='+temRptRight+'&allowBegin='+temAllowBegin+'&allowEnd='+temAllowEnd+'&passTime='+temPassTime+'&expireTime='+temExpireTime+'&tryTimes='+temTryTimes+'&vilidFlag='+temVilidFlag+'&maintainFlag='+temMainTainFlag+'&orgCode='+temOrgCode+'&deptCode='+temDeptCode+'&loginStatus='+temLoginStatus+'&ipAddress='+temIpAddress+'&runTime='+temRunTime,'','width=800,height=600,left=0,top=0,resizable=yes,scrollbars=yes,status=yes,menubar=yes');
}

</script>

<script>

function submitt()
{
	if(!checkElement(document.frm.contractPhoneNo)){
		return false;
	}
	//*************sunwt modify in 20080125*****************
  /* 20091230 增加自助缴费类型 || document.frm.AccountType.value=="4"*/
	if(document.frm.AccountType.value=="1" || document.frm.AccountType.value=="4")
	{
		if(document.frm.yloginNo.value.length=="0")
		{
			rdShowMessageDialog("请输入BOSS工号代码！");
			return;
		}
		if(document.frm.inValidLoginNo.value != document.frm.yloginNo.value.substring(0,4))
		{
			rdShowMessageDialog("工号的前四位["+document.frm.inValidLoginNo.value+"]不允许修改！");
			document.frm.yloginNo.value = document.frm.inValidLoginNo.value;
			return;
		}
		if(document.frm.yorgNo.value.length=="0")
		{
			rdShowMessageDialog("请输入编号！");
			return;
		}
	}
	else if(document.frm.AccountType.value=="3" )
	{
	//	if(document.frm.FuncNo.value.length=="0")
	//	{
	//		rdShowMessageDialog("请输入管理类BOSS帐号代码！");
	//		return;
	//	}
		if(document.frm.groupName.value.length==0)
		{
			rdShowMessageDialog("请选择组织节点！");
			return;
		}
	}
	else  //.AccountType.value == "2"
	{
		if(document.frm.AccountNo.value.length=="0")
		{
			rdShowMessageDialog("请输入客服帐号代码！");
			return;
		}
		if(document.frm.groupName.value.length==0)
		{
			rdShowMessageDialog("请选择组织节点！");
			return;
		}

		//document.frm.power_code.value = "019901";
	}
	//**************************************
	if(document.frm.yloginName.value.length=="0")
	{
		rdShowMessageDialog("请输入工号名称！");
		return;
	}
	if(document.frm.yloginPass.value=="")
	{
	  rdShowMessageDialog("请输入密码！");
		return;
	}
	if(document.frm.yloginPass.value != document.frm.ycfmPass.value)
	{
		rdShowMessageDialog("两次输入密码不一致！");
		return;
	}
	if(document.frm.power_code.value=="")
	{
	  rdShowMessageDialog("请选择角色代码！");
		return;
	}
	if($("#oaNumber").val()==""){
		rdShowMessageDialog("请输入OA编号！");
		return;
	}
	if($("#oaTitle").val()==""){
		rdShowMessageDialog("请输入OA标题！");
		return;
	}
	if(forDate(document.frm.yallowBegin)==false)
	{
		return;
	}
	if(forDate(document.frm.yexpireTime)==false)
	{
		return;
	}
	if(forDate(document.frm.yallowEnd)==false)
	{
		return;
	}

	if(document.frm.ydeptCode.value.length=="0")
	{
		document.frm.ydeptCode.value="";
	}
	var radioJ = 0;
	for(radioJ = 0 ; radioJ < document.frm.yvalidFlag.length ; radioJ ++)
	{
		if(document.frm.yvalidFlag[radioJ].checked)
		{
			document.frm.valid_flag.value = document.frm.yvalidFlag[radioJ].value;
		}
	}
	var radioK = 0;
	for(radioK = 0 ; radioK < document.frm.ymaintainFlag.length ; radioK++)
	{
		if(document.frm.ymaintainFlag[radioK].checked)
		{
			document.frm.maintain_flag.value = document.frm.ymaintainFlag[radioK].value;
		}
	}
	var flagI = 0 ;
	for(flagI = 0 ; flagI < document.frm.yloginFlag.length ; flagI ++)
	{
		if(document.frm.yloginFlag.options[flagI].selected)
		{
			document.frm.login_flag.value = document.frm.yloginFlag.options[flagI].value;
		}
	}

	var powerRightI = 0 ;
	for(powerRightI = 0 ; powerRightI < document.frm.ypowerRight.length ; powerRightI ++)
	{
		if(document.frm.ypowerRight.options[powerRightI].selected)
		{
			document.frm.power_right.value = document.frm.ypowerRight.options[powerRightI].value;
		}
	}
	var rptRightI = 0 ;
	for(rptRightI = 0 ; rptRightI < document.frm.yrptRight.length ; rptRightI ++)
	{
		if(document.frm.yrptRight.options[rptRightI ].selected)
		{
			document.frm.rpt_right.value = document.frm.yrptRight.options[rptRightI ].value;
		}
	}
	/* 20091230 增加自助缴费类型 || document.frm.AccountType.value=="4"*/
	if(document.frm.AccountType.value == "1" || document.frm.AccountType.value == "4")
	{
		var regionCodeI = 0 ;
		for(regionCodeI = 0 ; regionCodeI < document.frm.yregionCode.length ; regionCodeI ++)
		{
			if(document.frm.yregionCode.options[regionCodeI].selected)
			{
				document.frm.region_code.value = document.frm.yregionCode.options[regionCodeI].value;
			}
		}
		var disctrictCodeI = 0 ;
		for(disctrictCodeI = 0 ; disctrictCodeI < document.frm.ydisctrictCode.length ; disctrictCodeI ++)
		{
			if(document.frm.ydisctrictCode.options[disctrictCodeI].selected)
			{
				document.frm.disctrict_code.value = document.frm.ydisctrictCode.options[disctrictCodeI].value;
			}
		}
		var townCodeI = 0 ;
		for(townCodeI = 0 ; townCodeI < document.frm.ytownCode.length ; townCodeI ++)
		{
			if(document.frm.ytownCode.options[townCodeI].selected)
			{
				document.frm.town_code.value = document.frm.ytownCode.options[townCodeI].value;
			}
		}
	}

	var reFlagI = 0 ;
	for(reFlagI = 0 ; reFlagI < document.frm.yreFlag.length ; reFlagI ++)
	{
		if(document.frm.yreFlag.options[reFlagI].selected)
		{
			document.frm.re_flag.value = document.frm.yreFlag.options[reFlagI].value;
		}
	}
	var loginStatusI = 0 ;
	for(loginStatusI = 0 ; loginStatusI < document.frm.yloginStatus.length ; loginStatusI ++)
	{
		if(document.frm.yloginStatus.options[loginStatusI].selected)
		{
			document.frm.login_status.value = document.frm.yloginStatus.options[loginStatusI].value;
		}
	}
	var otherFlagI = 0 ;
	for(otherFlagI = 0 ; otherFlagI < document.frm.yotherFlag.length ; otherFlagI ++)
	{
		if(document.frm.yotherFlag.options[otherFlagI].selected)
		{
			document.frm.other_flag.value = document.frm.yotherFlag.options[otherFlagI].value;
		}
	}
	var zz = 0 ;
	var cTypeCode1 = 0 ;
	for(zz = 0 ; zz < document.frm.yloginFlag.length ; zz ++)
	{
		if(document.frm.yloginFlag.options[zz].selected)
		{
			cTypeCode1 = document.frm.yloginFlag.options[zz].type_value;
		}
	}
	var newCreateLoginNo = document.frm.yloginNo.value;
	if(cTypeCode1=="k")
	{
		document.frm.org_code.value="0000005"+document.frm.yorgNo.value;
		newCreateLoginNo = "k"+document.frm.yloginNo.value;
	}
	else
	{
		document.frm.org_code.value=document.frm.region_code.value+document.frm.disctrict_code.value+
	    		document.frm.town_code.value+document.frm.yloginNo.value.substring(4,6);
	}
    if(!forDate(document.frm.yallowBegin)){
		rdShowMessageDialog("开始时间格式");
		return false;
	}
	if(!forDate(document.frm.yallowEnd)){
		rdShowMessageDialog("开始时间不能大于结束时间");
		return false;
	}
	if(compareDates(document.frm.yallowBegin,document.frm.yallowEnd) != 0){
		rdShowMessageDialog("开始时间不能大于结束时间");
		return false;
    }
	document.frm.submitr.disabled=true;
	
	var myPacket = new AJAXPacket("newSubmit.jsp?loginName="+document.frm.yloginName.value+"&remark="+document.frm.yremark.value,"正在提交，请稍候......");
	myPacket.data.add("workNo",document.frm.ywork_no.value);
	myPacket.data.add("nopass",document.frm.nopass.value);
	myPacket.data.add("opCode",document.frm.op_code.value);
	myPacket.data.add("opType",document.frm.op_type.value);
//	myPacket.data.add("funcNo",document.frm.FuncNo.value);
	myPacket.data.add("AccountNo",document.frm.AccountNo.value);

	myPacket.data.add("groupId",document.frm.groupId.value);
	myPacket.data.add("AccountType",document.frm.AccountType.value);
	myPacket.data.add("loginNo",newCreateLoginNo);
	myPacket.data.add("contractPhoneNo",document.frm.contractPhoneNo.value);
	myPacket.data.add("loginFlag",document.frm.login_flag.value);
	myPacket.data.add("loginPass",document.frm.yloginPass.value);
	myPacket.data.add("powerCode",document.frm.power_code.value);
	myPacket.data.add("powerRight",document.frm.power_right.value);
	myPacket.data.add("rptRight",document.frm.rpt_right.value);
	myPacket.data.add("allowBegin",document.frm.yallowBegin.value);
	myPacket.data.add("allowEnd",document.frm.yallowEnd.value);
	myPacket.data.add("expireTime",document.frm.yexpireTime.value);
	myPacket.data.add("tryTimes",document.frm.ytryTimes.value);
	myPacket.data.add("maintainFlag",document.frm.maintain_flag.value);
	myPacket.data.add("validFlag",document.frm.valid_flag.value);
	myPacket.data.add("orgCode",document.frm.org_code.value);
	myPacket.data.add("deptCode",document.frm.ydeptCode.value);
	myPacket.data.add("lastIpAdd",document.frm.selfIpAddr.value);
	myPacket.data.add("reFlag",document.frm.re_flag.value);
	myPacket.data.add("otherFlag",document.frm.other_flag.value);
	myPacket.data.add("loginStatus",document.frm.login_status.value);
	myPacket.data.add("regionChar",document.frm.yotherFlag.value);
	myPacket.data.add("SEQ_MailCode",document.frm.SEQ_MailCode.value);//20100317 add
	myPacket.data.add("reject_flag",document.frm.reject_flag.value);//diling add for 关于做好天猫商城进驻准备工作的通知@2014/3/10 
	myPacket.data.add("oaNumber",$("#oaNumber").val());
	myPacket.data.add("oaTitle",$("#oaTitle").val());
	core.ajax.sendPacket(myPacket);
	myPacket=null;
}

function selectNoType()
{
	document.frm.yloginNo.value='';
	var z = 0 ;
	var cTypeCode = 0 ;
	var cLoginFlager = 0;
	for(z = 0 ; z < document.frm.yloginFlag.length ; z ++)
	{
		if(document.frm.yloginFlag.options[z].selected)
		{
			cTypeCode = document.frm.yloginFlag.options[z].type_value;
			cLoginFlager = document.frm.yloginFlag.options[z].value;
		}
	}
	if(cTypeCode=="k")
	{
		document.all.khide.style.display='';
		document.all.idLoginNo.maxlength=5;
		document.all.yloginNo.disabled=false;
		document.all.yregionCode.disabled=true;
		document.all.ydisctrictCode.disabled=true;
		document.all.ytownCode.disabled=true;
		document.all.creatNo.disabled=true;
		document.all.yloginNo.maxlength=5;
		var myPacket = new AJAXPacket("getMaxLastOrgNo.jsp","正在创建客服最大工号信息，请稍候......");
		myPacket.data.add("fLoginFlager",cLoginFlager);
		core.ajax.sendPacket(myPacket);
    		myPacket=null;
	}
	else
	{
		document.all.khide.style.display='none';
		document.all.yloginNo.disabled=true;
		document.all.yregionCode.disabled=false;
		document.all.ydisctrictCode.disabled=false;
		document.all.ytownCode.disabled=false;
		document.all.creatNo.disabled=false;
		document.all.yloginNo.maxlength=6;
		document.all.idLoginNo.maxlength=6;
	}
}
//sunwt add function 20080128
function AccTypeChg()
{
	/* 20091230 增加自助缴费类型 || document.frm.AccountType.value=="4"*/
	if(document.frm.AccountType.value == "1" || document.frm.AccountType.value == "4")
	{
		var sysdate = "<%=cuDate%>";
		var dateStringtmp1 = "<%=dateString%>"; //add by sungq
		document.frm.yallowBegin.value = sysdate.substring(0,8) + " 08:00:00";
		document.frm.yallowEnd.value = "20500101 18:00:00";
		document.frm.yotherFlag.value = "N";
		document.frm.ypowerRight.disabled = false;
		document.frm.yrptRight.disabled = false;
		document.frm.yloginFlag.disabled = false;
		document.getElementById("tbAccName").style.display = "none";//不显示
		document.getElementById("tbRegion1").style.display = "";
		document.getElementById("tbRegion2").style.display = "";
		document.getElementById("trPowerCode").style.display = "";
		document.getElementById("tdAccType").style.display = "none";
	//	document.getElementById("tdAccType2").style.display = "none";
		document.getElementById("tdFuncType").style.display = "";
	//	document.getElementById("tdFuncType2").style.display = "";
		document.frm.yexpireTime.value=dateStringtmp1; //add by sungq
	}
	else if(document.frm.AccountType.value == "2")
	{
		//document.frm.yallowBegin.value = "00:00:00";
		//document.frm.yallowEnd.value = "23:59:59";
		var dateStringtmp2 = "<%=dateString2%>";  //add by sungq
		//alert(tmpcurrentTime2);
		document.frm.yotherFlag.disabled = true;
		document.frm.yotherFlag.value = "N";
		document.getElementById("tbAccName").style.display = "";//显示
		document.getElementById("tbRegion1").style.display = "none";
		document.getElementById("tbRegion2").style.display = "none";
		document.getElementById("trPowerCode").style.display = "";
		document.getElementById("tdFuncType").style.display = "none";
	//	document.getElementById("tdFuncType2").style.display = "none";
		document.getElementById("tdAccType").style.display = "";
	//	document.getElementById("tdAccType2").style.display = "";
		document.frm.submitr.disabled=true;
		document.frm.yloginNo.disabled=true;
		document.frm.ypowerRight.disabled = true;
		document.frm.yrptRight.disabled = true;
		document.frm.chkAccNo.disabled = false;
		document.frm.addButton.disabled = false;
		document.frm.AccountNo.disabled = false;
		document.frm.yloginFlag.disabled = true;
		document.frm.ypowerRight.value = "2";
		document.frm.yrptRight.value = "9";
		document.frm.groupId.value = "";
		document.frm.groupName.value = "";
		document.frm.yloginFlag.value = "2";
		document.frm.AccountNo.value = "";
		document.frm.yexpireTime.value=dateStringtmp2; //add by sungq
	}
	else //if((document.frm.AccountType.value == "0")||(document.frm.AccountType.value == "3"))
	{
		var dateStringtmp3 = "<%=dateString%>";  //add by sungq
		document.getElementById("tbAccName").style.display = "";//显示
		document.getElementById("tbRegion1").style.display = "none";
		document.getElementById("tbRegion2").style.display = "none";
		document.getElementById("trPowerCode").style.display = "";
		document.getElementById("tdAccType").style.display = "none";
	//	document.getElementById("tdAccType2").style.display = "none";
		document.getElementById("tdFuncType").style.display = "";
	//	document.getElementById("tdFuncType2").style.display = "";
		document.frm.ypowerRight.disabled = false;
		document.frm.yrptRight.disabled = false;
		document.frm.submitr.disabled = true;
		document.frm.AccountNo.disabled = false;
		document.frm.yloginNo.disabled = true;
	//	document.frm.FuncNo.disabled = false;
		document.frm.addButton.disabled = false;
	//	document.frm.chkFuncNo.disabled = false;
		document.frm.yotherFlag.disabled = false;
		document.frm.yloginFlag.disabled = false;
		document.frm.groupId.value = "";
		document.frm.groupName.value = "";
		document.frm.AccountNo.value = "";
		document.frm.yexpireTime.value=dateStringtmp3; //add by sungq
	}

	document.frm.yloginNo.value = "";
}



function checkAccountNo(opType)
{
	//20160812 liangyl 关于哈尔滨分公司申请新增BOSS系统工号管理员账号的需求
	if(opType=="0"){
		opType="3";
	}
	if(document.frm.AccountType.value.trim()=="2"){//只有客服工号才校验工号只能为数字
				var patrn=/^\d\d\d\d\d\d$/;
				var patrnVal = patrn.test(document.frm.AccountNo.value.trim());
				if(!patrnVal){
						rdShowMessageDialog("工号应该为6位数字!");
						document.frm.AccountNo.value="";
						return;
				}
	}
	if(document.frm.groupId.value.length==0)
	{
		rdShowMessageDialog("管理类BOSS帐号信息不能为空!");
		return;
	}

	if(document.frm.AccountNo.value.length==0)
	{
		rdShowMessageDialog("客服帐号不能为空!");
		return;
	}

	var myPacket = new AJAXPacket("fChkAccNo.jsp?accountNo="+document.frm.AccountNo.value,"正在提交，请稍候......");
	myPacket.data.add("workNo",document.frm.ywork_no.value);
	myPacket.data.add("nopass",document.frm.nopass.value);
	myPacket.data.add("opCode",document.frm.op_code.value);
	myPacket.data.add("opType",opType);
	myPacket.data.add("groupId",document.frm.groupId.value);

	core.ajax.sendPacket(myPacket);
	myPacket=null;
}

function checkFuncNo()
{
	if(document.frm.groupId.value.length==0)
	{
		rdShowMessageDialog("管理类BOSS帐号信息不能为空!");
		return;
	}

	if(document.frm.FuncNo.value.length==0)
	{
		rdShowMessageDialog("管理类BOSS帐号信息不能为空!");
		return;
	}

	var myPacket = new AJAXPacket("fChkAccNo.jsp?accountNo="+document.frm.FuncNo.value,"正在提交，请稍候......");
	myPacket.data.add("workNo",document.frm.ywork_no.value);
	myPacket.data.add("nopass",document.frm.nopass.value);
	myPacket.data.add("opCode",document.frm.op_code.value);
	myPacket.data.add("opType","3");
	myPacket.data.add("groupId",document.frm.groupId.value);

	core.ajax.sendPacket(myPacket);
	myPacket=null;
}

function select_groupId()
{
	if(document.frm.AccountType.value == "2")
	{
		var path = "/npage/public/pubtree/grouptree.jsp?frmName=frm&groupId=groupId&groupName=groupName&serverType=USE&accType=2&selType=C";
	}
	//20160812 liangyl 关于哈尔滨分公司申请新增BOSS系统工号管理员账号的需求 document.frm.AccountType.value=="0"
	else if(document.frm.AccountType.value == "3" || document.frm.AccountType.value=="0")
	{
		var path = "/npage/public/pubtree/grouptree.jsp?frmName=frm&groupId=groupId&groupName=groupName&serverType=USE&accType=3&selType=Z";
	}
	window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}

function getGroupId()
{
	var path = "/npage/public/pubtree/grouptree.jsp?frmName=frm&groupId=grpId&groupName=grpName&serverType=USE&accType=2&selType=C";
	window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}

function groupIdChanged()
{
	var myPacket = new AJAXPacket("getAccountNo.jsp","正在提交，请稍候......");
	myPacket.data.add("accType",document.frm.AccountType.value);
	myPacket.data.add("groupId",document.frm.groupId.value);

	core.ajax.sendPacket(myPacket);
	myPacket=null;
}
//选择角色
function queryPowerCode(str)
{
	var path = "roletree.jsp?formFlag="+str+"&CodeType=power_code&NameType=power_name";
	window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}

/****************角色权限查询部分****************/
function qryPdRoleCode(str)
{
	var path = "roletree.jsp?formFlag="+str+"&CodeType=pdRoleCode&NameType=pdRoleName";
	window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}

function qryPdPdomCode()
{
	var path = "/npage/s8057/functree_qry.jsp?formFlag=frm";
	window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}
function chgRoleName()
{
	if((document.frm.pdRoleCode.value != "") || (document.frm.popedom_code.value != ""))
	{
		resetDropDown(document.all.partPodem);
	}
	else
	{
		fillDropDown(document.all.partPodem);
	}
}

function resetPdom()
{
	document.frm.reset();
	fillDropDown(document.all.partPodem);
}

function qryPopedom()
{
	var pdLoginNo = document.frm.pdLoginNo.value;
	if(pdLoginNo == "")
	{
		rdShowMessageDialog("请输入工号信息查询！");
		return;
	}

	var pdRoleCode = document.frm.pdRoleCode.value;
	var pdPdomCode = document.frm.popedom_code.value;
	var pdPdomType = "";
	var pdi = 0 ;

	for(pdi = 0 ; pdi < document.all.partPodem.length ; pdi ++)
	{
		if(document.all.partPodem.options[pdi].selected)
		{
			pdPdomType = pdi;
		}
	}
	var str = "?loginNo=" + pdLoginNo + "&roleCode="+pdRoleCode
			+ "&pdomCode=" + pdPdomCode + "&pdomType="+pdPdomType;

	window.open("f8002_qry.jsp"+str,'_blank','height=600,width=960,scrollbars=yes');

}
/***********************************************/

function fillSelect(obj,code,text)
{
	obj.length=0;
	var option0 = new Option("--请选择--","");
	obj.add(option0);
	for(var i=0; i<code.length; i++)
	{
		var option1 = new Option(code[i]+"->"+text[i],code[i]);
        obj.add(option1);
	}
}
function FixWidth(selectObj)
{

	if (navigator.userAgent.toLowerCase().indexOf("firefox") > 0) {
		return;
	}

	var newSelectObj = document.createElement("select");
	newSelectObj = selectObj.cloneNode(true);
	newSelectObj.selectedIndex = selectObj.selectedIndex;
	newSelectObj.id="newSelectObj";
  
	var e = selectObj;
	var absTop = e.offsetTop;
	var absLeft = e.offsetLeft;
	while(e = e.offsetParent)
	{
	    absTop += e.offsetTop;
	    absLeft += e.offsetLeft;
	}
	with (newSelectObj.style)
	{
	    position = "absolute";
	    top = absTop + "px";
	    left = absLeft + "px";
	    width = "auto";
	}
   
	var rollback = function(){ RollbackWidth(selectObj, newSelectObj); };
	if(window.addEventListener)
	{
	    newSelectObj.addEventListener("blur", rollback, false);
	    newSelectObj.addEventListener("change", rollback, false);
	}
	else
	{
	    newSelectObj.attachEvent("onblur", rollback);
	    newSelectObj.attachEvent("onchange", rollback);
	}
	
	selectObj.style.visibility = "hidden";
	document.body.appendChild(newSelectObj);
	
	var newDiv = document.createElement("div");
	with (newDiv.style)
	{
	    position = "absolute";
	    top = (absTop-10) + "px";
	    left = (absLeft-10) + "px";
	    width = newSelectObj.offsetWidth+20;
	    height= newSelectObj.offsetHeight+20;;
	    background = "transparent";
	    //background = "green";
	}
	document.body.appendChild(newDiv);
	newSelectObj.focus();
	var enterSel="false";
	var enter = function(){enterSel=enterSelect();};
	newSelectObj.onmouseover = enter;
	
	var leavDiv="false";
	var leave = function(){leavDiv=leaveNewDiv(selectObj, newSelectObj,newDiv,enterSel);};
	newDiv.onmouseleave = leave;
}

function RollbackWidth(selectObj, newSelectObj)
{
    selectObj.selectedIndex = newSelectObj.selectedIndex;
    selectObj.style.visibility = "visible";
    if(document.getElementById("newSelectObj") != null){
       document.body.removeChild(newSelectObj);
    }
}

function removeNewDiv(newDiv)
{
	document.body.removeChild(newDiv);
}

function enterSelect(){
	return "true";
}

function leaveNewDiv(selectObj, newSelectObj,newDiv,enterSel){
	if(enterSel == "true" ){
		RollbackWidth(selectObj, newSelectObj);
		removeNewDiv(newDiv);
	}
}

</script>

</HEAD>
<body>
<FORM action="" method=post name="frm">
	<%@ include file="/npage/include/header.jsp" %>   
	<div class="title">
		<div id="title_zi">操作信息</div>
	</div>

	<TABLE cellSpacing=0>
		<tr>
			<TD nowrap>
				<a id="tabhead1" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showInfo()" value="1">&nbsp;&nbsp;<font id="font1" color="3366cc">查询工号信息&nbsp;&nbsp;</font></a>
			</TD>
 			<TD nowrap>
				<a id="tabhead2" style="CURSOR: hand; TEXT-DECORATION: none" class="tabdisp" href="javascript:onclick=showNew()" value="1">&nbsp;&nbsp;<font id="font2" color="000000">新建工号&nbsp;&nbsp;</font></a>
			</TD>
			<TD nowrap>
				<a id="tabhead3" style="CURSOR: hand; TEXT-DECORATION: none" class="tabdisp" href="javascript:onclick=showOld()" value="1">&nbsp;&nbsp;<font id="font3" color="000000">工号变更信息查询&nbsp;&nbsp;</font></a>
			</TD>
			<TD nowrap>
				<a id="tabhead4" style="CURSOR: hand; TEXT-DECORATION: none" class="tabdisp" href="javascript:onclick=showPdom()" value="1">&nbsp;&nbsp;<font id="font4" color="000000">工号权限信息查询&nbsp;&nbsp;</font></a>
			</TD>			
		</tr>
	</table>	
	<!-- 查询-->	
	<div id=infoDiv>	
		<br>
		<div class="title">
			<div id="title_zi">请输入下列条件查询符合的工号记录</div>
		</div>		
		<table id=tbs9  cellspacing="0">
			<tbody>			
				<tr id="trAccount">
					<td  class="blue">
						<q vType="setNg35Attr" >
						<input id=radio1 type=radio name=qryItem value=0  checked >
						工号代码
						<q>
					</td>
					<td>
						
						<input  id=Text2 type=text size=10 name=work_no maxlength=6>
					</td>
					<td  class="blue">
						<q vType="setNg35Attr">
						<input id=radio1 type=radio name=qryItem value=2 >
						帐户代码
					</q>
					</td>
					<td>
						<input  id=Text3 type=text size=15 name=acc_no maxlength=30>
					</td>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td  class="blue">
						<q vType="setNg35Attr" >
						<input id=radio1 type=radio name=qryItem value=3 >
						组织机构
					</q>
					</td>
					<td>
						<input type="hidden" name="grpId" value="">
						<input  id=Text3 type=text size=15 name=grpName maxlength=30>
						<input name="qryButton" type="button" class="b_text" value="选择" onClick="getGroupId()">
					</td>		
					<td  class="blue">
						<q vType="setNg35Attr" >
						<input id=radio1 type=radio name=qryItem value=1 >
						地 区
					</q>
					</td>
					<td nowrap >
						<select id=part13 size=1 name=regionCode onchange="callDisCode()">
						<%for(int i = 0 ; i < regionCode.length; i ++)
						{%>
							<option value="<%=regionCode[i][0]%>">
								<%=regionCode[i][1]%>
							</option>
						<%}%>
						</select>
					</td>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td class="blue">&nbsp;&nbsp;&nbsp;&nbsp;市&nbsp;&nbsp;&nbsp;&nbsp;县</td>
					<td>
						<div id=disCodeDiv>
							<select id=disCode size=1 name=disctrictCode onchange="callTownCode()">
								<%-- <%for(int i = 0 ; i < disCodeInit1.length ; i ++){%>
									<option value="<%=disCodeInit1[i][1]%>"><%=disCodeInit1[i][2]%></option>
								<%}%> --%>
							</select>
						</div>
					</td>
					<td class="blue">&nbsp;&nbsp;&nbsp;&nbsp;营业厅</td>
					<td>
						<div id=townCodeDiv>
							<select id=tCode size=1 name=townCode>
								<%for(int i = 0 ; i < townCodeInit1.length ; i ++){%>
									<option value="<%=townCodeInit1[i][0]%>"><%=townCodeInit1[i][1]%></option>
								<%}%>
							</select>
						</div>
					</td>
					<td>
						<select name=validFlag>
							<option value="1">有效</option>
							<option value="0">无效</option>
						</select>
					</td>
				</tr>
			</tbody>
		</table>
		<table cellspacing="0">
			<tbody>
				<tr>
					<td id="footer">
						<input type=button class="b_foot" name=inp6 value="查询" onclick="qryLoginNo()"> &nbsp;
						<input type=button  class="b_foot" name=gb value="关闭" onclick="removeCurrentTab()">&nbsp;&nbsp;
					</td>
				</tr>
			</tbody>
		</table>
		<div id=loginDiv style="display:none">
			<table id=tbs9  cellspacing=0 >
				<tr>
					<td width="30%" >
						<font color=white><b>符合条件工号信息列表</b></font>
					</td>
					<td width="70%">&nbsp;</td>
				</tr>
			</table>
			<table id=infoTab width=100% height=25 border=0 align="center" >
				<tbody>
				</tbody>
			</table>
		</div>			
	</div>
	
	<div id=frameDiv style="display:none">
		<iframe name=ifr width=100% height=300 align="center" cellspacing=0 src="blank.htm">
		</iframe>
	</div>
	
	<div id=PdomDiv style="display:none">
		<table  cellspacing="0" >
			<tr>
				<td width="18%" class="blue">&nbsp;工号信息</td>
				<td width="32%">
					<input type="text" name="pdLoginNo" value="" maxlength=6>
					<font class="orange">*</font>
				</td>
				<td width="18%" class="blue">&nbsp;角色信息</td>
				<td width="32%">
					<input type="hidden" name="pdRoleCode" value="">
					<input type="text" name="pdRoleName" value="" readonly class="InputGrey" onChange="chgRoleName()">
					<input type="button" class="b_text" name="setRoleCode"  class="b_text" value="查询" onclick="qryPdRoleCode('frm')">
				</td>
			</tr>
			<tr>
				<td width="18%" class="blue">&nbsp;权限信息</td>
				<td width="32%">
					<input type="hidden" name="popedom_code" value="">
					<input type="text" name="popedom_name" value="" readonly class="InputGrey">
					<input type="button" name="setPdomCode" class="b_text" value="查询" onclick="qryPdPdomCode()">
				</td>
				<td width="18%" class="blue">&nbsp;权限类型</td>
				<td width="32%">
					<select id=partPodem size=1 name="pdPdomType">
						<option value=0 selected > 全部权限 </option>
						<option value=1 > 全部相关权限 </option>
						<option value=2 > 角色权限 </option>
						<option value=3 > 叠加权限 </option>
						<option value=4 > 互斥权限 </option>
						<option value=5 > 叠加和互斥权限 </option>
					</select>
				</td>
			</tr>
	    	</table>

		<TABLE id="tabBusi" style="display:none" cellspacing="0">
			<TR>
				<td nowrap>
					<IFRAME frameBorder=0 id=middle name=middle scrolling="yes"
						style="HEIGHT: 100%; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
					</IFRAME>
				</td>
			</TR>
		</TABLE>

		<table cellspacing="0">
			<tr>
		        	<TD id="footer">
		        		<input  type="button" class="b_foot" name="qryPdom" onclick="qryPopedom()" value="查询">&nbsp;
		        		<input name="resetBtn" class="b_foot" type="button"  value="重置" onclick="resetPdom()">&nbsp;
					<input  type="button" class="b_foot" name="Return" onclick="removeCurrentTab()" value="关闭">
		        	</TD>
	        	</TR>
		</table>
	</div>
<!-------新建界面--------->
	<div id=newDiv >	
			<TABLE cellspacing="0">
				<tbody>
					<tr >
						<td width="18%" nowrap class="blue"> &nbsp;帐户类型</td>
						<td colspan="3" nowrap>
							<select id=idAccType size=1 name=AccountType onchange="AccTypeChg()">
								<% for(int i = 0; i < acctypeArr.length; i++) {
								%>
									<option value="<%=acctypeArr[i][0]%>" <%if(acctypeArr[i][0].equals("1")){%> selected <%}%>> <%=acctypeArr[i][1]%> </option>
								<%
								}%>
							</select>
						</td>
						
					</tr>
				</tbody>
			</table>
			
			<table id="tbAccName" style="display:none"  cellSpacing=0>
				<tbody>
					<tr>
						<td width="18%" class="blue"> &nbsp;组织结构</td>
						<td width="32%">
							<input type="hidden" name="groupId" value="" onchange="groupIdChanged()">
							<input type="text"  name="groupName"  v_must="1" v_type="string" value="" maxlength="60" readonly class="InputGrey">&nbsp;
							<input name="addButton" type="button" class="b_text" value="选择" onClick="select_groupId()">
						</td>
						<td width="18%" nowrap id=tdAccType style="display:none" class="blue">&nbsp;客服类BOSS帐号</td>
						<td width="18%" nowrap id=tdFuncType class="blue">&nbsp;管理类BOSS帐号</td>	
						<td width="32%" size=12 nowrap>
							<input type="text"  size=20 name=AccountNo value="" maxlength=6>
							<input type=button  name=chkAccNo value="验证" class="b_text" onclick="checkAccountNo(document.frm.AccountType.value)">&nbsp;&nbsp;
						</td>	
					</tr>
				</tbody>
			</table>
			
			<table id="tbRegion1" style="display" cellSpacing=0>
				<tbody>
					<tr  type=hidden>
						<td width="18%" nowrap class="blue">&nbsp;地 &nbsp;&nbsp;&nbsp;区</td>
						<td width="32%" >
							<select id=part13 size=1 name=yregionCode onchange="ycallDisCode()"  >
								<%for(int i = 0 ; i < regionCode.length; i ++){%>
									<option value="<%=regionCode[i][0]%>" pvalue="<%=regionCode[i][2]%>"
										<%if(region_codeT.trim().equals(regionCode[i][0])){%> selected <%}%>>
										<%=regionCode[i][1]%>
									 </option>
								<%}%>
							</select>
						</td>
						<td width="18%" nowrap class="blue"> &nbsp;市 &nbsp;&nbsp;&nbsp;县</td>
						<td width="32%" >
							<div id=ydisCodeDiv >
								<select id=disCode size=1 name=ydisctrictCode onchange="ycallTownCode()" >
									<%-- <%for(int i = 0 ; i < disCodeInit.length ; i ++)
									{%>
										<option value="<%=disCodeInit[i][1]%>" pvalue="<%=disCodeInit[i][3]%>"
											<% if(dis_codeT.trim().equals(disCodeInit[i][1])){%> selected <%}%>>
											<%=disCodeInit[i][2]%>
										</option>
									<%}%> --%>
									<option value="02" pvalue="b">呼兰 </option>
									<option value="03" pvalue="c">阿城</option>
								</select>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			
			<table id="tbRegion2" style="display" cellSpacing=0>
				<tbody>
					<tr >
						<td width="18%" nowrap class="blue">&nbsp;营&nbsp;业&nbsp;厅</td>
						<td width="50%">
							<div id=ytownCodeDiv>
							</div>
						</td>
						<td  nowrap>
	                      				<input  id=part14  type=hidden size=10 name=yorgNo value="00"  >
						  	<input type=button  name=creatNo class="b_text" value="生成工号" onclick="creatLoginNo()">
						</td>
					</tr>
				</tbody>
			</table>
			
			<!------------------------------------------------------------------->
			<table id=tbs9  cellspacing=0>
				<tr>
					<td width="18%" class="blue">&nbsp;工号代码</td>
					<td id=khide style="display:none">k</td>
					<td width="32%" >
						<input  id=idLoginNo type=text size=20 name=yloginNo value=""   maxlength=6 >
					</td>
					<td width="18%"  class="blue">&nbsp;工号名称&nbsp;&nbsp;
					</td>
					<td width="32%">
						<input  id=part2  type=text size=20 name=yloginName value=""  >
					</td>
				</tr>				
				<tr>
					<td width="18%" class="blue">&nbsp;工号类型</td>
					<td width="32%" >
						<select id=part3 size=1 name=yloginFlag  onchange="selectNoType()">
							<%-- <%for(int i = 0 ; i < loginTypeStr.length ; i ++){%>
								<option value="<%=loginTypeStr[i][0]%>" type_value="<%=loginTypeStr[i][2]%>">
									<%=loginTypeStr[i][1]%>
								</option>
							<%}%> --%>
							<option value="2" type_value="UnKnown">功号签退</option>
							<option value="3" type_value="UnKnown">功号平帐</option>
						</select>
					</td>
					<td width="18%" class="blue">&nbsp;邮箱地址</td><!--20100317 fengry add for 营业员邮箱需求-->
					<td width="32%"><input id=MailCodeAddr type=text size=40 name=MailCodeAddr readonly=true disabled></td><!--20100317 add-->
				</tr>
			</TABLE>
			
			<table id=tbs9  cellspacing=0>
				<tr>
					<td width="18%" class="blue">&nbsp;工号密码</td>
					<td width="32%" >
						<input  id=part4  type=password size=20 name=yloginPass autocomplete="off" maxlength=6>
					</td>
					<td width="18%" class="blue">&nbsp;确认密码</td>
					<td width="32%">
						<input  id=part5 type=password size=20 name=ycfmPass autocomplete="off" maxlength=6>
					</td>
				</tr>
			</TABLE>
			
			<div id=mainTable>			
				<TABLE cellSpacing=0>
					<TBODY>
						<tr  id="trPowerCode" style="display">
							<td width="18%" class="blue">&nbsp;角色代码</td>
							<td width="32%">
								<input type=text  v_type="string"  v_must=1  name=power_code  maxlength=10 size="10" readonly class="InputGrey">
								<input type=text  name=power_name size=24 maxlength=10 readonly class="InputGrey">
							</td>
							<td width="18%" >
								<input  type="button" name="query_powercode" class="b_text"onclick="queryPowerCode('frm')" value="选择">
							</td>
							<td width="32%" > </td>
						</tr>
						<tr  style="display">
							<td width="18%" class="blue">&nbsp;权限值</td>
							<td width="32%" >
								<select id=part7 size=1 name=ypowerRight  >
									<%
									for(int i = 0 ; i<powerRight.length; i ++)
									{ %>
										<option value="<%=powerRight[i][0]%>" > <%=powerRight[i][0]+"->"+powerRight[i][1]%> </option>
									<%
									}
									%>
								</select>
							</td>
							<td  width="18%" class="blue">报表权限</td>
							<td width=32%">
								<select id=part8 size=1 name=yrptRight  >
								<%for(int i = 0 ; i < rptCode.length; i ++){%>
									<option value="<%=rptCode[i][0]%>" ><%=rptCode[i][1]%></option>
								<%}%>
								</select>
							</td>
						</tr>
					</TBODY>
				</TABLE>
				
				<TABLE   cellSpacing=0>
						<TBODY>
							<tr >
								<td width="18%" class="blue">&nbsp;登陆允许时间</td>
								<td width="32%" >
									<input   id=part9  type=text size=20 name=yallowBegin value="<%=cuDate%>" v_format="yyyyMMdd HH:mm:ss"  onblur="forDate(this)">
									<input   id=part20 type=hidden size=2 name=allowBeginMonth>
									<input 1 id=part21 type=hidden size=2 name=allowBeginDate>
									<input 1 id=part22 type=hidden size=2 name=allowBeginHour>
									<input 1 id=part23 type=hidden size=2 name=allowBeginMinute>
									<input 1 id=part24 type=hidden size=2 name=allowBeginSecond>
								</td>
								<td width="18%"  class="blue">登陆允许结束时间&nbsp; </td>
								<td width="32%">
									<input  id=part10 type=text size=20 name=yallowEnd value="20500101 18:00:00"  v_format="yyyyMMdd HH:mm:ss" onblur="forDate(this)">
									<input 1 id=part25 type=hidden size=2 name=allowEndMonth>
									<input 1 id=part26 type=hidden size=2 name=allowEndDate>
									<input 1 id=part27 type=hidden size=2 name=allowEndHour>
									<input 1 id=part28 type=hidden size=2 name=allowEndMinute>
									<input 1 id=part29 type=hidden size=2 name=allowEndSecond>
								</td>
							</tr>
						</TBODY>
				</TABLE>
				
				<TABLE  cellSpacing=0>
					<TBODY>
						<tr >
							<td width="18%" class="blue">&nbsp;密码到期时间</td>
							<td width="32%" >
								<input  id=part11 type=text size=20 name=yexpireTime value="<%=dateString%>" readonly class="InputGrey" v_format="yyyyMMdd HH:mm:ss">
								<input 1 id=part30 type=hidden size=2 name=expireTimeMonth>
								<input 1 id=part31 type=hidden size=2 name=expireTimeDate>
								<input 1 id=part32 type=hidden size=2 name=expireTimeHour>
								<input 1 id=part33 type=hidden size=2 name=expireTimeMinute>
								<input 1 id=part34 type=hidden size=2 name=expireTimeSecond>
							</td>
							<td width="18%"  class="blue">当前登陆次数</td>
							<td width="32%">
								<input  id=part12 type=text size=20 name=ytryTimes readOnly class="InputGrey" value="">
							</td>
						</tr>
					</TBODY>
				</TABLE>
			
				<TABLE cellSpacing=0>
					<TBODY>
						<tr>
							<td width="18%" class="blue">&nbsp;工号有效标志</td>
							<td width="16%" >
								<q vType="setNg35Attr" >
								<input id=radio1 type=radio name=yvalidFlag value=1  checked >有效
							</q>
							</td>
							<td width="16%" >
								<q vType="setNg35Attr" >
								<input id=radio1 type=radio  name=yvalidFlag value=0 >  无效
							</q>
							</td>
		 					<td width="18%" class="blue">系统维护标志&nbsp; </td>
		 					<td width="16%">
		 						<q vType="setNg35Attr" >
		 						<input id=radio type=radio name=ymaintainFlag value=1>  维护工号
		 					</q>
							</td>
		 					<td width="16%">
		 						<q vType="setNg35Attr" >
		 						<input id=radio type=radio name=ymaintainFlag value=0  checked >  非维护工号
		 					</q>
							</td>
						</tr>
					</TBODY>
				</TABLE>
				
				<TABLE  cellSpacing=0>
					<TBODY>
						<tr>
							<td width="18%" class="blue">&nbsp;工单归属部门</td>
							<td width="32%">
								<input  id=part15 type=text size=20 name=ydeptName value=""  maxlength=5 title="请点击文本框选择工单归属部门" onclick="getDptCode()" readonly class="InputGrey">
								<input type=hidden name=ydeptCode value="">
							</td>			
							<td width="18%" class="blue">&nbsp;身份证号</td>
							<td width="32%" >
								<input type=text  name=contractPhoneNo maxlength=18 v_must="1" v_type="idcard" onblur="checkElement(this)" />
								<font class="orange">*</font>
							</td>
						</tr>
					</TBODY>
				</TABLE>
			
				<TABLE  cellSpacing=0>
					<TBODY>
						<tr >
							<td width="18%" class="blue">&nbsp;上次登陆IP地址</td>
							<td width="32%">
								<input  id=part16 type=text size=16 name=ylastIpAdd value="0.0.0.0">
							</td>
							<td width="18%" class="blue">异地受理标志</td>
							<td width="32%">
								<select name=yotherFlag id=part35>
								    	<option value="N" >不允许</option>
								    	<option value="Y" >允许</option>
								</select>
							</td>
						</tr>
					</TBODY>
				</TABLE>
			
				<TABLE  cellSpacing=0>
					<TBODY>
						<tr>
							<td width="18%" class="blue">&nbsp;重复登陆标志</td>
							<td width="32%" >
								<select name=yreFlag id=part17  >
									<option value="1" >不允许</option>
									<option value="0" >允许</option>
								</select>
							</td>
							<td width="18%">&nbsp;</td>
							<td width="32%">
								<select name=yloginStatus id=part18  style="display:none'">
									<option value="1" >签到</option>
									<option value="2" >签退</option>
								</select>
							</td>
						</tr>
					</TBODY>
				</TABLE>
				<TABLE  cellSpacing=0>
					<TBODY>
						<tr>
							<td width="18%" class="blue">&nbsp;工号操作在实收报表中剔除</td>
							<td colspan="3" >
								<select name="reject_flag" id="part38"  >
									<option value="0" >否</option>
									<option value="1" >是</option>
								</select>
							</td>
						</tr>
					</TBODY>
				</TABLE>
			
				<table  cellspacing="0" >				
					<tr>
						<td  width="18%" class="blue">&nbsp;备注</td>
						<td>
							<input  id=part19 type=text size=88 name=yremark value="" readOnly class="InputGrey">
						</td>
					</tr>
				</table>
				<table id="tbRegion1" style="display" cellSpacing=0>
				<tbody>
					<tr  type=hidden>
						<td width="18%" nowrap class="blue">OA编号</td>
						<td width="32%" >
							<input type="text" id="oaNumber" name="oaNumber" maxlength="30"/><font color="orange">*</font>
						</td>
						<td width="18%" nowrap class="blue">OA标题</td>
						<td width="32%" >
							<input type="text" id="oaTitle" name="oaTitle" maxlength="30"/><font color="orange">*</font>
						</td>
					</tr>
				</tbody>
			</table>
			
				<TABLE  cellSpacing=0>
					<TBODY>
						<TR>
							<TD id="footer">
								<input  name=submitr  class="b_foot" type=button value="确认" onclick="submitt()" id=Button1>&nbsp;&nbsp;
								<input  name=back1  class="b_foot" type=button value=关闭 id=Button2 onclick="removeCurrentTab()">
							</TD>
						</TR>
					</TBODY>
				</TABLE>			
			</div>
			<input type=hidden name=loginPass value="">
			<input type=hidden name=ywork_no value="<%=sWorkNo%>">
			<input type=hidden name=nopass value="<%=dNopass%>">
			<input type=hidden name=op_code value="8002">
			<input type=hidden name=op_type value="0">
			<input type=hidden name=login_flag value="">	
			<input type=hidden name=power_right value="">
			<input type=hidden name=rpt_right value="">
			<input type=hidden name=valid_flag value="">
			<input type=hidden name=maintain_flag value="">
			<input type=hidden name=orgCode value="">
			<input type=hidden name=region_code value="">
			<input type=hidden name=disctrict_code value="">
			<input type=hidden name=town_code value="">
			<input type=hidden name=org_code value="">
			<input type=hidden name=re_flag value="">
			<input type=hidden name=other_flag value="">
			<input type=hidden name=login_status value="">
			<input type=hidden name=inValidLoginNo value="">
			<input type=hidden name=selfIpAddr value="<%=request.getRemoteAddr()%>">
			<input type=hidden name=dateString value=<%=dateString%>>
			<input type=hidden name=SEQ_MailCode value=""><!--20100317 add-->
		</div>
		
		<div id=oldDiv style="display:none">
			<TABLE cellSpacing=0>
				<tr>
					<td width="22%">
						<q vType="setNg35Attr" >
						<input type="radio" name="rdLoginNo" value="1" onclick="checkAccType()" checked >
						工号代码
					</q>
					</td>
					<td width="28%">
						<input   type=text size=16 name=login_no value="">
						<input  type=button class="b_text" name="btnQryLogin" value="查询" onclick="queryLoginchange()">
					</td>
					<td width="22%">
						<q vType="setNg35Attr" >
						<input type="radio" name="rdLoginNo" value="2" onclick="checkAccType()">
						帐号代码
					</q>
					<td width="28%">
						<input   type=text size=16 name=account_no value="" disabled >
						<input  type=button class="b_text" name="btnQryAcc" value="查询" onclick="queryLoginchange()" disabled>
					</td>
				</tr>
				
				<TABLE  cellSpacing=0>
					<tbody >
						<tr>
							<td id="footer">
								<input type=button  class="b_foot" name=closetable value="关闭" onclick="removeCurrentTab()">&nbsp;&nbsp;
							</td>
						</tr>
					</tbody>
				</TABLE>
			</table>
		</div>
		
		<input type=hidden name=opAccType value="<%=accountType%>">
		<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

<script>
/****************sunwt add for popedom*****************/
function fillDropDown(obj)
{
	obj.options.length = 0;
	var option0 = new Option("全部权限","0");
	obj.add(option0);
	var option1 = new Option("全部相关权限","1");
	obj.add(option1);
	var option2 = new Option("角色权限","2");
	obj.add(option2);
	var option3 = new Option("叠加权限","3");
	obj.add(option3);
	var option4 = new Option("互斥权限","4");
	obj.add(option4);
	var option5 = new Option("叠加和互斥权限","5");
	obj.add(option5);
}


   //--用来RESET
function resetDropDown(obj)
{
	obj.options.length=0;
	var option0 = new Option("全部相关权限","1");
	obj.add(option0);
}
/************sunwt add for popedom end *************/
<%
if(accountType.equals("2"))
{
%>
	document.frm.AccountType.disabled = true;
	document.frm.AccountType.value = "2";
	AccTypeChg();
	tabhead4.className="tabdisp";
	//document.getElementById("tabhead4").style.display = "none";
<%
}
%>
</script>

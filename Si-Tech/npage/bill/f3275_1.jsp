<%
/********************
* 功能: 可选套餐包年取消 3275
* version v3.0
* 开发商: si-tech
* update by qidp @ 2008-11-29
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.io.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
    String opCode = "3275";
    String opName = "可选套餐包年取消";
	String iPhoneNo = request.getParameter("srv_no");
	String iLoginNo = request.getParameter("iLoginNo");
	String iOrgCode = request.getParameter("iOrgCode");
	String iOpCode = "3250";
	//String pw_favor = request.getParameter("pw_favor");
	String thepassword = request.getParameter("ipassword");
  ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
  ArrayList retArray = new ArrayList();
  String[][] baseInfoSession = (String[][])arrSession.get(0);
  String[][] otherInfoSession = (String[][])arrSession.get(2);
  String[][] pass = (String[][])arrSession.get(4);

  String loginNo = baseInfoSession[0][2];
  String loginName = baseInfoSession[0][3];
  String powerCode= otherInfoSession[0][4];
  String orgCode = baseInfoSession[0][16];
  String ip_Addr = request.getRemoteAddr();
  String regionCode = orgCode.substring(0,2);
  String disCode = orgCode.substring(2,4);
  String regionName = otherInfoSession[0][5];
  String loginNoPass = pass[0][0];
  String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
  String aftertrim = baseInfoSession[0][5].trim();
  String[][] result = new String[][]{};
  //S1100View callView = new S1100View();
  String sqlStr="";
  int recordNum=0;
  int i=0;

  //comImpl co1 = new comImpl();
  String paraStr[]=new String[1];
  String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
    %>
    <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=iPhoneNo%>" outnum="2" retmsg="retMsg2">
        <wtc:sql><%=prtSql%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retPubSelectArr"  scope="end"/>

  <%
  //paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
  paraStr[0]=retPubSelectArr[0][0];
    ArrayList arrSession2 = (ArrayList)session.getAttribute("allArr");
	  String[][] baseInfoSession2 = (String[][])arrSession2.get(0);


  ArrayList retList = new ArrayList();
  String[][] tempArr= new String[][]{};

  String retFlag="",retMsg="";
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
  String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
  String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
  String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";
  String  breach_fee="",year_fee="";





	//SPubCallSvrImpl co2 = new SPubCallSvrImpl();
	String  inputParsm [] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = "3275";

	System.out.println("iPhoneNo === "+ iPhoneNo);
	System.out.println("loginNo === "+ loginNo);
	System.out.println("orgCode === "+ orgCode);
	System.out.println("iOpCode === "+ iOpCode);
%>

<wtc:service name="s3250Qry" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="err_code_s3250Qry" retmsg="err_msg_s3250Qry" outnum="29">
    <wtc:param value="<%=inputParsm[0]%>"/>
    <wtc:param value="<%=inputParsm[1]%>"/>
    <wtc:param value="<%=inputParsm[2]%>"/>
    <wtc:param value="<%=inputParsm[3]%>"/>
</wtc:service>
<wtc:array id="retS3250QryArr"  scope="end"/>
    
<%
    System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
    System.out.println("err_msg="+err_msg_s3250Qry);
    System.out.println("err_code="+err_code_s3250Qry);
%>

<%
  //retList = co2.callFXService("s3250Qry", inputParsm, "29","phone",iPhoneNo);
  String errCode = err_code_s3250Qry;
  String errMsg = err_msg_s3250Qry;

	//co2.printRetValue();

  if(retS3250QryArr == null)
  {
	   retFlag = "1";
	   retMsg = "s3250Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else
  {
	  if (errCode.equals("000000") ){
//	  tempArr = retS3250QryArr[0][3];
	  if(!(retS3250QryArr[0][3].equals(""))){
	    bp_name = retS3250QryArr[0][3];           //机主姓名
	  }

//	  tempArr = retS3250QryArr[0][4];
	  if(!(retS3250QryArr[0][4].equals(""))){
	    bp_add = retS3250QryArr[0][4];            //客户地址
	  }

//	  tempArr = retS3250QryArr[0][2];
	  if(!(retS3250QryArr[0][2].equals(""))){
	    passwordFromSer = retS3250QryArr[0][2];  //密码
	  }

//	  tempArr = retS3250QryArr[0][11];
	  if(!(retS3250QryArr[0][11].equals(""))){
	    sm_code = retS3250QryArr[0][11];         //业务类别
	  }

//	  tempArr = retS3250QryArr[0][12];
	  if(!(retS3250QryArr[0][12].equals(""))){
	    sm_name = retS3250QryArr[0][12];        //业务类别名称
	  }

//	  tempArr = retS3250QryArr[0][13];
	  if(!(retS3250QryArr[0][13].equals(""))){
	    hand_fee = retS3250QryArr[0][13];      //手续费
	  }

//	  tempArr = retS3250QryArr[0][14];
	  if(!(retS3250QryArr[0][14].equals(""))){
	    favorcode = retS3250QryArr[0][14];     //优惠代码
	  }

//	  tempArr = retS3250QryArr[0][5];
	  if(!(retS3250QryArr[0][5].equals(""))){
	    rate_code = retS3250QryArr[0][5];     //资费代码
	  }

//	  tempArr = retS3250QryArr[0][6];
	  if(!(retS3250QryArr[0][6].equals(""))){
	    rate_name = retS3250QryArr[0][6];    //资费名称
	  }

//	  tempArr = retS3250QryArr[0][7];
	  if(!(retS3250QryArr[0][7].equals(""))){
	    next_rate_code = retS3250QryArr[0][7];//下月资费代码
	  }

//	  tempArr = retS3250QryArr[0][8];
	  if(!(retS3250QryArr[0][8].equals(""))){
	    next_rate_name = retS3250QryArr[0][8];//下月资费名称
	  }

//	  tempArr = retS3250QryArr[0][9];
	  if(!(retS3250QryArr[0][9].equals(""))){
	    bigCust_flag = retS3250QryArr[0][9];//大客户标志
	  }

//	  tempArr = retS3250QryArr[0][10];
	  if(!(retS3250QryArr[0][10].equals(""))){
	    bigCust_name = retS3250QryArr[0][10];//大客户名称
	  }

//	  tempArr = retS3250QryArr[0][15];
	  if(!(retS3250QryArr[0][15].equals(""))){
	    lack_fee = retS3250QryArr[0][15];//总欠费
	  }

//	  tempArr = retS3250QryArr[0][16];
	  if(!(retS3250QryArr[0][16].equals(""))){
	    prepay_fee = retS3250QryArr[0][16];//总预交
	  }

//	  tempArr = retS3250QryArr[0][17];
	  if(!(retS3250QryArr[0][17].equals(""))){
	    cardId_type = retS3250QryArr[0][17];//证件类型
	  }

//	  tempArr = retS3250QryArr[0][18];
	  if(!(retS3250QryArr[0][18].equals(""))){
	    cardId_no = retS3250QryArr[0][18];//证件号码
	  }

//	  tempArr = retS3250QryArr[0][19];
	  if(!(retS3250QryArr[0][19].equals(""))){
	    cust_id = retS3250QryArr[0][19];//客户id
	  }

//	  tempArr = retS3250QryArr[0][20];
	  if(!(retS3250QryArr[0][20].equals(""))){
	    cust_belong_code = retS3250QryArr[0][20];//客户归属id
	  }

//	  tempArr = retS3250QryArr[0][21];
	  if(!(retS3250QryArr[0][21].equals(""))){
	    group_type_code = retS3250QryArr[0][21];//集团客户类型
	  }

//	  tempArr = retS3250QryArr[0][22];
	  if(!(retS3250QryArr[0][22].equals(""))){
	    group_type_name = retS3250QryArr[0][22];//集团客户类型名称
	  }

//	  tempArr = retS3250QryArr[0][23];
	  if(!(retS3250QryArr[0][23].equals(""))){
	    imain_stream = retS3250QryArr[0][23];//当前资费开通流水
	  }

//	  tempArr = retS3250QryArr[0][24];
	  if(!(retS3250QryArr[0][24].equals(""))){
	    next_main_stream = retS3250QryArr[0][24];//预约资费开通流水
	  }

//	  tempArr = retS3250QryArr[0][25];
	  if(!(retS3250QryArr[0][25].equals(""))){
	    print_note = retS3250QryArr[0][25];//工单广告
	  }

//	  tempArr = retS3250QryArr[0][27];
	  if(!(retS3250QryArr[0][27].equals(""))){
	    contract_flag = retS3250QryArr[0][27];//是否托收账户
	  }

//	  tempArr = retS3250QryArr[0][28];
	  if(!(retS3250QryArr[0][28].equals(""))){
	    high_flag = retS3250QryArr[0][28];//是否中高端用户
	  }
	  year_fee=String.valueOf((double) Double.parseDouble(prepay_fee) - Double.parseDouble(lack_fee));
	  breach_fee=String.valueOf((double) Double.parseDouble(year_fee)*3/10);
	  if ((Double.parseDouble(year_fee))<0)
	  {
	  	year_fee="0.00";
	  	breach_fee="0.00";
	  }
	 }else{%>
	 <script language="JavaScript">
<!--
  	rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);
  	 history.go(-1);
  	//-->
  </script>
<%	 }
	}

String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);

%>

<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
<title>可选包年套餐取消</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>


<script language="JavaScript">
<!--
  var arrbrandcode = new Array();//手机型号代码
  var arrbrandname = new Array();//手机型号名称
  var arrbrandmoney = new Array();//代理商代码

  var arrPhoneType = new Array();//手机型号代码
  var arrPhoneName = new Array();//手机型号名称
  var arrAgentCode = new Array();//代理商代码
  var selectStatus = 0;

  var arrsalecode =new Array();
  var arrsaleName=new Array();
  var arrsalebarnd=new Array();
  var arrsaletype=new Array();
  var arrtypemoney=new Array();
  var arrsalemoney=new Array();

  var arrdetbase=new Array();
  var arrdetfree=new Array();
  var arrdetfavour=new Array();
  var arrdetconsume=new Array();
  var arrdetmonbase=new Array();
  var arrdetmode=new Array();
  var arrdetsummoney=new Array();
  var arrdetsalecode=new Array();


  //--------2---------验证按钮专用函数-------------

function frmCfm()
{
	frm.submit();
	return true;
}

 function chkType()
 {
 	document.all.addModeCode.value ="";
 	document.all.addModeName.value ="";
 }
 function getInfo_code()
	{
  	//调用公共js
  	var phoneNo = "<%=iPhoneNo%>";
  	var regionCode = "<%=regionCode%>";
  	var disCode = "<%=disCode%>";
  	var modeCode = "<%=rate_code%>";
  	//alert("region_code="+regionCode);
  	//alert("disCode="+disCode);
  	//alert("modeCode="+modeCode);
    var pageTitle = "可选套餐选择";
    var fieldName = "套餐类别|套餐代码|套餐名称|开始时间|结束时间|状态|";//弹出窗口显示的列、列名
    var sqlStr = "select distinct d.type_name,b.mode_code,b.mode_name,to_char(a.begin_time,'yyyymmdd hh24:mi:ss'),to_char(a.end_time,'yyyymmdd hh24:mi:ss'),'已开通' "+
				 "from dBillCustDetail a,sBillModeCode b,dCustMsg c,sAddModeType d "+
				 "where a.region_code=b.region_code "+
				 "and a.region_code=d.region_code "+
				 "and b.sm_code=d.sm_code "+
				 "and a.mode_code=b.mode_code "+
				 "and a.id_no=c.id_no "+
				 "and c.phone_no='"+phoneNo+"' "+
				 "and b.mode_type=d.mode_type "+
				 "and a.mode_flag='2' and a.mode_time='Y' and a.mode_status='Y'";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "6|0|1|2|3|4|5|";//返回字段
    var retToField = "ModeType|addModeCode|addModeName|oBeginTime|oEndTime|oStatus|";//返回赋值的域
    if(MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,50));

	document.all.do_note.value = "可选包年套餐取消，套餐代码："+document.all.addModeCode.value;
	getMidPrompt("10442",codeChg(document.getElementById("addModeCode").value),"ipTd");
	}

function MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,dialogWidth)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    retInfo = window.showModalDialog(path,"","dialogWidth:"+dialogWidth);
    if(retInfo ==undefined)
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");

    }
	return true;
}

function printCommit()
{
    getAfterPrompt();
 	if(!checkElement(document.all.phoneNo)) return;
	if(document.all.addModeCode.value==""){
		rdShowMessageDialog("请选择可选套餐代码!");
		document.all.addModeCode.focus();
		return false;
	}
	if (document.all.i9.value == "Y")
	{
		rdShowMessageDialog("托收用户不允许办理此业务！");
		return false;
	}

 //打印工单并提交表单
  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
      {
	    frmCfm();
      }
	}
	if(ret=="continueSub")
	{
      if(rdShowConfirmDialog('确认要提交信息吗？')==1)
      {
	    frmCfm();
      }
	}
  }
  else
  {
     if(rdShowConfirmDialog('确认要提交信息吗？')==1)
     {
	   frmCfm();
     }
  }
  return true;
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框
   //var h=150;
   //var w=350;
   //var t=screen.availHeight/2-h/2;
   //var l=screen.availWidth/2-w/2;
   //
   //var printStr = printInfo(printType);
   //
   //var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   //var path = "<%=request.getContextPath()%>/page/innet/hljGdPrintNew.jsp?DlgMsg=" + DlgMessage;
   //var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   //var ret=window.showModalDialog(path,"",prop);
   //return ret;
   
    var h=210;
    var w=400;
    var t=screen.availHeight/2-h/2;
    var l=screen.availWidth/2-w/2;
    
    var pType="subprint";
    var billType="1";
    var sysAccept = "<%=printAccept%>";
    var mode_code = document.all.addModeCode.value+"~";
    var fav_code = null;
    var area_code = null;
    var printStr = printInfo(printType);
    
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
    var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=iPhoneNo%>&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
    var ret=window.showModalDialog(path,printStr,prop);
    return ret;

}

function printInfo(printType)
{

	//var retInfo = "";
	//retInfo+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
	//retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	//retInfo+="手机号码："+document.all.phoneNo.value+"|";
	//retInfo+="客户姓名："+document.all.oCustName.value+"|";
	//retInfo+="证件号码："+document.all.i7.value+"|";
	//retInfo+="客户地址："+document.all.i5.value+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+="用户品牌："+document.all.oSmName.value+"    办理业务：可选包年套餐取消"+"|";
  	//retInfo+="操作流水："+document.all.login_accept.value+"|";
  	//retInfo+="取消的可选包年资费："+document.all.addModeName.value+"--"+document.all.addModeCode.value+"|";
  	//retInfo+="业务生效时间：当日"+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+="备注：由于包年资费未到期，取消包年资费属于违约行为，在本月出帐后，我公司将按剩余"+"|";
	//retInfo+="包年预存的30％收取违约金，之后剩余的预存款将自动转到您的现金账户中。"+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
    //return retInfo;
    
    var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
    var retInfo = "";
	cust_info+="手机号码： "+document.all.phoneNo.value+"|";
	cust_info+="客户姓名： "+document.all.oCustName.value+"|";
	cust_info+="客户地址： "+document.all.i5.value+"|";
	cust_info+="证件号码： "+document.all.i7.value+"|";
	
	opr_info+="用户品牌："+document.all.oSmName.value+"    办理业务：可选包年套餐取消"+"|";
    opr_info+="操作流水："+document.all.login_accept.value+"|";
    opr_info+="取消的可选包年资费："+document.all.addModeName.value+"--"+document.all.addModeCode.value+"|";
	opr_info+="业务生效时间：当日"+"|";
	
	note_info1+="备注："+"|";
	
    retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 

    return retInfo;
}

//-->
</script>

</head>




<body>
	<form name="frm" method="post" action="f3275Cfm.jsp" onKeyUp="chgFocus(frm)">
	    <%@ include file="/npage/include/header.jsp" %>
	    <div class="title">
            <div id="title_zi">套餐选择</div>
        </div>
		<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=paraStr[0]%>">

	<table border="0" >
		<tr>
			<td class="blue">手机号码</td>
            <td>
				<input type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" readonly >
			<td class="blue">业务品牌</td>
            <td>
				<input name="oSmName" type="text" id="oSmName" value="<%=sm_name%>" readonly>
				<input name="oIdNo" type="hidden" id="oIdNo" value="<%=cust_id%>" readonly>
			</td>
		</tr>
		<tr>
			</td>
			<td class="blue">客户名称</td>
			<td>
				<input name="oCustName" type="text" id="oCustName" value="<%=bp_name%>" readonly>
			</td>
			<td class="blue">客户地址</td>
            <td>
				<input name="oCustadd" type="text" id="oCustadd" value="<%=bp_add%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">证件类型</td>
            <td>
				<input name="oIdType" type="text" id="oIdType" value="<%=cardId_type%>" readonly>
			</td>
            <td class="blue">证件号码</td>
            <td>
				<input name="oIdName" type="text" id="oIdName" value="<%=cardId_no%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">当前资费</td>
            <td>
				<input name="oModeCode" type="text" id="oModeCode" value="<%=rate_code%>" readonly>
			</td>
            <td class="blue">资费名称</td>
            <td>
				<input name="oModeName" type="text" id="oModeName" value="<%=rate_name%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">下月资费</td>
            <td>
				<input name="oNextModeCode" type="text" id="oNextModeCode" value="<%=next_rate_code%>" readonly>
			</td>
            <td class="blue">资费名称</td>
            <td>
				<input name="oNextModeName" type="text" id="oNextModeName" value="<%=next_rate_name%>" readonly>
			</td>
		</tr>
		  <tr>
		    <td class="blue">包年期初预存</td>
            <td>
			  <input name="leave_fee" type="text" id="leave_fee" value="<%=prepay_fee%>" readonly>
			</td> 
            <td class="blue">包年未出帐话费</td>
            <td>
			  <input name="lack_fee" type="text" id="lack_fee" value="<%=lack_fee%>" readonly >
            </td>
          </tr>	
          <tr>

            <td class="blue">套餐代码</td>
            <td id="ipTd">
              <input type="text" name="addModeCode" id="addModeCode" v_name="可选套餐代码" readonly>
			  <input class="b_text" type="button" name="qryId_No" value="查询" onClick="getInfo_code()" >
              </select>
			  <font class="orange">*</font>
			</td>
			<td class="blue">包年当前可用余额</td>
            <td>
			  <input name="year_fee" type="text" id="year_fee" value="<%=year_fee%>" readonly >
 			  <input name="breach_fee" type="hidden" id="breach_fee" value="<%=breach_fee%>" readonly>
           </td>
          </tr>
		</tr>
		<tr>
			<td class="blue">套餐类别</td>
            <td>
				<input name="ModeType" type="text" id="ModeType" value="" readonly>
			</td>
            <td class="blue">套餐名称</td>
            <td>
				<input name="addModeName" type="text" id="addModeName" v_type="string" v_must=1 value="" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">开始时间</td>
            <td>
				<input name="oBeginTime" type="text" id="oBeginTime" value="" readonly>
			</td>
            <td class="blue">结束时间</td>
            <td>
				<input name="oEndTime" type="text" id="oEndTime" value="" readonly>
				<input name="oStatus" type="hidden" id="oStatus" value="" readonly>
			</td>
		</tr>
		<tr>
 			<td class="blue">
				备    注
			</td>
            <td colspan="4" >
				<input name="do_note" type="text" id="do_note" value="" size="60" maxlength="60" readonly>
			</td>
		</tr>
				<tr>
                <td nowrap colspan="4" id="footer">
                <div align="center"> 
    				<input class="b_foot" name="commit" id="commit" type="button" class="button"   value="确认&打印" onClick="printCommit();">
                    <input class="b_foot" name="reset" type="reset" class="button" value="清除" >
                    <input class="b_foot" name="back" onClick="history.go(-1)" type="button" class="button" value="返回">
                </div>
                </td>
            </tr>
	</table>
			<input type="hidden" name="iOpCode" value="3275">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
			<input type="hidden" name="i2" value="<%=cust_id%>">
			<input type="hidden" name="i16" value="<%=rate_code%>">
			<input type="hidden" name="ip" value="">

			<input type="hidden" name="belong_code" value="<%=cust_belong_code%>">
			<input type="hidden" name="print_note" value="<%=print_note%>">
			<input type="hidden" name="iAddStr" value="">

			<input type="hidden" name="i1" value="">
			<input type="hidden" name="i4" value="<%=bp_name%>">
			<input type="hidden" name="i5" value="<%=bp_add%>">
			<input type="hidden" name="i6" value="<%=cardId_type%>">
			<input type="hidden" name="i7" value="<%=cardId_no%>">
			<input type="hidden" name="i8" value="<%=sm_code%>--<%=sm_name%>">
			<input type="hidden" name="i9" value="<%=contract_flag%>">

			<input type="hidden" name="ipassword" value="<%=thepassword%>">
			<input type="hidden" name="group_type" value="<%=group_type_code%>--<%=group_type_name%>">
			<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">
			<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">

			<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">
			<input type="hidden" name="i20" value="<%=hand_fee%>">

			<input type="hidden" name="mode_type" value="">
			<input type="hidden" name="New_Mode_Name" value=" ">
			<input type="hidden" name="return_page" value="/npage/bill/f3250_login.jsp">
			<input type="hidden" name="login_accept" value="<%=printAccept%>">
			<input type="hidden" name="send_flag" value="">
			<input type="hidden" name="choiced_flag" value="">
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
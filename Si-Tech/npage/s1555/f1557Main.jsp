<%
/********************
 version v2.0
 开发商: si-tech
 模块：统一领奖
 update zhaohaitao at 2008.12.31
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%
  response.setDateHeader("Expires", 0);
%>
<%@ include file="/npage/include/public_title_name.jsp" %>	
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%		

  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");	
	    
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
%>
<%
  String retFlag="",retMsg="";//用于判断页面刚进入时的正确性
/****************由移动号码得到密码、机主姓名、 等信息 s126bInit***********************/
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String award_type= request.getParameter("award_type");
  String passwordFromSer="";
  
  paraAray1[0] = phoneNo;		/* 手机号码   */ 
  paraAray1[1] = loginNo; 	    /* 操作工号   */
  paraAray1[2] = orgCode;	    /* 归属代码   */
  paraAray1[3] = "1557";	    /* 操作代码   */
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  //retList = impl.callFXService("s1557Init", paraAray1, "29","phone",phoneNo);
%>
	<wtc:service name="s1557Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="29">			
		<wtc:param value="<%=paraAray1[0]%>" />
		<wtc:param value="<%=paraAray1[1]%>" />
		<wtc:param value="<%=paraAray1[2]%>" />
		<wtc:param value="<%=paraAray1[3]%>" />
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",print_note="",contract_flag="",high_flag="";
  //String[][] tempArr= new String[][]{};
  String errCode = retCode1;
  String errMsg = retMsg1;
  if(tempArr.length==0)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s1557Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(retCode1.equals("000000") && tempArr.length>0)
  {
	
	    bp_name = tempArr[0][3];//机主姓名
	
	    bp_add = tempArr[0][4];//客户地址
	 
	    passwordFromSer = tempArr[0][2];//密码
	
	    sm_code = tempArr[0][11];//业务类别
	
	    sm_name = tempArr[0][12];//业务类别名称
	 
	    hand_fee = tempArr[0][13];//手续费
	 
	    favorcode = tempArr[0][14];//优惠代码
	 
	    rate_code = tempArr[0][5];//资费代码
	 
	    rate_name = tempArr[0][6];//资费名称
	 
	    next_rate_code = tempArr[0][7];//下月资费代码
	 
	    next_rate_name = tempArr[0][8];//下月资费名称
	
	    bigCust_flag = tempArr[0][9];//大客户标志
	 
	    bigCust_name = tempArr[0][10];//大客户名称
	  
	    lack_fee = tempArr[0][15];//总欠费
	 
	    prepay_fee = tempArr[0][0];//总预交
	  
	    cardId_type = tempArr[0][17];//证件类型
	 
	    cardId_no = tempArr[0][18];//证件号码
	 
	    cust_id = tempArr[0][19];//客户id
	  
	    cust_belong_code = tempArr[0][20];//客户归属id
	  
	    group_type_code = tempArr[0][21];//集团客户类型
	 
	    group_type_name = tempArr[0][22];//集团客户类型名称
	 
	    imain_stream = tempArr[0][23];//当前资费开通流水
	 
	    next_main_stream = tempArr[0][24];//预约资费开通流水
	
	    print_note = tempArr[0][25];//工单广告
	
	    contract_flag = tempArr[0][27];//是否托收账户
	 
	    high_flag = tempArr[0][28];//是否中高端用户
	 
	}else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
	       retMsg = "s1557Init查询号码基本信息失败!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		}
	}

//********************得到营业员权限，核对密码，并设置优惠权限*****************************//   
   //优惠信息
  String[][] favInfo = (String[][])session.getAttribute("favInfo");   //数据格式为String[0][0]---String[n][0]
  String handFee_Favourable = "readonly";        //a230  手续费
  int infoLen = favInfo.length;
  String tempStr = "";
  for(int i=0;i<infoLen;i++)
  {
    tempStr = (favInfo[i][0]).trim();
   
	if(tempStr.compareTo(favorcode) == 0)
    {
      handFee_Favourable = "";
    }
  }
 
//******************得到下拉框数据***************************//

  //业务类型 
  //sqlsawardop  = "select distinct awardop_code,awardop_name,mode_flag,mode_code from sawardop order by awardop_code" ;
  //ArrayList sawardopArr  = co.spubqry32("4",sqlsawardop );
  //礼品分类
  String sqlawardCode  = "";  
  sqlawardCode  = "select distinct awardflag_code,awardflag_name,awardtype_code,awardop_code from sawardsinfo order by awardflag_code";
  //ArrayList awardCodeArr  = co.spubqry32("4",sqlawardCode );
%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode2" retmsg="retMsg2" outnum="4">
	<wtc:sql><%=sqlawardCode%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="awardCodeStr" scope="end" />
<%
  //价值分档
  String sqlmoney  = "";  
  sqlmoney  = "select distinct money_flag,awardtype_code,awardop_code,awardflag_code from sawardsinfo order by money_flag";
  //ArrayList moneyflagArr  = co.spubqry32("4",sqlmoney );
%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode3" retmsg="retMsg3" outnum="4">
	<wtc:sql><%=sqlmoney%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="moneyflagStr" scope="end" />
<%
  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept();  
%>
<head>
<title>统一领奖 </title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
 
<script language="JavaScript">

  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>");
    history.go(-1);
  <%}%>

<!--
  //定义应用全局的变量
  var SUCC_CODE	= "0";   		//自己应用程序定义
  var ERROR_CODE  = "1";			//自己应用程序定义
  var YE_SUCC_CODE = "0000";	 	//根据营业系统定义而修改

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

  var arrFlagOne = new Array();//扣费方式1
  var arrOrderCode = new Array();//方案代码
  var arrOrderName = new Array();//方案名称
  var arrMachineTypeTwo = new Array();//机器类型2
  var arrFlagTwo = new Array();//扣费方式2
  var arrMachineFee= new Array();
  var arrPreparePay= new Array();
  var arrBindMoney= new Array();

   onload=function()
  {		

  } 

  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
  //***//校验
  function check(){
 	with(document.frm){	  
	  
	 	if( money_flag.value==""){
			rdShowMessageDialog("请选择价值分档");
			return false;
		}
		if(awardflag_code.value==""){
			rdShowMessageDialog("请选择礼品类型");
			return false;
		}
		if(award_info.value==""){
			rdShowMessageDialog("请选择一个礼品");
			return false;
		}
	}
	
	  return true;
	}

  function printCommitTwo(subButton){
   	getAfterPrompt();
	//校验
	if(!check()) 
	{
		
	    return false;
	}
	setOpNote();//为备注赋值
	frm.action = "f1557Confirm_1.jsp";
    //打印工单并提交表单
    var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
    if(typeof(ret)!="undefined")
    {
      if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
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
     var h=200;
     var w=400;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var pType="subprint";                                      // 打印类型：print 打印 subprint 合并打印
	 var billType="1";                                          //  票价类型：1电子免填单、2发票、3收据
	 var sysAccept=<%=printAccept%>;                            // 流水号
	 var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
	 var mode_code=null;                                        //资费代码
	 var fav_code=null;                                         //特服代码
	 var area_code=null;                                        //小区代码
	 var opCode="<%=opCode%>";                                  //操作代码
	 var phoneNo=document.frm.phoneNo.value;                    //客户电话
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
     var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;    
  }

  function printInfo(printType)
  {
	var cust_info=""; //客户信息
	var opr_info=""; //操作信息
	var note_info1=""; //备注1
	var note_info2=""; //备注2
	var note_info3=""; //备注3
	var note_info4=""; //备注4
	var retInfo = "";  //打印内容
	
	cust_info+="手机号码："+document.frm.phoneNo.value+"|";
	cust_info+="客户姓名："+document.frm.bp_name.value+"|";
	//cust_info+="客户地址："+"<%=bp_add%>"+"|";
	//cust_info+="证件号码："+"<%=cardId_no%>"+"|";
	
    opr_info+="业务类型："+"礼品领取"+"|";
    opr_info+="流水："+"<%=printAccept%>"+"|";
    opr_info+="礼品名称："+document.frm.award_info.value+"|";
    opr_info+="工单广告："+"<%=print_note%>"+"|"; 

	note_info1+="备注："+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	return retInfo;
  }




  
 /******为备注赋值********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	   document.frm.opNote.value = "礼品领取;"+document.frm.phoneNo.value+";"+";"+document.frm.award_info.value; 
	}
	
	return true;
}
function awardoptypeChange(){

	if(document.all.awardop_type.value==""){
	rdShowMessageDialog("请选择业务类型");
	return false;
	}
	//if( (document.all.awardop_type.value=="0001") ||(document.all.awardop_type.value=="0002") || (document.all.awardop_type.value=="0003")||(document.all.awardop_type.value=="0004"))
	//if (parseInt(document.all.awardop_type.value,10)<=10)
	//{
   		var getAccountId_Packet = new AJAXPacket("pubGetopType.jsp","");
    	getAccountId_Packet.data.add("retType","getawardType");
		getAccountId_Packet.data.add("awardtype","<%=award_type%>");
		getAccountId_Packet.data.add("awardop_code",document.all.awardop_type.value);
	
		getAccountId_Packet.data.add("cust_id","<%=cust_id%>");
	
		getAccountId_Packet.data.add("regionCode","<%=regionCode%>");
	
		core.ajax.sendPacket(getAccountId_Packet);
		getAccountId_Packet=null;
	//}

}
function doProcess(packet)
{	
	var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage");	
    if(retType=="getawardType")
    {
    	if(retCode=="000000")
	 {
	  	awardflagcode();
	  	
	  	
         	//var sawardflagcode()im_type = packet.data.findValueByName("sim_type");    	    
        	// var sim_typename = packet.data.findValueByName("sim_typename");
		//document.all.simType.value=jtrim(sim_type);
		// document.all.simTypeName.value=jtrim(sim_typename);
	  }
      	else
      	{
		retMessage = retMessage + "[errorCode2:" + retCode + "]";
		rdShowMessageDialog(retMessage,0);
		dawardflagcode();
		dmoneyflag();
		return false;
      	}
      	
     }
     
    

}
 var arrawardcode= new Array();
 var arrawardname= new Array();
 var arrawardtype= new Array();
 var arrawardop= new Array();
 var arrmoneytype= new Array();
 var arrmoneyop= new Array();
 var arrmoney= new Array();
 var arrmoneyawardflag=new Array();
  <%
 for(int i=0;i<awardCodeStr.length;i++)
  {
	out.println("arrawardcode["+i+"]='"+awardCodeStr[i][0]+"';\n");
	out.println("arrawardname["+i+"]='"+awardCodeStr[i][1]+"';\n");
	out.println("arrawardtype["+i+"]='"+awardCodeStr[i][2]+"';\n");
	out.println("arrawardop["+i+"]='"+awardCodeStr[i][3]+"';\n");
  } 
  for(int l=0;l<moneyflagStr.length;l++)
  {
	out.println("arrmoney["+l+"]='"+moneyflagStr[l][0]+"';\n");
	System.out.println("arrmoney["+l+"]='"+moneyflagStr[l][0]+"';\n");
	out.println("arrmoneytype["+l+"]='"+moneyflagStr[l][1]+"';\n");
	out.println("arrmoneyop["+l+"]='"+moneyflagStr[l][2]+"';\n");
	out.println("arrmoneyawardflag["+l+"]='"+moneyflagStr[l][3]+"';\n");
	
  } 
  %> 
//清空礼品类型下拉框
function dawardflagcode(){
	for (var q= document.all.awardflag_code.options.length;q>=0;q--){  document.all.awardflag_code.options[q]=null;}
}
//生成礼品类型下拉框
function awardflagcode(){
   
	var y ;
	 var myEle ;
   var x ;
   
   // Empty the second drop down box of any choices
   for (var q= document.all.awardflag_code.options.length;q>=0;q--){  document.all.awardflag_code.options[q]=null;}
   
   // ADD Default Choice - in case there are no values
   myEle = document.createElement("option") ;
   myEle = document.createElement("option") ;
        myEle.value = "";
        myEle.text ="--请选择--";
         document.all.awardflag_code.add(myEle) ;
   for ( x = 0 ; x <  arrawardcode.length  ; x++ )
 {
  	
      if ( document.all.awardop_type.value==arrawardop[x] && <%=award_type%>==arrawardtype[x] )
      {
        myEle = document.createElement("option") ;
        myEle.value = arrawardcode[x] ;
        myEle.text = arrawardname[x] ;
         document.all.awardflag_code.add(myEle) ;
       
      }
   }
}
//清空价值分档下拉框
function dmoneyflag(){
	for (var q= document.all.money_flag.options.length;q>=0;q--){  document.all.money_flag.options[q]=null;}
	 dawardinfo();
}
function moneyflagchange(){
moneyflag();
dawardinfo();
}
//生成价值分档下拉框
function moneyflag(){
	var y ;
	 var myEle ;
   var x ;
   
   // Empty the second drop down box of any choices
   for (var q= document.all.money_flag.options.length;q>=0;q--){  document.all.money_flag.options[q]=null;}
   
   // ADD Default Choice - in case there are no values
   myEle = document.createElement("option") ;
   myEle = document.createElement("option") ;
        myEle.value = "";
        myEle.text ="--请选择--";
         document.all.money_flag.add(myEle) ;
        // alert(arrmoneyop.length);
   for ( x = 0 ; x <  arrmoneyop.length  ; x++ )
 {
  	
      if ( document.all.awardop_type.value==arrmoneyop[x] && <%=award_type%>==arrmoneytype[x] && document.all.awardflag_code.value==arrmoneyawardflag[x])
      {
        myEle = document.createElement("option") ;
        myEle.value = arrmoney[x] ;
        myEle.text = arrmoney[x] ;
         document.all.money_flag.add(myEle) ;
       
      }
   }
   dawardinfo();
}
function choiceSelWay(){
	if( document.all.money_flag.value==""){
		rdShowMessageDialog("请选择价值分档");
		return false;
	
	}
	if(document.all.awardflag_code.value==""){
		rdShowMessageDialog("请选择礼品类型");
		return false;
	}
	getawardinfo();
}
function getawardinfo(){
 	var pageTitle = "礼品信息查询";
	var fieldName = "礼品ID|礼品名称|";
	var sqlStr = "select awardinfo_code,award_info from sawardsinfo where awardtype_code='"+"<%=award_type%>"+"' and awardop_code='"+document.all.awardop_type.value+"' and awardflag_code='"+document.all.awardflag_code.value+"' and money_flag='"+document.all.money_flag.value+"'";	
	var selType = "S";    //'S'单选；'M'多选
   	var retQuence = "2|0|1|";
	var retToField = "in0|in1|";
	custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 
}
function custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    /*
    参数1(pageTitle)：查询页面标题
    参数2(fieldName)：列中文名称，以'|'分隔的串
    参数3(sqlStr)：sql语句
    参数4(selType)：类型1 rediobutton 2 checkbox
    参数5(retQuence)：返回域信息，返回域个数＋ 返回域标识，以'|'分隔，如"3|0|2|3"表示返回3个域0，2，3
    参数6(retToField))：返回值存放域的名称,以'|'分隔
    */
  
    var path = "pubGetawardInfo.jsp";   //密码为*
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
   
    retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");

    if(typeof(retInfo) == "undefined")     
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
   
}
function dawardinfo(){
   document.all.award_info.value="";
   document.all.awardinfo_code.value="";
}
//-->
</script>

</head>


<body>
<form name="frm" method="post">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

<table cellspacing="0">
	<tr>
		<td class="blue">手机号码</td>
		<td>
			<input name="phoneNo" type="text" class="InputGrey" id="phoneNo" value="<%=phoneNo%>" readonly> 
		</td> 
		<td class="blue">机主姓名</td>
		<td>
			<input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>	
			<input name="award_type" type="hidden" value=<%=award_type%>> 		  
		</td>           
	</tr>
	<tr > 
		<td class="blue">业务品牌</td>
		<td>
			<input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_code + "--" + sm_name%>" readonly>
		</td>
		<td class="blue">大客户标志</td>
		<td>
			<input name="bigCust_flag" type="text" class="InputGrey" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" readonly>
		</td>            
	</tr>
	<tr> 
		<td class="blue">证件类型</td>
		<td>
			<input name="cardId_type" type="text" class="InputGrey" id="cardId_type" value="<%=cardId_type%>" readonly>
		</td>
		<td class="blue">证件号码</td>
		<td>
			<input name="cardId_no" type="text" class="InputGrey" id="cardId_no" value="<%=cardId_no%>" readonly>
		</td>            
	</tr>
	<tr> 
		<td class="blue">当前主套餐</td>
		<td colspan="3">
			<input name="rate_name" type="text" class="InputGrey" id="rate_name" value="<%=rate_code+"--"+rate_name%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">业务类型</td>
		<td colspan="3">
		<select  name="awardop_type" class="button"  onChange="awardoptypeChange()">
		<option value="">--请选择--</option>
		<wtc:qoption name="sPubSelect" outnum="4">
		<wtc:sql>select distinct awardop_code,awardop_name,mode_flag,mode_code from sawardop order by awardop_code</wtc:sql>
		</wtc:qoption>
		</select>
		<font color="orange">*</font>
		</td>
	</tr>
	<tr>
		<td class="blue">礼品类型</td>
		<td>
		<select  name="awardflag_code" size=1 class="button" onChange="moneyflagchange()" >
		
		</select>
		<font color="orange">*</font>
		</td> 
		<td class="blue">价值分档</td>
		<td>
		<select  name="money_flag" size=1 class="button" onChange="dawardinfo()">
		
		</select>
		<font color="orange">*</font>
		</td> 
	</tr>
	<tr >
		<td class="blue">礼品名称</td>
		<td colspan="3">
			<input name="award_info" type="text" class="InputGrey" id='in1' readonly>
			<input name="awardinfo_code" type="hidden" id='in0'>
			<input name=custIdQuery type=button onClick="choiceSelWay();" class="b_text" style="cursor:hand" id="custIdQuery" value=信息查询>
		</td>
	</tr>
	<tr> 
		<td class="blue">备注</td>
		<td colspan="3">
			<input name="opNote" type="text" value="" size="40" onfocus="setOpNote()" readOnly> 
		</td>
	</tr>
	<tr> 
	<td id="footer" colspan="4"> 
		<div align="center"> 
		<input name="commit" id="commit" type="button" class="b_foot" value="确认&打印" onClick="printCommitTwo(this)" >
		<input name="reset" type="reset" class="b_foot" value="清除" >
		<input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
		</div>
	</td>
	</tr>
</table>
 
  <input type="hidden" name="iOpCode">
  <input type="hidden" name="iAddStr">
  <input type="hidden" name="belong_code">
  <input type="hidden" name="i2">
  <input type="hidden" name="i16">
  <input type="hidden" name="ip">
  <input type="hidden" name="i1">
  <input type="hidden" name="i4" value="<%=bp_name%>">
  <input type="hidden" name="i5">
  <input type="hidden" name="i6">
  <input type="hidden" name="i7">
  <input type="hidden" name="ipassword">
  <input type="hidden" name="group_type">
  <input type="hidden" name="ibig_cust">
  <input type="hidden" name="i18">
  <input type="hidden" name="i19">
  <input type="hidden" name="i20">
  <input type="hidden" name="i8">
  <input type="hidden" name="do_note">
  <input type="hidden" name="favorcode">
  <input type="hidden" name="maincash_no">
  <input type="hidden" name="imain_stream">
  <input type="hidden" name="next_main_stream">
  <input type="hidden" name="new_rate_code">
  <input type="hidden" name="pay_type">
  <input type="hidden" name="flag_code_1">
  <input type="hidden" name="region_code" value='<%=regionCode%>'>
  <input type="hidden" name="sm_code" value='<%=sm_code%>'>
  <input type="hidden" name="order_code">
  <input type="hidden" name="print_note" value="<%=print_note%>">
  <input type="hidden" name="printAccept" value="<%=printAccept%>">
  <input type="hidden" name="opCode" value="<%=opCode%>">
  <input type="hidden" name="opName" value="<%=opName%>">
  <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
<script language="JavaScript">
  <%if((high_flag.trim()).equals("Y")){%>
    rdShowMessageDialog('提示: 请注意,该用户为中高端用户！');
  <%}%>
</script>

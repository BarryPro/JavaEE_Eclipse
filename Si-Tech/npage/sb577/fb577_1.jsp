<%
/********************
 version v2.0
开发商: si-tech
update: huangrong@2010-09-15
********************/

%>
 <!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  String opCode = "b577";     
  String opName = "预存话费赠黑莓终端申请";

  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String powerCode= (String)session.getAttribute("powerCode");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = (String)session.getAttribute("ipAddr");
  String regionCode = orgCode.substring(0,2);
  
  String loginNoPass = (String)session.getAttribute("password");
  String op_code=request.getParameter("opCode");
  /*获取系统时间*/
  java.util.Date sysdate = new java.util.Date();
  SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
  String begin_time = sf.format(sysdate);
  String groupId = (String)session.getAttribute("groupId");


%>
<%
  String retFlag="",retMsg="";
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opCode");
  String passwordFromSer="";
  int sale_num = 0;
 
 /* 输出参数： 返回码，返回信息，客户姓名，客户地址，证件类型，证件号码，业务品牌，
 			运行状态，VIP级别，当前积分,可用预存
 */

  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",run_name="",vip="",posint="",prepay_fee="",userpass="";
  String[][] result2  = null;
%>
<wtc:service  name="s1145Qry" routerKey="phone" routerValue="<%=phoneNo%>" outnum="21"  retcode="errCode" retmsg="errMsg">
		<wtc:param value=" "/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opcode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNoPass%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=" "/>
	  <wtc:param  value="21"/>
</wtc:service>
<wtc:array id="retList"  start="0" length="14" scope="end"/>
<wtc:array id="retList2" start="14" length="7" scope="end"/>
<%
  System.out.println("retList"+retList);
  if(retList == null)
  {
	if(!retFlag.equals("1"))
	{
	   System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s1141Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }
  }
  else
  {
  	System.out.println("errCode="+errCode);
  	System.out.println("errMsg="+errMsg);
	if(!errCode.equals("000000")&&!errCode.equals("0")){%>
		<script language="JavaScript">
			rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
			history.go(-1);
		</script>
	<%}
	else
	{
	  bp_name = retList[0][2];
	  bp_add = retList[0][3];
	  cardId_type = retList[0][4];
	  cardId_no = retList[0][5];
	  sm_code = retList[0][6];
	  run_name = retList[0][8];
	  vip = retList[0][9];
	  prepay_fee = retList[0][11];
	  userpass = retList[0][13];
	  result2 = retList2;
	}
  }
%>

<%
//******************得到下拉框数据***************************//
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);

  //手机品牌
 	String sqlAgentCode = " select  unique a.brand_code,trim(b.brand_name) from dphoneSaleCode a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='39' and a.brand_code=b.brand_code and a.valid_flag='Y'";
  System.out.println("sqlAgentCode====="+sqlAgentCode);

  //手机类型
  String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from dphoneSaleCode a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and a.brand_code=b.brand_code and a.sale_type='39' and a.valid_flag='Y'";
  System.out.println("sqlPhoneType====="+sqlPhoneType);

  //营销代码
  String sqlsaleType = "select unique trim(a.sale_code),trim(a.sale_name), a.brand_code,a.type_code from dphoneSaleCode a where a.region_code='" + regionCode + "' and a.sale_type='39' and a.valid_flag='Y' ";
  System.out.println("sqlsaleType====="+sqlsaleType);
  
   //营销明细 zhangyan 修改 应收金额原来是base_fee现在改为 favour_cost
  String sqlsaledet = "select t.favour_cost,t.mon_base_fee,t.consume_term,t.sale_code, 	"
  	+"	t1.allowance_cost, t1.prepay_limit, t1.prepay_gift , "
  	+"	t1.mode_code, t1.all_gift_price , t1.active_term "
  	+"	from dphoneSaleCode t ,dbchnterm.dchnressaleplanact t1 "
  	+"	where 1=1 and t.sale_code=t1.sale_code and t1.plan_code = '39' "
  	+"	and t.region_code='"+regionCode+"'and t.sale_type='39' and t.valid_flag='Y'	";
  System.out.println("zhangyan@sqlsaledet=["+sqlsaledet+"]");
%>
<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlAgentCode%></wtc:sql>
</wtc:pubselect>
<wtc:array id="agentCodeStr" scope="end"/>

<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlPhoneType%></wtc:sql>
</wtc:pubselect>
<wtc:array id="phoneTypeStr" scope="end"/>

<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlsaleType%></wtc:sql>
</wtc:pubselect>
<wtc:array id="saleTypeStr" scope="end"/>
	
<wtc:pubselect name="sPubSelect" outnum="10" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlsaledet%></wtc:sql>
</wtc:pubselect>
<wtc:array id="saledetStr"  scope="end"/>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>

<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" >
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

 <script language=javascript>

 function doProcess(packet){

 	  var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
   	var retMessage = packet.data.findValueByName("retMessage");

    	if(retType == "0"){
			var retResult = packet.data.findValueByName("retResult");
			if(retResult == "000000"){
					rdShowMessageDialog("IMEI号校验成功1!",2);
					document.frm.IMEINo.readOnly=true;
					document.frm.confirm.disabled=false;
					return ;

			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI号校验成功2!",2);
					document.frm.confirm.disabled=false;
					document.frm.IMEINo.readOnly=true;
					return ;

			}else if(retResult == "000003"){
					rdShowMessageDialog("IMEI号不在营业员归属营业厅或IMEI号与业务办理机型不符！",0);
					document.frm.confirm.disabled=true;
					return false;
			}else{
					rdShowMessageDialog("IMEI号不存在或者已经使用！",0);
					document.frm.confirm.disabled=true;
					return false;
			}
		}
	}
 //***IMEI 号码校验
 function checkimeino()
{
	if (document.frm.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!",0);
      document.frm.IMEINo.focus();
      document.frm.confirm.disabled = true;
	 	  return false;
     }
	var myPacket = new AJAXPacket("../s1141/queryimei.jsp","正在校验IMEI信息，请稍候......");
	myPacket.data.add("imei_no",(document.all.IMEINo.value).trim());
	myPacket.data.add("brand_code",(document.all.agent_code.options[document.all.agent_code.selectedIndex].value).trim());
	myPacket.data.add("style_code",(document.all.phone_type.options[document.all.phone_type.selectedIndex].value).trim());
	myPacket.data.add("opcode",(document.all.opcode.value).trim());
	myPacket.data.add("retType","0");

	core.ajax.sendPacket(myPacket);
	myPacket = null;
}

function viewConfirm()
{
	if(document.frm.IMEINo.value=="")
	{
		document.frm.confirm.disabled=true;
	}
}

 </script>
<script language="JavaScript">

<!--
  var arrPhoneType = new Array();
  var arrPhoneName = new Array();
  var arrAgentCode = new Array();

  var arrsalecode =new Array();
  var arrsalename=new Array();
  var arrsalebarnd=new Array();
  var arrsaletype=new Array();
  
  var arrdetbase_fee=new Array(); 
  var arrdetmon_base_fee=new Array();
  var arrdetconsume_term=new Array();
  var arrdetsale_code=new Array();
  
  
	var arrAllowanceCost=new Array();
	var arrPrepayLimit=new Array();
	var arrPrepayGift=new Array();
	var arrModeCode=new Array();
	var arrAllGiftPrice=new Array();
	var arrActiveTerm =new Array();
<%
  for(int i=0;i<phoneTypeStr.length;i++)
  {
	out.println("arrPhoneType["+i+"]='"+phoneTypeStr[i][0]+"';\n");
	out.println("arrPhoneName["+i+"]='"+phoneTypeStr[i][1]+"';\n");
	out.println("arrAgentCode["+i+"]='"+phoneTypeStr[i][2]+"';\n");
  }
  for(int l=0;l<saleTypeStr.length;l++)
  {
	out.println("arrsalecode["+l+"]='"+saleTypeStr[l][0]+"';\n");
	out.println("arrsalename["+l+"]='"+saleTypeStr[l][1]+"';\n");
	out.println("arrsalebarnd["+l+"]='"+saleTypeStr[l][2]+"';\n");
	out.println("arrsaletype["+l+"]='"+saleTypeStr[l][3]+"';\n");
  }
  	/*zhangyan */
	for(int l=0;l<saledetStr.length;l++)
	{
		out.println("arrdetbase_fee["+l+"]='"+saledetStr[l][0]+"';\n");
		out.println("arrdetmon_base_fee["+l+"]='"+saledetStr[l][1]+"';\n");
		out.println("arrdetconsume_term ["+l+"]='"+saledetStr[l][2]+"';\n");
		out.println("arrdetsale_code ["+l+"]='"+saledetStr[l][3]+"';\n");	
		
		out.println("arrAllowanceCost ["+l+"]='"+saledetStr[l][4]+"';\n");	
		out.println("arrPrepayLimit ["+l+"]='"+saledetStr[l][5]+"';\n");	
		out.println("arrPrepayGift ["+l+"]='"+saledetStr[l][6]+"';\n");	
		out.println("arrModeCode ["+l+"]='"+saledetStr[l][7]+"';\n");		
		out.println("arrAllGiftPrice ["+l+"]='"+saledetStr[l][8]+"';\n");	
		out.println("arrActiveTerm ["+l+"]='"+saledetStr[l][9]+"';\n");	
	}
%>

  //提交表单
  function frmCfm(){	
  	var pingchuan="";
  	pingchuan+=document.all.sale_code.value+"|"; 
  	pingchuan+=document.all.agent_code.value+"|"; 
  	pingchuan+=document.all.phone_type.value+"|"; 
  	pingchuan+=document.all.Base_Fee.value+"|"; 
  	pingchuan+=document.all.mon_base_fee.value+"|"; 
  	pingchuan+=document.all.Consume_Term.value+"|"; 
  	pingchuan+=document.all.Price.value+"|"; 
  	pingchuan+=document.all.IMEINo.value+"|";   	  	
  	var chuan=document.getElementById("chuan");
  	chuan.value=pingchuan;
		frm.submit();
		return true;
	}

 function printCommit()
 {
		getAfterPrompt();
		with(document.frm){
		if(cust_name.value==""){
		rdShowMessageDialog("请输入姓名!",1);
		  cust_name.focus();
		return false;
		}
		if(agent_code.value==""){
		  rdShowMessageDialog("请输入手机品牌!",1);
	      agent_code.focus();
		  return false;
		}
		if(phone_type.value==""){
		  rdShowMessageDialog("请输入手机型号!",1);
	      phone_type.focus();
		  return false;
		}
		if(sale_code.value==""){
		  rdShowMessageDialog("请输入营销方案!",1);
	      sale_code.focus();
		  return false;
		}
		if(payTypeSelect.value==""){
		  rdShowMessageDialog("请输入缴费方式!",1);
	      sale_code.focus();
		  return false;
		}
		if (IMEINo.value.length == 0) {
	      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !",1);
	      IMEINo.focus();
	      confirm.disabled = true;
		  return false;
	     }
	     if(opNote.value=="")
	     {
				opNote.value=phone_no.value+"预存话费赠黑莓终端";
			}
	phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text;
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
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";
	var sysAccept = document.all.login_accept.value;
	var printStr = printInfo(printType);

	var mode_code=null;
	var fav_code=null;
	var area_code=null

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg="+DlgMessage;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}

function printInfo(printType)
{    
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	var retInfo = "";

	cust_info+= "手机号码：     "+document.all.phone_no.value+"|";
	cust_info+= "客户姓名：     "+document.all.cust_name.value+"|";
	cust_info+= "证件号码：     "+document.all.cardId_no.value+"|";
	cust_info+= "客户地址：     "+document.all.cust_addr.value+"|";

	opr_info+="用户品牌："+document.all.sm_code.value+"          办理业务：预存话费赠黑莓终端申请"+"|";
	opr_info+="操作流水："+document.all.login_accept.value+"|"; 	
  	opr_info+="手机型号："+document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text
  				+"      IMEI码："+document.frm.IMEINo.value+"|";		
  var jkinfo="";
  jkinfo+="缴费合计："+document.all.sum_money.value+"元  含：预存话费 "+document.all.sum_money.value+"元"+"|";
		
	opr_info+=jkinfo+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";    
	retInfo+=" "+"|";	
	retInfo+=" "+"|";
		
	note_info1 =retInfo;

	/*zhangyan add*/
	var allowanceCost = document.getElementById("allowanceCost").value;/*预存话费*/
	var prepayLimit=parseInt(document.getElementById("prepayLimit").value);/*话费消费期限*/
	var monBaseFee= (parseInt(allowanceCost)/parseInt(prepayLimit)).toFixed(2) ;/*每月返还话费*/
	
	var prepayGift = document.getElementById("prepayGift").value;/*黑莓功能费*/	
	var modeCode = parseInt(document.getElementById("modeCode").value);/*黑莓功能消费期限*/
	
	var allGiftPrice = document.getElementById("allGiftPrice").value;/*黑莓功能fee*/	 
	var activeTerm = parseInt(document.getElementById("activeTerm").value);/*黑莓功能消费期限*/	 
	var monGiftPrice= (parseInt(allGiftPrice)/parseInt(activeTerm)).toFixed(2) ;/*每月返还话费*/
		
	note_info3="欢迎您参加“预存话费赠黑莓终端活动”，您本次预存话费为"
		+allowanceCost+"元，每月返还话费为"
		+monBaseFee+"元；黑莓BES业务功能费"
		+prepayGift+"元，分"
		+modeCode+"个月返还,系统充值每月为用户充值"
		+monGiftPrice+"元，用以冲销黑莓月功能费。当月未消费完的剩余话费可累积；要求消费年限"
		+prepayLimit+"个月内,用户不可退订已经办理的黑莓功能；"
		+"本次活动未涉及的话音资费，按现行的移动电话资费标准执行，在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行！";

		retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
//-->
</script>

<script language="JavaScript">
<!--
/****************根据agent_code动态生成phone_type下拉框************************/
 function selectChange(control, controlToPopulate, ItemArray, GroupArray)
 {
   var myEle ;
   var x ;
   // Empty the second drop down box of any choices
   for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
   // ADD Default Choice - in case there are no values

   myEle = document.createElement("option") ;
   myEle.value = "";
   myEle.text ="--请选择--";
   controlToPopulate.add(myEle) ;
   for ( x = 0 ; x < ItemArray.length  ; x++ )
   {
      if ( GroupArray[x] == control.value )
      {
        myEle = document.createElement("option") ;
        myEle.value = arrPhoneType[x];
        myEle.text = ItemArray[x] ;
        controlToPopulate.add(myEle) ;
        document.all.type_code.value=arrPhoneType[x];
      }
   }
 }
 
/****************根据phone_type动态生成sale_code下拉框************************/ 
 function typechange(){
  	var myEle1 ;
   	var x1 ;
   	for (var q1=document.all.sale_code.options.length;q1>=0;q1--) document.all.sale_code.options[q1]=null;
   	myEle1 = document.createElement("option") ;
    myEle1.value = "";
    myEle1.text ="--请选择--";
    document.all.sale_code.add(myEle1) ;

   	for ( x1 = 0 ; x1 < arrsaletype.length  ; x1++ )
   	{
      		if ( arrsaletype[x1] == document.all.phone_type.value  && arrsalebarnd[x1] == document.all.agent_code.value )
      		{
        		myEle1 = document.createElement("option") ;
        		myEle1.value = arrsalecode[x1];      	
        		myEle1.text = arrsalename[x1];
        		document.all.sale_code.add(myEle1) ;
      		}
   	}
 }
/****************获取购机款、话费、话费消费期限和应付金额的值************************/ 
function salechage(){
	var x3;
	for ( x3 = 0 ; x3 <arrdetsale_code.length  ; x3++ )
	{ 
		if ( arrdetsale_code[x3] == document.all.sale_code.value ) 
		{   		
			document.all.Price.value=arrdetbase_fee[x3]-(arrdetmon_base_fee[x3]*arrdetconsume_term[x3]);
			document.all.Base_Fee.value=arrdetbase_fee[x3];
			document.all.mon_base_fee.value=arrdetmon_base_fee[x3];
			document.all.sum_money.value=arrdetbase_fee[x3];
			document.all.Consume_Term.value=arrdetconsume_term[x3];  
			
			document.all.allowanceCost.value=arrAllowanceCost[x3];
			document.all.prepayLimit.value=arrPrepayLimit[x3];
			document.all.prepayGift.value=arrPrepayGift[x3];
			document.all.modeCode.value=arrModeCode[x3];
			document.all.allGiftPrice.value=arrAllGiftPrice[x3];				
			document.all.activeTerm.value=arrActiveTerm[x3];	
		}    		
	}
}

//-->
</script>
</head>
<body>
<form name="frm" method="post" action="fb577_2.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">用户信息</div>
	</div>
  <table  cellspacing="0">
	<tr>
            <td class="blue">操作类型</td>
            <td>预存话费赠黑莓终端申请</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
	</tr>
	<tr >
            <td class="blue">客户姓名</td>
            <td>
						  <input name="cust_name" value="<%=bp_name%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" v_name="姓名">
            </td>
            <td class="blue">客户地址</td>
            <td>
						  <input name="cust_addr" value="<%=bp_add%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_addr" maxlength="50" size="50" >
            </td>
	</tr>
	<tr>
            	<td class="blue">证件类型</td>
            <td>
						  <input name="cardId_type" value="<%=cardId_type%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20" >
            </td>
            <td class="blue">证件号码</td>
            <td>
						  <input name="cardId_no" value="<%=cardId_no%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_no" maxlength="20" >
            </td>
	</tr>
	<tr>
            <td class="blue">业务品牌</td>
            <td>
						  <input name="sm_code" value="<%=sm_code%>" type="text" Class="InputGrey" v_must=1 readonly id="sm_code" maxlength="20" >
            </td>
            <td class="blue">运行状态</td>
            <td>
						  <input name="run_type" value="<%=run_name%>" type="text" Class="InputGrey" v_must=1 readonly id="run_type" maxlength="20" >
            </td>
	</tr>
	<tr>
            <td class="blue">VIP级别</td>
            <td>
						  <input name="vip" value="<%=vip%>" type="text" Class="InputGrey" v_must=1 readonly id="vip" maxlength="20" >
            </td>
            <td class="blue">可用预存</td>
            <td>
						  <input name="prepay_fee" value="<%=prepay_fee%>" type="text" Class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" >
            </td>
	</tr>
    </table>
    </div>
    <div id="Operation_Table">
	 <div class="title">
		<div id="title_zi">业务办理</div>
	</div>
	<table cellspacing="0">
	<tr>
            <td class="blue">手机品牌</td>
            <td>
		<select id="agent_code" name="agent_code" v_must=1  onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);" v_name="手机代理商">
						     <option value ="">--请选择--</option>
			                <%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
			                <option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
			                <%}%>			              
			</select>
			                <font class="orange">*</font>
						    </td>
						    <td class="blue">手机型号</td>
            <td>
			<select size=1 name="phone_type" id="phone_type" v_must=1 v_name="手机型号" onchange="typechange()">
		    			<input type="hidden" name="type_code" id="type_code" >
			</select>
			  			   <font class="orange">*</font>
						  </td>
	</tr>
	<tr>
            <td class="blue">营销方案</td>
            <td >
						  <select size=1 name="sale_code" id="sale_code" v_must=1 v_name="营销代码" onchange="salechage()">
			        </select>
			 				<font class="orange">*</font>
						</td>
						<td class="blue">购机款</td>
            <td >
						  <input name="Price" type="text"  id="Price" v_type="money" v_must=1   readonly Class="InputGrey" v_name="手机价格" >
						</td>
	</tr>
	<tr style="display:none">
            <td class="blue">话费</td>
            <td>
						  <input name="Base_Fee" type="text"   id="Base_Fee" v_type="0_9" v_must=1   v_name="话费" Class="InputGrey" readonly>
						  <input name="mon_base_fee" type="hidden"   id="mon_base_fee" v_type="0_9" v_must=1   v_name="每月消费话费" readonly>
						</td>
            <td class="blue">话费消费期限</td>
            <td>
						  <input name="Consume_Term" type="text"   id="Consume_Term" v_type="0_9" v_must=1   v_name="话费消费期限" Class="InputGrey" readonly>
						</td>
	</tr>
	<!--zhangyan add 2011-12-21 14:55:09 b-->
	<input type="hidden" id="allGiftPrice" name="allGiftPrice"><!--黑莓系统冲直-->
	<input type="hidden" id="activeTerm" name="activeTerm"><!--黑莓系统冲直消费期限-->
	<tr>
		<td class="blue">预存话费</td>
		<td>						  
			<input name="allowanceCost" type="text" id="allowanceCost" v_type="0_9"
				v_must=1   v_name="预存话费" Class="InputGrey" readonly>
		</td>		
		<td class="blue">预存话费消费期限</td>
		<td>
			<input name="prepayLimit" type="text" id="prepayLimit" v_type="0_9"
				v_must=1   v_name="预存话费消费期限" Class="InputGrey" readonly>			
		</td>	
	</tr>
	<tr>
		<td class="blue">黑莓功能费</td>
		<td>						  
			<input name="prepayGift" type="text" id="prepayGift" v_type="0_9"
				v_must=1   v_name="黑莓功能费" Class="InputGrey" readonly>
		</td>		
		<td class="blue">黑莓功能费消费期限</td>
		<td>
			<input name="modeCode" type="text" id="modeCode" v_type="0_9"
				v_must=1   v_name="黑莓功能费消费期限" Class="InputGrey" readonly>			
		</td>	
	</tr>
	<!--zhangyan add 2011-12-21 14:55:09 e-->
	<tr>
            <td class="blue">应付金额</td>
            <td >
						  <input name="sum_money" type="text"  id="sum_money" Class="InputGrey" readonly>
						</td>
						
						<td class="blue">缴费方式</td>
						<td colspan="3">
							<select name="payTypeSelect" >
								<option value ="">--请选择--</option>
								<option value="0">现金缴费</option>
							</select>
							<font class="orange">*</font>
						</td>
						
	</tr>					
	<tr>									
					<TD  class="blue" nowrap>
							IMEI码
          </TD>
          <TD >
							<input name="IMEINo"  type="text" v_type="0_9" v_name="IMEI码"  maxlength=15 value="" onblur="viewConfirm()">
							<input name="checkimei" class="b_text" type="button" value="校验" onclick="checkimeino()">
               <font class="orange">*</font>
          </TD>

					<TD class="blue" nowrap>保修时限</TD>
					<TD >
						<input name="repairLimit" v_type="date.month"  size="10" type="text" v_name="保修时限" value="12" onblur="viewConfirm()">
						(个月)<font class="orange">*</font>
					</TD>
	</tr>
	<tr>				
					<td  class="blue">用户备注</td>
          <td colspan="3">
             <input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="预存话费赠黑莓终端申请" >
          </td>
	</tr>
	</table>
    </div>
	<div id="Operation_Table">
	<table cellspacing="0"> 
	<tr>
            <td colspan="6" align="center" id="footer">
                <input name="confirm" type="button" class="b_foot" index="2" value="确认&打印" onClick="printCommit()" disabled >
                <input name="reset" type="reset" class="b_foot" value="清除" >
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
            </td>
	</tr>
	</table>
	</div>
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginNo%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="used_point" value="0" >
    <input type="hidden" name="point_money" value="0" >
    <input type="hidden" name="opcode" value="<%=opCode%>">
    <input type="hidden" name="sale_type" value="39" >
    <input type="hidden" name="phone_typename" >
    <input type="hidden" name="userpass" value="<%=userpass%>" >
	  <input type="hidden" name="op_code" value="<%=op_code%>" >
	  <input type="hidden" name="chuan" id="chuan">
	  	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>


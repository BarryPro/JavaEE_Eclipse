<%
/********************
 * 功能: 合约优惠购机d069
 * 版本: 1.0
 * 日期: 2011-1-11 
 * 作者: 
 * 版权: si-tech
 * update:huangrong
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String iPhoneNo = request.getParameter("activePhone");
  
  			//增加参数区分网站预约和前台办理 wanghyd
	String banlitype =request.getParameter("banlitype");
  
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String region_code = orgCode.substring(0,2);
  String regionCode = (String)session.getAttribute("regCode");
 	String groupId = (String)session.getAttribute("groupId");
 	String loginPwd  = (String)session.getAttribute("password"); 
 	String sqlCustString = "select substr(belong_code ,1,2) from dcustmsg where phone_no ='"+iPhoneNo+"'";
 	String cust_name="";
%>
<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<wtc:sql><%=sqlCustString%></wtc:sql>
</wtc:pubselect>
<wtc:array id="resultCustString" scope="end"/>
<%
  System.out.println("resultCustString"+resultCustString); 
	if(!code.equals("000000")&&!code.equals("0")){%>
		<script language="JavaScript">
			rdShowMessageDialog("查询用户所属地失败，错误代码：<%=code%>，错误信息：<%=msg%>",0);
			history.go(-1);
		</script>
	<%}
	else
	{
		if(resultCustString.length>0&&resultCustString[0][0]!=null)
		{
			cust_name = resultCustString[0][0];
			System.out.println("------------cust_name-------------"+cust_name);
			System.out.println("------------region_code-------------"+region_code);
		}
	  else
  	{%>
  	<script language="JavaScript">
			rdShowMessageDialog("用户所属地为空！",0);
			history.go(-1);
		</script>
  	<%
  	}
	}
	if(!cust_name.equals(region_code))
	{
%>
  	<script language="JavaScript">
			rdShowMessageDialog("用户与操作工号非同一地市，不允许跨地市办理！",0);
			history.go(-1);
		</script>

<%
	}
  String retFlag="",retMsg="";
  String[] paraAray1 = new String[4];
 
 /* 输出参数： 返回码，返回信息，客户姓名，客户地址，证件类型，证件号码，业务品牌，
 			运行状态，VIP级别，当前积分,资费代码,资费名称,可用预存
 */

  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_name="",run_name="",vip="",print_note="",prepay_fee1="",rate_code="",rate_name="",userpass="";
  String[][] result2  = null;
%>
<wtc:service  name="s1145Qry" routerKey="phone" routerValue="<%=iPhoneNo%>" outnum="21"  retcode="errCode" retmsg="errMsg">
		<wtc:param value=" "/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginPwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=" "/>
	  <wtc:param  value="41"/>
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
				rdShowMessageDialog("调用服务s1145Qry出错，错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
				history.go(-1);
			</script>
	<%}
		else
		{
		  bp_name = retList[0][2];
		  bp_add = retList[0][3];
		  cardId_type = retList[0][4];
		  cardId_no = retList[0][5];
		  sm_name = retList[0][6];
		  run_name = retList[0][8];
		  vip = retList[0][9];
		  print_note= retList[0][10];
		  prepay_fee1 = retList[0][11];
		  rate_code = retList[0][12];
		  
		  userpass = retList[0][13];
		  result2 = retList2;
		}
  }
%>
<%
//******************查询资费名称***************************//
  String sqlOffer_name = "select offer_name from product_offer where offer_id ='"+rate_code+"'";
  System.out.println("sqlOffer_name====="+sqlOffer_name);
%>
<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlOffer_name%></wtc:sql>
</wtc:pubselect>
<wtc:array id="resultOffer_name" scope="end"/>
<%
  System.out.println("resultOffer_name"+resultOffer_name); 
	if(!code1.equals("000000")&&!code1.equals("0")){%>
		<script language="JavaScript">
			rdShowMessageDialog("查询资费名称出错，错误代码：<%=code1%>，错误信息：<%=msg1%>",0);
			history.go(-1);
		</script>
	<%}
	else
	{
		if(resultOffer_name.length>0&&resultOffer_name[0][0]!=null)
		{
			rate_name = resultOffer_name[0][0];
		}
	  else
  	{%>
  	<script language="JavaScript">
			rdShowMessageDialog("资费名称为空！",0);
			history.go(-1);
		</script>
  	<%
  	}
	}
%>

<%
  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept();
%>

<%
//******************得到下拉框数据***************************//

  //手机品牌
  String sqlAgentCode = "select unique a.brand_code, trim(b.brand_name) from dphoneSaleCode a, schnresbrand b where a.region_code = '" + regionCode + "' and a.sale_type = '41' and a.brand_code = b.brand_code and a.valid_flag = 'Y'";
  String[] inParamA = new String[2];
  inParamA[0] = "select unique a.brand_code, trim(b.brand_name) from dphoneSaleCode a, schnresbrand b where a.region_code = '" + regionCode + "' and a.sale_type = '41' and a.brand_code = b.brand_code and a.valid_flag = 'Y'"; 
  inParamA[1] = "region_code=" + regionCode ;
  System.out.println("sqlAgentCode====="+sqlAgentCode);
 
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeA" retmsg="retMsgA" outnum="2">
	<wtc:param value="<%=inParamA[0]%>"/>
	<wtc:param value="<%=inParamA[1]%>"/>
	</wtc:service>
	<wtc:array id="agentCodeStr"  scope="end"/>
<%
  //手机类型
  String sqlPhoneType = "select unique a.type_code, trim(b.res_name), b.brand_code from dphoneSaleCode a, schnrescode_chnterm b where a.region_code = '" + regionCode + "'  and a.type_code = b.res_code  and a.brand_code = b.brand_code and a.sale_type ='41' and a.valid_flag = 'Y'"; /*diling 将sale_type的赋值由number变为varchar类型 2011/8/30 11:19:39 */
  String[] inParamB = new String[2];
  inParamB[0] = "select unique a.type_code, trim(b.res_name), b.brand_code from dphoneSaleCode a, schnrescode_chnterm b where a.region_code = '" + regionCode + "'  and a.type_code = b.res_code  and a.brand_code = b.brand_code and a.sale_type ='41' and a.valid_flag = 'Y'"; 
  inParamB[1] = "region_code=" + regionCode ;
  System.out.println("sqlPhoneType====="+sqlPhoneType);
 
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeB" retmsg="retMsgB" outnum="3">
	<wtc:param value="<%=inParamB[0]%>"/>
	<wtc:param value="<%=inParamB[1]%>"/>
	</wtc:service>
	<wtc:array id="phoneTypeStr"  scope="end"/>
<%
  //营销代码
  String sqlsaleType = "select unique trim(a.sale_code), trim(a.sale_name),  a.brand_code, a.type_code from dphoneSaleCode a where a.region_code = '" + regionCode + "'  and a.sale_type = '41'  and a.valid_flag = 'Y'"; 
  String[] inParamC = new String[2];
  inParamC[0] = "select unique trim(a.sale_code), trim(a.sale_name),  a.brand_code, a.type_code from dphoneSaleCode a where a.region_code = '" + regionCode + "'  and a.sale_type = '41'  and a.valid_flag = 'Y' and trim(a.sale_code) not in ('10456584','10456585','10456586','10456587','10456588','10456589','10456590','10456591','10456592','10456593','10456594','10456595','10456596','10456571','10456572','10456573','10456574','10456575','10456576','10456577','10456578','10456579','10456580','10456581','10456582','10456583') "; 
  inParamC[1] = "region_code=" + regionCode ;
  System.out.println("sqlsaleType============================================================"+sqlsaleType);
  
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeC" retmsg="retMsgC" outnum="4">
	<wtc:param value="<%=inParamC[0]%>"/>
	<wtc:param value="<%=inParamC[1]%>"/>
	</wtc:service>
	<wtc:array id="saleTypeStr"  scope="end"/>
<%
 //营销明细 huangrong 修改sqlsaledet增加对“手机电视费”和“手机电视费消费期限” 即 FREE_FEE,ACTIVE_TERM 两个字段的查询 2011-2-17 14:13
  String sqlsaledet="select sale_price, prepay_gift , prepay_limit ,mon_base_fee  ,consume_term ,base_fee  ,sale_code,mode_code,free_fee,to_char(active_term) from dphoneSaleCode where region_code = '" + regionCode + "' and sale_type = '41' and valid_flag = 'Y'"; 
  String[] inParamD = new String[2];
  inParamD[0] = "select sale_price, prepay_gift , prepay_limit ,mon_base_fee  ,consume_term ,base_fee  ,sale_code,mode_code,free_fee,to_char(active_term) from dphoneSaleCode where region_code = '" + regionCode + "' and sale_type = '41' and valid_flag = 'Y' and sale_code not in ('10456584','10456585','10456586','10456587','10456588','10456589','10456590','10456591','10456592','10456593','10456594','10456595','10456596','10456571','10456572','10456573','10456574','10456575','10456576','10456577','10456578','10456579','10456580','10456581','10456582','10456583') "; 
  inParamD[1] = "region_code=" + regionCode ;
  System.out.println("sqlsaledet====="+sqlsaledet);
 
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeD" retmsg="retMsgD" outnum="10">
	<wtc:param value="<%=inParamD[0]%>"/>
	<wtc:param value="<%=inParamD[1]%>"/>
	</wtc:service>
	<wtc:array id="saledetStr"  scope="end"/>
		
<head>
<title><%=opName%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
<!--

  onload=function()
  {
  	document.all.phoneNo.focus();
   	self.status="";
   	
   	  var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/public/qryRealUserState.jsp","正在查询客户是否是实名制客户，请稍候......");
			myPacket.data.add("PhoneNo","<%=iPhoneNo%>");
			core.ajax.sendPacket(myPacket,checkSMZValue);
			myPacket=null;
   }
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
  //var arrdetmode=new Array();
  var arrdetsummoney=new Array();
  var arrdetmodecode=new Array();
  var arrdetsalecode=new Array();   
  var arrfreefee=new Array();
	var arractiveterm=new Array();
  <%
  for(int m=0;m<agentCodeStr.length;m++)
  {
	out.println("arrbrandcode["+m+"]='"+agentCodeStr[m][0]+"';\n");
	out.println("arrbrandname["+m+"]='"+agentCodeStr[m][1]+"';\n");
  }
  for(int i=0;i<phoneTypeStr.length;i++)
  {
	out.println("arrPhoneType["+i+"]='"+phoneTypeStr[i][0]+"';\n");
	out.println("arrPhoneName["+i+"]='"+phoneTypeStr[i][1]+"';\n");
	out.println("arrAgentCode["+i+"]='"+phoneTypeStr[i][2]+"';\n");
  }
  for(int l=0;l<saleTypeStr.length;l++)
  {
	out.println("arrsalecode["+l+"]='"+saleTypeStr[l][0]+"';\n");
	out.println("arrsaleName["+l+"]='"+saleTypeStr[l][1]+"';\n");
	out.println("arrsalebarnd["+l+"]='"+saleTypeStr[l][2]+"';\n");
	out.println("arrsaletype["+l+"]='"+saleTypeStr[l][3]+"';\n");

  }
  for(int l=0;l<saledetStr.length;l++)
  {
  System.out.println("444444444444444444444444444444445````````````````````"+saledetStr.length);
	out.println("arrdetbase["+l+"]='"+saledetStr[l][0]+"';\n");       //缴费合计
	out.println("arrdetfree["+l+"]='"+saledetStr[l][1]+"';\n");       //活动预存
	out.println("arrdetfavour["+l+"]='"+saledetStr[l][2]+"';\n");     //月返费
	out.println("arrdetconsume["+l+"]='"+saledetStr[l][3]+"';\n");    //月底线消费
	out.println("arrdetmonbase["+l+"]='"+saledetStr[l][4]+"';\n");    //消费期限

	out.println("arrdetsummoney["+l+"]='"+saledetStr[l][5]+"';\n");    //购机款
	out.println("arrdetmodecode["+l+"]='"+saledetStr[l][6]+"';\n");    //营销方案代码
  out.println("arrdetsalecode["+l+"]='"+saledetStr[l][7]+"';\n");    //资费代码
	out.println("arrfreefee["+l+"]='"+saledetStr[l][8]+"';\n");       //手机电视费
	out.println("arractiveterm["+l+"]='"+saledetStr[l][9]+"';\n");       //手机电视费消费期限
  }

%>
//--------1---------doProcess函数----------------

  function doProcess(packet)
  {

    var vRetPage=packet.data.findValueByName("rpc_page");
		var retType=packet.data.findValueByName("retType");
		var verifyType = packet.data.findValueByName("verifyType");
		if(retType=="0"){
			var  retResult=packet.data.findValueByName("retResult");
			if(retResult == "000000"){
					rdShowMessageDialog("IMEI号校验成功！",2);
					document.frm.commit.disabled=false;
					document.frm.IMEINo.readOnly = true;
					return ;

			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI号校验成功2！",2);
					document.frm.commit.disabled=false;
					document.frm.IMEINo.readOnly = true;
					return ;

			}else if(retResult == "000003"){
					rdShowMessageDialog("IMEI号不在营业员归属营业厅或IMEI号与业务办理机型不符！");
					document.frm.commit.disabled=true;
					return false;
			}else{
					rdShowMessageDialog("IMEI号不存在或者已经使用！");
					document.frm.commit.disabled=true;
					return false;
			}
	}
 }

  function checkSMZValue(packet) {
      document.all.shiming_state.value="";
			var smzname = packet.data.findValueByName("smzname");
			var smzflag = packet.data.findValueByName("smzvalue");
      document.all.shiming_state.value=smzname;
      if(smzflag=="3") {
      $("#shiming_state").css({"font-weight":"bold" ,"color":"red"});     	
			}else {
			 $("#shiming_state").removeAttr("size"); 
			//alert($("#shiming_state").width());
			$("#shiming_state").width("125");
			//alert($("#shiming_state").width());
			}
}
  //--------2---------验证按钮专用函数-------------

  function checkimeino()
	{
	 if(document.frm.IMEINo.value.length == 0){
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
      document.frm.IMEINo.focus();
      document.frm.commit.disabled = true;
	 	  return false;
     }

		var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/s1141/queryimei.jsp","正在校验IMEI信息，请稍候......");
		myPacket.data.add("imei_no",(document.all.IMEINo.value).trim());
		myPacket.data.add("brand_code",(document.all.agent_code.options[document.all.agent_code.selectedIndex].value).trim());
		myPacket.data.add("style_code",(document.all.phone_type.options[document.all.phone_type.selectedIndex].value).trim());
		myPacket.data.add("opcode",(document.all.opCode.value).trim());
		myPacket.data.add("retType","0");
		core.ajax.sendPacket(myPacket);
		myPacket=null;

	}
	
 function viewConfirm()
 {
	if(document.frm.IMEINo.value=="")
	{
		document.frm.commit.disabled=true;
	}
 }

/*zhangyan add*/
function getMarkPoint()
{
	/*校验*/
	if(!checkElement(document.all.phoneNo)) return;
	
	if(document.all.agent_code.value=="")
	{
		rdShowMessageDialog("请选择手机品牌!");
		document.all.agent_code.focus();
		return false;
	}
	
	if(document.all.phone_type.value=="")
	{
		rdShowMessageDialog("请选择手机型号!");
		document.all.phone_type.focus();
		return false;
	}
	
	if(document.all.sale_code.value=="")
	{
		rdShowMessageDialog("请选择营销代码!");
		document.all.sale_code.focus();
		return false;
	}	
	
	/*指定Ajax调用页*/
	var packet = new AJAXPacket("fd069Ajax.jsp","请稍后...");
		
	/*给ajax页面传递参数*/
	packet.data.add("opCode","<%=opCode%>" );
	packet.data.add("ajaxType","getM" );
	packet.data.add("phoneNo",document.all.phoneNo.value );
	/*购机款*/
	packet.data.add("machPrice",document.all.Phone_Fee.value );
	/*消费积分*/
	packet.data.add("markPoint",  parseInt(document.all.markPoint.value ,10));
	
	/*调用页面,并指定回调方法*/
	core.ajax.sendPacket(packet,setMarkPoint,true);
	packet=null;
}

/*zhangyan add*/
function setMarkPoint(packet)
{
	/*Prepay_Fee 应收金额*/
	var rtCode=packet.data.findValueByName("rtCode"); 	
	var rtMsg=packet.data.findValueByName("rtMsg"); 	
	
	/* 计算应付金额的初始值*/
	for ( x3 = 0 ; x3 < arrdetmodecode.length  ; x3++ )
   	{
  		if ( arrdetmodecode[x3] == document.all.sale_code.value )
  		{
    		document.all.Prepay_Fee.value=arrdetbase[x3];
  		}
   	}		
	if ( rtCode=="000000" )
	{
		
		/*积分对应的钱数*/
		var	rstMarkQry	=packet.data.findValueByName("rstMarkQry"); 
		
		/*表单赋值*/
		document.all.pointMoney.value	= rstMarkQry;
		
		var ppFee=document.all.Prepay_Fee.value ;
		
		/*应收金额-积分兑换的钱数*/
		ppFee=parseFloat(ppFee-rstMarkQry).toFixed(2);
		
		document.all.Prepay_Fee.value=ppFee;
	}
	else
	{
		document.all.markPoint.value="0";
		rdShowMessageDialog(rtCode+":"+rtMsg);
		return false;
	}
}


 function printCommit()
 {
 	/*zhangyan add*/
	if(!check(document.frm) )
	{
		return false;
	}	


 		
		getAfterPrompt();
		document.frm.iAddStr.value=
			document.frm.sale_code.value+"|"
			+document.all.agent_code.options[document.all.agent_code.selectedIndex].text+"|"
			+document.all.phone_type.options[document.all.phone_type.selectedIndex].text+"|"
			+document.frm.Prepay_Fee.value+"|"
			+document.frm.Free_Fee.value+"|"
			+document.frm.Mon_back.value+"|"
			+document.frm.Mon_Base_Fee.value+"|"
			+parseFloat(document.frm.Phone_Fee.value-document.frm.pointMoney.value).toFixed(2)+"|"
			+document.frm.Consume_Term.value+"|"
			+document.frm.i2.value+"|"
			+document.frm.IMEINo.value+"|"
			+document.frm.PhoneFree_Fee.value+"|"
			+document.frm.Active_Term.value+"|";
		
		document.frm.p3.value=document.all.phone_type.options[document.all.phone_type.selectedIndex].innerHTML;
	
		if(!checkElement(document.all.phoneNo)) return;
    if(document.all.agent_code.value==""){
	 		rdShowMessageDialog("请输入手机品牌!");
      document.all.agent_code.focus();
	  	return false;
			}
		if(document.all.phone_type.value==""){
		  rdShowMessageDialog("请输入手机型号!");
	      document.all.phone_type.focus();
		  return false;
		}
		if(document.all.sale_code.value==""){
	 	 	rdShowMessageDialog("请输入营销代码!");
	   	document.all.sale_code.focus();
		  return false;
		}
		if (document.all.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
      document.all.IMEINo.focus();
      document.all.commit.disabled = true;
	 		return false;
     }
     
     // add by wanglma 
        var myPacket = new AJAXPacket("selLimit.jsp","请稍候......");
		myPacket.data.add("printAccept",document.all.printAccept.value);
		myPacket.data.add("iPhoneNo",document.all.phoneNo.value);
		myPacket.data.add("phone_type",document.all.phone_type.options[document.all.phone_type.selectedIndex].value);
		core.ajax.sendPacket(myPacket,doMsg);
		myPacket=null;
		
}

function doMsg(packet){
  var retCode=packet.data.findValueByName("retCode");
  var retMsg=packet.data.findValueByName("retMsg");
  if(retCode == "000000"){
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
  }else{
     rdShowMessageDialog(" errCode :"+retCode +" errMsg : "+retMsg );	
     return;
  }
  
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

  var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=printAccept%>;             	//流水号
	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=null;           							  //资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		  //小区代码
	var opCode="d069" ;                   			 	//操作代码
	var phoneNo="<%=iPhoneNo%>";                  //客户电话
		var iccidInfoStr = "";
	var accInfoStr = "";
		iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" 
			+$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();		

    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
    path+="&mode_code="+mode_code+"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr +
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.frm.phoneNo.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
}

function printInfo(printType)
{
	var cust_info="";  				//客户信息
	var opr_info="";   				//操作信息
	var note_info1=""; 				//备注1
	var note_info2=""; 				//备注2
	var note_info3=""; 				//备注3
	var note_info4=""; 				//备注4
	var retInfo = "";  				//打印内容
	var _consumeTerm = parseInt(document.getElementById("Consume_Term").value,10);/* diling add 消费期限保留整数部分 2011/8/30 11:17:17 */
	
	opr_info+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="手机号码："+document.all.phoneNo.value+"|";
	cust_info+="客户姓名："+document.all.oCustName.value+"|";
	cust_info+="证件号码："+document.all.i7.value+"|";
	cust_info+="客户地址："+document.all.i5.value+"|";

	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	opr_info+="用户品牌："+document.all.oSmName.value+"    办理业务：<%=opName%>"+"|";
  opr_info+="业务流水："+document.all.printAccept.value+"|";
  opr_info+="手机型号："+document.all.phone_type.options[document.all.phone_type.selectedIndex].innerHTML+"    IMEI码："+document.all.IMEINo.value+"|";
	opr_info+="缴费合计："+document.all.Prepay_Fee.value+"元  含：预存话费"+document.all.Save_Fee.value+"元，每月返还金额："+document.all.Mon_back.value+"元，一次性返还："+document.all.Free_Fee.value+"元，月底限消费"+document.all.Mon_Base_Fee.value+"元，手机电视费："+document.all.PhoneFree_Fee.value+"元，每月退还："+document.all.i3.value+"元。业务有效期"+_consumeTerm+"个月（含办理当月）"+"|"; /*diling add  增加业务有效期 2011/8/30 11:17:17 */

	note_info1+="备注："+document.all.do_note.value+"|";

	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

function frmCfm()
{
	  document.all.payType.value = document.all.payTypeSelect.value;
		if(document.all.payType.value=="BX")
  	{
    		/*set 输入参数*/
				var transerial    = "000000000000";  	                    //交易唯一号 ，将会取消
				var trantype      = "00";         //交易类型
				var bMoney        = document.all.Prepay_Fee.value; 				//缴费金额
				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
				var tranoper      = "<%=loginNo%>";                       //交易操作员
				var orgid         = "<%=groupId%>";                       //营业员归属机构
				var trannum       = "<%=iPhoneNo%>";                      //电话号码
				getSysDate();       /*取boss系统时间*/
				var respstamp     = document.all.Request_time.value;      //提交时间
				var transerialold = "";																		//原交易唯一号,在缴费时传入空
				var org_code      = "<%=orgCode%>";                       //营业员归属						
				CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
				if(ccbTran=="succ") posSubmitForm();
  	}
		else if(document.all.payType.value=="BY")
		{
				var transType     = "05";					/*交易类型 */         
				var bMoney        = document.all.Prepay_Fee.value;         /*交易金额 */
				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";         
				var response_time = "";                								 		/*原交易日期 */				
				var rrn           = "";                           				/*原交易系统检索号 */ 
				var instNum       = "";                                   /*分期付款期数 */     
				var terminalId    = "";                    								/*原交易终端号 */			
				getSysDate();       																			//取boss系统时间                                            
				var request_time  = document.all.Request_time.value;      /*交易提交日期 */     
				var workno        = "<%=loginNo%>";                        /*交易操作员 */       
				var orgCode       = "<%=orgCode%>";                       /*营业员归属 */       
				var groupId       = "<%=groupId%>";                       /*营业员归属机构 */   
				var phoneNo       = "<%=iPhoneNo%>";                       /*交易缴费号 */       
				var toBeUpdate    = "";						                        /*预留字段 */         
				var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
				if(icbcTran=="succ") posSubmitForm();
		}else{
				posSubmitForm();
		}
}

	function posSubmitForm(){
		frm.submit();
		return true;
	}
	function getSysDate()
	{
		var myPacket = new AJAXPacket("../public/pos_getSysDate.jsp","正在获得系统时间，请稍候......");
		myPacket.data.add("verifyType","getSysDate");
		core.ajax.sendPacket(myPacket,doSetStsDate);
		myPacket = null;
	}
	function doSetStsDate(packet){
		var verifyType = packet.data.findValueByName("verifyType");
		var sysDate = packet.data.findValueByName("sysDate");
		if(verifyType=="getSysDate"){
			document.all.Request_time.value = sysDate;
			return false;
		}
	}
	function padLeft(str, pad, count)
	{
			while(str.length<count)
			str=pad+str;
			return str;
	}
	function getCardNoPingBi(cardno)
	{
			var cardnopingbi = cardno.substr(0,6);
			for(i=0;i<cardno.length-10;i++)
			{
				cardnopingbi=cardnopingbi+"*";
			}
			cardnopingbi=cardnopingbi+cardno.substr(cardno.length-4,4);
			return cardnopingbi;
	}


 //-------------------

 function selectChange(control, controlToPopulate, ItemArray, GroupArray)
 {
 	/*zhangyan add 手机品牌变化时消费积分清零*/
 	document.all.markPoint.value="0";
 	document.all.Prepay_Fee.value="0.00";
 	
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
        myEle.value = arrPhoneType[x] ;
        myEle.text = ItemArray[x] ;
        controlToPopulate.add(myEle) ;
      }
   }

   document.all.commit.disabled = "true";

 }

 function typechange(){
 	
 	/*zhangyan add 手机类型变化时消费积分清零*/
 	document.all.markPoint.value="0";
 	document.all.Prepay_Fee.value="0.00";
 	
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
        		myEle1.text = arrsaleName[x1];
        		document.all.sale_code.add(myEle1) ;
      		}
   	}
   	document.all.commit.disabled = "true";

 }

 
  function salechage(){
  	/*zhangyan add 营销方案变化时,消费积分和应收金额清0*/
 	document.all.markPoint.value="0";
 	document.all.Prepay_Fee.value="0.00";
  	
	 document.all.commit.disabled = "true";
  	var x3;
	for ( x3 = 0 ; x3 < arrdetmodecode.length  ; x3++ )
   	{
      		if ( arrdetmodecode[x3] == document.all.sale_code.value )
      		{
        		document.all.Base_Fee.value=Number(arrdetfavour[x3])*Number(arrdetmonbase[x3]);
        		document.all.Mon_back.value=arrdetfavour[x3];
        		document.all.Free_Fee.value=arrdetfree[x3];
        		document.all.Consume_Term.value=arrdetmonbase[x3];
        		document.all.Mon_Base_Fee.value=arrdetconsume[x3];
        		document.all.Mon_Base_prefee.value=
        			(Number(Number(arrdetfavour[x3])*Number(arrdetmonbase[x3]))/Number(arrdetmonbase[x3])).toFixed(2);
        		document.all.Prepay_Fee.value=arrdetbase[x3];
        		document.all.Phone_Fee.value=arrdetsummoney[x3];
        		document.all.i2.value=arrdetsalecode[x3];
        		document.all.i3.value=arrfreefee[x3];		
        		document.all.PhoneFree_Fee.value=Number(arrfreefee[x3])*Number(arractiveterm[x3]);
        		document.all.mon_PhoneFree_Fee.value=Number(arrfreefee[x3]);
        		document.all.Active_Term.value=arractiveterm[x3];
        		document.all.Save_Fee.value=Number(arrdetbase[x3])-Number(arrdetsummoney[x3]);
      		}
   	}
    document.frm.i1.value=document.frm.phoneNo.value;
 }


function retFrm(){
	hiddenTip(document.frm.markPoint);
	document.frm.IMEINo.readOnly = false;
	document.frm.reset();
}
//-->
</script>

</head>


<body>
	<form name="frm" method="post" action="fd069_2.jsp" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

	<table cellspacing="0">
		<tr>
			<td class="blue">手机号码</td>
            <td>
				<input class="InputGrey"  type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" v_name="手机号码" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" readonly >
			</td>
			<td class="blue">机主姓名</td>
			<td>
				<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">业务品牌</td>
            <td>
				<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
			</td>
            <td class="blue">资费名称</td>
            <td>
				<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=rate_name%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">帐号预存</td>
            <td>
				<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="<%=prepay_fee1%>" readonly>
			</td>
            <td class="blue">当前积分</td>
            <td>
				<input name="oMarkPoint" type="text" class="InputGrey" id="oMarkPoint" value="<%=print_note%>" readonly>
			</td>
		</tr>
				<tr>
			<td class='blue' >实名状态</td>
      		<td colspan="3">
				<input name="shiming_state" type="text" class="InputGrey" id="shiming_state"  size='17' readonly>
			</td>
		</tr>
             <tr>
            <td class="blue">手机品牌</td>
            <td>
			  <SELECT id="agent_code" name="agent_code" v_must=1  onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);" v_name="手机代理商">
			   <option value ="">--请选择--</option>
                <%for(int i = 0 ; i < agentCodeStr.length ; i++){%>
                <option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
                <%}%>
              </select>
			  <font color="orange">*</font>
			</td>
	 		<td class="blue">手机型号</td>
            <td>
			  <select size=1 name="phone_type" id="phone_type" v_must=1 v_name="手机型号" onchange="typechange()">

              </select>
			  <font color="orange">*</font>
			</td>
   </tr>
   <tr>
     <td class="blue">营销方案</td>
        <td>
			  <select size=1 name="sale_code" id="sale_code" v_must=1 v_name="营销代码" onchange="salechage()">
              </select>
			  <font color="orange">*</font>
			</td>
			
				<TD class="blue">
					<div align="left">缴费方式</div>
				</TD>
				<TD colspan="3">
					<select name="payTypeSelect" >
						<option value="0">现金缴费</option>
						<option value="BX">建设银行POS机缴费</option>
						<option value="BY">工商银行POS机缴费</option>
					</select>
				</TD>
     </tr>
		<tr>
			<td class="blue">
				底线预存
			</td>
            <td>
				<input name="Base_Fee" type="text" class="InputGrey" id="Base_Fee" readonly>
			</td>
			<td class="blue">
            	         活动预存
                        </td>
            <td>
				<input name="Free_Fee" type="text" class="InputGrey" id="Free_Fee"   readonly>
			</td>
		</tr>
		<tr>
			 <td class="blue">
            	消费期限
            </td>
            <td>
            	<input name="Consume_Term" type="text" class="InputGrey" id="Consume_Term"   readonly>
			</td>


			<td class="blue">
				购机款
			</td>
            <td>
				<input name="Phone_Fee" type="text" class="InputGrey" id="Phone_Fee"   readonly>
			</td>

		</tr>
<!--begin huangrong add “手机电视费”和“手机电视费消费期限”的展示 2011-2-17 14:18-->   
		<tr>
			<td class="blue">手机电视费</td>
			<td>
				<input name="PhoneFree_Fee" type="text" class="InputGrey" id="PhoneFree_Fee" readonly>
			</td>
			
      <td class="blue">手机电视费消费期限</td>
      <td colspan="3">
      	<input name="Active_Term" type="text" class="InputGrey" id="Active_Term" readonly>
			</td>
		</tr>
		<tr>
			<td class='blue' >月手机电视费</td>
			<td colspan="3">
				<input name="mon_PhoneFree_Fee" type="text" class="InputGrey" id="mon_PhoneFree_Fee" readonly>
			</td>
		</tr>
		
<!--end huangrong add “手机电视费”和“手机电视费消费期限”的展示-->
		<tr>
			<!--zhangyan -->
			<td class="blue">消费积分</td>
      			<td> 
				<input name="markPoint" type="text"  id="markPoint" value='0'
					v_must='1' v_type='0_9' onchange='getMarkPoint()' >
			</td>
			
      <td class="blue">应收金额</td>
      <td>
      	<input name="Prepay_Fee" type="text" class="InputGrey" id="Prepay_Fee" readonly>
			</td>
		</tr>
		<!--zhangyan -->
		<tr>
			<td class='blue' >月底线金额</td>
			<td colspan="3">
				<input name="Mon_Base_Fee" type="text" class="InputGrey" id="Mon_Base_Fee" readonly>
			</td>
		</tr>
		<TR>
			<td class='blue' >月底线预存</td>
			<td>
				<input name="Mon_Base_prefee" type="text" class="InputGrey" id="Mon_Base_prefee" readonly>
			</td>			
			<TD class="blue">
				<div align="left">IMEI码</div>
			</TD>
			<TD>
				<input name="IMEINo" class="button" type="text" v_type="0_9" v_name="IMEI码"  
					maxlength=15 value="" onblur="viewConfirm()">
				<input name="checkimei" class="b_text" type="button" value="校验" onclick="checkimeino()">
				<font color="orange">*</font>
			</TD>
		</TR>        
		  <TR id=showHideTr >
			<TD class="blue">
				<div align="left">付机时间</div>
            </TD>
			<TD >
				<input name="payTime" type="text" v_name="付机时间"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
				(年月日)<font color="orange">*</font>
			<TD class="blue">
				<div align="left">保修时限</div>
			</TD>
			<TD >
				<input name="repairLimit" v_type="date.month"  size="10" type="text" value="12" onblur="viewConfirm()">
				(个月)<font color="orange">*</font>
			</TD>
   </TR>
   <tr>
		<td class="blue">备    注</td>
		<td colspan="3" >
			<input name="do_note" type="text" class="button" id="do_note" value="" size="60" maxlength="60" >

		</td>
	</tr>   
</table>
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>	
<table>
		<tr>
			<td id="footer" colspan="4">
				<div align="center">
                &nbsp;
				<input name="commit" id="commit" type="button" class="b_foot"   value="确认&打印" onClick="printCommit();"  >
                &nbsp;
                <input name="reset11" type="button" class="b_foot" value="清除" onclick="retFrm();" >
                &nbsp;
                <input name="close" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭">
                &nbsp;
				</div>
			</td>
		</tr>
	</table>

<div name="licl" id="licl">
      <input type="hidden" name="banlitype" value="<%=banlitype%>">
			<input type="hidden" name="opCode" value="<%=opCode%>">
			
			<!--zhangyan 积分兑换的钱数-->			
			<input type="hidden" name="pointMoney" value="">
			
			<input type="hidden" name="opName" value="<%=opName%>">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
		

			<input type="hidden" name="Mon_back" value=""><!--月返费-->
      <input type="hidden" name="Rate_Code" value="<%=rate_code%>"><!--资费代码-->
      <input type="hidden" name="iAddStr" value=""><!--拼串-->
      

			<input type="hidden" name="i1" value="">
			<input type="hidden" name="i2" value=""><!--附加资费-->
			<input type="hidden" name="i3" value=""><!--每月手机电视费-->
			<input type="hidden" name="p3" value=""><!--手机型号-->
			<input type="hidden" name="i4" value="<%=bp_name%>"><!--客户名称-->
			<input type="hidden" name="i5" value="<%=bp_add%>"><!--客户地址：-->
			<input type="hidden" name="i6" value="<%=cardId_type%>">
			<input type="hidden" name="i7" value="<%=cardId_no%>"><!--证件号码-->
			<input type="hidden" name="Save_Fee" value=""><!--预存话费-->
			
			<input type="hidden" name="printAccept" value="<%=printAccept%>">
			<input type="hidden" name="opName" value="<%=opName%>">
			
			
				<!-- pos机 begin-->		
					<input type="hidden" name="payType"  value=""><!-- 缴费类型 payType=BX 是建行 payType=BY 是工行 -->			
					<input type="hidden" name="MerchantNameChs"  value=""><!-- 从此开始以下为银行参数 -->
					<input type="hidden" name="MerchantId"  value="">
					<input type="hidden" name="TerminalId"  value="">
					<input type="hidden" name="IssCode"  value="">
					<input type="hidden" name="AcqCode"  value="">
					<input type="hidden" name="CardNo"  value="">
					<input type="hidden" name="BatchNo"  value="">
					<input type="hidden" name="Response_time"  value="">
					<input type="hidden" name="Rrn"  value="">
					<input type="hidden" name="AuthNo"  value="">
					<input type="hidden" name="TraceNo"  value="">
					<input type="hidden" name="Request_time"  value="">
					<input type="hidden" name="CardNoPingBi"  value="">
					<input type="hidden" name="ExpDate"  value="">
					<input type="hidden" name="Remak"  value="">
					<input type="hidden" name="TC"  value="">
			<!-- pos机 end-->	

</div>
 <%@ include file="/npage/include/footer.jsp" %>
</form>
<%@ include file="/npage/public/posCCB.jsp" %>
<%@ include file="/npage/public/posICBC.jsp" %>
<%@ include file="/npage/public/hwObject.jsp" %> 
</body>
</html>


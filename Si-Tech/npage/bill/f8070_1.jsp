
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-10
********************/
%>

<%
  String opCode = "8070";
  String opName = "致富信息机营销案";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page contentType="text/html;charset=GBK"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.io.*"%>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%String Readpaths = request.getRealPath("npage/properties")+"/getRDMessage.properties";%>
<%


  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = request.getRemoteAddr();
  String regionCode = (String)session.getAttribute("regCode");

  //String prtSql="select to_char(sMaxSysAccept.nextval) from dual";

%>

	 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" />

<%
  String printAccept=sysAcceptl;
  String retFlag="",retMsg="";
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
  String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
  String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
  String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";
  String vUnitId="",vUnitName="",vproduct_name="",vUnitAddr="";


	String iPhoneNo = request.getParameter("srv_no");
	String iOpCode = request.getParameter("opcode");
	String iUnitId=request.getParameter("vUnitId");
	String cus_pass = WtcUtil.repNull(request.getParameter("cus_pass"));
	String getCardCodeSql="select card_code from dbvipadm.dGrpBigUserMsg where phone_no ='"+iPhoneNo+"'";
	System.out.println("getCardCodeSql|"+getCardCodeSql);
	String cardCode="";	    
%>
<wtc:pubselect name="sPubSelect"  retcode="retCode1" retmsg="retMsg1" outnum="1">
 <wtc:sql><%=getCardCodeSql%>
 </wtc:sql>
 </wtc:pubselect>
<wtc:array id="result1" scope="end"/>		
<%
	if(result1.length!=0){
  		cardCode=result1[0][0];
	}

	String  inputParsm [] = new String[5];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	inputParsm[4] = iUnitId;
	System.out.println("phoneNO === "+ iPhoneNo);


	//retList = co2.callFXService("s8070InitEx", inputParsm, "33","phone",iPhoneNo);

%>

    <wtc:service name="s8070Init" outnum="33" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inputParsm[0]%>" />
			<wtc:param value="<%=inputParsm[1]%>" />
			<wtc:param value="<%=inputParsm[2]%>" />
			<wtc:param value="<%=inputParsm[3]%>" />
			<wtc:param value="<%=inputParsm[4]%>" />
		</wtc:service>
		<wtc:array id="result_t1" scope="end" />

<%
  String errCode = code2;
  String errMsg = msg2;
  if(result_t1 == null)
  {
	   retFlag = "1";
	   retMsg = "s8070Init查询号码基本信息为空!<br>errCode " + errCode + "<br>errMsg+" + errMsg;
  }
  else
  {
	  if (errCode.equals("000000")){
	    bp_name = result_t1[0][3];           //机主姓名
	    bp_add = result_t1[0][4];            //客户地址
	    passwordFromSer = result_t1[0][2];  //密码
	    sm_code = result_t1[0][11];         //业务类别
	    sm_name = result_t1[0][12];        //业务类别名称
	    hand_fee = result_t1[0][13];      //手续费
	    favorcode = result_t1[0][14];     //优惠代码
	    rate_code = result_t1[0][5];     //资费代码
	    rate_name = result_t1[0][6];    //资费名称
	    next_rate_code = result_t1[0][7];//下月资费代码
	    next_rate_name = result_t1[0][8];//下月资费名称
	    bigCust_flag = result_t1[0][9];//大客户标志
	    bigCust_name = result_t1[0][10];//大客户名称
	    lack_fee = result_t1[0][15];//总欠费
	    prepay_fee = result_t1[0][16];//总预交
	    cardId_type = result_t1[0][17];//证件类型
	    cardId_no = result_t1[0][18];//证件号码
	    cust_id = result_t1[0][19];//客户id
	    cust_belong_code = result_t1[0][20];//客户归属id
	    group_type_code = result_t1[0][21];//集团客户类型
	    group_type_name = result_t1[0][22];//集团客户类型名称
	    imain_stream = result_t1[0][23];//当前资费开通流水
	    next_main_stream = result_t1[0][24];//预约资费开通流水
	    print_note = result_t1[0][25];//工单广告
	    contract_flag = result_t1[0][27];//是否托收账户
	    high_flag = result_t1[0][28];//是否中高端用户
	    vUnitId = result_t1[0][29];//集团编号
	    vUnitName = result_t1[0][30].trim();//集团名称
	    vproduct_name = result_t1[0][31];//产品名称
	    vUnitAddr = result_t1[0][32].trim();//集团地址

	 }else{%>
		<script language="JavaScript">
			rdShowMessageDialog("错误代码<%=errCode%>，错误信息<%=errMsg%>",0);
			history.go(-1);
		</script>
<%	 }
	}
	//String rpcPage = "qryCus_s126hInit";
  String[][] favInfo = (String[][])session.getAttribute("favInfo");  //数据格式为String[0][0]---String[n][0]
  boolean pwrf = false;//a272 密码免验证
  int infoLen = favInfo.length;
  String tempStr = "";
  for(int i=0;i<infoLen;i++)
  {
    tempStr = (favInfo[i][0]).trim();
    if(tempStr.compareTo("a272") == 0)
    {
      pwrf = true;
    }
  }

  /*
  if(!pwrf)
  {
	String passFromPage=Encrypt.encrypt(cus_pass);
	if(0==Encrypt.checkpwd2(passwordFromSer.trim(),passFromPage))
	{
		if(!retFlag.equals("1"))
		{%>
			<script language="JavaScript">
				rdShowMessageDialog("密码验证错误，请重新输入密码！",0);
				history.go(-1);
			</script>
		<%}
	}
  }
  */

%>
<%
//******************得到下拉框数据***************************//


  //营销代码
  String sqlsaleType = "select unique a.sale_code,trim(a.sale_name) from sGrpCtysideCfg a where a.region_code='" + regionCode + "' and  a.valid_flag='Y' ";
  System.out.println("sqlsaleType====="+sqlsaleType);
  //ArrayList saleTypeArr = co.spubqry32("2",sqlsaleType);

  //营销明细
  String sqlsaledet = "select machine_fee,prepay_fee,sale_code,mode_code,mode_name,sum_money from sGrpCtysideCfg  where region_code='" + regionCode + "'  and valid_flag='Y'";
  System.out.println("sqlsaledet====="+sqlsaledet);
  //ArrayList saledetArr = co.spubqry32("6",sqlsaledet);


  //农情业务包
   String ctrsidsql="select trim(choice_code),trim(choice_name),trim(choice_add1),to_char(choice_price,'999990.00') from sPhoneSaleChoice where region_code='" + regionCode + "' and sale_type=6 and choice_type=1 and valid_flag='Y'";
   System.out.println("ctrsidsql====="+ctrsidsql);
 // ArrayList ctrsidCodeArr = co.spubqry32("4",ctrsidsql);



%>


	 <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlsaleType%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t3" scope="end"/>

	 <wtc:pubselect name="sPubSelect" outnum="6" retmsg="msg4" retcode="code4" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlsaledet%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t4" scope="end"/>

	 <wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg5" retcode="code5" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=ctrsidsql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t5" scope="end"/>

<%
String[][] saleTypeStr = result_t3;
String[][] saledetStr = result_t4;
String[][] ctrsidCodeStr = result_t5;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>致富信息机营销案</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>



<script language="JavaScript">
<!--
  onload=function()
  {
   	self.status="";
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

  var arrdetmash=new Array();
  var arrdetprepay=new Array();
  var arrdetsalecode=new Array();
  var arrdetmodecode=new Array();
  var arrdetmodename=new Array();
  var arrdetsummoney=new Array();

  var arrspchoice=new Array()
  var arrspfee=new Array()
  var arrspcode=new Array()

  var arrmodecode=new Array()
  var arrmodename=new Array()
  var arrmodebrand=new Array()
  var arrmodetype=new Array()

  <%
  for(int k=0;k<saledetStr.length;k++)
  {
	out.println("arrdetmash["+k+"]='"+saledetStr[k][0]+"';\n");
	out.println("arrdetprepay["+k+"]='"+saledetStr[k][1]+"';\n");
	out.println("arrdetsalecode["+k+"]='"+saledetStr[k][2]+"';\n");
	out.println("arrdetmodecode["+k+"]='"+saledetStr[k][3]+"';\n");
	out.println("arrdetmodename["+k+"]='"+saledetStr[k][4]+"';\n");
	out.println("arrdetsummoney["+k+"]='"+saledetStr[k][5]+"';\n");
  }
  for(int n=0;n<ctrsidCodeStr.length;n++)
  {
	out.println("arrspchoice["+n+"]='"+ctrsidCodeStr[n][0]+"';\n");
	out.println("arrspcode["+n+"]='"+ctrsidCodeStr[n][2]+"';\n");
	out.println("arrspfee["+n+"]='"+ctrsidCodeStr[n][3]+"';\n");

  }
%>
//--------1---------doProcess函数----------------

  function doProcess(packet)
  {
    var vRetPage=packet.data.findValueByName("rpc_page");
	var retType=packet.data.findValueByName("retType");
    
     

   

    if(vRetPage == "qryAreaFlag")
    {
	    var retCode = packet.data.findValueByName("retCode");
	    var retMsg = packet.data.findValueByName("retMsg");
	    var area_flag = packet.data.findValueByName("area_flag");
		if(retCode == 000000)
		{
		    if(parseInt(area_flag)>0)
		    {
		       document.all.flagCodeTr.style.display="";
		       getFlagCode();
		    }else{
		    	document.all.flagCodeTr.style.display="none";
		    	document.all.flag_code.value="";
		    	document.all.flag_code_name.value="";
		    	document.all.rate_code.value="";
		    }
		}
		else
		{
				rdShowMessageDialog("错误"+ retCode + "->" + retMsg,0);
				return;
		}
	}
	if(retType=="0"){
			var  retResult=packet.data.findValueByName("retResult");
			if(retResult == "000000"){
					rdShowMessageDialog("IMEI号校验成功1！",2);
					document.frm.commit.disabled=false;
					document.frm.IMEINo.readOnly = true;
					return ;

			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI号校验成功2！",2);
					document.frm.commit.disabled=false;
					document.frm.IMEINo.readOnly = true;
					return ;

			}else if(retResult == "000003"){
					rdShowMessageDialog("IMEI号不在营业员归属营业厅或IMEI号与业务办理机型不符！",0);
					document.frm.commit.disabled=true;
					return false;
			}else{
					rdShowMessageDialog("IMEI号不存在或者已经使用！",0);
					document.frm.commit.disabled=true;
					return false;
			}
	}

	//added by hanfa 20070119 begin
	if(vRetPage == "querySmcode")
	{
		var errCode = packet.data.findValueByName("errCode");
	    var errMsg = packet.data.findValueByName("errMsg");
		var m_smCode = packet.data.findValueByName("m_smCode");
		self.status="";

		if(errCode == 0)
		{
			document.all.m_smCode.value = m_smCode;
		}else
		{
			rdShowMessageDialog("错误"+ errCode + "->" + errMsg,0);
			return false;
		}
	}//added by hanfa 20070119 end

 }

  //--------2---------验证按钮专用函数-------------

  function checkimeino()
{
	 if (document.frm.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!",0);
      document.frm.IMEINo.focus();
      document.frm.commit.disabled = true;
	  return false;
     }



	var myPacket = new AJAXPacket("/npage/s1141/queryimei.jsp","正在校验IMEI信息，请稍候......");
	myPacket.data.add("imei_no",(document.all.IMEINo.value).trim());
	myPacket.data.add("brand_code",(document.all.agent_code.options[document.all.agent_code.selectedIndex].value).trim());
	myPacket.data.add("style_code",(document.all.phone_type.options[document.all.phone_type.selectedIndex].value).trim());
	myPacket.data.add("retType","0");
	core.ajax.sendPacket(myPacket);
	myPacket = null;

}

 function viewConfirm()
{
	if(document.frm.IMEINo.value=="")
	{
		document.frm.commit.disabled=true;
	}
	else
	{
		document.frm.commit.disabled=false; //added by hanfa 20070124
	}

}
    function checksmz()
  {

  var myPacket = new AJAXPacket("checkSMZ.jsp","正在查询客户是否是实名制客户，请稍候......");
	myPacket.data.add("PhoneNo",(document.all.phoneNo.value).trim());
	core.ajax.sendPacket(myPacket,checkSMZValue);
	myPacket=null;
  }
  function checkSMZValue(packet) {
      document.all.smzvalue.value="";
			var smzvalue = packet.data.findValueByName("smzvalue");
      document.all.smzvalue.value=smzvalue;
}
  /***** 提交前增加品牌转换提示信息 added by hanfa 20070119 begin *****/
  function formCommit()
  {

	  	var userCardCode = '<%=cardCode%>';
  		if(document.all.oSmCode.value == "zn" && document.all.m_smCode.value == "gn")
  		{
  			//薛英哲 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@关于积分清零条件调整的需求 zn->gn 积分不清零
  		}
  		else
  		{
	  		if((document.all.m_smCode.value !="") && (document.all.m_smCode.value != document.all.oSmCode.value))
	  		{
		  		if(document.all.oSmCode.value == "gn"){
		  			if((userCardCode == "01" || userCardCode == "02" || userCardCode == "03")){
			  			//rdShowMessageDialog("该操作涉及到品牌变更，您的现有积分（或M值）将于品牌变更生效时失效，请您及时兑换; ");
			  			rdShowMessageDialog("您目前为全球通VIP会员，如变更品牌，您的VIP会员资格将于业务生效后自动取消。同时提醒您非全球通客户将不能参与VIP评定。");
			  		}else{
			  			rdShowMessageDialog("非全球通客户将不能参与VIP评定。");
			  		}
		  		}else if(document.all.oSmCode.value == "dn"){
		  			//rdShowMessageDialog("该操作涉及到品牌变更，您的现有积分或M值将于品牌变更生效时失效，请您在新资费生效前及时兑换。");
		  		}
		  		
		  				  		if(document.all.oSmCode.value != "zn" && document.all.m_smCode.value=="zn" && document.all.oSmCode.value !="") {//
		  			checksmz();
		  			var smzvalues =document.all.smzvalue.value.trim();
		  			if(smzvalues=="3") {//非实名制全球通、动感地带客户转移为神州行客户
		  				rdShowMessageDialog("<%=readValue("8070","ps","jf",Readpaths)%>");
		  			}
		  		}
		  		
	  		}
  		}
		    frmCfm();

  }
  /***** 提交前增加品牌转换提示信息 added by hanfa 20070119 end *****/

  function frmCfm()
  {
	document.frm.ip.value=document.frm.New_Mode_Code.value;
	document.frm.iAddStr.value=document.frm.sale_code.value+"|"+document.frm.prepay_fee.value+"|"+document.frm.spfee.value+"|"+document.frm.pay_money.value+"|"+document.frm.ctrsidCode.value+"|"+document.frm.IMEINo.value+"|"+document.frm.vUnitId.value+"|"+document.frm.vUnitName.value+"|"+document.frm.mash_fee.value+"|";
	if(!checkElement(document.frm.phoneNo)) return;

	if(document.all.sale_code.value==""){
	  rdShowMessageDialog("请输入营销代码!",0);
      document.all.sale_code.focus();
	  return false;
	}
	if(document.all.ctrsidCode.value==""){
		 rdShowMessageDialog("请选择农信通业务包!",0);
      		document.all.ctrsidCode.focus();
	  	return false;

	}

	if (document.all.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!",0);
      document.all.IMEINo.focus();
     // document.all.confirm.disabled = true;
	  return false;
     }
         if (document.all.i9.value == "Y")
         {
         	rdShowMessageDialog("该用户是托收用户,预存款将在下月托收时收回！",0);
         }

         //if(document.all.i9.value == "N" && parseFloat(document.all.oPayPre.value)<parseFloat(document.all.Prepay_Fee.value))
         //{
          // rdShowMessageDialog("本次缴纳预存款不足,不能办理!");
           //return;
        // }

         frm.submit();
  }

 function judge_area()
 {
  var myPacket = new AJAXPacket("qryAreaFlag.jsp","正在查询客户，请稍候......");
	myPacket.data.add("orgCode",(document.all.orgCode.value).trim());
	myPacket.data.add("modeCode",(document.all.New_Mode_Code.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket = null;
 }

 //-------------------


function getFlagCode()
{
  	//调用公共js
    var pageTitle = "资费查询";
    var fieldName = "小区代码|小区名称|";//弹出窗口显示的列、列名
    /*
    var sqlStr ="select a.flag_code, a.flag_code_name,a.rate_code from sRateFlagCode a, sBillModeDetail b where a.region_code=b.region_code and a.rate_code=b.detail_code and b.detail_type='0' and a.region_code='" + document.frm.orgCode.value.substring(0,2) + "' and b.mode_code='" + document.frm.New_Mode_Code.value + "' order by a.flag_code" ;*/
    var sqlStr = "select a.flag_code, a.flag_code_name from sofferflagcode a, sregioncode b where a.offer_id = " + document.frm.New_Mode_Code.value + " and a.group_id = b.group_id and b.region_code = '" + document.frm.orgCode.value.substring(0,2) + "' order by a.flag_code"

    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "0|1";//返回字段
    var retToField = "flag_code|flag_code_name";//返回赋值的域

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

 function ctrsidCodechange(){
 	var x6 ;
 	for ( x6 = 0 ; x6 < arrspchoice.length  ; x6++ )
 	{
 		if ( arrspchoice[x6] == document.all.ctrsidCode.value  ){
 			document.all.spcode.value=arrspcode[x6];
 			document.all.spfee.value=arrspfee[x6];
 		}
 	}


 }
  function salechage(){
 
  	var x3;

	for ( x3 = 0 ; x3 < arrdetsalecode.length  ; x3++ )
   	{
      		if ( arrdetsalecode[x3] == document.all.sale_code.value )
      		{
        		document.all.mash_fee.value=arrdetmash[x3];
        		document.all.prepay_fee.value=arrdetprepay[x3];
        		document.all.pay_money.value=arrdetsummoney[x3];
        		document.all.New_Mode_Code.value=arrdetmodecode[x3];
        		document.all.mode_name.value=arrdetmodename[x3];

      		}
   	}
    document.frm.i1.value=document.frm.phoneNo.value;
    document.all.do_note.value = "用户"+document.all.phoneNo.value+"办理致富信息机营销案";
    judge_area();
	   if(document.all.sale_code.value != "")
    {
    	querySmcode(); //added by hanfa 20070119
    }
    getMidPrompt("10442",codeChg(document.all.New_Mode_Code.value),"ipTd")
 }

   //新增函数查询资费代码相应的品牌代码 added by hanfa 20070119
  function querySmcode()
  {
	  var myPacket = new AJAXPacket("querySmcode_rpc.jsp","正在获得信息，请稍候......");
	  myPacket.data.add("modeCode",(document.frm.New_Mode_Code.value).trim());
	  core.ajax.sendPacket(myPacket);
	  myPacket = null;
  }
  function oneTokSelf(str,tok,loc)
  {
	    var temStr=str;
		var temLoc;
		var temLen;
	    for(ii=0;ii<loc-1;ii++)
		{
			temLen=temStr.length;
			temLoc=temStr.indexOf(tok);
			temStr=temStr.substring(temLoc+1,temLen);
	 	}
		if(temStr.indexOf(tok)==-1)
		  	return temStr;
		else
	      	return temStr.substring(0,temStr.indexOf(tok));
  }
function retFrm(){
	document.frm.IMEINo.readOnly = false;
	document.frm.reset();	
}
//-->
</script>

</head>


<body>
	<form name="frm" method="post" action="f1270_3.jsp" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">致富信息机营销案</div>
	</div>

		<input name="oSmCode" type="hidden"  id="oSmCode" value="<%=sm_code%>">
	  	<input type="hidden" name="m_smCode" value="">
		<input name="oModeCode" type="hidden"  id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=sysAcceptl%>">
		<input type="hidden" name="Gift_Code" value="">


	<table  cellspacing="0" >
		<tr>
			<td width="11%" class="blue">手机号码</td>
            <td width="39%">
				<input   type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" v_name="手机号码" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" readonly   Class="InputGrey" >
			</td>
			<td width="11%" class="blue">机主姓名</td>
			<td width="39%">
				<input name="oCustName" type="text"  id="oCustName" value="<%=bp_name%>" readonly   Class="InputGrey" >
			</td>
		</tr>
		<tr>
			<td class="blue">业务品牌</td>
            <td>
				<input name="oSmName" type="text"  id="oSmName" value="<%=sm_name%>" readonly  Class="InputGrey" >
			</td>
            <td class="blue">资费名称</td>
            <td>
				<input name="oModeName" type="text"  id="oModeName" value="<%=rate_name%>" readonly  Class="InputGrey" >
			</td>
		</tr>
		<tr>
			<td class="blue">
				帐号预存
			</td>
            <td>
				<input name="oPrepayFee" type="text"  id="oPrepayFee" value="<%=prepay_fee%>" readonly  Class="InputGrey" >
			</td>
            <td class="blue">
            	当前积分
            </td>
            <td>
				<input name="oMarkPoint" type="text"  id="oMarkPoint" value="<%=print_note%>" readonly  Class="InputGrey" >
			</td>
		</tr>
		<tr>
			<td class="blue">
				集团ID
			</td>
            <td>
				<input name="vUnitId" type="text"  id="vUnitId" value="<%=vUnitId%>" readonly  Class="InputGrey" >
			</td>
            <td class="blue">
            	集团名称
            </td>
            <td>
				<input name="vUnitName" type="text"  id="vUnitName" value="<%=vUnitName%>" readonly  Class="InputGrey" >
			</td>
		</tr>
		<tr>
			<td class="blue">
				集团产品
			</td>
            <td>
				<input name="vproduct_name" type="text"  id="vproduct_name" value="<%=vproduct_name%>" readonly  Class="InputGrey" >
			</td>
            <td class="blue">
            	集团地址
            </td>
            <td>
				<input name="vUnitAddr" type="text"  id="vUnitAddr" value="<%=vUnitAddr%>" readonly  Class="InputGrey" >
			</td>
		</tr>

          <tr>

            <td class="blue">营销方案</td>
            <td>
			  <select size=1 name="sale_code" id="sale_code" v_must=1 v_name="营销代码" onchange="salechage()">
             	<option value ="">--请选择--</option>
                <%for(int i = 0 ; i < saleTypeStr.length ; i ++){%>
                <option value="<%=saleTypeStr[i][0]%>"><%=saleTypeStr[i][0]%>--><%=saleTypeStr[i][1]%></option>
                <%}%>
              </select>
			   <font class="orange">*</font>
			</td>
            <td>&nbsp;</td><td>&nbsp;</td>
          </tr>
		</tr>

		<tr>

			<td class="blue">
				购机款
			</td>
            <td>
				<input name="mash_fee" type="text"  id="mash_fee" readonly  Class="InputGrey" >
			</td>
			<td class="blue">
            	预存要求
            </td>
            <td>
				<input name="prepay_fee" type="text"  id="prepay_fee"   readonly  Class="InputGrey" >
			</td>
		</tr>
		<tr>
           <td class="blue">
            	新主资费
            </td>
            <td id="ipTd">
            <input name="New_Mode_Code" type="text"  id="New_Mode_Code" value="" readonly  Class="InputGrey" >
			</td>
			<td class="blue">

				资费名称
			</td>
            <td>
            	 <input name="mode_name" type="text"  id="mode_name" value="" readonly  Class="InputGrey" >

			</td>

		</tr>
		<tr>

			<td class="blue">
				农信通业务包
			</td>

            <td>
            <SELECT id="ctrsidCode" name="ctrsidCode" v_must=1  onchange="ctrsidCodechange()" v_name="农信通业务包">
			   <option value ="">--请选择--</option>
                <%for(int i = 0 ; i < ctrsidCodeStr.length ; i ++){%>
                <option value="<%=ctrsidCodeStr[i][0]%>"><%=ctrsidCodeStr[i][0]%>--><%=ctrsidCodeStr[i][1]%></option>
                <%}%>
              </select>
	<input type="hidden" name="spcode">
			</td>
			 <td class="blue">
            	业务包价值
            </td>
            <td>
            	<input name="spfee" type="text"  id="spfee"   readonly  Class="InputGrey" >
			</td>
			<td>
		</tr>


		</tr>
		  <tr id="flagCodeTr" style="display:none">
		    <TD  class="blue">小区代码</TD>
			  <TD >
				    <input  type="hidden" size="17" name="rate_code" id="rate_code" readonly>
            		<input type="text"  name="flag_code" size="8" maxlength="10" readonly Class="InputGrey" >
			      <input type="text"  name="flag_code_name" size="18" readonly   Class="InputGrey" >&nbsp;&nbsp;
			      <input name="newFlagCodeQuery" type="button"   style="cursorhand" onClick="getFlagCode()" value=选择 class="b_text">
        </TD>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
		 <TR>
		 <td class="blue">
            	应收金额
            </td>
            <td >
            	<input name="pay_money" type="text"  id="pay_money"   readonly  Class="InputGrey" >
			</td>
			<TD  nowrap>
				<div align="left" class="blue">IMEI码</div>
            </TD>
            <TD >
				<input name="IMEINo"  type="text" v_type="0_9" v_name="IMEI码"  maxlength=15 value="" onblur="viewConfirm()">
                 <font class="orange">*</font>
            </TD>
			<TD>
			</td>
			<td>
			</td>
          </TR>

		<tr>
			<td colspan="4">
				<div align="center" id="footer">
                &nbsp;

                <input name="commit" id="commit" type="button"    value="下一步" onClick="formCommit();" class="b_foot" >
                &nbsp;
                <input name="reset11" type="button"  value="清除" class="b_foot" onclick="retFrm();">
                &nbsp;
                <input name="close" onClick="removeCurrentTab();" type="button"  value="关闭" class="b_foot">
                &nbsp;
				</div>
			</td>
		</tr>
	</table>

<div name="licl" id="licl">
			<input type="hidden" name="iOpCode" value="8070">
			<input type="hidden" name="opCode" value="8070">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
			<!--以下部分是为调f1270_3.jsp所定义的参数
			i2客户ID
			i16当前主套餐代码
			ip申请主套餐代码
			belong_codebelong_code
			print_note工单广告词
			iAddStr

			i1手机号码
			i4客户名称
			i5客户地址
			i6证件类型
			i7证件号码
			i8业务品牌

			ipassword密码
			group_type集团客户类别
			ibig_cust大客户类别
			do_note用户备注
			favorcode手续费优惠权限
			maincash_no现主套餐代码（老）
			imain_stream当前主资费开通流水
			next_main_stream预约主资费开通流水

			i18下月主套餐
			i19手续费
			i20最高手续费
			-->
			<input type="hidden" name="i2" value="<%=cust_id%>">
			<input type="hidden" name="i16" value="<%=rate_code%>">
			<input type="hidden" name="ip" value="">

			<input type="hidden" name="belong_code" value="<%=cust_belong_code%>">
			<input type="hidden" name="print_note" value="<%=print_note%>">
			<input type="hidden" name="iAddStr" value="">

			<input type="hidden" name="i1" value="">
			<input type="hidden" name="i4" value="<%=bp_name%>">
			<input type="hidden" name="opName" value="<%=opName%>">
			<input type="hidden" name="i5" value="<%=bp_add%>">
			<input type="hidden" name="i6" value="<%=cardId_type%>">
			<input type="hidden" name="i7" value="<%=cardId_no%>">
			<input type="hidden" name="i8" value="<%=sm_code%>--<%=sm_name%>">			
			<input type="hidden" name="i9" value="<%=contract_flag%>">			

			<input type="hidden" name="ipassword" value="">
			<input type="hidden" name="group_type" value="<%=group_type_code%>--<%=group_type_name%>">
			<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
			<input type="hidden" name="do_note" value="">
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">
			<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">

			<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">
			<input type="hidden" name="i20" value="<%=hand_fee%>">

			<input type="hidden" name="mode_type" value="">
			<input type="hidden" name="printAccept" value="<%=printAccept%>">
			<input type="hidden" name="New_Mode_Name" value="新主资费名称">
			<input type="hidden" name="return_page" value="/page/bill/f8070_1.jsp">			
			<input type="hidden" name="cus_pass" value="<%=cus_pass%>">
			<input type="hidden" name="smzvalue" >
</div>
</form>
<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>

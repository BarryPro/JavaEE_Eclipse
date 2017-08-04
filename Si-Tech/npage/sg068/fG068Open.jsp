<%
/********************
 version v2.0
 开发商: si-tech
 update wangyua at 2010.5.11
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<%/*
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
  */
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.*" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%String Readpaths = request.getRealPath("npage/properties")+"/getRDMessage.properties";%>
<%
String opCode = request.getParameter("opCode");
String opName = request.getParameter("opName");
String iPhoneNo = request.getParameter("srv_no");
String main_phone=request.getParameter("main_phoneno");
String loginNo = (String)session.getAttribute("workNo");
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = (String)session.getAttribute("regCode");
String op_strong_pwd = (String) session.getAttribute("password");
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=iPhoneNo%>"  id="paraStr"/>
<%
ArrayList arrSession2 = (ArrayList)session.getAttribute("allArr");
String[][] baseInfoSession2 = (String[][])arrSession2.get(0);
String  retFlag="",retMsg="";
String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";
/*测试暂时写死7898
String iOpCode ="7898";*/
String iOpCode = request.getParameter("opcode");

String cus_pass = request.getParameter("cus_pass");
String loginAccept = request.getParameter("printAccept");
String getCardCodeSql="select card_code from dbvipadm.dGrpBigUserMsg where phone_no ='"+iPhoneNo+"'";
String cardCode="";	    
%>

<%
String sqlChkPho=" select count(*)  "
+" from wmachsndopr t , dcustmsg t1  "  
+" where 1=1 "
+" and t.id_no = t1.id_no  and  sysdate between t.bx_begin and t.bx_end "  
+" and t.back_flag = '0' and t1.phone_no='"+iPhoneNo+"'"  
+" and t.op_code = 'g068'";
System.out.println("g068~~~~~"+sqlChkPho);
%>

<wtc:pubselect name="sPubSelect"  retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:sql><%=sqlChkPho%>
</wtc:sql>
</wtc:pubselect>
<wtc:array id="rstChkPho" scope="end"/>		
<%

if (!rstChkPho[0][0].equals("0"))
{%>
	<script>
	rdShowMessageDialog("该号码已经办理过此营销案,不能重复办理!",0);
	window.history.go(-1);
</script>

<%}
%>

<wtc:pubselect name="sPubSelect"  retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:sql><%=getCardCodeSql%>
</wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" scope="end"/>		
<%
if(result1.length!=0)
{
	cardCode=result1[0][0];
}
String  inputParsm [] = new String[5];
inputParsm[0] = iPhoneNo;
inputParsm[1] = loginNo;
inputParsm[2] = orgCode;

inputParsm[3] = iOpCode;
inputParsm[4] = loginAccept;

System.out.println("7898~~~`iOpCode="+iOpCode);
%>
<wtc:service name="s126bInit" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="29">			
	<wtc:param value=""/>
	<wtc:param value="01"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=loginNo%>"/>
	<wtc:param value="<%=op_strong_pwd%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=inputParsm[2]%>"/>
</wtc:service>
<wtc:array id="tempArr"  scope="end"/>
<%
String errCode = retCode2;
String errMsg = retMsg2;
if(tempArr.length==0)
{
	retFlag = "1";
	retMsg = "s126bInit查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
}
else if(errCode.equals("000000") && tempArr.length>0)
{
	bp_name = tempArr[0][3];           //机主姓名
	bp_add = tempArr[0][4];            //客户地址
	passwordFromSer = tempArr[0][2];  //密码
	sm_code = tempArr[0][11];         //业务类别
	sm_name = tempArr[0][12];        //业务类别名称
	hand_fee = tempArr[0][13];      //手续费
	favorcode = tempArr[0][14];     //优惠代码
	rate_code = tempArr[0][5];     //资费代码
	rate_name = tempArr[0][6];    //资费名称
	next_rate_code = tempArr[0][7];//下月资费代码
	next_rate_name = tempArr[0][8];//下月资费名称
	bigCust_flag = tempArr[0][9];//大客户标志
	bigCust_name = tempArr[0][10];//大客户名称
	lack_fee = tempArr[0][15];//总欠费
	prepay_fee = tempArr[0][16];//总预交
	cardId_type = tempArr[0][17];//证件类型
	cardId_no = tempArr[0][18];//证件号码
	cust_id = tempArr[0][19];//客户id
	cust_belong_code = tempArr[0][20];//客户归属id
	group_type_code = tempArr[0][21];//集团客户类型
	group_type_name = tempArr[0][22];//集团客户类型名称
	imain_stream = tempArr[0][23];//当前资费开通流水
	next_main_stream = tempArr[0][24];//预约资费开通流水
	print_note = tempArr[0][25];//当前积分
	contract_flag = tempArr[0][27];//是否托收账户
	high_flag = tempArr[0][28];//是否中高端用户
}
else
{%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
		history.go(-1);
	</script>
<%	 
}
	String rpcPage = "qryCus_s126hInit";
%>
<%
//******************得到下拉框数据***************************//
  //手机品牌
  String sqlAgentCode = "select  unique a.brand_code,trim(b.brand_name) from dphoneSaleCode a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='50' and a.brand_code=b.brand_code and a.valid_flag='Y'";
  String[] inParamA = new String[2];
  inParamA[0] = "select  unique a.brand_code,trim(b.brand_name) from dphoneSaleCode a,schnresbrand b where a.region_code=:region_code and a.sale_type='50' and a.brand_code=b.brand_code and a.valid_flag='Y'";
  inParamA[1] = "region_code="+regionCode;
  System.out.println("sqlAgentCode====="+sqlAgentCode);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeA" retmsg="retMsgA" outnum="2">
		<wtc:param value="<%=inParamA[0]%>"/>
	<wtc:param value="<%=inParamA[1]%>"/>
	</wtc:service>
	<wtc:array id="agentCodeStr"  scope="end"/>
<%
  //手机类型
  String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from dphoneSaleCode a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and a.brand_code=b.brand_code and a.sale_type='50' and a.valid_flag='Y'";
  String[] inParamB = new String[2];
  inParamB[0] = "select unique a.type_code,trim(b.res_name), b.brand_code from dphoneSaleCode a,schnrescode_chnterm b where a.region_code=:region_code and  a.type_code=b.res_code and a.brand_code=b.brand_code and a.sale_type='50'and a.valid_flag='Y'";
  inParamB[1] = "region_code=" + regionCode;
  System.out.println("sqlPhoneType====="+sqlPhoneType);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeB" retmsg="retMsgB" outnum="3">
	<wtc:param value="<%=inParamB[0]%>"/>
	<wtc:param value="<%=inParamB[1]%>"/>
	</wtc:service>
	<wtc:array id="phoneTypeStr"  scope="end"/>
<%
  //营销代码 2012-08-23新增查询字段 op_note 用于判断该营销案是否属于裸机销售0还是正常销售1
  String sqlsaleType = "select unique trim(a.sale_code),trim(a.sale_name), a.brand_code,a.type_code,a.op_note from dphoneSaleCode a where a.region_code='" + regionCode + "' and a.sale_type='50' and a.valid_flag='Y'";
  String[] inParamC = new String[2];
  inParamC[0] = "select unique trim(a.sale_code),trim(a.sale_name), a.brand_code,a.type_code,a.op_note from dphoneSaleCode a where a.region_code=:region_code and a.sale_type='50' and a.valid_flag='Y'";
  inParamC[1] = "region_code=" + regionCode;
  System.out.println("sqlsaleType====="+sqlsaleType);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeC" retmsg="retMsgC" outnum="5">
	<wtc:param value="<%=inParamC[0]%>"/>
	<wtc:param value="<%=inParamC[1]%>"/>
	</wtc:service>
	<wtc:array id="saleTypeStr"  scope="end"/>
<%
  //营销明细
  String sqlsaledet = "select to_char(to_number(sale_price)-to_number(prepay_gift)-to_number(prepay_limit)),prepay_gift,consume_term,prepay_limit,to_char(active_term),mon_base_fee,all_gift_price,sale_price,trim(sale_code),market_price from dphoneSaleCode  where region_code='" + regionCode + "' and sale_type='50' and valid_flag='Y'";
  String[] inParamD = new String[2];
  inParamD[0] = "select to_char(to_number(sale_price)-to_number(prepay_gift)-to_number(prepay_limit)),prepay_gift,consume_term,prepay_limit,to_char(active_term),mon_base_fee,all_gift_price,sale_price,trim(sale_code),market_price from dphoneSaleCode where region_code=:region_code and sale_type='50' and valid_flag='Y'";
  inParamD[1] = "region_code=" + regionCode;
  System.out.println("inParamD[0]===111"+inParamD[0]);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeD" retmsg="retMsgD" outnum="12">
	<wtc:param value="<%=inParamD[0]%>"/>
	<wtc:param value="<%=inParamD[1]%>"/>
	</wtc:service>
	<wtc:array id="saledetStr"  scope="end"/>
<%
  //新主资费(修改部分)
  String sqlmodecode = "select a.mode_code,trim(a.sale_code),a.mode_code||'--'||c.mode_name from dChnResSalePlanModeRel a , dphoneSaleCode b,sbillmodecode c where a.sale_code=b.sale_code and b.region_code='" + regionCode + "' and b.sale_type='50'  and b.region_code=c.region_code and a.mode_code=c.mode_code";
  String[] inParamE = new String[2];
  // inParamE[0] = "select a.mode_code,trim(a.sale_code),a.mode_code||'--'||c.mode_name from dChnResSalePlanModeRel a , dphoneSaleCode b,sbillmodecode c where a.sale_code=b.sale_code and b.region_code=:region_code and b.sale_type='50' and b.region_code=c.region_code and a.mode_code=c.mode_code";
  inParamE[0] = "select a.mode_code,trim(a.sale_code),a.mode_code||'--'||c.offer_name from dChnResSalePlanModeRel a , dphoneSaleCode b,product_offer c where a.sale_code=b.sale_code and b.region_code=:region_code and b.sale_type='50' and trim(a.mode_code) = to_char(c.offer_id) and b.valid_flag = 'Y' and c.exp_date>sysdate ";
  inParamE[1] = "region_code=" + regionCode;
  System.out.println("inParamE[0]====="+inParamE[0]);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeE" retmsg="retMsgE" outnum="3">
	<wtc:param value="<%=inParamE[0]%>"/>
	<wtc:param value="<%=inParamE[1]%>"/>
	</wtc:service>
	<wtc:array id="modecodeStr"  scope="end"/>

<head>
<title>购TD商务固话，赠通信费(铁通)</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="JavaScript">
<!--
  onload=function()
  {
  	document.all.phoneNo.focus();
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
  var arrsalename=new Array();
  var arrsalebarnd=new Array();
  var arrsaletype=new Array();
  //2012-08-23新增 gaopeng begin
  var arropnote=new Array();
  //2012-08-23新增 gaopeng end
  var arrtypemoney=new Array();
  var arrsalemoney=new Array();
  var arrdetphone=new Array();
  var arrdetbase=new Array();
  var arrdetconsumeterm=new Array();
  var arrdetfree=new Array();
  var arrdetactiveterm=new Array();
  var arrdetallgiftprice=new Array();
  var arrdetmonbase=new Array();
  var arrdetsaleprice=new Array();
  var arrdetsalecode=new Array();
  var arrdetmarketprice=new Array();
  //var arrdetmode=new Array();
  //修改部分
  var arrmodecode=new Array();
  var arrmodesale=new Array();
  var arrmodename=new Array();
  //
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
	out.println("arrsalename["+l+"]='"+saleTypeStr[l][1]+"';\n");
	out.println("arrsalebarnd["+l+"]='"+saleTypeStr[l][2]+"';\n");
	out.println("arrsaletype["+l+"]='"+saleTypeStr[l][3]+"';\n");
	// 2012-08-23新增 gaopeng
	out.println("arropnote["+l+"]='"+saleTypeStr[l][4]+"';\n");
  }
  for(int l=0;l<saledetStr.length;l++)
  {
	out.println("arrdetphone["+l+"]='"+saledetStr[l][0]+"';\n");
	out.println("arrdetbase["+l+"]='"+saledetStr[l][1]+"';\n");
	out.println("arrdetconsumeterm["+l+"]='"+saledetStr[l][2]+"';\n");
	out.println("arrdetfree["+l+"]='"+saledetStr[l][3]+"';\n");
	out.println("arrdetactiveterm["+l+"]='"+saledetStr[l][4]+"';\n");
	out.println("arrdetmonbase["+l+"]='"+saledetStr[l][5]+"';\n");
	out.println("arrdetallgiftprice["+l+"]='"+saledetStr[l][6]+"';\n");
    out.println("arrdetsaleprice["+l+"]='"+saledetStr[l][7]+"';\n");
	out.println("arrdetsalecode["+l+"]='"+saledetStr[l][8]+"';\n");
	out.println("arrdetmarketprice["+l+"]='"+saledetStr[l][9]+"';\n");
  }
  //修改部分 .............................................................
  for(int l=0;l<modecodeStr.length;l++)
  {
  out.println("arrmodecode["+l+"]='"+modecodeStr[l][0]+"';\n");
  out.println("arrmodesale["+l+"]='"+modecodeStr[l][1]+"';\n");
  out.println("arrmodename["+l+"]='"+modecodeStr[l][2]+"';\n");
  }
  //................................................................
%>
//--------1---------doProcess函数----------------
  function doProcess(packet)
  {
    var vRetPage=packet.data.findValueByName("rpc_page");
	var retType=packet.data.findValueByName("retType");

    if(vRetPage == "qryCus_s126hInit")
    {
	    var retCode = packet.data.findValueByName("retCode");
	    var retMsg = packet.data.findValueByName("retMsg");
	    var bp_name        = packet.data.findValueByName("bp_name"        );
	    var sm_code         = packet.data.findValueByName("sm_code"        );
	    var family_code     = packet.data.findValueByName("family_code"    );
	    var rate_code       = packet.data.findValueByName("rate_code"      );
	    var bigCust_flag    = packet.data.findValueByName("bigCust_flag"   );
	    var sm_name         = packet.data.findValueByName("sm_name"        );
	    var rate_name       = packet.data.findValueByName("rate_name"      );
	    var bigCust_name    = packet.data.findValueByName("bigCust_name"   );
	    var next_rate_code  = packet.data.findValueByName("next_rate_code" );
	    var next_rate_name  = packet.data.findValueByName("next_rate_name" );
	    var lack_fee        = packet.data.findValueByName("lack_fee"       );
	    var prepay_fee      = packet.data.findValueByName("prepay_fee"     );
	    var bp_add          = packet.data.findValueByName("bp_add"         );
	    var cardId_type     = packet.data.findValueByName("cardId_type"    );
	    var cardId_no       = packet.data.findValueByName("cardId_no"      );
	    var cust_id         = packet.data.findValueByName("cust_id"        );
	    var cust_belong_code= packet.data.findValueByName("cust_belong_code");
	    var group_type_code = packet.data.findValueByName("group_type_code");
	    var group_type_name = packet.data.findValueByName("group_type_name");
	    var imain_stream    = packet.data.findValueByName("imain_stream"   );
	    var next_main_stream= packet.data.findValueByName("next_main_stream");
	    var hand_fee        = packet.data.findValueByName("hand_fee"       );
	    var favorcode       = packet.data.findValueByName("favorcode"      );
	    var card_no         = packet.data.findValueByName("card_no"        );
	    var print_note      = packet.data.findValueByName("print_note"     );
	    var contract_flag   = packet.data.findValueByName("contract_flag"  );
	    var high_flag       = packet.data.findValueByName("high_flag"      );
		if(retCode == 000000)
		{
		document.all.i2.value = cust_id;
		document.all.i16.value = rate_code;
		document.all.belong_code.value = cust_belong_code;
		document.all.print_note.value = print_note;

		document.all.i4.value = bp_name;
		document.all.i5.value = bp_add;
		document.all.i6.value = cardId_type;
		document.all.i7.value = cardId_no;
		document.all.i8.value = sm_code+"--"+sm_name;
		document.all.i9.value = contract_flag;
		document.all.ipassword.value = "";
		document.all.group_type.value = group_type_code+"--"+group_type_name;
		document.all.ibig_cust.value =  bigCust_flag+"--"+bigCust_name;
		document.all.favorcode.value = favorcode;
		document.all.maincash_no.value = rate_code;
		document.all.imain_stream.value =  imain_stream;
		document.all.next_main_stream.value =  next_main_stream;
		document.all.i18.value = next_rate_code+"--"+next_rate_name;
		document.all.i19.value = hand_fee;
		document.all.i20.value = hand_fee;
		document.all.oCustName.value = bp_name;
		document.all.oSmCode.value = sm_code;
		document.all.oSmName.value = sm_name;
		document.all.oModeCode.value = rate_code;
		document.all.oModeName.value = rate_name;
		document.all.oPrepayFee.value = prepay_fee;
		document.all.oMarkPoint.value = "0";
		}
		else
		{
				rdShowMessageDialog("错误:"+ retCode + "->" + retMsg);
				return;
		}
  	}
    if(vRetPage == "qryPayPrepay")
    {
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    var pay_pre        = packet.data.findValueByName("pay_pre"        );
		if(retCode == 000000)
		{
		document.all.oPayPre.value = pay_pre;
		}
		else
		{
				rdShowMessageDialog("错误:"+ retCode + "->" + retMsg);
				return;
		}
     getbrand();
    }
    if(vRetPage == "qryAreaFlag")
    {
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    var area_flag        = packet.data.findValueByName("area_flag"        );
		if(retCode == 000000)
		{
		    if(parseInt(area_flag)>0)
		    {
		       document.all.flagCodeTr.style.display="";
		       getFlagCode();
		    }
		}
		else
		{
				rdShowMessageDialog("错误:"+ retCode + "->" + retMsg);
				return;
		}
	}
	if(retType=="0"){
			var  retResult=packet.data.findValueByName("retResult");
			if(retResult == "000000"){
					rdShowMessageDialog("IMEI号校验成功1！",2);
					document.frm.commit.disabled=false;
					return ;
			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI号校验成功2！",2);
					document.frm.commit.disabled=false;
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
	else if(retType == "checkAward")
	{
		var retCode = packet.data.findValueByName("retCode");
		var retMessage = packet.data.findValueByName("retMessage");
    	window.status = "";
    }

	//added by hanfa 20070118 begin
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
			rdShowMessageDialog("错误:"+ errCode + "->" + errMsg,0);
			return false;
		}
	}//added by hanfa 20070118 end
 }
  //--------2---------验证按钮专用函数-------------
function doChkImei( packet )
{
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");	
    if ( retCode!="000000" )
    {
    	rdShowMessageDialog(retCode+":"+retMsg);
    	return false;
    }
    else
    {
	
	if (document.frm.IMEINo.value.length == 0) {
	rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
	document.frm.IMEINo.focus();
	document.frm.commit.disabled = true;
	return false;
	}
	
	var chkImeiPacket = new   AJAXPacket("fG068OpenAjax.jsp");
	chkImeiPacket.data.add("imeiNo",(document.all.IMEINo.value).trim());
	chkImeiPacket.data.add("sale_code",(document.all.sale_code.options[document.all.sale_code.selectedIndex].value).trim());
	chkImeiPacket.data.add("ajaxType","chkImei1");
	chkImeiPacket.data.add("retType" , "0")
	core.ajax.sendPacket(chkImeiPacket );
	chkImeiPacket=null;	
    }
    
}
  
 
  function checkimeino()
{
	
	var chkImeiPacket = new   AJAXPacket("fG068OpenAjax.jsp");
	chkImeiPacket.data.add("imeiNo",(document.all.IMEINo.value).trim());
	chkImeiPacket.data.add("ajaxType","chkImei");
	core.ajax.sendPacket(chkImeiPacket , doChkImei );
	chkImeiPacket=null;	
}
 function viewConfirm()
{
	if(document.frm.IMEINo.value=="")
	{
		document.frm.commit.disabled=true;
	}
}
  function chkPass()
  {
  var myPacket = new AJAXPacket("qryCus_s126hInit.jsp","正在查询客户，请稍候......");
	myPacket.data.add("iPhoneNo",(document.all.phoneNo.value).trim());
	myPacket.data.add("iLoginNo",(document.all.loginNo.value).trim());
	myPacket.data.add("iOrgCode",(document.all.orgCode.value).trim());
	myPacket.data.add("iOpCode",(document.all.iOpCode.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket=null;
  }
  function qryPayPrepay()
  {
  if(!checkElement(document.all.oPayAccept)) return;
  var myPacket = new AJAXPacket("qryPayPrepay.jsp","正在查询客户，请稍候......");
	myPacket.data.add("PayAccept",(document.all.oPayAccept.value).trim());
	myPacket.data.add("IdNo",(document.all.i2.value).trim());
	myPacket.data.add("PhoneNo",(document.all.phoneNo.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket=null;
  }
      function checksmz()
  {
  var myPacket = new AJAXPacket("checkSMZ.jsp","正在查询客户是否是实名制客户，请稍候......");
	myPacket.data.add("PhoneNo",(document.frm.phoneNo.value).trim());
	core.ajax.sendPacket(myPacket,checkSMZValue);
	myPacket=null;
  }
  function checkSMZValue(packet) {
      document.all.smzvalue.value="";
			var smzvalue = packet.data.findValueByName("smzvalue");
      document.all.smzvalue.value=smzvalue;
}
  /***** 提交前增加品牌转换提示信息 added by hanfa 20070118 begin *****/
  function formCommit()
  {
  		//getAfterPrompt();
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
			  			rdShowMessageDialog("非全球通客户将不能参与VIP评定。	");
			  		}
		  		}else if(document.all.oSmCode.value == "dn"){
		  			//rdShowMessageDialog("该操作涉及到品牌变更，您的现有积分或M值将于品牌变更生效时失效，请您在新资费生效前及时兑换。");
		  		}
		  				  		if(document.all.oSmCode.value != "zn" && document.all.m_smCode.value=="zn" && document.all.oSmCode.value !="") {//
		  			checksmz();
		  			var smzvalues =document.all.smzvalue.value.trim();
		  			if(smzvalues=="3") {//非实名制全球通、动感地带客户转移为神州行客户
		  				rdShowMessageDialog("<%=readValue("7688","ps","jf",Readpaths)%>");
		  			}
		  		}
	  		}
  		}
		frmCfm();
  }
  /***** 提交前增加品牌转换提示信息 added by hanfa 20070118 end *****/
  function frmCfm()
  {
  	//20120824  gaopeng 增加一个新的参数 为opnote 判断当前营销案属于裸机销售还是正常销售
	 document.frm.iAddStr.value=document.frm.sale_code.value+"|"+document.all.agent_code.options[document.all.agent_code.selectedIndex].text+"|"+document.all.phone_type.options[document.all.phone_type.selectedIndex].text+"|"+
	                            document.frm.Sale_Price.value+"|"+document.frm.Base_Fee.value+"|"+document.frm.Consume_Term.value+"|"+document.frm.Free_Fee.value+"|"+document.frm.Active_Term.value+"|"+
	                            document.frm.Price.value+"|"+document.frm.Market_Price.value+"|"+document.frm.IMEINo.value+"|"+document.frm.needopnote.value;
	 if(!checkElement(document.all.phoneNo)) return;
     if(document.all.agent_code.value==""){
	  rdShowMessageDialog("请输入TD商务固话品牌!");
      document.all.agent_code.focus();
	  return false;
	}
	if(document.all.phone_type.value==""){
	  rdShowMessageDialog("请输入TD商务固话型号!");
      document.all.phone_type.focus();
	  return false;
	}
	if(document.all.sale_code.value==""){
	  rdShowMessageDialog("请输入营销代码!");
      document.all.sale_code.focus();
	  return false;
	}
	  //修改部分...............................................................................................
	if(document.all.New_Mode_Code.value=="")
	{////111
		rdShowMessageDialog("请输入新主资费代码!")
		document.all.New_Mode_Code.focus();
		return false;  ///222
	}
		//完毕....................................................................................................
	if (document.all.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
      document.all.IMEINo.focus();
      //document.all.confirm.disabled = true; //confirm 错了，应为 commit  //modified by hanfa 20070118
      document.all.commit.disabled = true;
	  return false;
     }
     if (document.all.i9.value == "Y")
     {
     	rdShowMessageDialog("该用户是托收用户,预存款将在下月托收时收回！");
     }
         //if(document.all.i9.value == "N" && parseFloat(document.all.oPayPre.value)<parseFloat(document.all.Prepay_Fee.value))
         //{
          // rdShowMessageDialog("本次缴纳预存款不足,不能办理!");
           //return;
        // }
	frm.submit();
	document.all.commit.disabled=true;
  }
 function judge_area()
 {
	var myPacket = new AJAXPacket("qryAreaFlag.jsp","正在查询客户，请稍候......");
	myPacket.data.add("orgCode",(document.all.orgCode.value).trim());
	myPacket.data.add("modeCode",(document.all.New_Mode_Code.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket=null;
 }
function getFlagCode1()
	{
		document.all.commit.disabled=false;
		if (document.frm.back_flag_code.value == 2)
		{
 	 	  document.all.flagCodeTextTd.style.display = "";
    	document.all.flagCodeTd.style.display = "";
	  }
    }
function getFlagCode()
{
  	//调用公共js
    var pageTitle = "资费查询";
    var fieldName = "小区代码|小区名称|二批代码";//弹出窗口显示的列、列名
    //var sqlStr ="select a.flag_code, a.flag_code_name,a.rate_code from sRateFlagCode a, sBillModeDetail b where a.region_code=b.region_code and a.rate_code=b.detail_code and b.detail_type='0' and a.region_code='" + document.frm.orgCode.value.substring(0,2) + "' and b.mode_code='" + document.frm.New_Mode_Code.value + "' order by a.flag_code" ;
	var sqlStr = "select a.flag_code, a.flag_code_name from sofferflagcode a, sregioncode b where a.offer_id = " + document.frm.New_Mode_Code.value + " and a.group_id = b.group_id and b.region_code = '" + document.frm.orgCode.value.substring(0,2) + "' order by a.flag_code";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "0|1|2";//返回字段
    var retToField = "flag_code|flag_code_name|rate_code";//返回赋值的域
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框
     var h=150;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
     var printStr = printInfo(printType);
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
     var path = "<%=request.getContextPath()%>/pages/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
     var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
     var ret=window.showModalDialog(path,"",prop);
     return ret;
  }
function MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,dialogWidth)
{
    var path = "<%=request.getContextPath()%>/page/public/fPubSimpSel.jsp";
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
function getbrand(){
	var myEle2 ;
   	var x2 ;
   	for (var q2=document.all.agent_code.options.length;q2>=0;q2--) document.all.agent_code.options[q2]=null;
   	myEle2 = document.createElement("option") ;
    	myEle2.value = "";
        myEle2.text ="--请选择--";
        document.all.agent_code.add(myEle2) ;
        for ( x2 = 0 ; x2 < arrbrandcode.length  ; x2++ )
   	{
      		if ( arrbrandmoney[x2] <=parseInt(document.all.oPayPre.value,10))
      		{
        		myEle2 = document.createElement("option") ;
        		myEle2.value = arrbrandcode[x2];
        		myEle2.text = arrbrandname[x2];
        		document.all.agent_code.add(myEle2) ;
      		}
   	}
}
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
        myEle.value = arrPhoneType[x] ;
        myEle.text = ItemArray[x] ;
        controlToPopulate.add(myEle) ;
      }
   }
 }
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
        		//2012-08-23新增 gaopeng 加入一个新的属性 name 用于取值判断是裸机销售0还是正常销售1
        		myEle1.name = arropnote[x1];
        		document.all.sale_code.add(myEle1) ;
      		}
   	}
 }
 function checkAward()
 {
 	 if(document.all.phone_type.value == "")
 	 {
 	 	 rdShowMessageDialog("请先选择机型");
 	 	 return;
 	 }
 }
  function salechage(){
  	
//首先得到被选中的营销方案的name 实际是取到营销代码中的opnote字段
    var selsed=$("#sale_code").find("option:selected").attr("name");
    
//给隐藏域赋值opnote 赋值为了判断当前选择的营销方案属于裸机销售还是正常销售
		$("input[name='needopnote']").val(selsed);
  	var x3;

	for ( x3 = 0 ; x3 < arrdetsalecode.length  ; x3++ )
   	{
      		if ( arrdetsalecode[x3] == document.all.sale_code.value )
      		{
      			document.all.Price.value=arrdetphone[x3];
        		document.all.Base_Fee.value=arrdetbase[x3];
        		document.all.Consume_Term.value=arrdetconsumeterm[x3];
        		document.all.Free_Fee.value=arrdetfree[x3];
        		document.all.Active_Term.value=arrdetactiveterm[x3];
        		document.all.All_Gift_Price.value=arrdetallgiftprice[x3];
                document.all.Mon_Base_Fee.value=arrdetmonbase[x3];
        		document.all.Sale_Price.value=arrdetsaleprice[x3];
        		document.all.Market_Price.value=arrdetmarketprice[x3];
      		}
   	}
    document.frm.i1.value=document.frm.phoneNo.value;
    document.frm.ip.value=document.frm.New_Mode_Code.value;
    document.all.do_note.value = "用户"+document.all.phoneNo.value+"办理购TD商务固话，赠通信费(铁通)";
     document.frm.iAddStr.value=document.frm.sale_code.value+"|"+document.all.agent_code.options[document.all.agent_code.selectedIndex].text+"|"+document.frm.Sale_Price.value+"|"+document.frm.Base_Fee.value+"|"+document.frm.Active_Term.value+"|"+document.frm.Free_Fee.value+"|"+document.frm.Consume_Term.value+"|"+document.all.phone_type.options[document.all.phone_type.selectedIndex].text+"|"+document.frm.Price.value+"|"+document.frm.Market_Price.value+"|"+document.frm.IMEINo.value;
    var myEle4 ;
   	for (var q4=document.all.New_Mode_Code.options.length;q4>=0;q4--) document.all.New_Mode_Code.options[q4]=null;
   	myEle4 = document.createElement("option") ;
    	myEle4.value = "";
        myEle4.text ="--请选择--";
        document.all.New_Mode_Code.add(myEle4) ;
     
    for ( x4 = 0 ; x4 < arrmodesale.length  ; x4++ )
	{
		if ( arrmodesale[x4] == document.all.sale_code.value )
		{
				myEle4 = document.createElement("option") ;
        		myEle4.value = arrmodecode[x4];
        		myEle4.text = arrmodename[x4];
        		document.all.New_Mode_Code.add(myEle4);
		}
	}
 }
	//修改部分......................................................................................
function modechage()
{
	var x4;
    document.frm.ip.value=document.frm.New_Mode_Code.value;
    getMidPrompt("10442",codeChg(document.frm.New_Mode_Code.value),"ipTd")
	/*不查小区*/
	  judge_area();
    if(document.all.sale_code.value != "")
    {
    	querySmcode();
    }
 }
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
  //新增函数：查询资费代码相应的品牌代码 added by hanfa 20070118
  function querySmcode()
  {
	  var myPacket = new AJAXPacket("querySmcode_rpc.jsp","正在获得信息，请稍候......");
	  myPacket.data.add("modeCode",(document.frm.New_Mode_Code.value).trim());
	  core.ajax.sendPacket(myPacket);
	  myPacket=null;
  }
//-->
</script>
</head>
<body>
	<form name="frm" method="post" action="/npage/bill/f1270_3.jsp" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
		<input type="hidden" name="m_smCode" value="">
		<input name="oModeCode" type="hidden" class="button" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=paraStr%>">
		<input type="hidden" name="Sale_Code" value="">
		<input type="hidden" name="Market_Price" class="InputGrey" id="Market_Price" readonly>
		<input name="Mon_Base_Fee" type="hidden" class="InputGrey" id="Mon_Base_Fee" readonly>
		<input name="All_Gift_Price" type="hidden" class="InputGrey" id="All_Gift_Price" readonly>
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
				<input name="oModeName" type="text" size='40' class="InputGrey" id="oModeName" value="<%=rate_name%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">帐号预存</td>
			<td colspan = '3'>
				<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="<%=prepay_fee%>" readonly>
				<input name="oMarkPoint" type="hidden" class="InputGrey" id="oMarkPoint" value="<%=print_note%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">TD商务固话品牌</td>
			<td>
				<SELECT id="agent_code" name="agent_code" v_must=1  
					onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);" v_name="手机代理商">
				<option value ="">--请选择--</option>
				<%
				for(int i = 0 ; i < agentCodeStr.length ; i ++)
				{
				%>
					<option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
				<%
				}
				%>
				</select>
				<font color="orange">*</font>
			</td>
				<td class="blue">TD商务固话型号</td>
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
			<td class="blue">新主资费</td>
			<td id="ipTd">
				<select type="hidden" name="New_Mode_Code" id="New_Mode_Code" v_must=1 v_name="新主资费" onchange="modechage()">
				</select>
				<font color="orange">*</font>
			</td>
		</tr>
		<tr style='display:none'>
			<td class="blue">赠送话费</td>
           		 <td>
				<input Class="InputGrey" name="Base_Fee" type="text" class="InputGrey" id="Base_Fee" readonly>
			</td>
			<td class="blue">话费消费期限</td>
           		 <td>
				<input Class="InputGrey" name="Consume_Term" type="text" class="InputGrey" id="Consume_Term"   readonly>
			</td>
		</tr>
		<tr style='display:none'>
			<td class="blue">赠上网费</td>
          		  <td>
				<input Class="InputGrey" name="Free_fee" type="text" class="InputGrey" id="Free_Fee"   readonly>
			</td>
			 <td class="blue">上网费消费期限</td>
           	 	<td>
            			<input Class="InputGrey" name="Active_Term" type="text" class="InputGrey" id="Active_Term"   readonly>
			</td>
		</tr>
		<tr style='display:none'>
			 <td class="blue">应收金额</td>
              		<td>
            			<input Class="InputGrey" name="Sale_Price" type="text" class="InputGrey" id="Sale_Price" readonly>
			</td>
			   
               		<td class="blue" >购TD商务固话费</td>
	               	<td>
	                		<input Class="InputGrey" name="Price" type="text" class="InputGrey" id="Price" readonly>
	             	</td>			   

		</tr>
		<tr style='display:none' id="flagCodeTr" style="display:none">
		    	<TD class="blue">小区代码</TD>
			  <TD colspan="3">
				    <input type="hidden" size="17" name="rate_code" id="rate_code" readonly>
           			<input type="text" class="InputGrey" name="flag_code" size="8" maxlength="10" readonly>
			      <input type="text" class="InputGrey" name="flag_code_name" size="18" readonly >&nbsp;&nbsp;
			      <input name="newFlagCodeQuery" type="button" class="b_text"  style="cursor:hand" onClick="getFlagCode()" value=选择>
       		 	</TD>
      		</tr>
		 <TR>
			<TD class="blue">
			<div align="left">IMEI码</div>
			</TD>
			<TD colspan='3'>
				<input name="IMEINo" class="button" type="text" v_type="0_9" v_name="IMEI码"  maxlength=15 value="" onblur="viewConfirm()">
				<input name="checkimei" class="b_text" type="button" value="校验" onclick="checkimeino()">
				<font color="orange">*</font>
			</TD>
          	</TR>
		  <TR id=showHideTr  style='display:none'>
			<TD class="blue">
				<div align="left">购机时间</div>
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
			<td id="footer" colspan="4">
				<div align="center">
                &nbsp;
				<input name="commit" id="commit" type="button" class="b_foot"  
				 value="下一步" onClick="formCommit();"  disabled>
                &nbsp;
                <input name="reset" type="reset" class="b_foot" value="清除" >
                &nbsp;
                <input name="close" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭">
                &nbsp;
				</div>
			</td>
		</tr>
	</table>
<div name="licl" id="licl">
			<input type="hidden" name="iOpCode" value="g068">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
			<!--缴费方式原为下拉框,本营销按不涉及 默认为0-->
			<input type="hidden" name="payType" value="0">
			<!--以下部分是为调f1270_3.jsp所定义的参数
			i2:客户ID
			i16:当前主套餐代码
			ip:申请主套餐代码
			belong_code:belong_code
			print_note:工单广告词
			iAddStr:
			i1:手机号码
			i4:客户名称
			i5:客户地址
			i6:证件类型
			i7:证件号码
			i8:业务品牌
			ipassword:密码
			group_type:集团客户类别
			ibig_cust:大客户类别
			do_note:用户备注
			favorcode:手续费优惠权限
			maincash_no:现主套餐代码（老）
			imain_stream:当前主资费开通流水
			next_main_stream:预约主资费开通流水
			i18:下月主套餐
			i19:手续费
			i20:最高手续费
			-->
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
			<input type="hidden" name="cus_pass" value="<%=cus_pass%>">
			<input type="hidden" name="opName" value="<%=opName%>">
			<input type="hidden" name="mode_type" value="">
			<input type="hidden" name="New_Mode_Name" value="新主资费名称">
			<input type="hidden" name="return_page" value="/npage/sg068/fG068Main.jsp">		
			<input type="hidden" name="main_phoneno" value="<%=main_phone%>">	
			<input type="hidden" name="smzvalue" >
			<input type="hidden" name="needopnote" value=""/>
</div>		
 <%@ include file="/npage/include/footer.jsp" %>   	
</form>
</body>
</html>

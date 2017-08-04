<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 预存赠固话、话费可分享 7671
   * 版本: 1.0
   * 日期: 2010/4/7
   * 作者: sunaj
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%String Readpaths = request.getRealPath("npage/properties")+"/getRDMessage.properties";%>
<%
	String opCode="7671";
	String opName="预存赠固话、话费可分享";

	String loginNo = (String)session.getAttribute("workNo");				//操作工号
	String orgCode = (String)session.getAttribute("orgCode");				//归属代码
	String regionCode = (String)session.getAttribute("regCode");			//地市
	/* liujian 安全加固修改 2012-4-6 16:18:13 begin */
	String op_strong_pwd = (String) session.getAttribute("password");
  /* liujian 安全加固修改 2012-4-6 16:18:13 end */
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>
<%
	 String printAccept="";
     printAccept = loginAccept;
	String retFlag="";
	String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
	String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
	String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
	String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
	String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";

	String iPhoneNo = request.getParameter("srv_no");
	String iOpCode = request.getParameter("opcode");
	String cus_pass = request.getParameter("cus_pass");
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

	String  inputParsm [] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	System.out.println("phoneNO === "+ iPhoneNo);

%>
	<wtc:service name="s126bInit" routerKey="region" routerValue="<%=regionCode%>" outnum="29" retcode="retCode" retmsg="retMsg">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=iOpCode%>"/>
				<wtc:param value="<%=loginNo%>"/>
				<wtc:param value="<%=op_strong_pwd%>"/>
				<wtc:param value="<%=iPhoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=inputParsm[2]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;

  if(tempArr == null)
  {
	   retFlag = "1";
	   retMsg = "s126bInit查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else
  {
	  if (errCode.equals("000000")&tempArr.length>0 ){
		    bp_name = tempArr[0][3];           			//机主姓名
		    bp_add  = tempArr[0][4];            		//客户地址
		    passwordFromSer = tempArr[0][4];  			//密码
		    sm_code = tempArr[0][11];         			//业务类别
		    sm_name = tempArr[0][12];        			//业务类别名称
		    hand_fee = tempArr[0][13];      			//手续费
		    favorcode = tempArr[0][14];     			//优惠代码
		    rate_code = tempArr[0][5];     				//资费代码
		    rate_name = tempArr[0][6];    				//资费名称
		    next_rate_code = tempArr[0][7];				//下月资费代码
		    next_rate_name = tempArr[0][8];				//下月资费名称
	    	bigCust_flag = tempArr[0][9];				//大客户标志
	    	bigCust_name = tempArr[0][10];				//大客户名称
	    	lack_fee = tempArr[0][15];					//总欠费
	    	prepay_fee = tempArr[0][16];				//总预交
	    	cardId_type = tempArr[0][17];				//证件类型
	    	cardId_no = tempArr[0][18];					//证件号码
	    	cust_id = tempArr[0][19];					//客户id
	    	cust_belong_code = tempArr[0][20];			//客户归属id
	    	group_type_code = tempArr[0][21];			//集团客户类型
	    	group_type_name = tempArr[0][22];			//集团客户类型名称
	    	imain_stream = tempArr[0][23];				//当前资费开通流水
	    	next_main_stream = tempArr[0][24];			//预约资费开通流水
	    	print_note = tempArr[0][25];				//工单广告
	    	contract_flag = tempArr[0][27];				//是否托收账户
	    	high_flag = tempArr[0][28];					//是否中高端用户
	 }else{%>
		<script language="JavaScript">
			rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
			history.go(-1);
		</script>
<%	 }
	}

%>
<%
//******************得到下拉框数据***************************//

	//手机品牌
	String sqlAgentCode = "select  unique a.brand_code,trim(b.brand_name) from dphoneSaleCode a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='30' and a.brand_code=b.brand_code and a.valid_flag='Y'";
 	//手机类型
	String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from dphoneSaleCode a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and a.brand_code=b.brand_code and a.sale_type='30' and a.valid_flag='Y'";
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode1" retmsg="retMsg1">
		<wtc:sql><%=sqlPhoneType%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="phoneTypeStr" scope="end" />
<%
	//营销代码
	String sqlsaleType = "select unique trim(a.sale_code),trim(a.sale_name), a.brand_code,a.type_code from dphoneSaleCode a where a.region_code='" + regionCode + "' and a.sale_type='30' and a.valid_flag='Y'";
	System.out.println("sqlsaleType====="+sqlsaleType);
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode2" retmsg="retMsg2">
		<wtc:sql><%=sqlsaleType%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="saleTypeStr" scope="end" />
<%
	//营销明细
	String sqlsaledet = "select sale_price,sale_price-prepay_gift-prepay_limit,base_fee*consume_term,free_fee,consume_term,prepay_limit,active_term,sale_code from dphoneSaleCode  where region_code='" + regionCode + "' and sale_type='30' and valid_flag='Y'";
	System.out.println("sqlsaledet====="+sqlsaledet);
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="8" retcode="retCode3" retmsg="retMsg3">
		<wtc:sql><%=sqlsaledet%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="saledetStr" scope="end" />
<%
	//新主资费(修改部分)
	String sqlmodecode = "select a.mode_code,trim(a.sale_code),a.mode_code||'--'||c.offer_name from dChnResSalePlanModeRel a,dphoneSaleCode b,product_offer c where a.sale_code=b.sale_code and b.region_code='" + regionCode + "' and b.sale_type='30' and valid_flag='Y' and trim(a.mode_code)=to_char(c.offer_id) and c.state = 'A'";
	System.out.println("sqlmodecode====="+sqlmodecode);

%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode4" retmsg="retMsg4">
		<wtc:sql><%=sqlmodecode%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="modecodeStr" scope="end" />

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>预存赠固话、话费可分享</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
<!--
  onload=function()
  {

  	document.all.phoneNo.focus();
   	core.ajax.onreceive = doProcess;
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

  var arrdetsummoney=new Array();
  var arrdetfixedfee=new Array();
  var arrdetbase=new Array();
  var arrdetfree=new Array();
  var arrdetconsumeterm=new Array();
  var arrdetphonefee=new Array();
  var arrdetactiveterm=new Array();
  var arrdetsalecode=new Array();

  var arrmodecode=new Array();
  var arrmodesale=new Array();
  var arrmodename=new Array();
  <%  
/**  
  for(int m=0;m<agentCodeStr.length;m++)
  {
	out.println("arrbrandcode["+m+"]='"+agentCodeStr[m][0]+"';\n");
	out.println("arrbrandname["+m+"]='"+agentCodeStr[m][1]+"';\n");
  }
  **/
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
	out.println("arrdetsummoney["+l+"]='"+saledetStr[l][0]+"';\n");
	out.println("arrdetfixedfee["+l+"]='"+saledetStr[l][1]+"';\n");
	out.println("arrdetbase["+l+"]='"+saledetStr[l][2]+"';\n");
	out.println("arrdetfree["+l+"]='"+saledetStr[l][3]+"';\n");
	out.println("arrdetconsumeterm["+l+"]='"+saledetStr[l][4]+"';\n");
	out.println("arrdetphonefee["+l+"]='"+saledetStr[l][5]+"';\n");
	out.println("arrdetactiveterm["+l+"]='"+saledetStr[l][6]+"';\n");
	out.println("arrdetsalecode["+l+"]='"+saledetStr[l][7]+"';\n");
  }
  //修改部分 .............................................................
  for(int l=0;l<modecodeStr.length;l++)
  {
  out.println("arrmodecode["+l+"]='"+modecodeStr[l][0]+"';\n");
  out.println("arrmodesale["+l+"]='"+modecodeStr[l][1]+"';\n");
  out.println("arrmodename["+l+"]='"+modecodeStr[l][2]+"';\n");
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
    var area_flag        = packet.data.findValueByName("area_flag"        );

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
				rdShowMessageDialog("错误:"+ retCode + "->" + retMsg,0);
				return;
		}
	}
	if(retType=="0"){
			var  retResult=packet.data.findValueByName("retResult");
			if(retResult == "000000"){
					rdShowMessageDialog("IMEI号校验成功1！");
					document.frm.commit.disabled=false;
					document.frm.IMEINo.readOnly = true;
					return ;

			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI号校验成功2！");
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
	else if(retType == "checkAward")
	{
			var retCode = packet.data.findValueByName("retCode");
			var retMessage = packet.data.findValueByName("retMessage");
    	window.status = "";
    	if(retCode!=0){
    		rdShowMessageDialog(retMessage);
    		document.all.need_award.checked = false;
    		document.all.award_flag.value = 0;
    		return ;
    	}
    	document.all.award_flag.value = 1;
    }

    if(vRetPage=="qrysecondpn")
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
		document.all.secondname.value = bp_name;
		//document.all.secondsmname.value = sm_name;
		//document.all.secondmodename.value = rate_name;
		//document.all.secondprepay.value = prepay_fee;
		//document.all.secondMarkPoint.value = print_note;
		document.frm.checkimei.disabled = false;
		document.all.secondphone.disabled =true;
		}
		else
		{
				rdShowMessageDialog("错误:"+ retCode + "->" + retMsg);
				document.frm.checkimei.disabled = true;
				document.all.secondphone.disabled =false;
				return;
		}

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

  function checkimeino()
{
	 if (document.frm.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
      document.frm.IMEINo.focus();
      document.frm.commit.disabled = true;
	  return false;
     }
	var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/s1141/queryimei.jsp","正在校验IMEI信息，请稍候......");
	myPacket.data.add("imei_no",document.all.IMEINo.value.trim());
	myPacket.data.add("brand_code",document.all.agent_code.options[document.all.agent_code.selectedIndex].value.trim());
	myPacket.data.add("style_code",document.all.phone_type.options[document.all.phone_type.selectedIndex].value.trim());
	myPacket.data.add("opcode",document.all.iOpCode.value.trim());
	myPacket.data.add("retType","0");
	core.ajax.sendPacket(myPacket);
	myPacket=null;

}
function checksec(){
	if(document.frm.sale_code.value.length == 0)
	{
		rdShowMessageDialog("请选择营销案 !!");
      	document.frm.sale_code.focus();
     	document.frm.checkimei.disabled = true;
	  	return false;
	}

	if (document.frm.secondphone.value.length == 0) {
      rdShowMessageDialog("手机卡号码不能为空，请重新输入 !!");
      document.frm.secondphone.focus();
      document.frm.checkimei.disabled = true;
	  return false;
     }
     
     if (document.frm.secondphone.value == document.frm.phoneNo.value) {
      rdShowMessageDialog("手机卡号码不能与固话卡号码相同，请重新输入 !!");
      document.frm.secondphone.focus();
      document.frm.checkimei.disabled = true;
	  return false;
     }
     //alert(document.frm.secondphone.value.substring(0,3));
	if (document.frm.secondphone.value.substring(0,3) == "157") 
	{
      	rdShowMessageDialog("手机卡号码不可以是157号段的号码!");
      	document.frm.secondphone.focus();
      	document.frm.checkimei.disabled = true;
	  	return false;
     }
	var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/s1141/qrysecondpn.jsp","正在校验手机卡信息，请稍候......");
	myPacket.data.add("secondphone",document.all.secondphone.value.trim());
	myPacket.data.add("orgcode",document.all.orgCode.value.trim());
	myPacket.data.add("loginno",document.all.loginNo.value.trim());
	myPacket.data.add("salecode",document.all.sale_code.value.trim());
	myPacket.data.add("iOpCode","7671");
	myPacket.data.add("qrysecondpn","1");
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
  		var userCardCode = '<%=cardCode%>';
  		if(document.all.New_Mode_Code.value=="")
	{
		rdShowMessageDialog("请输入新主资费代码!")
		document.all.New_Mode_Code.focus();
		return false;
	}
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
		  				rdShowMessageDialog("<%=readValue("7671","ps","jf",Readpaths)%>");
		  			}
		  		}
	  		}

  		}
	//打印工单并提交表单
		    frmCfm();

  }
  /***** 提交前增加品牌转换提示信息 added by hanfa 20070118 end *****/

 function frmCfm()
  {
	 document.frm.iAddStr.value=document.frm.sale_code.value+"|"+document.all.agent_code.options[document.all.agent_code.selectedIndex].text+"|"
	 							+document.frm.Prepay_Fee.value+"|"+document.frm.Base_Fee.value+"|"+document.frm.Free_Fee.value+"|"
								+document.all.phone_type.options[document.all.phone_type.selectedIndex].text+"|"
	 							+document.frm.Fixed_Fee.value+"|"+document.frm.Consume_Term.value+"|"
	 							+document.frm.Active_Term.value+"|"+document.frm.IMEINo.value+"|"+document.frm.secondphone.value+"|"+document.frm.Phone_Fee.value+"|"
	 							+document.frm.award_flag.value+"|";
//	alert(document.frm.iAddStr.value);
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
	  //修改部分...............................................................................................
	if(document.all.New_Mode_Code.value=="")
	{
		rdShowMessageDialog("请输入新主资费代码!")
		document.all.New_Mode_Code.focus();
		return false;
	}
	if (document.all.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
      document.all.IMEINo.focus();
      document.all.commit.disabled = true;

	  return false;
     }
         if (document.all.i9.value == "Y")
         {
         	rdShowMessageDialog("该用户是托收用户,预存款将在下月托收时收回！");
         }

        document.all.secondphone.disabled =false;
        frm.submit();
  }

 function judge_area()
 {
  	var myPacket = new AJAXPacket("qryAreaFlag.jsp","正在查询客户，请稍候......");
	myPacket.data.add("orgCode",document.all.orgCode.value.trim());
	myPacket.data.add("modeCode",document.all.New_Mode_Code.value.trim());
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
    var fieldName = "小区代码|小区名称";//弹出窗口显示的列、列名
	var sqlStr = "select a.flag_code, a.flag_code_name from sofferflagcode a, sregioncode b where a.offer_id = " + document.frm.New_Mode_Code.value + " and b.region_code = '" + document.frm.orgCode.value.substring(0,2) + " ' and a.group_id = b.group_id order by a.flag_code"
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "0|1";//返回字段
    var retToField = "flag_code|flag_code_name";//返回赋值的域

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框
     var h=180;
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
 	
	document.frm.commit.disabled=true;
    //alert(document.all.licl.innerHTML);
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
  	document.frm.commit.disabled=true;
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

 }
 function checkAward()
 {
 	 if(document.all.phone_type.value == "")
 	 {
 	 	 rdShowMessageDialog("请先选择机型");
 	 	 document.all.need_award.checked = false;
 	 	 document.all.award_flag.value = 0;
 	 	 return;
 	 }
 	 if(document.all.need_award.checked )
 	 {
 	 	 var packet = new AJAXPacket("../s1141/phone_getAwardRpc.jsp","正在获得奖品明细，请稍候......");
 	 	 packet.data.add("retType","checkAward");
 	 	 packet.data.add("op_code","7671");
 	 	 packet.data.add("style_code",document.all.phone_type.value );

 	 	 core.ajax.sendPacket(packet);
 	 	 packet=null;

 	 }
 	 document.all.award_flag.value = 0;

 }

  function salechage(){
 	
 	document.frm.commit.disabled=true;
 	var x3;
	for ( x3 = 0 ; x3 < arrdetsalecode.length  ; x3++ )
   	{
      		if ( arrdetsalecode[x3] == document.all.sale_code.value )
      		{
        		document.all.Base_Fee.value=arrdetbase[x3];
        		document.all.Free_Fee.value=arrdetfree[x3];
        		document.all.Fixed_Fee.value=arrdetfixedfee[x3];
        		document.all.Consume_Term.value=arrdetconsumeterm[x3];
        		document.all.Active_Term.value=arrdetactiveterm[x3];
        		document.all.Phone_Fee.value=arrdetphonefee[x3];
        		document.all.Prepay_Fee.value=arrdetsummoney[x3];
      		}
   	}
    document.frm.i1.value=document.frm.phoneNo.value;
    document.frm.ip.value=document.frm.New_Mode_Code.value;
    document.all.do_note.value = "用户"+document.all.phoneNo.value+"办理预存赠固话、话费可分享";

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
				myEle4 = document.createElement("option");
        		myEle4.value = arrmodecode[x4];
        		myEle4.text = arrmodecode[x4];
        		myEle4.text = arrmodename[x4];
        		document.all.New_Mode_Code.add(myEle4);
		}
	}
  }
function modechage()
{
	var x4;
    document.frm.ip.value=document.frm.New_Mode_Code.value;
    judge_area();

    if(document.all.sale_code.value != "")
    {
    	querySmcode(); 
    }
    getMidPrompt("10442",codeChg(document.all.New_Mode_Code.value),"ipTd")
}

  //新增函数：查询资费代码相应的品牌代码 added by hanfa 20070118
  function querySmcode()
  {
	  var myPacket = new AJAXPacket("querySmcode_rpc.jsp","正在获得信息，请稍候......");
	  myPacket.data.add("modeCode",document.frm.New_Mode_Code.value.trim());
	  core.ajax.sendPacket(myPacket);
	  myPacket=null;
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
		<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
		<!-- added by hanfa 20070118-->
	  	<input type="hidden" name="m_smCode" value="">

		<input name="oModeCode" type="hidden" class="button" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
		<input type="hidden" name="Gift_Code" value="">

	<div class="title">
		<div id="title_zi">业务明细</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue">手机号码</td>
	    <td>
			<input class="InputGrey" type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" readonly >
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
			<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=rate_name%>" size="30" readonly>
		</td>
	</tr>

	<tr>
		<td class="blue">帐号预存</td>
		<td>
			<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="<%=prepay_fee%>" readonly>
		</td>
		<td class="blue">当前积分</td>
		<td>
			<input name="oMarkPoint" type="text" class="InputGrey" id="oMarkPoint" value="<%=print_note%>" readonly>
		</td>
	</tr>

	<tr>
		<td class="blue">手机品牌</td>
		<td>
			<SELECT id="agent_code" name="agent_code" v_must=1  onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);">
				<option value ="">--请选择--</option>
				<wtc:qoption name="sPubSelect" outnum="2">
					<wtc:sql><%=sqlAgentCode%></wtc:sql>
				</wtc:qoption>
			</select>
			<font color="orange">*</font>
		</td>
		<td class="blue">手机型号</td>
		<td>
			<select size=1 name="phone_type" id="phone_type" v_must=1 onchange="typechange()">
			</select>
			<font color="orange">*</font>
		</td>
	</tr>

	<tr>
		<td class="blue">营销方案</td>
		<td>
			<select size=1 name="sale_code" id="sale_code" v_must=1 onchange="salechage()">
			</select>
			<font color="orange">*</font>
		</td>
		<!--<td colspan="2" class="blue">是否参与赠礼
			<input type="checkbox" name="need_award" onclick="checkAward()" />
			<input type="hidden" name="award_flag" value="0" />
		</td>
		-->
		<td class="blue">TD固话费</td>
		<td>
			<input name="Fixed_Fee" type="text" class="InputGrey" id="Fixed_Fee" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">底限预存</td>
		<td>
			<input name="Base_Fee" type="text" class="InputGrey" id="Base_Fee" readonly>
		</td>
		<td class="blue">活动预存</td>
		<td>
			<input name="Free_Fee" type="text" class="InputGrey" id="Free_Fee" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">固话卡消费期限</td>
		<td>
			<input name="Consume_Term" type="text" class="InputGrey" id="Consume_Term" readonly>
		</td>
		<td class="blue">赠手机卡话费</td>
		<td>
			<input name="Phone_Fee" type="text" class="InputGrey" id="Phone_Fee" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">手机卡话费消费期限</td>
		<td>
			<input name="Active_Term" type="text" class="InputGrey" id="Active_Term" readonly>
		</td>	
		<td class="blue">新主资费</td>
		<td id="ipTd">
			<select name="New_Mode_Code" id="New_Mode_Code" v_must=1 onchange="modechage();">
			</select>
		</td>
	</tr>
	<tr id="flagCodeTr" style="display:none">
		<TD class="blue">小区代码</TD>
		<TD colspan="3">
			<input class="InputGrey" type="hidden" size="17" name="rate_code" id="rate_code" readonly>
			<input type="text" class="InputGrey" name="flag_code" size="8" maxlength="10" readonly>
			<input type="text" class="InputGrey" name="flag_code_name" size="18" readonly >&nbsp;&nbsp;
			<input name="newFlagCodeQuery" type="button" class="b_text" style="cursor:hand" onClick="getFlagCode()" value=选择>
		</TD>
	</tr>
		<!------------------------手机卡信息----------------------------------->
	<tr>
		<td class="blue">手机卡号码</td>
		<td>
			<input class="button" type="text" v_must="1" v_type="mobphone" v_must=1 name="secondphone" id="secondphone" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3"  >
			<font color="orange">*</font>
			<input name="checksecond" class="b_text" type="button" value="手机卡校验" onclick="checksec()">
		</td>
		<td class="blue">手机卡姓名</td>
		<td>
			<input name="secondname" type="text" class="InputGrey" id="secondname" readonly>
		</td>
	</tr>
<!---------------------------手机卡信息结束----------------------------------------------->
	<tr>
		<td class="blue">应收金额</td>
		<td>
			<input name="Prepay_Fee" type="text" class="InputGrey" id="Prepay_Fee" readonly>
		</td>
		<TD nowrap class="blue">IMEI码</TD>
		<td>
			<input name="IMEINo" class="button" type="text" v_type="0_9" maxlength=15 value="" onblur="viewConfirm()">
			<input name="checkimei" class="b_text" type="button" value="校验" disabled onclick="checkimeino()">
			<font color="orange">*</font>
		</TD>
	</TR>
		<!-- ningtn add for pos start @  -->
		<TR>
			<TD class="blue">缴费方式</TD>
			<TD colspan="3">
				<select name="payType" >
					<option value="0">现金缴费</option>
					<option value="BX">建设银行POS机缴费</option>
					<option value="BY">工商银行POS机缴费</option>
				</select>
			</TD>
		</TR>
		<!-- ningtn add for pos end @  -->
	<TR id=showHideTr >
		<TD nowrap class="blue">付机时间</TD>
		<TD>
			<input name="payTime" class="button" type="text" value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
			(年月日)<font color="orange">*</font>
		</TD>
		<TD nowrap class="blue">保修时限</TD>
		<TD>
			<input name="repairLimit" v_type="date.month" class="button" size="10" type="text" value="12" onblur="viewConfirm()">
			(个月)<font color="orange">*</font>
		</TD>
	</TR>

	<tr>
		<td colspan="4" align="center" id="footer">
			<input name="commit" id="commit" type="button" class="b_foot" value="下一步" onClick="formCommit();" disabled>
			&nbsp;
			<input name="reset11" type="button"  value="清除" class="b_foot" onclick="retFrm();">
			&nbsp;
			<input name="close" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭">
			&nbsp;
		</td>
	</tr>
</table>
<div name="licl" id="licl">
			<input type="hidden" name="iOpCode" value="7671">
			<input type="hidden" name="opCode" value="7671">
			<input type="hidden" name="opName" value="<%=opName%>">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
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
			<input type="hidden" name="printAccept" value="<%=printAccept%>">
			<input type="hidden" name="mode_type" value="">
			<input type="hidden" name="New_Mode_Name" value="新主资费名称">
			<input type="hidden" name="returnPage" value="/npage/bill/f7671_1.jsp">			
			<input type="hidden" name="cus_pass" value="<%=cus_pass%>">
			<input type="hidden" name="award_flag" value="0" />
			<input type="hidden" name="smzvalue" >
</div>
	<%@ include file="/npage/include/footer.jsp" %>			
</form>
</body>
</html>

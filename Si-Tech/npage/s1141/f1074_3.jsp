<%
/********************
 version v2.0
 开发商: si-tech
 update wangyua at 2010.5.11
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>


<%
	String opCode = request.getParameter("opCode");
	String opName = "铁通固话入网IMEI绑定";
	String iPhoneNo = request.getParameter("srv_no");
	String main_phone=request.getParameter("main_phoneno");
	String loginNo = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String nopass = (String)session.getAttribute("password"); 
	String userPwd = "";
	String custName = "";
	String smName = "";
	String offerName = "";
	String chnSource = "01";
	String opNote = "自采终端铁通固话入网IMEI绑定";
	String printAccept="";
	printAccept = getMaxAccept();
	String paraAray[] = new String[7];
  	paraAray[0] = printAccept;
  	paraAray[1] = chnSource;
  	paraAray[2] = opCode;
  	paraAray[3] = loginNo;
  	paraAray[4] = nopass;
  	paraAray[5] = iPhoneNo;
  	paraAray[6] = userPwd;
  	
%>
<wtc:service  name="s1074Init" routerKey="region" routerValue="<%=regionCode%>" outnum="3"  retcode="errCode" retmsg="errMsg">
	<wtc:param  value="<%=paraAray[0]%>"/>
	<wtc:param  value="<%=paraAray[1]%>"/>
	<wtc:param  value="<%=paraAray[2]%>"/>
	<wtc:param  value="<%=paraAray[3]%>"/>
	<wtc:param  value="<%=paraAray[4]%>"/>
	<wtc:param  value="<%=paraAray[5]%>"/>
	<wtc:param  value="<%=paraAray[6]%>"/>
	<wtc:param  value="1"/>
</wtc:service>
<wtc:array id="tempArr" scope="end"/>
<%
  if(errCode.equals("000000") && tempArr.length>0)
  {
	    custName = tempArr[0][0];           
	    smName = tempArr[0][1];            
	    offerName = tempArr[0][2];  

  }else{
%>
	<script language="JavaScript">
			rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
			history.go(-1);
	</script>
<%}
%>

<%
  //******************得到下拉框数据***************************//
  //手机品牌
  String sqlAgentCode = "select  unique a.brand_code,trim(b.brand_name) from dphoneSaleCode a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='33' and a.brand_code=b.brand_code and a.valid_flag='Y'";
  String[] inParamA = new String[2];
  inParamA[0] = "select  unique a.brand_code,trim(b.brand_name) from dphoneSaleCode a,schnresbrand b where a.region_code=:region_code and a.sale_type='33' and a.brand_code=b.brand_code and a.valid_flag='Y'";
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
  String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from dphoneSaleCode a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and a.brand_code=b.brand_code and a.sale_type='33' and a.valid_flag='Y'";
  String[] inParamB = new String[2];
  inParamB[0] = "select unique a.type_code,trim(b.res_name), b.brand_code from dphoneSaleCode a,schnrescode_chnterm b where a.region_code=:region_code and  a.type_code=b.res_code and a.brand_code=b.brand_code and a.sale_type='33'and a.valid_flag='Y'";
  inParamB[1] = "region_code=" + regionCode;
  System.out.println("sqlPhoneType====="+sqlPhoneType);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeB" retmsg="retMsgB" outnum="3">
	<wtc:param value="<%=inParamB[0]%>"/>
	<wtc:param value="<%=inParamB[1]%>"/>
	</wtc:service>
	<wtc:array id="phoneTypeStr"  scope="end"/>
<%
  //营销代码
  String sqlsaleType = "select unique trim(a.sale_code),trim(a.sale_name), a.brand_code,a.type_code from dphoneSaleCode a where a.region_code='" + regionCode + "' and a.sale_type='33' and a.valid_flag='Y'";
  String[] inParamC = new String[2];
  inParamC[0] = "select unique trim(a.sale_code),trim(a.sale_name), a.brand_code,a.type_code from dphoneSaleCode a where a.region_code=:region_code and a.sale_type='33' and a.valid_flag='Y'";
  inParamC[1] = "region_code=" + regionCode;
  System.out.println("sqlsaleType====="+sqlsaleType);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeC" retmsg="retMsgC" outnum="4">
	<wtc:param value="<%=inParamC[0]%>"/>
	<wtc:param value="<%=inParamC[1]%>"/>
	</wtc:service>
	<wtc:array id="saleTypeStr"  scope="end"/>

<head>
<title>铁通固话入网IMEI绑定</title>
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


  var arrsalecode =new Array();
  var arrsalename=new Array();
  var arrsalebarnd=new Array();
  var arrsaletype=new Array();



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

  }
%>

//***IMEI 号码校验
function checkimeino()
{

	if (document.frm.IMEINo.value.length == 0) {
		rdShowMessageDialog("IMEI号码不能为空，请重新输入!");
		document.frm.IMEINo.focus();
		document.frm.commit.disabled = true;
		return false;
	}
		if (document.frm.IMEINo.value.length != 15) {
		rdShowMessageDialog("IMEI号码应该为15位，请重新输入!");
		document.frm.IMEINo.focus();
		document.frm.commit.disabled = true;
		return false;
	}
			if (isNaN(document.frm.IMEINo.value)) {
		rdShowMessageDialog("IMEI号码必须都为数字，请重新输入!");
		document.frm.IMEINo.focus();
		document.frm.commit.disabled = true;
		return false;
	}
	var myPacket = new AJAXPacket("queryimei_TD.jsp","正在校验IMEI信息，请稍候......");
	myPacket.data.add("imei_no",(document.all.IMEINo.value).trim());
	myPacket.data.add("opcode",(document.all.opcode.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket=null;

}
function doProcess(packet){

 		errorCode = packet.data.findValueByName("errorCode");
		errorMsg =  packet.data.findValueByName("errorMsg");
		retResult= packet.data.findValueByName("retResult");


		var tmpObj="";
		var i=0;
		var j=0;
		var ret_code=0;
		var tmpstr="";


			if(retResult == "000000"){
					rdShowMessageDialog("IMEI号校验成功1！");
					document.frm.IMEINo.readOnly=true;
					document.frm.commit.disabled=false;
					return ;

			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI号校验成功2！");
					document.frm.IMEINo.readOnly=true;
					document.frm.commit.disabled=false;
					return  ;

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


 function viewConfirm()
{
	if(document.frm.IMEINo.value=="")
	{
		document.frm.commit.disabled=true;
	}

}



  function formCommit()
  {

	frm.submit();
	document.all.commit.disabled=true;
  }

</script>
</head>
<body>
	<form name="frm" method="post" action="f1074_4.jsp" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>   
  		<div class="title">
			<div id="title_zi">铁通自采终端固话入网IMEI绑定</div>
		</div>
		<table cellspacing="0">
		<tr>
			<td class="blue">手机号码</td>
            <td>
				<input class="InputGrey"  type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" v_name="手机号码" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" readonly >
			</td>
			<td class="blue">机主姓名</td>
			<td>
				<input name="custName" type="text" class="InputGrey" id="custName" value="<%=custName%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">业务品牌</td>
            <td>
				<input name="smName" type="text" class="InputGrey" id="smName" value="<%=smName%>" readonly>
			</td>
            <td class="blue">资费名称</td>
            <td>
				<input name="offerName" type="text" size='40' class="InputGrey" id="offerName" value="<%=offerName%>" readonly>
			</td>
		</tr>
            
          <tr>
           
						<TD class="blue">
				<div align="left">IMEI码</div>
            </TD>
            <TD>
				<input name="IMEINo" class="button" type="text" v_type="0_9" v_name="IMEI码"  maxlength=15 value="" onblur="viewConfirm()">
				<input name="checkimei" class="b_text" type="button" value="校验" onclick="checkimeino()">
                <font color="orange">*</font>
            </TD>
            
            <TD class="blue">
				<div align="left">保修时限</div>
			</TD>
			<TD >
				<input name="repairLimit" v_type="date.month"  size="10" type="text" value="12" onblur="viewConfirm()">
				(个月)<font color="orange">*</font>
			</TD>
          </tr>

		  <TR id=showHideTr >
			<TD class="blue">
				<div align="left">购机时间</div>
            </TD>
			<TD colspan="3">
				<input name="payTime" type="text" v_name="付机时间"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
				(年月日)<font color="orange">*</font>
			
          </TR>
		<tr>
			<td id="footer" colspan="4">
				<div align="center">
                &nbsp;
				<input name="commit" id="commit" type="button" class="b_foot"   value="确定" onClick="formCommit();" disabled >
                &nbsp;
                <input name="reset" type="reset" class="b_foot" value="清除" >
                &nbsp;
                <input name="close" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭">
                &nbsp;
				</div>
			</td>
		</tr>
	</table>
<input type="hidden" name="opcode" value="<%=opCode%>"/>
<input type="hidden" name="login_accept" value="<%=printAccept%>">
<input type="hidden" name="opNote" value="<%=opNote%>">

	
 <%@ include file="/npage/include/footer.jsp" %>   	
</form>
</body>
</html>

<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
   /*
   * 功能:世博会门票付款确认
   * 版本: 1.0
   * 日期: 2009/5/14
   * 作者: wangjya
   * 版权: si-tech
   */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "6920";
	String opName = "世博会门票付款确认";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");

	

	String  oprNumb = request.getParameter("opr_numb");
	String  tktType = request.getParameter("tkt_type");
	String  tktSum = request.getParameter("tkt_sum");
	String  tktDate = request.getParameter("tkt_date");
	String  payFee = request.getParameter("price");
	String  tktTag = request.getParameter("tkt_tag");
	
	String commitType = request.getParameter("commit_type");
	String[] tktTypeList = tktType.split("[|]");
	String[] tktSumList = tktSum.split("[|]");
	String[] tktDateList = tktDate.split("[|]");
	String[] tktTagList = tktTag.split("[|]");
	

	StringBuffer  insql = new StringBuffer();
	insql.append("select tickettype_code,tickettype_name ");
	insql.append(" from sticketcode ");
	insql.append(" where use_flag='Y' and biz_type='01' ");
	insql.append(" order by tickettype_code  ");
	System.out.println("insql====="+insql);
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:sql><%=insql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="roleDetailData" scope="end" />
	<%
	Map tktTypeMap = new HashMap();	
	if(retCode2.equals("000000"))
	{	
		for(int j = 0;j < roleDetailData.length;j++)
		{
			tktTypeMap.put(roleDetailData[j][0],roleDetailData[j][1]);
		}
	}
	
	insql = new StringBuffer();
	insql.append("select idtype_code,idtype_name ");
	insql.append(" from sidcardcode ");
	insql.append(" where use_flag='Y' and biz_type='01' ");
	insql.append(" order by idtype_code  ");
	System.out.println("insql====="+insql);
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:sql><%=insql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="idtypearray" scope="end" />

		
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	
onload=function()
{		
	init();
}
function getBytesLength(str) { 
	return str.replace(/[^\x00-\xff]/gi, "--").length; 
}
// 初始化
function init()
{
	selGetType();
}
function unOrder()
{
	window.location="f6918_1.jsp?oprnumb=<%=oprNumb%>&tkt_type=<%=tktType%>&tkt_sum=<%=tktSum%>&tkt_Date=<%=tktDate%>&tkt_tag=<%=tktTag%>";	
}
function doNothing()
{
	
}	
function commitJsp()
{
	getAfterPrompt();
	if(getBytesLength(document.all.id_card.value.trim()) > 32)
	{
		rdShowMessageDialog("证件号码必须少于32个英文字符或16个中文字符!",1);
		return;
	}
	if(getBytesLength(document.all.cust_name.value.trim()) > 32)
	{
		rdShowMessageDialog("收票人姓名必须少于32个英文字符或16个中文字符!",1);
		
		return;
	}
	if(getBytesLength(document.all.mobile_no.value.trim()) > 32)
	{
		rdShowMessageDialog("手机号码必须少于32个英文字符或16个中文字符!",1);
		return;
	}
	if(getBytesLength(document.all.phone_no.value.trim()) > 32)
	{
		rdShowMessageDialog("固话号码必须少于32个英文字符或16个中文字符!",1);
		return;
	}

	
	if(document.all.id_card.value.trim().length == 0)
	{
		rdShowMessageDialog("请输入证件号码!",1);
		return;
	}
	if(document.all.cust_name.value.trim().length == 0)
	{
		rdShowMessageDialog("请输入收票人姓名!",1);
		return;
	}
	if(document.all.mobile_no.value.trim().length == 0)
	{
		rdShowMessageDialog("请输入手机号码!",1);
		return;
	}
	if(document.all.phone_no.value.trim().length == 0)
	{
		rdShowMessageDialog("请输入固话号码!",1);
		return;
	}
	//document.all.payType.value=document.all.spay_type.value;
	document.all.getType.value=document.all.sget_type.value;
	document.all.mobileNo.value=document.all.mobile_no.value;
	document.all.phoneNo.value=document.all.phone_no.value;
	document.all.custName.value=document.all.cust_name.value;
	document.all.idType.value=document.all.sid_type.value;
	document.all.idCard.value=document.all.id_card.value;
	document.all.voucher.value=document.all.svoucher.value;
	document.all.custAddress.value=document.all.cust_address.value;
	document.all.postCode.value=document.all.post_code.value;
	document.all.code_type.value=document.all.code_type.value;
	if(document.all.sget_type.options[document.all.sget_type.selectedIndex].value == "0")//送票上门
	{
		
		document.all.voucher.value = "";//取票凭证
		document.all.code_type.value = "";//二维码类型
		if(document.all.postCode.value.trim().length != 6)
		{
			rdShowMessageDialog("邮编必须为6位!",0);
			return;
		}
		if(getBytesLength(document.all.postCode.value.trim()) != 6)
		{
			rdShowMessageDialog("邮编必须为数字!",1);
			return;
		}
		if(document.all.cust_address.value.trim().length == 0)
		{
			rdShowMessageDialog("请输入详细地址!",1);
			return;
		}		
		if(getBytesLength(document.all.cust_address.value.trim()) > 128)
		{
			rdShowMessageDialog("详细地址必须少于128个英文字符或64个中文字符!",1);
			return;
		}
	}
	else if(document.all.sget_type.options[document.all.sget_type.selectedIndex].value == "1")//自行取票
	{
		
		if(document.all.code_type.value == "" && document.all.svoucher.value == "0")
		{
			rdShowMessageDialog("请选择二维码类型!",1);
			return;
		}
		document.all.custAddress.value = "";
		document.all.postCode.value = "";	
	}
	else//手机票
	{	
		document.all.voucher.value = "";//取票凭证
		document.all.code_type.value = "";//二维码类型
		document.all.custAddress.value = "";
		document.all.postCode.value = "";
	}	
	form6920.submit();
}

function resetjsp()
{
	with(document.form6920)
	{
		mobile_no.value = "";
		phone_no.value="";
		cust_name.value="";
		id_card.value="";
		cust_address.value="";
		post_code.value="";
	}	
	
}
function selGetType()
{
	if(document.all.sget_type.options[document.all.sget_type.selectedIndex].value == "0")//送票上门
	{
		document.getElementById("tr_cust_add").style.display = "";//地址
		document.getElementById("tr_post_code").style.display = "";//邮编
		document.getElementById("tr_svoucher").style.display = "none";//取票凭证
		document.getElementById("tr_code_type").style.display = "none";//二维码类型
		document.all.other.style.display="none";
	}
	else if(document.all.sget_type.options[document.all.sget_type.selectedIndex].value == "1")//自行取票
	{
		document.getElementById("tr_svoucher").style.display = "";//取票凭证
		document.getElementById("post_code").value="";
		document.getElementById("cust_address").value="";		
		document.getElementById("tr_cust_add").style.display = "none";
		document.getElementById("tr_post_code").style.display = "none";
		document.all.other.style.display="";
		selGetVoucher();
	}
	else//手机票
	{
		document.getElementById("post_code").value="";
		document.getElementById("cust_address").value="";		
		
		document.getElementById("tr_cust_add").style.display = "none";
		document.getElementById("tr_post_code").style.display = "none";		
		document.getElementById("tr_svoucher").style.display = "none";//取票凭证
		document.getElementById("tr_code_type").style.display = "none";//二维码类型
	}	
}	
function selGetVoucher()
{
	if(document.all.svoucher.options[document.all.svoucher.selectedIndex].value == "0")
	{
		document.getElementById("tr_code_type").style.display = "";
		document.all.code_type.options[0].selected = true;
	}
	else
	{
		document.getElementById("tr_code_type").style.display = "none";
	}
}
</script> 
 
<title>世博会门票付款确认</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">

</head>
<BODY>
<form name="form6920" method="post" action="f6920_2.jsp">
	
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">世博会门票付款确认</div>
	</div>
		<table width="100%" id="tabList" border=0 align="center" cellspacing=0>			
			<tr>				
				<%/*<td  class="blue" width="20%"><b>付款方式</b></td>
				<td> 
					<select type="text" name="spay_type" class="button" id="spay_type" v_must="1" onchange="doNothing()"> 
				      <option value="0">POS</option>
				      <option value="1">现金</option>				   
      				</select>
    			</td>*/%>
    			<td  class="blue" width="20%"><b>应付金额</b></td>
    			<td  class="blue" name="pay_fee" type="text" id="pay_fee"  value="<%=payFee%>"><b><%=payFee%>元</b></td>   			
    		</tr>
			<tr>				
				<td width="20%" class="blue"><b>取票方式</b></td>
				<td> 
					<select type="text" name="sget_type" class="button" id="sget_type" v_must="1" onchange="selGetType()"> 
				      <option value="0">送票上门</option>
				      <option value="1">自行至上海取票</option>					      	   
      				</select>
    			</td>
    		</tr>
			<tr>				
				<td width="20%" class="blue"><b>收票人手机号码</b></td>
				<td> 
					<input name="mobile_no" type="text" id="mobile_no" size="32" maxlength="32" ><font color="red"> *</font></td>
    			</td>
    		</tr>
			<tr>				
				<td width="20%" class="blue"><b>收票人固话号码</b></td>
				<td> 
					<input name="phone_no" type="text" id="phone_no" size="32" maxlength="32" ><font color="red"> *</font></td>
    			</td>
    		</tr>
			<tr>				
				<td width="20%" class="blue"><b>收票人姓名</b></td>
				<td> 
					<input name="cust_name" type="text" id="cust_name" size="32" maxlength="32" ><font color="red"> *</font></td>
    			</td>
    		</tr>
    		<tr>				
				<td width="20%" class="blue"><b>收票人有效证件类型</b></td>
				<td>
					<select type="text" name="sid_type" class="button" id="sid_type" v_must="1" onchange="doNothing()"> 
					<%for (int i = 0; i < idtypearray.length; i++) 
					{%>
				      <option value="<%=idtypearray[i][0]%>"><%=idtypearray[i][0]%>-><%=idtypearray[i][1]%>
				      </option>
				    <%}%> 
					</select>
    			</td>
    		</tr>
    		<tr>				
				<td width="20%" class="blue"><b>收票人有效证件号码</b></td>
				<td> 
					<input name="id_card" type="text" id="id_card" size="32" maxlength="32" ><font color="red"> *</font></td>
    			</td>
    		</tr>
    		<tr id="tr_svoucher">				
				<td width="20%" class="blue"><b>取票凭证</b></td>
				<td> 
					<select type="text" name="svoucher" class="button" id="svoucher" v_must="1" onchange="selGetVoucher()"> 
				      <option value="1">订购单</option>				   
      				</select>
    			</td>
    		</tr>
    		<tr id="tr_code_type">				
				<td width="20%" class="blue"><b>二维码类型</b></td>
				<td> 
					<select type="text" name="code_type" class="button" id="code_type" v_must="1" onchange="doNothing()"> 
				      <option value="">--请选择--</option>
				      <option value="00">其他品牌</option>
				      <option value="01">诺基亚手机</option>
				      <option value="02">您的手机不支持彩信</option>		
      				</select>
    			</td>
    		</tr>
    		<tr id="tr_cust_add">				
				<td width="20%" class="blue"><b>收票人详细地址</b></td>
				<td> 
					<input name="cust_address" type="text" id="cust_address" size="32" maxlength="128" ><font color="red"> *</font></td>
    			</td>
    		</tr>
    		<tr id="tr_post_code">				
				<td width="20%" class="blue"><b>收票人邮政编码</b></td>
				<td> 
					<input name="post_code" type="text" id="post_code" onKeyPress="return isKeyNumberdot(0)" size="32" maxlength="6" ><font color="red"> *</font></td>
    			</td>
    		</tr>
    		<tr id="other">
    			<td class="blue"><b>指定取票营业厅</b></td>
				<td>耀华路营业厅</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
    		</tr>
	<tr>
		<td align="center" id="footer" colspan="3"> 
			<%
			if(commitType.equals("0"))
			{%>
			<input type="button" name="delete" class="b_foot" value="确认&打印" onclick=commitJsp();>
			<%
			}
			else
			{
			%>
			<input type="button" name="delete" class="b_foot" value="补付款确认" onclick=commitJsp();>	
			<%
			}
			%>
				&nbsp;
			<input type="button" name="delete" class="b_foot" value="退订" onclick=unOrder()>
				&nbsp;
			<input type="button" name="delete" class="b_foot" value="清除" onclick=resetjsp()>
		</td>
	</tr>
		</table>		
<%@ include file="/npage/include/footer.jsp" %>
<input type="hidden" name="opr_numb" value="<%=oprNumb%>">
<input type="hidden" name="tkt_type" value="<%=tktType%>">
<input type="hidden" name="tkt_sum" value="<%=tktSum%>">
<input type="hidden" name="tkt_date" value="<%=tktDate%>">
<input type="hidden" name="tkt_tag" value="<%=tktTag%>">
<input type="hidden" name="payType" value="">
<input type="hidden" name="getType" value="">
<input type="hidden" name="mobileNo" value="">
<input type="hidden" name="phoneNo" value="">
<input type="hidden" name="custName" value="">
<input type="hidden" name="idType" value="">
<input type="hidden" name="idCard" value="">
<input type="hidden" name="voucher" value="">
<input type="hidden" name="custAddress" value="">
<input type="hidden" name="postCode" value="">
<input type="hidden" name="pay_fee" value="<%=payFee%>">
<input type="hidden" name="commit_type" value="<%=commitType%>">
</form>
</BODY>
</HTML>

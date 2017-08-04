 <!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 号码信息查询5186
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode="zgar";
	String opName="前台电子发票打印";
	//String phoneNo = (String)request.getParameter("activePhone");			//手机号码
 
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>前台电子发票打印</TITLE>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
</HEAD>

<body>
<SCRIPT language="JavaScript">
function isNumberString (InString,RefString)
{
if(InString.length==0) return (false);
	for (Count=0; Count < InString.length; Count++)  {
		TempChar= InString.substring (Count, Count+1);
		if (RefString.indexOf(TempChar, 0)==-1)  
		return (false);
	}
	return true;
}
function doCheck()
{
	//if(jtrim(document.frm5186.cus_pass.value).length ==0)
	//	document.frm5186.cus_pass.value="123456";   
	var beginym = document.frm5186.beginym.value;
	var endym = document.frm5186.endym.value;
	var qryvalue = document.frm5186.qryvalue.value;
	var qry_type = document.frm5186.qrytype[document.frm5186.qrytype.selectedIndex].value;
	if(qry_type=="1")
	{
		document.frm5186.contract_no.value="99999999999";
	}
	else
	{
		document.frm5186.contract_no.value=qryvalue;
		qryvalue="";//是否需要置空?
	}
	if(document.frm5186.qryvalue.value=="")
	{	rdShowMessageDialog("请输入查询条件！");
		document.frm5186.qryvalue.focus();
		return false;
	}
	else if(beginym=="" ||endym=="")
	{
		rdShowMessageDialog("请输入查询年月日！");
		return false;
	}
	else if(beginym.substr(0,6)!=endym.substr(0,6))
	{
		rdShowMessageDialog("只能查询相同年月的电子发票!");
		return false;
	}
	/*只能查询同月的*/
	else{
		document.frm5186.action="zgar_2.jsp";
		frm5186.submit();
	}
	 
}
function doCheck1()
{
	var qry_type = document.frm5186.qrytype1[document.frm5186.qrytype1.selectedIndex].value;
	//alert("校验密码后才走action qry_type is "+qry_type);
	//先进行号码转义 然后进行密码校验
	var beginym = document.frm5186.beginym.value;
	var endym = document.frm5186.endym.value;
	var qryvalue = document.frm5186.qryvalue.value;
	if(document.frm5186.qryvalue.value=="")
	{	rdShowMessageDialog("请输入查询条件！");
		document.frm5186.qryvalue.focus();
		return false;
	}
	else if(beginym=="" ||endym=="")
	{
		rdShowMessageDialog("请输入查询年月日！");
		return false;
	}
	else if(beginym.substr(0,6)!=endym.substr(0,6))
	{
		rdShowMessageDialog("只能查询相同年月的电子发票!");
		return false;
	}
	else
	{
		var checkPwd_Packet = new AJAXPacket("zgar_getPhoneNo.jsp","正在进行密码校验，请稍候......");
		//dcustmsgdead的密码校验 这个页面可能得换
		checkPwd_Packet.data.add("qry_type", qry_type);//号码类型					 
		checkPwd_Packet.data.add("qryvalue",qryvalue); //号码
		checkPwd_Packet.data.add("custPaswd", document.getElementById("cus_pass").value);
		core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
		checkPwd_Packet=null;
	}	
}
function doCheckPwd(packet) 
{
		var s_phone_no_out = packet.data.findValueByName("s_phone_no_out");
		var qry_type = packet.data.findValueByName("qry_type");
		var retResult = packet.data.findValueByName("retResult");
		//retResult="000000";
		var retResultMsg = packet.data.findValueByName("retResultMsg");
		//alert("s_phone_no_out is "+s_phone_no_out+" and qry_type is "+qry_type+" and retResult is "+retResult+" and retResultMsg is "+retResultMsg);
		if(qry_type=="6")
		{
			document.frm5186.contract_no.value=document.frm5186.qryvalue.value;
			document.all.qrytype.value="0";
			document.frm5186.action="zgar_2.jsp";
		    frm5186.submit();
		}
		else
		{
			if(qry_type=="0"||qry_type=="1"||qry_type=="2")
			{
				if(retResult=="000000")//校验通过
				{
					document.all.qrytype.value="0";
					document.frm5186.contract_no.value=s_phone_no_out;
					//qryvalue 这个值也是
					document.frm5186.qryvalue.value=s_phone_no_out;
					document.frm5186.action="zgar_2.jsp";
					frm5186.submit();
				}
				else
				{
					rdShowMessageDialog("密码校验失败!错误代码:"+retResult+",错误原因:"+retResultMsg);
					return false;
				}
			}
			else
			{
				//alert("s_phone_no_out is "+s_phone_no_out);//>0 说明有记录
				if(s_phone_no_out>0)//离网信息那种
				{
					if(qry_type=="5")
					{
						document.frm5186.contract_no.value="99999999999";
						document.all.qrytype.value="1";
					}
					else
					{
						document.frm5186.contract_no.value=document.frm5186.qryvalue.value;
						 
						document.all.qrytype.value="0";
					}
					document.frm5186.action="zgar_2.jsp";
					frm5186.submit();
				}
				else
				{
					rdShowMessageDialog("号码信息不存在,请核对后重新输入!");
					return false;
				}	
			}
		}
		
}
</SCRIPT>

<FORM method=post name="frm5186">
	<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="opCode"  value="5186">
<input type="hidden" name="custPass"  value="">
	<div class="title">
		<div id="title_zi">前台电子发票打印</div>
	</div>
<table cellspacing="0">
		<TR> 
	      <td class="blue">号码类型</TD>
          <td colspan=3>
          	<select name="qrytype1">
				<option value="0" selected>手机号码</option>
				<option value="1" >物联网号码</option>
				<option value="2" >宽带号码</option>
				<option value="3" >离网用户</option>
				<option value="4" >虚拟号码</option>
				<option value="5" >一点支付</option>
				<option value="6" >异地缴费号码</option>
			</select>
			</td>
		</TR>
		<!--
		<TR> 
	      <td class="blue">查询方式</TD>
          <td colspan=3>
          	<select name="qrytype">
				<option value="0" selected>用户号码</option>
				<option value="1" >账户号码</option>
			</select>
			</td>
		</TR>
		-->
		<tr>
			<td class="blue">查询条件</TD>
			<td >
				<input type="text" name="qryvalue">
			</td>
			<td class="blue"><div id="pass_msg">用户密码</div></td>
			<td>
				<jsp:include page="/npage/common/pwd_one.jsp">
				<jsp:param name="width1" value="16%"  />
				<jsp:param name="width2" value="34%"  />
				<jsp:param name="pname" value="cus_pass"  />
				<jsp:param name="pwd" value="12345"  />
				</jsp:include>
			</td> 
		</tr> 
		  <TR> 
	      <td class="blue">查询开始年月日</TD>
          <td>
          <input type="hidden" name="qrytype">	
			<input type="text"  name="beginym" value="<%=dateStr%>"  onKeyPress="return isKeyNumberdot(0)" size="20" maxlength="8"  >
			</td>
          <td class="blue">查询结束年月日</TD>
          <td>
          	
			<input type="text"  name="endym" value="<%=dateStr%>"  onKeyPress="return isKeyNumberdot(0)" size="20" maxlength="8"  >
			</td>
          </TR>
		  <input type="hidden" name="contract_no">	
			 
	    <TR> 
	      <TD align="center" id="footer" colspan="4"> 
		  <input type="submit" class="b_foot" name="Button1" value="查询" onclick="doCheck1()">
	        &nbsp; 
	        &nbsp;&nbsp;<input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
	        &nbsp; 
	      </TD>
	    </TR>
	    </table> 
    <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</body>
</html> 

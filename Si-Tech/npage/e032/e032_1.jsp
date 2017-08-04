   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-25
********************/
%>
              
<%
  String opCode = "e032";
  String opName = "宽带帐单打印";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*"%>
<%@ include file="../../npage/common/pwd_comm.jsp" %>
<%@ page import="com.sitech.util.DateTrans"%>
<%
		response.setHeader("Pragma","No-Cache");
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0);


		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		String date1="";
		String date2="";
		DateTrans dt=new DateTrans();
		date1=dt.getYear()+""+dt.getMonth();
		dt.addMonth(-1);
		date2=dt.getYear()+""+dt.getMonth();
		dt.addMonth(1);


		    //String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String[] mon = new String[]{"","","","","",""};

    Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4)),
                      (Integer.parseInt(dateStr.substring(4,6)) - 1),Integer.parseInt(dateStr.substring(6,8)));
	for(int i=0;i<=5;i++)
      {
              if(i!=5)
              {
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
                cal.add(Calendar.MONTH,-1);
              }
              else
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
      }
%>
<HTML>
<HEAD>

<script language="JavaScript">
<!--

function change() 
{ 
 	   var i = document.frm.printway.value;
	   var temp0="tb1";
	   var temp1="tb2";
	  
		if (i=="0") 
		{
			document.all(temp1).style.display="none";
			document.all(temp0).style.display="";
			document.all.pass_msg.innerHTML = "宽带密码";
			document.frm.phoneNo.focus();
	  	}	
	  	else if (i=="1")
		{
			document.all(temp1).style.display="";
			document.all(temp0).style.display="none";
			document.all.pass_msg.innerHTML = "用户密码";
			document.frm.contract_no.focus();
	  	}
	   document.frm.phoneNo.value = "";
	   document.frm.contract_no.value = "";
	   
}
function getPhone()
{
	if((document.all.phoneNo.value=="") &&(document.frm.printway.value=="0")  ){
  		rdShowMessageDialog("宽带号码不能为空!");
  		document.all.phoneNo.focus();
		return false;
  	}
	else if(document.frm.printway.value=="1") //直接输入用户号码
	{
		alert("按号码查询");
		if(document.all.contract_no.value=="")
		{
			rdShowMessageDialog("用户号码不能为空!");
  			document.all.contract_no.focus();
			return false;
		}
		else 
		{
			//document.getElementById("phone_input").value = document.all.contract_no.value;
			//alert("document.all.contract_no.value is "+document.all.contract_no.value);
			document.getElementById("contract_kd").value =document.all.contract_no.value ;
			docheck();
		}
	}
	else
	{
		var myPacket = new AJAXPacket("getPhoneNo.jsp","正在查询客户，请稍候......");
		myPacket.data.add("contractNo",(document.all.phoneNo.value).trim());
		myPacket.data.add("return_page","e032_1.jsp");
		core.ajax.sendPacket(myPacket);
		myPacket=null;
	}
	

}
function doProcess(packet){
	var phone_new = packet.data.findValueByName("phone_new");
    var contract_out = packet.data.findValueByName("contract_out"); 
	var phone_input = packet.data.findValueByName("phone_input");
	//alert("test contract_out is "+contract_out+" and phone_new is "+phone_new+" and phone_input is "+phone_input); 
	if(phone_new == "" && contract_out == "" )
	{
		rdShowMessageDialog("宽带号码不存在!");
  		document.all.phoneNo.focus();
		return false;
	}
	else
	{
		document.getElementById("phone_kd").value = phone_new;
		document.getElementById("phone_input").value = phone_input
		document.getElementById("contract_kd").value =contract_out ;
		docheck();
	}
}
function docheck()
{
	if(!forDate(document.frm.beginDate)) return;
	if(parseFloat(document.frm.beginDate.value)<190001){
		rdShowMessageDialog("帐务年月不能小于1900年！",0);
		return;
	}


	var i = document.frm.printway.value;
			if (i=="0") 
		{
 document.frm.password.value=document.frm.cus_pass.value;
	  	}	
	  	else if (i=="1")
		{
 document.frm.password.value=document.frm.cus_pass1.value;
	  	}
  
	document.frm.action="e032Cfm.jsp";
	document.frm.query.disabled=true;
	document.frm.return1.disabled=true;
	document.frm.return2.disabled=true;
	document.frm.submit();
}


function doclear() {
	frm.reset();
}

function load_t()
{
document.frm.phoneNo.focus();
-->
}

 </script>

<title>黑龙江BOSS-帐单打印 </title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY onload="load_t()">
<form action="" method="post" name="frm"  >
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">宽带账单</div>
	</div>

	<input type="hidden" name="password"/>
<input type="hidden" id="phone_input" name="phone_input"  >	
<input type="hidden" name="busy_type"  value="1">
<input type="hidden" name="op_code"  value="e032">
<input type="hidden" name="totaldate"  value="<%=dateStr1%>">
<input type="hidden" name="yearmonth"  value="<%=dateStr%>">
<input type="hidden" name="billdate"  value="<%=dateStr.substring(0,6)%>">
<input type="hidden" name="water_number"  >
 <input type = "hidden" id="phone_kd" name = "phone_kd">
 <input type = "hidden" id="contract_kd" name = "contract_kd">
		<table cellspacing="0">
			<tr> 
				<td class="blue">打印方式</td>
				<td>
					<select name="printway" onChange="change();">
						<option value="0" selected>按宽带号码</option>
						<option value="1">按用户号码</option>
					</select>
				</td>
				<td nowrap class="blue">帐务年月</td>
				<td nowrap>
					<input name="beginDate" type="text" v_format="yyyyMM"  class="input-write" value="<%=mon[1]%>" maxlength="6">
				</td>
			</tr>

			<tr id="tb1" style="display:"> 
				<td class="blue">宽带号码 </td>
				<td > 
					<input type="text" value="" name="phoneNo"  maxlength="25" onKeyDown="if(event.keyCode==13)frm.beginDate.focus()" >
				</td>
				<td class="blue"><div id="pass_msg">宽带密码</div></td>
				<td>
					<jsp:include page="/npage/common/pwd_one.jsp">
					<jsp:param name="width1" value="16%"  />
					<jsp:param name="width2" value="34%"  />
					<jsp:param name="pname" value="cus_pass"  />
					<jsp:param name="pwd" value="12345"  />
					</jsp:include>
				</td>
			</tr>

			<tr id="tb2" style="display:none"> 
				<td class="blue">用户号码 </td>
				<td > 
					<input type="text" name="contract_no"  maxlength="22" onKeyDown="if(event.keyCode==13)frm.beginDate.focus()"  onKeyPress="return isKeyNumberdot(0)">
				</td>
				<td class="blue"><div id="pass_msg">用户密码</div></td>
				<td>
					<jsp:include page="/npage/common/pwd_one.jsp">
					<jsp:param name="width1" value="16%"  />
					<jsp:param name="width2" value="34%"  />
					<jsp:param name="pname" value="cus_pass1"  />
					<jsp:param name="pwd" value="12345"  />
					</jsp:include>
				</td>
			</tr>
		</table>
 
        <TABLE  cellSpacing="0">
          <TR >
            <TD noWrap    align="center">
                 <input type="button" name="query" class="b_foot"  value="查询" onclick="getPhone()" index="9">
                &nbsp;
                <input type="button" name="return1" class="b_foot"   value="清除" onclick="doclear()" index="10">
                &nbsp;
                <input type="button" name="return2"  value="关闭"  class="b_foot" onClick="removeCurrentTab()" index="13">
             </TD>
          </TR>
        </TABLE>
 
<%@ include file="/npage/include/footer.jsp" %>
</form>


</BODY>
</HTML>
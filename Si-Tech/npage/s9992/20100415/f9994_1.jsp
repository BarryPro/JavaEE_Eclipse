<%
/********************
 version v2.0
 开发商: si-tech
 作者: dujl
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>手机支付主账户现金充值</title>
<%
	
//    String opCode = "9994";
//    String opName = "手机支付主账户现金充值";
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String phoneNo = request.getParameter("activePhone");
    String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
    
    StringBuffer sql = new StringBuffer();
    sql.append(" select phone_no,pay_ed,login_accept from sphonepaymsg ");
    sql.append(" where op_date=to_char(sysdate,'yyyymmdd') and flag='0'");
    System.out.println("sql=========="+sql);
%>

<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="3">
<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
onload=function()
{
	var phoneNo = "<%=phoneNo%>";
	if(phoneNo==null||phoneNo=="")
	removeCurrentTab();
	var opCode = "<%=opCode%>";
	if(opCode=="9994")
	{
		document.all.opFlag[0].checked=true;	
	}else if(opCode=="9995")
	{
		document.all.opFlag[1].checked=true;
	} 
	opchange();
}

function controlButt(subButton)
{
	subButt2 = subButton;
	subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
}


//----------------验证及提交函数-----------------
function check_HidPwd()
{
	if(document.frm.phoneNo.value=="")
	{
		 rdShowMessageDialog("请输入手机号码!");
		 document.frm.phoneNo.focus();
		 return false;
	}

  	if( document.frm.phoneNo.value.length != 11 )
  	{
		rdShowMessageDialog("手机号码只能是11位!");
		document.frm.phoneNo.value = "";
		return false;
  	}
}

function doCfm(subButton)
{
	
  	controlButt(subButton);//延时控制按钮的可用性
  	var radio1 = document.getElementsByName("opFlag");
  	for(var i=0;i<radio1.length;i++)
  	{
    	if(radio1[i].checked)
		{
	  		var opFlag = radio1[i].value;
	  		if(opFlag=="one")
	  		{
	    		if(document.frm.phoneNo.value=="")
			  	{
				     rdShowMessageDialog("请输入手机号码!");
				     document.frm.phoneNo.focus();
				     return false;
			  	}
			  	
			  	if(document.frm.payEd.value=="")
			  	{
				     rdShowMessageDialog("请输入充值金额!");
				     document.frm.payEd.focus();
				     return false;
			  	}
			
			  	if( document.frm.phoneNo.value.length != 11 )
			  	{
				     rdShowMessageDialog("手机号码只能是11位!");
				     document.frm.phoneNo.value = "";
				     return false;
			  	}
	    		
	    		frm.action="f9994Cfm.jsp";
	    		document.all.opcode.value="9994";
		  	}
		  	else if(opFlag=="two")
		  	{
	    		if(document.frm.phoneNoPayEd.value=="")
	    		{
	    			rdShowMessageDialog("请输入冲正信息！");
				     document.frm.phoneNoPayEd.focus();
				     return false;
	    		}
	    		
	    		frm.action="f9995Cfm.jsp";
	    		document.all.opcode.value="9995";
		  	}
		}
 	}
  	
  	frm.submit();
}

function opchange()
{
	if(document.all.opFlag[0].checked==true) 
	{
		document.all.zhi.style.display="";
		document.all.zhi1.style.display="";
		document.all.zheng.style.display="none";
	}else 
	{
		document.all.zhi.style.display="none";
		document.all.zhi1.style.display="none";
		document.all.zheng.style.display="";
	}
}


</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %> 	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
      <table cellspacing="0">
	  <TR> 
		<TD class="blue" width="20%">操作类型</TD>
		<TD>
			<input type="radio" name="opFlag" value="one" onclick="opchange()" checked >充值&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="two" onclick="opchange()">冲正
		</TD>
		      <input type="hidden" name="opcode" >
         </TR>
         <tr id="zhi">
            <td class="blue" width="20%">手机号码</div></td>
            <td> 
        		<input class="button"type="text" name="phoneNo" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
      		</td>
         </tr>
         <TR id="zhi1">
	          <TD class="blue" width="20%">充值金额（元）</TD>
	          <TD>
				<input class="button"type="text" name="payEd" size="20" maxlength="14" onKeyPress="return isKeyNumberdot(1)" onKeyDown="if(event.keyCode==13) doprint();">
	         </TD>
         </TR>
         <tr id="zheng">
         	<td class="blue" width="20%">冲正信息</td>
         	<td>
         		<select class="button" type="select" name="phoneNoPayEd">
         			<option value="">--请选择--</option>
         			<%
         			for(int i=0;i<result.length;i++)
         			{
         			%>
         				<option value="<%=result[i][0]%>~<%=result[i][1]%>~<%=result[i][2]%>"><%=result[i][0]%>--><%=result[i][1]%>--><%=result[i][2]%></option>
         			<%
         			}
         			%>
         		</select>
         	</td>
         </tr>
         
         <tr> 
            <td colspan="2" id="footer"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
              <input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
              </div>
           </td>
        </tr>
      </table>
   
<input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="opName" value="<%=opName%>" >
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
   
</body>
</html>


<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 统一预存赠礼2289
   * 版本: 1.0
   * 日期: 2008/12/30
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>统一预存赠礼</title>
<%
    //String opCode="2289";
	//String opName="统一预存赠礼";
	
  String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
	String phoneNo = (String)request.getParameter("activePhone");
  String workNo=(String)session.getAttribute("workNo");
  String regionCode=(String)session.getAttribute("regCode");
  String[][] favInfo=(String[][])session.getAttribute("favInfo");
	boolean workNoFlag=false;
	if(workNo.substring(0,1).equals("k"))
		workNoFlag=true;
%>

<%
  String sql = " select  unique sale_type,sale_type||'-->'||trim(sal_name) from sSaleType ";
  System.out.println("sql====="+sql);
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="tempArr" scope="end" />
<%
//  String[][] agentCodeStr = (String[][])agentCodeArr.get(0);
%>

  </script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
  onload=function()
  {
  	var opCode = "<%=opCode%>";
  	if(opCode=="2289"){
		document.all.opFlag[0].checked=true;
		opchange();		
  	}
  	if(opCode=="2293"){
		document.all.opFlag[1].checked=true;  
		opchange();			
  	}
  }

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
	controlButt(subButton);			//延时控制按钮的可用性
//	if(!check(frm)) return false; 
	var radio1 = document.getElementsByName("opFlag");
	for(var i=0;i<radio1.length;i++)
	{
		if(radio1[i].checked)
		{
			var opFlag = radio1[i].value;
			//begin huangrong 修改关于增加"统一预存赠礼营销案预约功能"的需求 2010-11-05
			var flag=document.getElementById("flag");
			if(opFlag=="one"||opFlag=="three")
			{
				if(opFlag=="one")
				{
					flag.value='0';
				}else{
					flag.value='1';
				}
				frm.action="f2289_1.jsp";
				document.all.opcode.value="2289";
			
			}else if(opFlag=="two"||opFlag=="four")
			{
				if(opFlag=="two")
				{
					flag.value='0';
				}else{
					flag.value='1';
				}
				//end huangrong 修改关于增加"统一预存赠礼营销案预约功能"的需求 2010-11-05
				if(document.all.backaccept.value==""){
					rdShowMessageDialog("请输入业务流水！",1)
					return;
				}
				frm.action="f2293_1.jsp";
				document.all.opcode.value="2293";
			}
		}
  }
	frm.submit();	
	return true;
}
 function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }
function opchange(){	
	//begin huangrong 修改关于增加"统一预存赠礼营销案预约功能"的需求 2010-11-05
	 if(document.all.opFlag[0].checked==true||document.all.opFlag[2].checked==true) 
	 {	  
	//end huangrong 修改关于增加"统一预存赠礼营销案预约功能"的需求 2010-11-05	
	  	document.all.backaccept_id.style.display = "none";
	 }else {
	  	document.all.backaccept_id.style.display = "";	
	  }
}
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
 	<input type="hidden" name="opcode" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="20%">操作类型</td>
		<td>
			<q vType='setNg35Attr'>
			<input type="radio" name="opFlag" value="one" onclick="opchange()"/>申请
		</q>
		</td>
		<td>
			<q vType='setNg35Attr'>
			<input type="radio" name="opFlag" value="two" onclick="opchange()"/>冲正
		</q>
			</td>
			<td>
			<!--begin huangrong 修改关于增加"统一预存赠礼营销案预约功能"的需求 2010-11-05-->
			<q vType='setNg35Attr'>
			<input type="radio" name="opFlag" value="three" onclick="opchange()"/>预约申请
		</q>
		</td>
		<td>
			<q vType='setNg35Attr'>
			<input type="radio" name="opFlag" value="four" onclick="opchange()"/>预约冲正
		</q>
			<!--end huangrong 修改关于增加"统一预存赠礼营销案预约功能"的需求 2010-11-05-->
		</td>
	</tr>    
	<tr> 
		<td class="blue">手机号码 </td>
		<td colspan="5"> 
			<input type="text" size="12" name="srv_no" value="<%=activePhone%>" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly>
			<!--begin huangrong 修改关于增加"统一预存赠礼营销案预约功能"的需求 2010-11-05-->
			<input type="hidden" name="flag" id="flag">
			<!--end huangrong 修改关于增加"统一预存赠礼营销案预约功能"的需求 2010-11-05-->
				<font color="orange">*</font>
		</td>
	</tr>
	<tr style="display:none" id="backaccept_id"> 
		<td class="blue">业务流水</td>
		<td colspan="5">
			<input class="button" type="text" name="backaccept" v_must=1 >
				<font color="orange">*</font>
		</td>
	</tr>    
	<tr> 
		<td colspan="5" align="center" id="footer"> 
			<input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-04 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");

  HashMap hm=new HashMap();
  hm.put("1","没有用户ID！");
  hm.put("2","未查询到任何相关数据");
  hm.put("3","用户密码错误！");
  hm.put("4","手续费不确定，您不能进行任何操作！");
  hm.put("5","不明错误1！");
  hm.put("6","不明错误2！"); 
  hm.put("7","详单验证未通过！"); 
  hm.put("8","详单验证已经超过五次,请明天再行办理！"); 
  hm.put("12","该号码为长白行号码，不允许更改密码！");  
%>

<html>
<head>
<title>用户密码修改</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	System.out.println("ningtn opCode " + opCode);
	String opName = request.getParameter("opName");
	String inputType="0";
	/*changType 修改0  重置1 */
	String changType="0";
	String op_code=request.getParameter("opCode");
	String workNo = (String)session.getAttribute("workNo");
	String broadPhone = request.getParameter("broadPhone");
	if("e357".equals(op_code)){
		changType = "0";
	}else if("e358".equals(op_code)){
		changType = "1";
	}
	String operationType=request.getParameter("oprationType");
	if (operationType!=null&&operationType.equals("change")){
		changType=request.getParameter("changType");
		if (changType.equals("1")){
			inputType="1";
		}else{ 
			inputType="0";
		}
	}
  String sqls="SELECT id_Name FROM sIdType order by id_type";
%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=activePhone%>" outnum="1">
	<wtc:sql><%=sqls%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="metaData" scope="end" />
<%
  String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
  if(ReqPageName.equals("main"))
  {
     String retMsgx=WtcUtil.repNull(request.getParameter("retMsg"));
 %>
      <script>
	  		rdShowMessageDialog("<%=(String)(hm.get(retMsgx))%>");
	 		</script>
<%
  }
%>

<script language=javascript>

	onload=function()
	{
		if(<%=activePhone%>==null||<%=activePhone%>==""){
			rdShowMessageDialog("请重新打开此修改主页面!");
			parent.removeTab("<%=opCode%>");
			return false;
		}
 		self.status="";
 		/* 根据opcode判断应该哪个radio有焦点 */
  	var opCode = "<%=opCode%>";
  	if(opCode == "e357"){
  		$("input[name='r_cus']:eq(0)").attr("checked",'checked');
  	}else{
  		$("input[name='r_cus']:eq(1)").attr("checked",'checked'); 
  	}
 		//初始化的时候,控制用户密码是否需要输入
 		for(var i=0;i<document.getElementsByName("r_cus").length;i++){
 			if(document.getElementsByName("r_cus")[i].checked){
 				if(document.getElementsByName("r_cus")[i].value=="0"){
 					document.all.cus_pass.disabled = false;
 					document.all.cus_pass_button.disabled = false;
 					document.all.identity_print.style.display = "none";
 				}else{
 					document.all.cus_pass.disabled = true;
 					document.all.cus_pass_button.disabled = true;	
 					document.all.identity_print.style.display = "";
 				}
 			}
 		}
	}

	$(document).ready(function(){
		
	});

	function changeidtype()
	{
		if (document.all.identity_type.value == "01")
		{
			document.all.identity_info.disabled = false;
		}else{
			document.all.identity_info.disabled = true;
		}	
	}

//-------2---------验证及提交函数-----------------
function doCfm()
{ 
		if (<%=changType%> == "1"){
			if (document.all.identity_type.value == "00")
			{
	    	rdShowMessageDialog("请选择验证类型!");
	      return;				
			}
			if(document.all.identity_type.value == "01"){
				if(document.all.identity_info.value.trim().len()==0){
					rdShowMessageDialog("选择详单核对时,信息号码不能为空!");
					document.all.identity_info.focus();
					return false;	
				}
			}
		}
		if(document.all.cus_pass.value.trim().len()==0 && <%=changType%> !="1"){
			rdShowMessageDialog("用户密码不能为空！");
 			document.all.cus_pass.focus();
 			return false;
 		}
 		//验证工号和手机是否在同一地市下 如果通过直接提交 失败就返回
 		validateGroupId();

}

function validateGroupId(){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/public/validateRegionCode.jsp","正在验证请稍等......");	
	packet.data.add("inPhone",document.s3216.cus_id.value);
	core.ajax.sendPacket(packet,doShowValidate);
	packet = null;
}

function doShowValidate(packet){
	var flag = packet.data.findValueByName("flag");//标志位 true 在同一地市  false 不再同一地市
	if(flag == "false"){
		rdShowMessageDialog("工号和客户手机归属地不一致，操作失败!");
		return ;
	}else{
		s3216.action="main.jsp";
    	s3216.submit();	
	}
}


function changeType(ichange)
{
	var opCode = "<%=opCode%>";
	var opName = "<%=opName%>";
	if (ichange=='1'){
		document.all.cus_pass.disabled = true;
		document.all.cus_pass_button.disabled = true;
		if(opCode == "1234" || opCode == "1235"){
			opCode = "1235";
			opName = "用户密码重置";
		}else{
			opCode = "e358";
			opName = "宽带用户密码重置";
		}
		s3216.action="f1234.jsp?changType=1&oprationType=change&activePhone=<%=activePhone%>&opCode=" + opCode + "&opName=" + opName + "&broadPhone=<%=broadPhone%>";
		s3216.submit();
	}else {
		document.all.cus_pass.disabled = false;
		document.all.cus_pass_button.disabled = false;
		if(opCode == "1234" || opCode == "1235"){
			opCode = "1234";
			opName = "用户密码修改";
		}else{
			opCode = "e357";
			opName = "宽带用户密码修改";
		}
		s3216.action="f1234.jsp?changType=0&activePhone=<%=activePhone%>&opCode=" + opCode + "&opName=" + opName + "&broadPhone=<%=broadPhone%>";
		s3216.submit();
	}
}
</script>
</head>
<body>

<form name="s3216" method="POST">
  <input type="hidden" name="ReqPageName" id="ReqPageName" value="f1234">
  <input type="hidden" name="rCus" value="">
  <input type="hidden" name="activePhone" value="<%=activePhone%>">
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">选择操作类型</div>
		</div>
<table cellspacing="0">
<tr>
    <td class="blue">操作类型</td>
    <td colspan="3">
        <input type="radio" name="r_cus" index="0" value="0" <%=changType.equals("0")?"checked":""%> onclick="changeType('0');">修改密码
        <input type="radio" name="r_cus" index="1" value="1" <%=changType.equals("1")?"checked":""%> onclick="changeType('1');">重置密码
    </td>
</tr>
<tr>
	<%
		if("e357".equals(opCode) || "e358".equals(opCode)){
	%>
		<td width="16%" class="blue">宽带账号</td>
    <td>
       <input type="text" name="broadPhone" id="broadPhone" value="<%=broadPhone%>" class="InputGrey" readonly>
       <input type="hidden" name="cus_id" id="cus_id" value="<%=activePhone%>" />
    </td>
	<%
		}else{
	%>
    <td width="16%" class="blue">服务号码</td>
    <td>
       <input type="text" size="17" maxlength=11 name="cus_id" id="cus_id" value="<%=activePhone%>" class="InputGrey" readonly>
    </td>
  <%
  	}
  %>
    <td width="20%" class="blue">用户密码</td>
    <td>
        <jsp:include page="/npage/common/pwd_one_new.jsp">
            <jsp:param name="width1" value="16%"/>
            <jsp:param name="width2" value="34%"/>
            <jsp:param name="pname" value="cus_pass"/>
            <jsp:param name="pwd" value="12345"/>
            <jsp:param name="irCus" value='<%=inputType%>'/>
        </jsp:include>
    </td>
</tr>
<!-- 密码重置修改 王良 2007年3月12日 -->
<tr id="identity_print" style="display:none">
    <td width="16%" class="blue">验证类型</td>
    <td>
        <select name="identity_type" index="15" onChange="changeidtype()">
            <option value="00" selected>*请选择*</option>
            <option value="01">01 --> 详单核对</option>
            <option value="02">02 --> 凭证件</option>
        </select><font class="orange">*</font>
    </td>
    <td class="blue">信息号码间以(,)分隔</td>
    <td>
        <input type="text" name="identity_info" size="50" maxlength="100" v_must=1 value="" Disabled>
    </td>
</tr>
<tr>
    <td colspan="5" id="footer">
      <input class="b_foot" type=button name=qryPage value="确认" onClick="doCfm()" index="2" onKeyUp="if(event.keyCode==13){doCfm()}">
      <input class="b_foot" type=button name=back value="清除" onClick="s3216.reset()">
      <input class="b_foot" type=button name=qryPage value="关闭" onClick="parent.removeTab('<%=op_code%>')">
    </td>
</tr>
</table>
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
<input type="hidden" name="opName" id="opName" value="<%=opName%>" />
  <%@ include file="/npage/include/footer_simple.jsp" %> 
   </form>
</body>
</html>
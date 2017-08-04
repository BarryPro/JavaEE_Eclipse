<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 强制开关机1246
   * 版本: 1.0
   * 日期: 2008/12/23
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String hdword_no =(String)session.getAttribute("workNo");//工号
	String opCode="1246";
	String opName="强制开关机";
	String phoneNo = (String)request.getParameter("activePhone");
	String accountType = (String)session.getAttribute("accountType"); //1 为营业工号 2 为客服工号
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>黑龙江BOSS-开关机管理－强制开关机</title>
</head>
<body>
<form action="" method=post name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">请选择操作类型</div>
	</div>

	<table cellspacing="0">
	<tr>
		<td class="blue">操作类型</td>
		<td  class="blue">
			<input type="radio" name="op_run_code" value="K" checked>强开
			<input type="radio" name="op_run_code" value="N"  <%if("2".equals(accountType)){out.print(" disabled");}%>> 强关
			<input type="radio" name="op_run_code" value="BK" onclick="show4A();"> 批量强开
			<input type="radio" name="op_run_code" value="BN" onclick="show4A();" <%if("2".equals(accountType)){out.print(" disabled");}%>> 批量强关
		</td>
	</tr>

	<tr>
		<td class="blue">服务号码</td>
		<td>
			<input name="i1" value="<%=phoneNo%>" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td align=center colspan="2">
			<input class="b_foot" name=sure  type=button value=批量强关结果查询 onClick="go_plresult()" >
			<input class="b_foot" name=sure  type=button value=确认 onClick="if(check(form1))  pageSubmit();" >
			<input class="b_foot" name=reset onClick="" type="reset" value=清除>
			<input class="b_foot" name=close onClick="removeCurrentTab()" type=button value=关闭>
		</td>
	</tr>
</table>
	<!-- 2014/12/26 14:47:50 gaopeng 关于完善金库模式管理和敏感信息模糊化的需求 引入公共页面 openType用来区分普通金库校验和定制类公共校验-->
	<jsp:include page="/npage/public/intf4A/common/intfCommon4A.jsp">
		<jsp:param name="openType" value="SPECIAL"  />
	</jsp:include>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
<%/*-----------------------------javascript区-------------------------------------*/%>
<script language="javascript">
/*-----------------------------------load页面时读取----------------------------------*/

/***
	2、新增“批量强关结果查询”
	界面元素：操作流水(即批量强关返回的操作流水)
	查询结果：手机号码、处理结果
	其中：如果处理成功，则处理结果显示“成功”；
	     如果处理失败，则处理结果显示失败的原因。
	说明：“批量强关结果查询”放在“1246·强制开关机”界面里增加一个按钮即可，不用新增操作代码。
*/
	function go_plresult(){
	    var tpath = "f1246_show_plresult.jsp?opCode=<%=opCode%>"+//opcode
	    																		"&opName=批量强关结果查询" ;
			form1.action=tpath;
			form1.submit();	    																		
	}
	
	function pageSubmit(){
		var op_run_codeC = $("input[name='op_run_code'][checked]").val();
		if(op_run_codeC == "BK" || op_run_codeC == "BN"){
			window.location.href="f1246_bat.jsp?opCode=<%=opCode%>&opName=<%=opName%>&opType="+op_run_codeC+"&i1=<%=phoneNo%>";
		}
		else{
			form1.action="f1246_2.jsp";
			form1.submit();
		}
	}
	/*定制的金库校验方法*/
	function show4A(){
		var flag4A = allCheck4A("<%=opCode%>");
		if(!flag4A){
			$("input[name='op_run_code']").eq(0).attr("checked","checked");
		}
		
	}
</script>



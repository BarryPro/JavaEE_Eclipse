<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
	String opCode = "zg57";
	String opName = "不良信息投诉关机_添加";
	String work_no = (String) session.getAttribute("workNo");
	String loginNoPass = (String)session.getAttribute("password");
	String org_code = (String) session.getAttribute("orgCode");
	String regionCode = org_code.substring(0, 2);
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	String loginaccept = WtcUtil.repNull(request.getParameter("printAccept"));
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<META http-equiv=Content-Type content="text/html; charset=GBK">
	<head>
		<title><%=opName%></title>
		<script language=javascript>
			function confirm(){
				if(document.all.shandlingtype.value == ""){
					rdShowMessageDialog("操作原因不可为空！");
					return -1;
				}
				if(document.all.sSourceData.value == ""){
					rdShowMessageDialog("加黑类型不可为空！");
					return -2;
				}
				if(document.all.sSourceType.value == ""){
					rdShowMessageDialog("数据来源不可为空！");
					return -3;
				}
				if(document.all.blackReason.value == ""){
					rdShowMessageDialog("原因说明不可为空！");
					return -4;
				}
				frm.submit();
			}
		</script>
	</head>
	<body>
		<form name="frm" method="POST" action="zg57_1_cfm.jsp">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
			  <div id="title_zi">用户信息</div>
			</div>
			<table cellspacing="0">
				<tr>
					<td class="blue" width="10%" nowrap>手机号码</td>
			    <td class="blue" width="20%">
			    	<input class="InputGrey" type="text" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" size="30" readonly>
			    </td>
			    <td class="blue" width="10%" nowrap>操作原因</td>
			    <td class="blue" width="20%">
			    	<select name="shandlingtype" id="shandlingtype" class="button" >
			    		<option value="0101">二次过滤违规</option>
			    		<option value="0102">人工审核违规</option>
			    		<option value="0103" selected >投诉</option>
			    		<option value="0104">人工导入</option>
			    		<option value="0105">其他</option>
			    	</select>
			    </td>
			    <td class="blue" width="10%" nowrap>加黑类型</td>
			    <td class="blue" width="20%">
			    	<select name="sSourceData" id="sSourceData" class="button" >
			    		<!--<option value="" selected>请选择</option>   huangrong 备注 2011-6-21 -->
			    		<option value="01">垃圾短信</option>
			    		<option value="02" selected>骚扰电话</option>
			    		<option value="03" >垃圾彩信</option>
			    	</select>
			    </td>	    
				</tr>
	      <TR id="bltys"  > 
	      	<TD width="16%" class="blue">数据来源</TD>
          <TD colspan="5">
						<select id="sSourceType" name="sSourceType" style="width:100px;">
							<option value="01">全网监控平台</option>
							<option value="02" >省内监控</option>
							<option value="03" >举报处理</option>
							<option value="04" selected>用户投诉</option>
						</select>
	         </TD>
	      </TR> 
				<tr>
					<td class="blue" width="10%" nowrap>原因说明</td>
					<td width="90%" class="blue" colspan="5">
						<input class="button" type="text" name="blackReason" id="blackReason" value="" size="140" maxlength="70">
						<!--huangrong add 修改页面展示样式，操作原因可输入70个汉字 2011-6-21 -->
					</td>
				</tr>
				<tr>
					<td colspan="6" id="footer">
						<input class="b_foot" type="button" name="b_add" value="确认" onClick="confirm();">
						&nbsp;
						<input class="b_foot" type="button" name="b_back" value="返回" onClick="history.go(-1);">
						&nbsp;
						<input class="b_foot" type="button" name="b_close" value="关闭" onClick="removeCurrentTab();">
					</td>
				</tr>
			</table>
			<input type="hidden" name="opCode" value="<%=opCode%>">
			<input type="hidden" name="opName" value="<%=opName%>">
			<input type="hidden" name="loginaccept" value="<%=loginaccept%>">
    	<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>
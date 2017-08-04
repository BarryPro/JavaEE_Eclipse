<%
  /* *********************
   * 功能: 工号业务受理量限制操作—录入
   * 版本: 1.0
   * 日期: 2010/07/12
   * 作者: 
   * 版权: si-tech
   * *********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<title>工号业务受理量限制操作</title>
	<%
		String opCode = "1076";
		String opName = "工号业务受理量限制操作—录入";
		String workNo = (String)session.getAttribute("workNo");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode= (String)session.getAttribute("regCode");
	%>
	<script language="javascript" type="text/javascript">
		$(document).ready(function(){
			$("#back").click(function(){
				history.go(-1);
			});
			$("#close").click(function(){
				removeCurrentTab();
			});
			var workNoRadioObj = $("#all,#enter");
			var enterObj = $("#inputWorkNo");
			var workNoHidObj = $("#workNoHid");
			//工号输入radio切换
			workNoRadioObj.click(function(){
				if($(this).val() == "ALL"){
					hiddenTip(enterObj[0]);
					enterObj.addClass("InputGrey");
					enterObj.attr("disabled","disabled");
					workNoHidObj.val("ALL");
				}else if($(this).val() == "enter"){
					enterObj.removeAttr("disabled");
					enterObj.removeClass("InputGrey");
					if(enterObj.val() == null || enterObj.val() == ""){
						workNoHidObj.val("");
					}else{
						workNoHidObj.val(enterObj.val());
					}
				}
			});
			enterObj.blur(function(){
				checkElement(this);
				workNoHidObj.val(enterObj.val());
			});
			$("#inputOpcode").blur(function(){
				checkElement(this);
			});
			$("#threshold").blur(function(){
				checkElement(this);
			});
			//表单提交事件
			$("#confirm").click(function(){
				var flag = checkEnter();
				if(!flag){
					return false;
				}
				if(!check(frm)){
					return false
				}
				$("#timeFlag").val($("input[name='timePoint']:checked").val());
				//alert(workNoHidObj.val());
				$("form:first").submit();
			});
		});
		
		function checkEnter(){
			var enterObj = $("#inputWorkNo");
			if($("input[name='workNoRadio']:checked").val() == "enter"){
				if(enterObj.val() == null || enterObj.val() == ""){
					showTip(enterObj[0],"不能为空");
					return false;
				}
			}
			hiddenTip(enterObj[0]);
			return true;
		}
	</script>
</head>
<body>
<form name="frm" method="POST" action="f1076_2_cfm.jsp">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">工号业务受理量限制操作—录入</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">时间点</td>
			<td>
				<input name="timePoint" type="radio" value="01" checked="checked" />1小时 
				<input name="timePoint" type="radio" value="24" />24小时 <font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">工号</td>
			<td>
				<input name="workNoRadio" id="all" type="radio" value="ALL" checked="checked" />所有 
				<input name="workNoRadio" id="enter" type="radio" value="enter" />输入
				<input type="text" id="inputWorkNo" v_type="string" class="InputGrey" disabled="disabled"/>
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">操作代码</td>
			<td>
				<input type="text" id="inputOpcode" name="inputOpcode" v_type="string" v_must="1" 
						v_minlength="4" v_maxlength="5" />
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">阀值</td>
			<td>
				<input type="text" id="threshold" name="limitValue" v_type="0_9" v_must="1" v_maxvalue="9999" />
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td id="footer" colspan="2">
				<div align="center">
					<input class="b_foot" type="button" id="confirm" value="确认" />    
					<input class="b_foot" type="button" id="back" value="返回" />   
					<input class="b_foot" type="button" id="close" value="关闭" />
				</div>
			</td>
		</tr>
	</table>
	<input type="hidden" id="timeFlag" name="timeFlag" />
	<input type="hidden" id="workNoHid" name="workNoHid" value="ALL" />
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
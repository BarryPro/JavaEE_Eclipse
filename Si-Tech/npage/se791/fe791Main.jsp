<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
/********************
version v3.0
开发商: si-tech
ningtn 2012-4-24 10:04:12
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
	String opCode=request.getParameter("opCode");
  String opName=request.getParameter("opName");
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String regionCode= (String)session.getAttribute("regCode");
%>


<script language="javascript">
	function changeOper(){
		var opValue = $("input[@name='operate'][@checked]").val();
		if(opValue == "0"){
			/*新增*/
			if($("#ctrlFlag").val() != "0"){
				getQuestion();
			}
			$("#ctrlFlag").val("0");
		}else if(opValue == "1"){
			/*删除*/
			$("#operDiv").empty();
			$("#ctrlFlag").val("1");
		}
	}
	function getQuestion(){
		/*点击的是新增*/
		var getdataPacket = new AJAXPacket("fe791AddQuestion.jsp","请稍后...");
		getdataPacket.data.add("opCode","<%=opCode%>");
		getdataPacket.data.add("opName","<%=opName%>");
		core.ajax.sendPacketHtml(getdataPacket,doGetQuestionHtml);
		getdataPacket =null;
	}
	function doGetQuestionHtml(data){
		$("#operDiv").empty();
		$("#operDiv").append(data);
	}
	function changeQues(obj,selectIndex){
		var selectedVal = $(obj).val();
		if(selectedVal != "0"){
			/*选择了某一个问题，看看是否设置过*/
			$("select").each(function(i,n){
				if(i != selectIndex && $(this).val() == selectedVal){
					rdShowMessageDialog("该问题已经设置过答案，请换一问题设置");
					$(obj).attr("value","0");
				}
			});
		}
	}
	function getByteLen(str){ 
		var byteLen=0,len=str.length; 
		if(str){ 
			for(var i=0; i<len; i++){ 
				if(str.charCodeAt(i)>255){ 
					byteLen += 2; 
				} 
				else{ 
					byteLen++; 
				} 
			} 
			return byteLen; 
		} 
		else{ 
			return 0; 
		} 
	}
	function doNext(subButton){
		/* 按钮延迟 */
		controlButt(subButton);
		/* 事后提醒 */
		getAfterPrompt();
		var flag = false;
		/*需要判断是新增还是删除操作*/
		var opValue = $("input[@name='operate'][@checked]").val();
		if(opValue == "0"){
			/*新增*/
			/*
				新增最少是两个问题两个答案，最多十一个问题十一个答案
				问题选择了，答案就不能为空
			*/
			flag = true;
			var countNum = 0;
			var questionList = new Array();
			var answerList = new Array();
			$("select").each(function(i,n){
				if($(this).val() != "0"){
					var answerVal = $("input[name='answer']").eq(i).val();
					if(answerVal.trim() != ""){
						questionList[countNum] = $(this).val();
						answerList[countNum]   = answerVal;
						countNum++;
					}else{
						rdShowMessageDialog("问题的答案不能为空");
						flag = false;
					}
				}
			});
			
			if(flag && countNum < 2){
				rdShowMessageDialog("请至少设置两个问题");
				flag = false;
				return false;
			}
			$("#funcType").val("A");
		}else if(opValue == "1"){
			/*删除*/
			flag = true;
			$("#funcType").val("D");
		}else{
			flag = false;
			rdShowMessageDialog("请选择操作类型");
			return false;
		}
		if(flag){
			var packet = new AJAXPacket("fe791Cfm.jsp","请稍后...");
			packet.data.add("opCode","<%=opCode%>");
			packet.data.add("opName","<%=opName%>");
			packet.data.add("funcType",$("#funcType").val());
			packet.data.add("questionList",questionList);
			packet.data.add("answerList",answerList);
			core.ajax.sendPacket(packet		,doCfmBack);
			packet =null;
		}
	}
	function doCfmBack(packet){
		var	retCode	=packet.data.findValueByName("retCode");
		var	retMsg	=packet.data.findValueByName("retMsg");
		if("000000" == retCode){
			rdShowMessageDialog("提交成功！");
			location="/npage/se791/fe791Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}else{
			rdShowMessageDialog("提交失败！" + retCode + retMsg);
			location="/npage/se791/fe791Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}
	}
</script>
<body >
<form name="frm" action="" method="post">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">操作</td>
			<td>
				<input type="radio" name="operate" value="0" onclick="changeOper()" />新增
				<input type="radio" name="operate" value="1" onclick="changeOper()" />删除
			</td>
		</tr>
		<tr>
			<td class="blue" width="25%">工号</td>
			<td>
				<input type="text" name="workNo" value="<%=workNo%>" readonly class="InputGrey" />
			</td>
		</tr>
	</table>
	<div id="operDiv">
	</div>
	<table cellspacing="0">
		<tr id="footer"> 
			<td> 
				<div align="center"> 
				<input name="confirm" type="button" class="b_foot" value="确认提交" onclick="doNext(this)" />
				&nbsp; 
				<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭" />
				&nbsp; 
				</div>
			</td>
		</tr>
	</table>
	<input type="hidden" name="funcType" id="funcType" />
	<input type="hidden" name="ctrlFlag" id="ctrlFlag" />
	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
	<input type="hidden" name="opName" id="opName" value="<%=opName%>" />
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

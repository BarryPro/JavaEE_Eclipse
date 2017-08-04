<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
/********************
version v3.0
������: si-tech
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
			/*����*/
			if($("#ctrlFlag").val() != "0"){
				getQuestion();
			}
			$("#ctrlFlag").val("0");
		}else if(opValue == "1"){
			/*ɾ��*/
			$("#operDiv").empty();
			$("#ctrlFlag").val("1");
		}
	}
	function getQuestion(){
		/*�����������*/
		var getdataPacket = new AJAXPacket("fe791AddQuestion.jsp","���Ժ�...");
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
			/*ѡ����ĳһ�����⣬�����Ƿ����ù�*/
			$("select").each(function(i,n){
				if(i != selectIndex && $(this).val() == selectedVal){
					rdShowMessageDialog("�������Ѿ����ù��𰸣��뻻һ��������");
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
		/* ��ť�ӳ� */
		controlButt(subButton);
		/* �º����� */
		getAfterPrompt();
		var flag = false;
		/*��Ҫ�ж�����������ɾ������*/
		var opValue = $("input[@name='operate'][@checked]").val();
		if(opValue == "0"){
			/*����*/
			/*
				�����������������������𰸣����ʮһ������ʮһ����
				����ѡ���ˣ��𰸾Ͳ���Ϊ��
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
						rdShowMessageDialog("����Ĵ𰸲���Ϊ��");
						flag = false;
					}
				}
			});
			
			if(flag && countNum < 2){
				rdShowMessageDialog("������������������");
				flag = false;
				return false;
			}
			$("#funcType").val("A");
		}else if(opValue == "1"){
			/*ɾ��*/
			flag = true;
			$("#funcType").val("D");
		}else{
			flag = false;
			rdShowMessageDialog("��ѡ���������");
			return false;
		}
		if(flag){
			var packet = new AJAXPacket("fe791Cfm.jsp","���Ժ�...");
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
			rdShowMessageDialog("�ύ�ɹ���");
			location="/npage/se791/fe791Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}else{
			rdShowMessageDialog("�ύʧ�ܣ�" + retCode + retMsg);
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
			<td class="blue">����</td>
			<td>
				<input type="radio" name="operate" value="0" onclick="changeOper()" />����
				<input type="radio" name="operate" value="1" onclick="changeOper()" />ɾ��
			</td>
		</tr>
		<tr>
			<td class="blue" width="25%">����</td>
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
				<input name="confirm" type="button" class="b_foot" value="ȷ���ύ" onclick="doNext(this)" />
				&nbsp; 
				<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�" />
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

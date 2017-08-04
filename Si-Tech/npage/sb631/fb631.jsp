<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:ningtn@2010-10-8 �����һ
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>�����һ</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
%>

<script language=javascript>
	$(document).ready(function(){
		initPage();
	});
	
	function initPage(){
		hiddenTip(document.getElementById("phoneNo"));
		closeDiv();
		$("#phoneNo")[0].focus();
	}
	
	function onQuery(){
		if(!check(frm)){
			return false;
		}
		if(!checkNo()){
			return false;
		}
		var startStr = $("#startTime").val().trim();
		var endStr   = $("#endTime").val().trim();
		if(endStr.length != 0){
			if(startStr.length == 0 || endStr < startStr){
				rdShowMessageDialog("��ʼʱ�������ʱ�䲻��ȷ",0);
				return false;
			}
		}else if(startStr.length != 0){
			if(endStr.length == 0 || endStr < startStr){
				rdShowMessageDialog("��ʼʱ�������ʱ�䲻��ȷ",0);
				return false;
			}
		}
		frameDiv.style.display="";
		frm.action="fb631_getMore.jsp?phoneNo=" + $("#phoneNo").val() 
		+ "&beginTime=" + $("#startTime").val() + "&endTime=" + $("#endTime").val();
		frm.target="ifm";
		frm.submit();
	}
	
	function closeDiv(){
		$("#frameDiv").hide();
	}
	
	function checkNo(){
		if(!checkElement($("#phoneNo")[0])){
			return false;
		}
		var queryWayObj = $("input[name='queryWay'][@checked]").val();
		if("0" == queryWayObj){
			//�����ֻ������ѯ
			if(!forMobil($("#phoneNo")[0])){
				return false;
			}
		}else if("1" == queryWayObj){
			//����IMEI���ѯ
		}
		return true;
	}
	
</script>
</head>
<body>

<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�����һ</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue">��ѯ��ʽ</td>
		<td>
			<input name="queryWay" id="queryWay" type="radio" value="0" checked onclick="checkNo()"/>�ֻ����� &nbsp;&nbsp;
			<input name="queryWay" id="queryWay" type="radio" value="1" onclick="checkNo()"/>IMEI��
		</td>
		<td class="blue">��ѯ����</td>
		<td>
			<input name="phoneNo" id="phoneNo" type="text" v_must="1" v_type="0_9" onblur="checkNo()" />
			<font class="orange">*</font>
		</td>
	</tr>
	<tr>
		<td class="blue">��ʼʱ��</td>
		<td>
			<input name="startTime" id="startTime" type="text" v_type="date" onblur="checkElement(this)" />
		</td>
		<td class="blue">����ʱ��</td>
		<td>
			<input name="endTime" id="endTime" type="text" v_type="date" onblur="checkElement(this)" />
		</td>
	</tr>
</table>
<div id="frameDiv" style="display:none">
	<iframe name="ifm" width="98%" height="380" align="center"
			frameborder="0" cellspacing="0" src="blank.htm">
	</iframe>
</div>
<table cellspacing="0">
	<tr>
	    <td colspan="3" id="footer">
	      <input class="b_foot" type="button" name="queryBtn" id="queryBtn" value="��ѯ" onclick="onQuery()">
	      <input class="b_foot" type="reset" name="back" value="���" onclick="initPage()">
	      <input class="b_foot" type="button" name="qryPage" value="�ر�" onClick="removeCurrentTab()">
	    </td>
	</tr>
</table>
  <%@ include file="/npage/include/footer.jsp" %> 
   </form>
</body>
</html>

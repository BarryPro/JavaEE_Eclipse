<%
  /*
   * ����: �ʼ����/�ʼ�����ѡ��
�� * �汾: 1.0
�� * ����: 2008/11/10
�� * ����: hanjc 
�� * ��Ȩ: sitech
   * 
   *  
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>

<%
    String opCode="K211";
    String opName="�ʼ����ݲ�ѯ";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String regionCode = "";
	  if(orgCode!=null){
	  regionCode = orgCode.substring(0,2);
	  }
		    
%>			


<html>
<head>
<title>ѡ�񱻼����/�ʼ�����</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("td").not("[input]").addClass("blue");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			$("input:text[@v_type]").blur(checkElement2);	
		
			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "blue");
			});
		}
	);

	function checkElement2() { 
				checkElement(this); 
		}	

function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="K211_evaItemQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit(); 
}

//�������¼
function clearValue(){
var e = document.forms[0].elements;
for(var i=0;i<e.length;i++){
  if(e[i].type=="select-one"||e[i].type=="text")
   e[i].value="";
 }
}


//��ʾͨ����ϸ��Ϣ
function getCallDetail(contact_id,start_date){
		var path="<%=request.getContextPath()%>/npage/callbosspage/k170/k170_getCallDetail.jsp";
    path = path + "?contact_id=" + contact_id;
    path = path + "&start_date=" + start_date;
    window.open(path,"newwindow","height=768, width=1072,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;
}

// ��iframemiddle��ֵ��ˢ��ҳ��
function sendIframemiddleId(selectedItemId){
	//alert(selectedItemId);
	var iframemiddle = window.frames['framemiddle']
	iframemiddle.location.href="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K211/K211_qcContent.jsp?selectedItemId="+selectedItemId;
	//iframemiddle.document.sitechform.selectedItemId.value=selectedItemId;
	//iframemiddle.location.reload();
 }

//��ѡȡ���������ظ�����
function setQryCondition(){
	 window.opener.sitechform.qcobjectid.value=window.sitechform.beQcContentId.value;
	 window.opener.sitechform.qcobjectName.value=window.sitechform.beQcContentName.value;
	 if(window.sitechform.beQcContentName.value!=""){
	   window.opener.sitechform.beQcObjId.value=window.sitechform.beQcObjId.value;
	   window.opener.sitechform.beQcObjName.value=window.sitechform.beQcObjName.value;
	 }
	 window.close();
}

</script>
</head>


<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table" style="width:100%;">
		<table cellspacing="0" >
			<tr><td><div class="title"><div id="title_zi">�ʼ����ݲ�ѯ</div></div></td></tr>
      <tr >
       <td > ��ѡ������� 
				<input  id="beQcObjName" name="beQcObjName" type="text"  onclick=""   value="">
        ��ѡ�ʼ�����
			  <input id="beQcContentName" name ="beQcContentName" type="text" onclick=""   value="">
			</td>
    </tr>
		</table>    
	</div>
	<iframe name="frameleft" id="frameleft" marginHeight="0" marginWidth="0" frameborder="1"  scrolling="auto" src="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K211/K211_beQcObjTree.jsp" width="40%" height="75%"></iframe>
	<iframe name="framemiddle" id="framemiddle" marginHeight="0" marginWidth="0" frameborder="1" scrolling="auto" src="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K211/K211_qcContent.jsp" width="60%" height="75%"></iframe>
				<p  align="center" id="footer" style="width:100%">
          <input name="cfm" type="button"  id="add" value="ȷ��" onClick="setQryCondition();return false;">
          <input name="camcle" type="button"  id="search" value="ȡ��" onClick="window.close();return false;">
       </p>
  <input  id="beQcObjId" name="beQcObjId" type="hidden"  value="">
	<input id="beQcContentId" name ="beQcContentId" type="hidden"  value="">
</form>
</body>
</html>


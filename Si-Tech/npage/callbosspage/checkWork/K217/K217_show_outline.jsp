<%
  /*
   * ����: �ƻ����ʼ�-��ѡ��������
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	String opCode = "K217";
	String opName = "ѡ��������";
	String staffno = request.getParameter("staffno");
	String group_flag = request.getParameter("group_flag");

%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>

<title></title>

<script>
	$(document).ready(
		function()
		{
	    $("td").not("[input]").addClass("blue");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			//$("input:text[@v_type]").blur(checkElement2);	
		
			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "blue");
			});
		}
	);
	
function closeThisWin(){
		var qc_objectvalue = document.getElementById("qc_object").value;
		var qc_contentvalue = document.getElementById("qc_content").value;
		var object_id  = document.getElementById("object_id").value;
		var content_id = document.getElementById("content_id").value;
		var staffno = document.getElementById("staffno").value;
		var group_flag = '<%=group_flag%>';
		if("" ==object_id){
				similarMSNPop("��ѡ���ʼ����"); 
				return false;
		}
		
		if("" == content_id){
				similarMSNPop("��ѡ�������ݣ�"); 
				return false;
		}	
		var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
		var serialnum = '<%=request.getParameter("serialnum")%>';
		var opCode = '<%=opCode%>';
		var tabId = opCode+serialnum;
		var path = '/npage/callbosspage/checkWork/K217/K217_out_plan_qc_form.jsp?serialnum=' + serialnum + '&object_id=' +object_id + '&content_id=' + content_id +'&qc_objectvalue=' + qc_objectvalue + '&qc_contentvalue=' + qc_contentvalue + '&isOutPlanflag=1&staffno=<%=staffno%>'+ '&group_flag=' + group_flag+ '&tabId='+tabId+'&opCode=<%=opCode%>';
		
		//zengzq start 090520
		//����ѡ����ͬһʱ��ֻ�ܴ�һ���ʼ�������ڣ��ƻ��ڣ��ƻ��⣬��ʱ���棬�޸ģ����˴��ڣ�
		/*
		var tabtag = top.document.getElementById("tabtag");
		var getElements = tabtag.getElementsByTagName("li");
		for(var i = 0; i<getElements.length; i++){
				var singleElement = getElements[i].getAttribute("id");
				if(singleElement.length > 4 ){
					var partElement = singleElement.substr(0,4);
						if('K217' == partElement||'K218' == partElement||'K219' == partElement||'K214' == partElement||'K216' == partElement){
								similarMSNPop("�Ѵ�һ���ʼ�������ڣ�");   
								return false;
						}
				} else if('K214'==singleElement){
						similarMSNPop("�Ѵ�һ���ʼ�������ڣ�");  
						return false;
				}
		}
		*/
		//zengzq end 
		
			
		if(!parent.parent.document.getElementById(tabId)){
				path = path+'&tabId='+tabId;
        parent.parent.addTab(true,tabId,'�ƻ����ʼ�',path);				
				parent.parent.removeTab(serialnum+1);
		}else{
				similarMSNPop("����ˮ�ʼ촰���Ѵ򿪣�");  
		}
}

function cancel(){
		var object_id      = document.getElementById("object_id");
		var content_id     = document.getElementById("content_id");
		var object_name    = document.getElementById("qc_object");
		var content_name   = document.getElementById("qc_content");	
		object_id.value    = "";
		content_id.value   = "";
		object_name.value  = "";
		content_name.value = "";
}

</script>
</head>

<body>
	<div id="Operation_Table">
<table>
	<tr>
		<td width="5%">�����������</td>
		<td width="8%">
			<input type="text" name="qc_object" id="qc_object"  value="" readonly />
			<input type="hidden" name="object_id" id="object_id" value=""/>
		</td>
		<td width="5%" >��������</td>
		<td width="10%" >
			<input type="text" name="qc_content" id="qc_content" size="30" value="" readonly />
			<input type="hidden" name="content_id" id="content_id" value=""  />
		</td>
		<input type="hidden" name="staffno" id="staffno" value="<%=staffno%>"/>
		<td width="5%" ><input type="button" name="btn_submit" value="ȷ��" class="b_foot" onclick="closeThisWin();"/></td>
		<td width="5%" ><input type="button" name="btn_cancel" value="ˢ��" class="b_foot" onclick="window.parent.frames['mainFrame'].history.go(0);"/></td>
	</tr>
</talbe>
</div>
</body>
</html>

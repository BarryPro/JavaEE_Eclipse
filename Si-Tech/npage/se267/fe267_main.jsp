<%
    /*************************************
    * ��  ��: 4A������¼�� e267 
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2011-9-16
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> 4A������¼�� </title>
<%
    String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
%>
  </script>
<script language="javascript">
    function doCfm(subButton)
    {
        controlButt(subButton);			//��ʱ���ư�ť�Ŀ�����
        var radio1 = document.getElementsByName("opFlag");
        for(var i=0;i<radio1.length;i++)
        {
        	if(radio1[i].checked)
        	{
        		var opFlag = radio1[i].value;
        		if(opFlag=="one")
        		{
        		    //�����ύ
        		    if($("#workNoOperated").val()==""){
        		        rdShowMessageDialog("������������ţ�", 0);
        		        return false;
        		    }
        			simpleListInput();
        		}
        	}
        }
    }
    
    function controlButt(subButton){
        subButt2 = subButton;
        subButt2.disabled = true;
        setTimeout("subButt2.disabled = false",3000);
    }
    
    function simpleListInput(){
        var simplePacket = new AJAXPacket ("fe267_ajax_getSimpleInfo.jsp","��ȴ�������");
        var workNoOperated = $("#workNoOperated").val();
        simplePacket.data.add("workNoOperated",workNoOperated);
    	core.ajax.sendPacketHtml(simplePacket,showSimpleMsg);
    	simplePacket =null;
    }
    
    function showSimpleMsg(data){
        $("#showSimpleTab").empty().append(data);
        $("#confirm").attr("disabled","");
    }

    function opFlagChange(obj){
	    document.frm.action="fe267_moreListInput.jsp";
		document.all.opcode.value="e267";
		document.frm.submit();
    }
    function resetPage(){
 		window.location.href = "fe267_main.jsp?opCode=e267&opName=4A������¼��";
	}
	
	function subSimpleInfo(){
         var val = $("#operateWorkNo").val();
	   	 document.frm.action = "fe267_ajax_sunInfo.jsp?val="+val;
		 document.frm.submit();
	}
	
</script>
</head>
<body>
<form name="frm" method="POST">
 	<input type="hidden" name="opcode" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ѡ���������</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="20%">��������</td>
		<td colspan="3">
			<input type="radio" name="opFlag" value="one" checked  />��������¼��&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="two" onclick="opFlagChange(this)" />�������¼��
		</td>
	</tr>
	<tr>
		<td class="blue">
			¼�����������
		</td>
		<td>
			<input type="text"  id="workNoOperated" name="workNoOperated" vlaue="" v_type="string" maxlength="6" />
     		<font color="orange">*</font>
     		<input class="b_text" type="button" name="query" value="��ѯ" onClick="doCfm(this)" />
     		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     		<span id="showSimpleTab"></span>
		</td>
		
	</tr>
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button id="confirm" name="confirm" value="ȷ��" onClick="subSimpleInfo()" disabled="disabled" index="2" />    
			<input class="b_foot" type=button name=back value="���" onClick="resetPage()" />
			<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();" />
		</td>
	</tr>
</table>

    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
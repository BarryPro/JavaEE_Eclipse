<%
    /*************************************
    * ��  ��: 4A������ɾ�� e268
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2011-9-16
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = "e268";
  String opName = "4A������ɾ��";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
%>
<script type="text/javascript">
  function queryGroup(){
  	   window.open("groupTree.jsp","","height=530,width=450,scrollbars=yes");
  }

  function getWorkNo(){
  	var getPacket = new AJAXPacket ("fe268_ajax_getTab.jsp","��ȴ�������");
	getPacket.data.add("groupId" , $("#groupId").val());
	getPacket.data.add("PageSize" , $("#pageRows").val());
	core.ajax.sendPacketHtml(getPacket,showMsg,true);
	getPacket =null;	
  }

  function showMsg(data){
	$("#showTab").empty().append(data);
	$("#pageTr").show();
}

 function doCfm(){
 		var selectGroupId = $("#groupId").val();
 		//ʹ��ѡ�񹤺�
 	    var val = "";
		    var selBoxArr = $('input[name="selBox"]:checked');
		    if(selBoxArr.length == 0){
		   		rdShowMessageDialog("�ޱ��������ţ�");
		  	    return;
		   	}else{
		   	    for(var j=0;j<selBoxArr.length;j++){
	   	    	    val=val+selBoxArr[j].v_text + ",";
		   	    }
		   	 }
			   	 var groupIdVal = $("#groupId").val();
			   	 document.form1.action = "fe268_ajax_sunInfo.jsp?groupId=" + groupIdVal + "&val="+val;
   				 document.form1.submit();
 }

 	function selPage(){
        getWorkNo();	
 	}

 	function resetPage(){
 		window.location.href = "fe268_main.jsp?opCode=e268&opName=4A������ɾ��";
	}
	
	function toPrevious(){
	    window.location.href = "fe268_main.jsp?opCode=e268&opName=4A������ɾ��";
	}

</script>
</head>
<body>
<form name="form1" id="form1" method="POST" ENCTYPE="multipart/form-data">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
      <table cellspacing="0">
		<tr>
			<td class="blue" width="20%">
				��֯�ڵ�
			</td>
			<td width="80%">
  				<input type="hidden" name="groupId" id="groupId" class="InputGrey" readonly />
  				<input type=text name="groupName" id="groupName" class="InputGrey" size="30" readonly />
            	<input class="b_text" type="button" name="" value="ѡ��" onclick="queryGroup();" />
	     		<font color="orange">*</font>
			</td>
		</tr>
	</table>
	<div id="showTab" ></div>
	<table>
		<tr id="pageTr" style="display:none">
			<td class="blue" width="10%">��ʾ����</td>
			<td cplspan="3">
		    <select name="pageRows" id="pageRows" style="width:80px" onchange="selPage();" />
					<option value="10">10��</option>
					<option value="20">20��</option>
					<option value="30">30��</option>
					<option value="40">40��</option>
					<option value="50">50��</option>
				</select>	
			</td>
		</tr>
         <tr>
            <td colspan="4" align="center">
              <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2" />
              <input class="b_foot" type=button name=back value="���" onClick="resetPage()" />
		      <input class="b_foot" type=button name=qryP value="����" onClick="toPrevious()" />
           </td>
        </tr>
      </table>
    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
</html>
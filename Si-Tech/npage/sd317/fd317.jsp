<%
/********************
 version v2.0
������: si-tech
create by wanglm 20110321
********************/
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = "d317";
  String opName = "�������";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script type="text/javascript">
  function queryGroup(){
  	   window.open("groupTree.jsp","","height=530,width=450,scrollbars=yes");
  }
  function getWorkNo(){
  	var chkPacket = new AJAXPacket ("ajax_getTab.jsp","��ȴ�������");
	chkPacket.data.add("groupId" , $("#groupId").val());
	chkPacket.data.add("PageSize" , $("#pageRows").val());
	core.ajax.sendPacketHtml(chkPacket,showMsg,true);
	chkPacket =null;	
  }
  function showMsg(data){
	$("#showTab").empty().append(data);
	$("#pageTr").show();
	/* ningtn */
	form1.feefile.value = "";
	$("#fileUpLoad").hide();
}
	function getFileName(obj){
		var pos = obj.lastIndexOf("\\");
		return obj.substring(pos+1);
	}
	function getFileExt(obj)
	{
	    var pos = obj.lastIndexOf(".");
	    return obj.substring(pos+1);
	}
 function doCfm(){
 		
 		var selectGroupId = $("#groupId").val();
 		if(selectGroupId.trim().length == 0){
 			//ʹ���ļ��ϴ�
 			 	if(form1.feefile.value.length<1){
					rdShowMessageDialog("���ϴ��ļ�������ѡ����֯������ѡ�񹤺�");
					document.form1.feefile.focus();
					return false;
				}
		 		//var fileVal = getFileName($("#feefile").val());
		 		var fileVal = getFileExt($("#feefile").val());
				if("txt" == fileVal){
					//��չ����txt
				}else{
					rdShowMessageDialog("�ϴ��ļ�����չ������ȷ",0);
					return false;
				}
				document.form1.action = "fd317_sub.jsp";
   			document.form1.submit();
 		}else{
 			//ʹ��ѡ�񹤺�
 			 		var val = "";
			    var selBoxArr = $('input[name="selBox"]:checked');
			    if(selBoxArr.length == 0){
			   		rdShowMessageDialog("�ޱ��������ţ�");
			  	    return;
			   	}else{
			   	    for(var j=0;j<selBoxArr.length;j++){
			   	    	var selBoxValue = parseInt(selBoxArr[j].value)+1;
			   	    	    val = val + $(" tr:eq("+selBoxValue+") td:eq(1)").html() + ",";	
			   	    }
			   	 }
			   	 var groupIdVal = $("#groupId").val();
			   	 document.form1.action = "fd317_sub.jsp?groupId=" + groupIdVal + "&val="+val;
   				 document.form1.submit();
 		}
   	
   	
 }
 	function selPage(){
    getWorkNo();	
 	}
 	function resetPage(){
 		window.location.href = "fd317.jsp";
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
	  				<input type="hidden" name="groupId" id="groupId" class="InputGrey" readonly>
	  				<input type=text name="groupName" id="groupName" class="InputGrey" size="30" readonly>
	            	<input class="b_text" type="button" name="" value="ѡ��" onclick="queryGroup();">
		     		<font color="orange">*</font>
				</td>
			</tr>
	</table>
	<div id="showTab" ></div>
	
	<table>
		<tr id="pageTr" style="display:none">
			<td class="blue" width="10%">��ʾ����</td>
			<td cplspan="3">
		    <select name="pageRows" id="pageRows" style="width:80px" onchange="selPage();">
					<option value="10">10��</option>
					<option value="20">20��</option>
					<option value="30">30��</option>
					<option value="40">40��</option>
					<option value="50">50��</option>
				</select>	
			</td>
		</tr>
		<tr id="fileUpLoad">
			<td class="blue">
				�ļ��ϴ�
			</td>
			<td>
				<input type="file" name="feefile" id="feefile">
			</td>
			<td class="blue">
				�ļ��ϴ�˵��
			</td>
			<td>
				<span>
					�����ļ�����Ϊ<font color="red">txt</font>��ʽ��ÿ�м�¼���ҽ�����һ������<br />
					һ��������100������<br />
					&nbsp;�ļ��й�����֯����Ϊ�ڲ���Ա������֯����������<br />
					&nbsp;�磺<br />
					&nbsp;&nbsp;&nbsp;aaaaa0<br />
					&nbsp;&nbsp;&nbsp;aaaaa1<br />
					&nbsp;&nbsp;&nbsp;aaaaa2
				</span>
			</td>
		</tr>
         <tr>
            <td colspan="4" align="center">
              <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">
              <input class="b_foot" type=button name=back value="���" onClick="resetPage()">
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab()">
           </td>
        </tr>
      </table>
    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
</html>
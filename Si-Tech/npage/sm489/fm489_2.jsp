<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)[2017/6/5 ����һ 14:27:09]------------------
 
 
 -------------------------��̨��Ա��[yuwd]--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");

	String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%> 
 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>
function reSetThis(){
	location = location ;
}

function set_busi_type(){
	
	if($("#busi_type").val()=="1"){
			location = "fm489_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}else{
	 
	}
}

function set_op_type(){
 
		if($("#op_type").val()=="A"){
			$("#type2_add").show();
			$("#type2_del").hide();
		}else{
			$("#type2_add").hide();
			$("#type2_del").show();
		}
}

function getFileExt(obj){
	    var pos = obj.lastIndexOf(".");
	    return obj.substring(pos+1);
}
	
	
function go_Cfm(){
	 
		
			if (form1.uploadfile_2.value.length < 1) {
				rdShowMessageDialog("���ϴ��ļ�!");
				document.form1.uploadfile_2.focus();
				return false;
			}
			var fileVal = getFileExt($("#uploadfile_2").val());
			if ("txt" == fileVal) {
				//��չ����txt
			} else {
				rdShowMessageDialog("�ϴ��ļ�����չ������ȷ,ֻ���Ǻ�׺Ϊtxt�����ļ���", 0);
				return false;
			}
			
			$("#form1").attr("encoding", "multipart/form-data");
			document.form1.action = "fm489_type2_uploadCfm.jsp";
			document.form1.submit();
			
		
		
}

</SCRIPT>
</HEAD>	
<BODY>
<FORM id="form1" name="form1" action="" method="post"> 
	<input type="hidden" id="opCode" name="opCode" value="<%=opCode%>" />
	<input type="hidden" id="opName" name="opName" value="<%=opName%>" />
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">ҵ������</td>
		  <td  width="35%">
		  	<select id="busi_type" name="busi_type" onchange="set_busi_type()" style="width:300px">
				    <option value="1">���Ϳ�����</option>
				    <option value="2" selected>�������ר���ʷ�Ȩ������</option>
				</select>
		  </td>
		  <td class="blue" width="15%">��������</td>
		  <td >
		  	<select id="op_type" name="op_type" onchange="set_op_type()">
				    <option value="A">����</option>
				    <option value="D">ɾ��</option>
				</select>
		  </td>
	</tr>
</table>

 
	<table cellSpacing="0">
		<tr>
			<td width="15%"  class="blue">ѡ���ļ�</td>
			<td>
					<input type="file" id="uploadfile_2" name="uploadfile_2"/>
			</td>
		</tr>
		
		<tr id="type2_add">
			<td colspan="2">
				ÿһ��һ����¼������ʹ�����߷ָ��������лس����С��ո���ַ�<br>
				�����ֶ�Ϊ��<br> group_id|��������|�ֻ����룬�磺<br>
				10031|aaaaxp|13904510033<br>
				10031|aaaaxp|13904510034<br>
				10031|aaaaxp|13904510035<br>
				<br>
				���һ�����Իس�����β<br>
				<font class="orange">���ܳ���500����¼</font> 
			</td>
		</tr>
		
		<tr id="type2_del" style="display:none">
			<td colspan="2">
				ÿһ��һ����¼������ʹ�����߷ָ��������лس����С��ո���ַ�<br>
				�����ֶ�Ϊ��<br> group_id|��������|�ֻ����룬�磺<br>
				10031|aaaaxp|13904510036<br>
				10031|aaaaxp|13904510037<br>
				10031|aaaaxp|13904510038<br>
				<br>
				���һ�����Իس�����β<br>
				<font class="orange">���ܳ���500����¼</font> 
			</td>
		</tr>
		
	</table>	


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��" onclick="go_Cfm()"            />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
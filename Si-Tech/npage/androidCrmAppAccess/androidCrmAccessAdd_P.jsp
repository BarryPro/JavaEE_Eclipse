<%
/********************
 version v2.0
 ������ si-tech
 create hejwa 2015-1-14 10:56:56
 ������������
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
   String input_group_id 	  = request.getParameter("input_group_id");
   String input_group_name	= request.getParameter("input_group_name");
   String opCode    = request.getParameter("opCode");
	 String opName    = "�������android��CRM�����ն�";
	 
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>������������</title>
<script type="text/javascript" >

function checkfile_v2(){
	//ѡ���ļ�
	
	$("#feefile").click();
	var filepath = $("#feefile").val();
	
	if(filepath==""||typeof(filepath)=="undefined"){//����ļ���δѡ���ļ�ֱ�ӹرջ��ȡ����ť
		return;
	}else{
		var filetype = filepath.substring(filepath.lastIndexOf(".")+1,filepath.length);
		if("txt" != filetype){
			 rdShowMessageDialog("��ѡ��txt�ı��ļ�");
			 $("#facefile").val("");
		}else{
			 $("#facefile").val(filepath);
		}
	}
}

function doAdd(){
		document.frm.action = "androidCrmAccessAddCfm_P.jsp?input_group_id=<%=input_group_id%>&opCode=<%=opCode%>&opName=<%=opName%>";
   	document.frm.submit();
}

function twClose(){
	window.location = "androidCrmAccessMain.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
}
</script>
</head>
<body>
<form  name="frm"  method="POST" ENCTYPE="multipart/form-data">
	<%@ include file="/npage/include/header.jsp" %>
				<div class="title">
					<div id="title_zi">����������������</div>
				</div>
				<table cellspacing="0">
					<tr>
						<td class="blue" style="text-align:left">
							<font class="orange">
								ѡ��txt�ı��ļ��硰�������.txt�����ı����ֶ����壺<br>
								IMEI��,��������,�����½��ʼ����,�����½��������,�����½��ʼʱ��,�����½����ʱ��,�ֻ�����
								<br>
								<br>
								txt�ļ�����ʾ��<br>
								862949024658283|�ŷ�|2014-02-17|2015-02-17|08:00:00|23:36:59|13904512001
								<br>
								866416010106863|����|2014-10-29|2015-10-29|08:00:00|18:00:00|13904512002
								<br>
								355287257870778|����|2014-01-07|2015-01-07|08:00:00|18:00:00|13904512003

							</font>
						</td>
					</tr>
				</table>
				
				<div class="title">
					<div id="title_zi">
						ѡ���ϴ����ļ�
					</div>
				</div>
			
				<table cellspacing="0">
					<tr>
						<td width="70%">
							<input type="file" id="feefile"  name="feefile" size="100" />
						</td>	
					</tr>
					<tr>
						<td class="blue" style="text-align:center"  >
							
							<input class="b_foot" name="add"   type=button value="ȷ��" onclick="doAdd()"   />
						  	&nbsp; 
						  <input class="b_foot" name="close" type=button value="����" onclick="twClose()"  />
						</td>
					</tr>
				</table>

	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

<%
  /*
   * ����: У԰��Ϣ¼�� m132
   * �汾: 1.0
   * ����: 2014/6/27
   * ����: 
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
    
  String regionCode = (String)session.getAttribute("regCode");
  String loginNo = (String)session.getAttribute("workNo");
	String noPass = (String)session.getAttribute("password");
	String phoneNo = (String)request.getParameter("activePhone");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName"); 
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
	<script src="../public/json2.js" type="text/javascript"></script>   
	<script language="JavaScript">
		function printCommit(){
			var uploadFile = $("#uploadFile").val();
			/*ִ���ϴ��ļ��������ϴ��ļ�����÷���*/
			if(uploadFile == ""){
				rdShowMessageDialog("��ѡ�����������ļ���");
				$("#uploadFile").focus();
				return false;
			}
			
			var formFile=uploadFile.lastIndexOf(".");
			var beginNum=Number(formFile)+1;
			var endNum=uploadFile.length;
			formFile=uploadFile.substring(beginNum,endNum);
			formFile=formFile.toLowerCase(); 
			if(formFile!="txt"){
				rdShowMessageDialog("�ϴ��ļ���ʽֻ����txt��������ѡ���ļ���",1);
				document.all.uploadFile.focus();
				return false;
			}
			
			/*׼���ϴ�*/
			//document.frm.target="hidden_frame";
			$("form").attr("encoding", "multipart/form-data");
			$("form").attr("ENCTYPE", "multipart/form-data");
	    document.frm.submit();
			return true;
		}
		
	</script> 
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
</head>
<BODY>
<form name="frm" method="post" action="/npage/sm132/fm132_Upload.jsp" >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">           
    <tr>
			<td width="20%" class="blue">�����ļ�</td>
			<td width="80%" colspan="3">
				<input type="file" id="uploadFile" name="uploadFile" v_must="1"  
					style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />&nbsp;<font color="red">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">
				�ļ���ʽ˵��
			</td>
      <td colspan="3"> 
          &nbsp;
					һ.�������ļ�����Ϊ�ı��ļ�����׺.txt��<br>&nbsp;
					��.һ��������100��<br>&nbsp;
					��.�ϴ��ļ��ı���ʽΪ�������֤����|�ͻ�����|ѧУ����|רҵ����|סַ�����ļ�����ʾ�����£�<br>&nbsp;
          <font class='orange'>
          	&nbsp;&nbsp; 230103198401011234|С��|��������ѧ|��ľ����|������ʡ���������ϸ���������100��
          </font>
          <b>
          <br>&nbsp;ע����ʽ�е�ÿһ�����������ڿո�,��ÿ�����ݶ���Ҫ�س����С��ϴ��ļ���ʽΪtxt�ļ���
          </b> 
      </td>
	 	</tr>
		<tr> 
			<td align="center" id="footer" colspan="4"> 
				<input type="button" name="qryBtn"  class="b_foot" value="ȷ��" onclick="printCommit()">
				&nbsp;
				<input type="button" name="closeBtn1" class="b_foot" value="�ر�" onclick="removeCurrentTab()">
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
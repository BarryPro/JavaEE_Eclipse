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
<%@ page import="java.text.SimpleDateFormat"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String current_timeNAME=new SimpleDateFormat("yyyyMMdd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">

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
	    
 			 	if(form1.feefile.value.length<1){
					rdShowMessageDialog("���ϴ��ļ�!");
					document.form1.feefile.focus();
					return false;
				}

		 		var fileVal = getFileExt($("#feefile").val());
				if("txt" == fileVal){
					//��չ����txt
				}else{
					rdShowMessageDialog("�ϴ��ļ�����չ������ȷ",0);
					return false;
				}
				document.form1.action = "fm166Upload.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
   			document.form1.submit();
 }

 	function resetPage(){
 		window.location.href = "fm166.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}

</script>
</head>
<body>
<form name="form1" id="form1" method="POST" ENCTYPE="multipart/form-data">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>


	<div id="showTab" ></div>
	
	<table>
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
					�����ļ�����Ϊ<font color="red">txt</font>��ʽ��ÿ�м�¼Ϊ�ֻ�����<br />
					һ��������100������<br />
					&nbsp;�磺<br />
					&nbsp;&nbsp;&nbsp;13836141518<br />
					&nbsp;&nbsp;&nbsp;13836141519<br />

			</span>
			</td>
		</tr>

      </table>
              <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
              <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">
              <input class="b_foot" type=button name=back value="���" onClick="resetPage()">
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab()">
              </div>
            </td>
          </tr>
        </table>
      <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>"/>
      <input type="hidden" name="opName" id="opName" value="<%=opName%>"/>
    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
</html>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>

<%!
private static String CGI_PATH = "";
private static String DETAIL_PATH = "";
static{
    //�ӹ��������ļ��ж�ȡ������Ϣ������Ϣ����sever����
    CGI_PATH = SystemUtils.getConfig("CGI_PATH");
	DETAIL_PATH = SystemUtils.getConfig("DETAIL_PATH");
    //�������"/"��ʽ����,����"/"
    if(!CGI_PATH.endsWith("/")){
		CGI_PATH=CGI_PATH+"/";
	    DETAIL_PATH=DETAIL_PATH+"/"; 
    }
  }
%>

<%
	String phoneNo = request.getParameter("phoneNo");		//�ֻ�����
	String billBegin = request.getParameter("billBegin");	//��ʼʱ��
	String billEnd = request.getParameter("billEnd");		//����ʱ��
	String qryType = request.getParameter("qryType");		//��ѯ����
	String qryName = request.getParameter("qryName");		//������ϸ����
	String dateStr = request.getParameter("dateStr");		//��ѯʱ��
	String outFile = request.getParameter("outFile");		//���ɵ��ļ�
	String beginLineStr = request.getParameter("beginLine");	//��ȡ��ʼ��
	String custName = request.getParameter("custName");			//ͨѶ�˿�
	String icount = request.getParameter("icount");			//ͨѶ�˿�
	
	String islowcust = request.getParameter("islowcust");
%>
<html>
<head>
<title> �������굥��ѯ-<%=qryName%></title>

<SCRIPT LANGUAGE="JavaScript">
<!--
function gohome()
{
	document.location.replace("f1516_1.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>");
}
//-->
</SCRIPT>

</head>	
<body>

<FORM method=post name="frm1500" OnSubmit=" ">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="phoneNo"  value="<%=phoneNo%>">
	<input type="hidden" name="billBegin"  value="<%=billBegin%>">
	<input type="hidden" name="billEnd"  value="<%=billEnd%>">
	<input type="hidden" name="qryType"  value="<%=qryType%>">
	<input type="hidden" name="qryName"  value="<%=qryName%>">
	<input type="hidden" name="outFile"  value="<%=outFile%>">
	<div class="title">
		<div id="title_zi">�й��ƶ�ͨ�ſͻ�<%=qryName%>�굥</div>
	</div>
	<table cellspacing="0">
	    <%
	       //�õ�����ļ� 
	  	   String txtPath = DETAIL_PATH;
	       File temp = new File( txtPath,outFile);
	       
	       int lineNum = 0;
	       String tline = null;
	       int beginLine = Integer.parseInt(beginLineStr);
	       int pageSize = 30;
	       
	       FileReader outFrT1 = new FileReader(temp);
	       BufferedReader outBrT1 = new BufferedReader(outFrT1);	
	       
	       do {
			     tline = outBrT1.readLine();
			     String tlinetep = "";
			     if (tline != null) {
			        tlinetep = tline.replaceAll(" ", "&nbsp;");
			     }
			     
			     if (lineNum >= beginLine && lineNum < beginLine + pageSize) {
			         out.println("<tr><td align='left' nowrap>" + tlinetep + "</td></tr>");
			     }
			     
			     lineNum++;
			  } while(tline!=null);
	       outBrT1.close();
		   outFrT1.close();
	    %>    
	</table>
      <table width="98%" border=0 align=center cellpadding="1" cellspacing=0>
				<tr> 
					<font class="orange">
						<td width="60%"> ���� <%=(Integer.parseInt(icount))/pageSize + ((Integer.parseInt(icount)) % pageSize == 0 ? 0 : 1)%> ҳ����ǰҳΪÿ <%=beginLine/pageSize + 1%> ҳ </td>
						<%if (beginLine != 0) {%>
						<td width="10%"><a href="fDetQryPrint1.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=0&opCode=<%=opCode%>&opName=<%=opName%>&phoneNo=<%=phoneNo%>" >����һҳ�� </a> </td>
						<td width="10%"><a href="fDetQryPrint1.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=beginLine - pageSize%>&opCode=<%=opCode%>&opName=<%=opName%>&phoneNo=<%=phoneNo%>" >����һҳ�� </a> </td>
						<%}%>
						
						<%if (beginLine + pageSize < Integer.parseInt(icount)) {%>
						<td width="10%"><a href="fDetQryPrint1.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=beginLine + pageSize%>&opCode=<%=opCode%>&opName=<%=opName%>&phoneNo=<%=phoneNo%>" >����һҳ�� </a> </td>
						
						<td width="10%"><a href="fDetQryPrint1.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=(((Integer.parseInt(icount))/pageSize + ((Integer.parseInt(icount)) % pageSize == 0 ? 0 : 1)-1)*pageSize)%>&opCode=<%=opCode%>&opName=<%=opName%>&phoneNo=<%=phoneNo%>" >�����һҳ�� </a> </td>
						
						<%}%>			  
					</font>
				</tr>
      </table>
      <table width="98%" cellspacing=0>
          <tr id="footer"> 
						<td>
							&nbsp; <input class="b_foot" name=back onClick="print_detail()" type=button value="  ��  ӡ  ">
							&nbsp; <input class="b_foot" name=close onClick="removeCurrentTab();" type=button value="  ��  ��  ">
							&nbsp; <input class="b_foot" name=close onClick="gohome()" type=button value="  ��  ��  ">		 
						</td>
          </tr>
      </table>
      <%@ include file="/npage/include/footer.jsp" %>
</Form>
<script language="JavaScript">
function print_detail()
{
    var h = 800;
    var w = 1000;
    var t = screen.availHeight / 2 - h / 2;
    var l = screen.availWidth / 2 - w / 2;
    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
    var path = "sPrint1516.jsp?qryName=<%=qryName%>&outFile=<%=outFile%>&opCode=<%=opCode%>&opName=<%=opName%>";
    var ret = window.open(path, "", prop);
}
</script>

</body>
</html>

<%
/********************
 version v2.0
������: si-tech
********************/
%>
<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=GB2312" %>
<%@ page import = "javax.ejb.*" %>
<%@ page import = "com.sitech.boss.pub.*" %>
<%@ page import = "com.sitech.boss.pub.config.*" %>
<%@ page import = "com.sitech.boss.pub.conn.*" %>
<%@ page import = "com.sitech.boss.pub.exception.*" %>
<%@ page import = "com.sitech.boss.pub.util.*" %>
<%@ page import = "com.sitech.boss.pub.wtc.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*"%>
<%@ page import = "java.lang.String" %>
<%@ page import = "java.text.*" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
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
	String outFile = request.getParameter("outFile");		//���ɵ��ļ�
	String beginLineStr = request.getParameter("beginLine");	//��ȡ��ʼ��
	String icount = request.getParameter("icount");			//ͨѶ�˿�
	
%>
<html>
<head>
<title>  �����굥��ѯ</title>
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

</head>	
<body>
<table width="98%" border=0 align=center cellpadding="4" cellspacing=0>
	<tbody> 
  	<tr bgcolor="#99ccff" align="center"> 
			<td>�й��ƶ�ͨ�ſͻ������굥
			</td>
    </tr>
	</tbody> 
</table>

<table border="0" align="center" cellspacing="0">
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

<FORM method=post name="frm1500" OnSubmit=" ">
	<input type="hidden" name="outFile"  value="<%=outFile%>">

      <table width="98%" border=0 align=center cellpadding="1" cellspacing=0>
        <tbody> 
          <tr bgcolor="#99ccff" align="center"> 
           <font color="#0000FF">
		    <td width="60%"> ���� <%=(Integer.parseInt(icount))/pageSize + ((Integer.parseInt(icount)) % pageSize == 0 ? 0 : 1)%> ҳ����ǰҳΪÿ <%=beginLine/pageSize + 1%> ҳ </td>
              <%if (beginLine != 0) {%>
                  <td width="10%"><a href="f2735DetQry1.jsp?icount=<%=icount%>&outFile=<%=outFile%>&beginLine=0" >����һҳ�� </a> </td>
                  <td width="10%"><a href="f2735DetQry1.jsp?icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=beginLine - pageSize%>" >����һҳ�� </a> </td>
              <%}%>
                            
              <%if (beginLine + pageSize < Integer.parseInt(icount)) {%>
                  <td width="10%"><a href="f2735DetQry1.jsp?icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=beginLine + pageSize%>" >����һҳ�� </a> </td>
				  
				  <td width="10%"><a href="f2735DetQry1.jsp?icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=(((Integer.parseInt(icount))/pageSize + ((Integer.parseInt(icount)) % pageSize == 0 ? 0 : 1)-1)*pageSize)%>" >�����һҳ�� </a> </td>
                  
			  <%}%>			  
            </font>
          </tr>
        </tbody> 
      </table>
      <table width="98%" border=0 align=center cellpadding="4" cellspacing=0>
        <tbody> 
          <tr bgcolor="#99ccff" align="center"> 
			<td>
				&nbsp; <input class="button" name=back onClick="print_detail()" type=button value="  ��  ӡ  ">
      			&nbsp; <input class="button" name=close onClick="window.close()" type=button value="  ��  ��  ">
    		</td>
          </tr>
        </tbody> 
      </table>
</Form>
<script language="JavaScript">
function print_detail()
{
	document.frm1500.action="sPrint.jsp?qryName=\"�����굥��ѯ\"&outFile=<%=outFile%>";
  frm1500.submit();
  return true;
}
</script>

</body>
</html>

<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%request.setCharacterEncoding("GBK");%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK" %>
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
<%@ page import = "import com.sitech.common.*" %>
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
    String opCode = "4947";
    String opName = "ԭʼ�굥��ѯ";	
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
	String ip = request.getRemoteAddr();//��ȡ����ԱIP��ַ yuanqs add 2010/8/31 9:40:18 �굥��ˮӡ����
	String workNo = (String)session.getAttribute("workNo");  //����
	String islowcust = 
request.getParameter("islowcust");

 //yuanqs add 2010/8/31 9:38:50 �굥��ˮӡ����
  String str = ip + "    " + workNo;
  String imageName = ip+workNo+".jpg";
   /*String imagePath = "/iwebd1/applications/DefaultWebApp/npage/query/img/" + imageName;
  int width = 619;
	int height = 187;
	float alpha = 0.5f;
  CreateImg.drawImage(str, imagePath, width, height, alpha);*/
%>
<head>
<title>  ԭʼ�굥��ѯ-<%=qryName%></title>

<SCRIPT LANGUAGE="JavaScript">
<!--
function gohome()
{
document.location.replace("f4947_1.jsp?activePhone=<%=phoneNo%>");
}
//-->
</SCRIPT>

</head>	
<!-- yuanqs add 2010/9/13 11:03:04 -->
<body onselectstart="return false" oncontextmenu= "window.event.returnvalue=false" oncopy="return false;">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">�й��ƶ�ͨ�ſͻ�<%=qryName%>�굥</div>
		</div>
<table border="0" align="center" cellspacing="0" id="t1" style="background-image:url(img/<%=imageName%>)">
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
	<input type="hidden" name="phoneNo"  value="<%=phoneNo%>">
	<input type="hidden" name="billBegin"  value="<%=billBegin%>">
	<input type="hidden" name="billEnd"  value="<%=billEnd%>">
	<input type="hidden" name="qryType"  value="<%=qryType%>">
	<input type="hidden" name="qryName"  value="<%=qryName%>">
	<input type="hidden" name="outFile"  value="<%=outFile%>">

      <table cellspacing="0">
        <tbody> 
          <tr> 
           <font class="orange">
		    <td> ���� <%=(Integer.parseInt(icount))/pageSize + ((Integer.parseInt(icount)) % pageSize == 0 ? 0 : 1)%> ҳ����ǰҳΪÿ <%=beginLine/pageSize + 1%> ҳ </td>
              <%if (beginLine != 0) {%>
                  <td><a href="fDetQry3.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=0&phoneNo=<%=phoneNo%>" >����һҳ�� </a> </td>
                  <td><a href="fDetQry3.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=beginLine - pageSize%>&phoneNo=<%=phoneNo%>" >����һҳ�� </a> </td>
              <%}%>
                            
              <%if (beginLine + pageSize < Integer.parseInt(icount)) {%>
                  <td><a href="fDetQry3.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=beginLine + pageSize%>&phoneNo=<%=phoneNo%>" >����һҳ�� </a> </td>
				  
				  <td><a href="fDetQry3.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=(((Integer.parseInt(icount))/pageSize + ((Integer.parseInt(icount)) % pageSize == 0 ? 0 : 1)-1)*pageSize)%>&phoneNo=<%=phoneNo%>" >�����һҳ�� </a> </td>
                  
			  <%}%>			  
            </font>
          </tr>
        </tbody> 
      </table>
      <table width="98%" border=0 align=center cellpadding="4" cellspacing=0>
        <tbody> 
          <tr> 
			<td id="footer">
				&nbsp; <input class="b_foot" name=back onClick="print_detail()" type=button value="  ��  ӡ  ">
      			&nbsp; <input class="b_foot" name=close onClick="window.close()" type=button value="  ��  ��  ">
      			&nbsp; <input class="b_foot" name=close onClick="gohome()" type=button value="  ��  ��  ">
				</td>
          </tr>
        </tbody> 
      </table>
  </div>
</Form>
<script language="JavaScript">
function print_detail()
{
	var h = 800;
    var w = 1000;
    var t = screen.availHeight / 2 - h / 2;
    var l = screen.availWidth / 2 - w / 2;
    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
    var path = "sPrint.jsp?qryName=<%=qryName%>&outFile=<%=outFile%>";
    var ret = window.open(path, "", prop);
    //document.frm1500.action="sPrint.jsp?qryName=<%=qryName%>&outFile=<%=outFile%>";
    //frm1500.submit();
    return true;
}
</script>
<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>

<%
    /*************************************
    * ��  ��: ��������ͨ�굥��ѯ(��) e234
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2011-8-23
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%request.setCharacterEncoding("GB2312");%>
<%@ page import = "com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>

<script type="text/javascript" src="/npage/public/printExcel.js"></script>	
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	String opCode="e234";
    String opName="��������ͨ�굥��ѯ(��)";
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
	
	String islowcust = request.getParameter("islowcust");
	
	//yuanqs add 100712 �굥����ˮӡ
	String workNo = (String)session.getAttribute("workNo");  //����
	String ip = request.getRemoteAddr();

	 //yuanqs add 2010/8/31 9:38:50 �굥��ˮӡ����
    String str = ip + "    " + workNo;
    String imageName = ip+workNo+".jpg";
%>
<html>
<head>
<title> ��������ͨ�굥��׼��ѯ-<%=qryName%></title>
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<SCRIPT LANGUAGE="JavaScript">
function gohome()
{
	document.location.replace("fe234_main.jsp?activePhone=<%=phoneNo%>");
}
</SCRIPT>

</head>	
<body onselectstart="return false" oncontextmenu= "window.event.returnvalue=false" oncopy="return false;">
   
 <FORM method=post name="frm234q" OnSubmit=" ">
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
<table border="0" align="center" cellspacing="0" style="background-image:url(../query/img/<%=imageName%>)" name="t1" id="t1">
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
		        out.println("<tr  align='center'><td nowrap height='24'><font style='font-size:14px;font-family:����'>" + tlinetep + "</font></td></tr>");
		     }
		     
		     lineNum++;
		  } while(tline!=null);
       outBrT1.close();
	   outFrT1.close();
    %>    
</table>
      <table width="98%" border=0 align=center cellpadding="1" cellspacing=0>
        <tbody> 
         <tr> 
           <font class="orange">
		    <td> 
		    	<% 	int allPage = 0; 
        			allPage = (Integer.parseInt(icount))/pageSize + ((Integer.parseInt(icount)) % pageSize == 0 ? 0 : 1);
        			int nowPage = 0;
        			nowPage = beginLine/pageSize + 1;
        	%>
		    	���� <%=allPage%> ҳ����ǰҳΪÿ <%=nowPage%> ҳ </td>
              <%if (beginLine != 0) {%>
                  <td><a href="fDetQryPrinte234.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=0&phoneNo=<%=phoneNo%>" >����һҳ�� </a> </td>
                  <td><a href="fDetQryPrinte234.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=beginLine - pageSize%>&phoneNo=<%=phoneNo%>" >����һҳ�� </a> </td>
              <%}%>
                            
              <%if (beginLine + pageSize < Integer.parseInt(icount)) {%>
                  <td><a href="fDetQryPrinte234.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=beginLine + pageSize%>&phoneNo=<%=phoneNo%>" >����һҳ�� </a> </td>
				  
				  <td><a href="fDetQryPrinte234.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=(((Integer.parseInt(icount))/pageSize + ((Integer.parseInt(icount)) % pageSize == 0 ? 0 : 1)-1)*pageSize)%>&phoneNo=<%=phoneNo%>" >�����һҳ�� </a> </td>
                  
			  <%}%>			  
						  <td>
		          	��ת��
								<select name="toPage" id="toPage" style="width:80px" onchange="setPage(this.value);">
									<%
									String selectCtrl = "";
									for (int i = 1; i <= allPage; i ++) {
									
										if(nowPage == i){
											selectCtrl = "selected";
										}else{
											selectCtrl = "";
										}
									%>
										<option value="<%=i%>" <%=selectCtrl%> >��<%=i%>ҳ</option>
									<%
									}
									%>
								</select>
								ҳ
		          </td>
            </font>
          </tr>
        </tbody> 
      </table>
      <table width="98%" border=0 align=center cellpadding="4" cellspacing=0>
        <tbody> 
          <tr align="center"> 
			<td id="footer">
				&nbsp; <input class="b_foot" name=back onClick="print_detail()" type=button value="  ��  ӡ  ">
      			&nbsp; <input class="b_foot" name=close onClick="parent.removeCurrentTab();" type=button value="  ��  ��  ">
      			&nbsp; <input class="b_foot" name=close onClick="gohome()" type=button value="  ��  ��  ">
            	&nbsp; <input class="b_foot_long" name=save onClick="printTable(t1)" type=button value="������ǰҳ">
    		</td>
          </tr>
        </tbody> 
      </table>
      <%@ include file="/npage/include/footer.jsp" %> 
</Form>
<script language="JavaScript">
function print_detail()
{
    document.frm234q.action="sPrint.jsp?qryName=<%=qryName%>&outFile=<%=outFile%>";
    frm234q.submit();
    return true;
}

function setPage(goPage){
	if (goPage == "-1") {
		return;
	} else{
		var pageSizeVal = "<%=pageSize%>";
		var beginLineVal = pageSizeVal * (goPage - 1);
		var dirtPate = "fDetQryPrinte234.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=" + beginLineVal + "&phoneNo=<%=phoneNo%>";
		location = dirtPate;
	}
}

</script>

</body>
</html>

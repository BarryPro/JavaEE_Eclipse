<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%request.setCharacterEncoding("GBK");%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import = "com.sitech.boss.pub.util.*" %>
<%
    String opCode = "4999";
    String opName = "DSMP����ȷ�϶��Ų�ѯ";
    
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	
  String[][] result = new String[][]{};
    
	boolean billCanView = true;
	
	int iErrorNo = 0;
  String sErrorMessage = "";
%>

<%!
private static HashMap cfgMap = new HashMap(200);//���滰����ʽ
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
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String workNo = baseInfo[0][2];                         //����
	String phoneNo = request.getParameter("phoneNo");		    //�ֻ�����
  String qryType = "301";		                                //�굥����
	String qryName = "DSMP����ȷ�϶��Ų�ѯ";
	String billBegin = request.getParameter("beginTime");	  //��ʼʱ��
	String billEnd = request.getParameter("endTime");		    //����ʱ��
    String searchType = request.getParameter("searchType");
	String searchTime = request.getParameter("searchTime");
	String billTime = billBegin + "^" + billEnd + "^";      //ʱ�䴮
	String password = (String)session.getAttribute("password");
	String ipAddrss = (String)session.getAttribute("ipAddr");
	String beizhussdese="����phoneNo=["+phoneNo+"]���в�ѯ";
	String regionCode=request.getParameter("regionCode");

	if (searchType.equals("1")) {
	   billTime = searchTime;
	}

	String predictionNO = "0";
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd_HH:mm:ss").format(new java.util.Date());
	String dateStr1 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	String custName = "";       //�ͻ�����	
    String outFile = "";

%>

	
<wtc:service name="sUserCustInfo" outnum="100" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="4999" />	
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=password%>" />
			<wtc:param value="<%=phoneNo%>" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrss%>" />
			<wtc:param value="<%=beizhussdese%>" />

</wtc:service>
<wtc:array id="retArr"  scope="end"/>

<%
    //result = callRemoteResultValue.getData();
    result = retArr;
    System.out.println(retArr.length+"----retArr.length---4999");
    System.out.println(result.length+"-----result.length--4999");
	boolean haveCustName = false;
	if (result.length != 1) {
        sErrorMessage = "���û������ڣ����������룡";
	    billCanView = false;
	} 

	int icount = 0;
  String tline = null;
	File temp = null;
  if (billCanView) {
       
	   try {
       //����·��,�������ļ���
	   String paramterString = workNo + " " + phoneNo  + " " + searchType + " " + billTime + " " + predictionNO + " " ;
	   outFile = phoneNo + dateStr1 + ".txt"; 
	 	 String exePath = "/usr/bin/ksh "+ CGI_PATH +"cp4999.sh " + paramterString + DETAIL_PATH + outFile;

     Runtime.getRuntime().exec(exePath);
     } catch(IOException ioe) {
		   ioe.printStackTrace();		
	   }    	

	   //�õ�����ļ� 
  	 String txtPath = DETAIL_PATH;
  	 String totalLine = "";
	   temp = new File( txtPath,outFile);
	   int readCount=0;
	   while(!temp.exists() && readCount<60) {
		 Thread.sleep(1000);
		 readCount++;
	   };

     FileReader outFrT = new FileReader(temp);
     BufferedReader outBrT = new BufferedReader(outFrT);	
    
     do {
		 tline = outBrT.readLine();
		 icount++;
     } while(tline!=null);
	
	   outBrT.close();
	   outFrT.close();   
	}		
%>

<html>
<head>
<title>DSMP����ȷ�϶��Ų�ѯ</title>
<SCRIPT LANGUAGE="JavaScript">

function ifprint(){
	
   <% if (!billCanView) { %>           
		 rdShowMessageDialog("<%=sErrorMessage%>");
         history.go(-1); 
   <% } %>	
}

function gohome() {
   document.location.replace("f4999.jsp?activePhone=<%=phoneNo%>");
}
//-->
</SCRIPT>
</head>	
<body onload="ifprint()">

<%if (billCanView) {%>
<FORM method=post name="frm1500" OnSubmit=" ">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="phoneNo" value="<%=phoneNo%>">
	<input type="hidden" name="billBegin"  value="<%=billBegin%>">
	<input type="hidden" name="billEnd"  value="<%=billEnd%>">
	<input type="hidden" name="dateStr"  value="<%=dateStr1%>">
	<input type="hidden" name="outFile"  value="<%=outFile%>">
	
	<div class="title">
		<div id="title_zi">�й��ƶ�ͨ��DSMP����ȷ�϶���</div>
	</div>
	
	<table border="0" align="center" cellspacing="0">
    	<%
       int lineNum = 0;
       tline = null;
       int beginLine = 0;
       int pageSize = 30;
       
       FileReader outFrT1 = new FileReader(temp);
       BufferedReader outBrT1 = new BufferedReader(outFrT1);	
       
       do {
		     tline = outBrT1.readLine();
		     String tlinetep = "";
		     if (tline != null) 
		     {
				if((tline.trim().equals(""))&&(lineNum == 0))
				{
					System.out.println("�յĻ���");
					outBrT1.close();
					outFrT1.close();
					out.print("<script language=\"javascript\">") ;
					out.print("rdShowMessageDialog(\""); 
					out.print("�û�����Ϊ�գ�");
					out.println("\");");
					out.println("history.back(); ");	   				
					out.println("</script>");      
					return;      
				}
				else if((tline.indexOf("������")==-1)&&(lineNum==0))
				{
					System.out.println("��������ȷ������ʽ��˵���������汨���ˣ�");	
					outBrT1.close();
					outFrT1.close();
					out.print("<script language=\"javascript\">") ;
					out.print("rdShowMessageDialog(\""); 
					out.print(tline);
					out.println("\");");
					out.println("history.back(); ");	   				
					out.println("</script>");                 	
					return;
				
				}
				 tlinetep = tline.replaceAll(" ", "&nbsp;");
		     }
		     
		     if (lineNum < beginLine + pageSize) 
		     {
		         out.println("<tr><td align='left' nowrap>" + tlinetep + "</td></tr>");
		     }
		     
		     lineNum++;
		  } while(tline!=null);
       outBrT1.close();
	   outFrT1.close();
    	%>    
	</table>


	<table cellspacing="0">
        <tbody> 
          <tr> 
		   			<font color="orange">
		    			<td> �ܹ��� <%=(icount-1)/pageSize + ((icount-1) % pageSize == 0 ? 0 : 1)%> ҳ����ǰҳΪÿ 1 ҳ </td>
            		<%if (beginLine + pageSize < icount-1) {%>    
         					<td><a href="fDetQryDSMP_1.jsp?icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=<%=beginLine + pageSize%>&phoneNo=<%=phoneNo%>" >����һҳ�� </a> </td>
               
									<td><a href="fDetQryDSMP_1.jsp?icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=<%=((icount-1)/pageSize + ((icount-1) % pageSize == 0 ? 0 : 1)-1)*pageSize%>&phoneNo=<%=phoneNo%>" >�����һҳ�� </a> </td>
							<%}%>
            </font>
          </tr>
        </tbody> 
      </table>
      <table cellspacing=0>
        <tbody> 
          <tr> 
			<td id="footer">
				&nbsp; <input class="b_foot" name=back onClick="print_detail()" type=button value="  ��  ӡ  ">
      	&nbsp; <input class="b_foot" name=close onClick="removeCurrentTab()" type=button value="  ��  ��  ">
      	&nbsp; <input class="b_foot" name=close onClick="gohome()" type=button value="  ��  ��  ">
			</td>
          </tr>
        </tbody> 
      </table>
      <%@ include file="/npage/include/footer.jsp" %>
</Form>

<script language="JavaScript">
function print_detail()
{
	getAfterPrompt();
    document.frm1500.action="sPrint.jsp?qryName=<%=qryName%>&outFile=<%=outFile%>";
    frm1500.submit();
    return true;
}
</script>
<% } %>
</body>
</html>
<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%request.setCharacterEncoding("GBK");%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import = "com.sitech.boss.pub.util.*" %>
<%
    String opCode = "1511";
    String opName = "�ƶ������굥��ѯ";
    
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	
	//ScallSvrViewBean viewBean = new ScallSvrViewBean();//ʵ����viewBean
  //CallRemoteResultValue callRemoteResultValue = null;
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
	String passWord = request.getParameter("passWord");		  //��ѯ����
    String qryType = "6";		                                //�굥����
	String qryName = "�ƶ�����";
	String billBegin = request.getParameter("beginTime");	  //��ʼʱ��
	String billEnd = request.getParameter("endTime");		    //����ʱ��
	String in_towPassWord = request.getParameter("towPassWord");//��������
    String searchType = request.getParameter("searchType");
	String searchTime = request.getParameter("searchTime");
	String billTime = billBegin + "^" + billEnd + "^";      //ʱ�䴮

	if (searchType.equals("1")) {
	   billTime = searchTime;
	}

	/*String predictionNO = "65258723"; */                      //��ʧ��
	String predictionNO = "0";                              /*��ˮ�ţ�changed by zhangnc 20081227 ԭ����ˮ��д��*/
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd_HH:mm:ss").format(new java.util.Date()); //��ǰʱ��
	String dateStr1 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	String custName = "";       //�ͻ�����	
    String outFile = "";
    String loginAccept = "";
  	String chnSource="";
	String[] inParas = new String[]{""};
    inParas[0] = "select b.cust_name, a.cust_id, a.user_passwd from dCustMsg a, dCustDoc b where a.cust_id = b.cust_id and substr(run_code,2,1) < 'a' and a.phone_no = '" + phoneNo + "'";
    
	//callRemoteResultValue = viewBean.callService("0", null, "sPubSelect", "3", inParas);
%>
<!--  ��ȫ�ӹ̸���
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg"  outnum="3">
	<wtc:sql><%=inParas[0]%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArr" scope="end" />
-->
	      <wtc:service name="sCustTypeQryH" routerKey="phone" routerValue="<%=phoneNo%>" outnum="3" >
				<wtc:param value="<%=loginAccept%>"/>
				<wtc:param value="<%=chnSource%>"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=passWord%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value="<%=passWord%>"/>
				</wtc:service>
				<wtc:array id="retArr" scope="end"/>


<%
    //result = callRemoteResultValue.getData();
    result = retArr;
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
	   String kshString = CGI_PATH + "cp.sh" + " ";
	   String paramterString = workNo + " " + phoneNo + " " + qryType + " " + searchType + " " + billTime + " " + predictionNO + " " + dateStr + " " + "26 ";
	   outFile = phoneNo + qryType + dateStr1 + ".txt"; 
	   String exePath = "/usr/bin/ksh "+ CGI_PATH +"cp.sh " + paramterString + DETAIL_PATH + outFile + " 1 " + "YYYYYY";
       
     Runtime.getRuntime().exec(exePath);
     } catch(IOException ioe) {
		   ioe.printStackTrace();		
	   }    	

	   //�õ�����ļ� 
  	 String txtPath = DETAIL_PATH;
  	 String totalLine = "";
	   temp = new File( txtPath,outFile);
	   int readCount=0;
	   while(!temp.exists() && readCount<30) {
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
<title> �굥��ѯ-�ƶ�����</title>
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE="JavaScript">
<!--
function ifprint(){
   <% if (!billCanView) { %>           
		 rdShowMessageDialog("<%=sErrorMessage%>");
         history.go(-1); 
   <% } %>	
}

function gohome() {
   document.location.replace("s1511.jsp?activePhone=<%=phoneNo%>");
}
//-->
</SCRIPT>
</head>	
<body onload="ifprint()">

<%if (billCanView) {%>
<p align="center"><font color="#0000FF" size="5">�й��ƶ�ͨ�ſͻ��ƶ������굥</font></p>
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
		     if (tline != null) {
		        tlinetep = tline.replaceAll(" ", "&nbsp;");
		     }
		     
		     if (lineNum < beginLine + pageSize) {
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
	<input type="hidden" name="dateStr"  value="<%=dateStr1%>">
	<input type="hidden" name="outFile"  value="<%=outFile%>">
      <table width="98%" border=0 align=center cellpadding="1" cellspacing=0>
        <tbody> 
          <tr bgcolor="#99ccff" align="center"> 
		   <font color="#0000FF">
		    <td width="80%"> �ܹ��� <%=(icount-1)/pageSize + ((icount-1) % pageSize == 0 ? 0 : 1)%> ҳ����ǰҳΪÿ 1 ҳ </td>
            <%if (beginLine + pageSize < icount-1) {%>    
               <td width="10%"><a href="fDetQry2.jsp?icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=<%=beginLine + pageSize%>" >����һҳ�� </a> </td>
               
			   <td width="10%"><a href="fDetQry1.jsp?icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=<%=((icount-1)/pageSize + ((icount-1) % pageSize == 0 ? 0 : 1)-1)*pageSize%>" >�����һҳ�� </a> </td>
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
      			&nbsp; <input class="button" name=close onClick="removeCurrentTab()" type=button value="  ��  ��  ">
      		    &nbsp; <input class="button" name=close onClick="gohome()" type=button value="  ��  ��  ">
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

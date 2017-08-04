<%
/********************
 version v2.0
������: si-tech
********************/
%>
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
    String[][] result = new String[][]{};
    
	boolean billCanView = false;
	int slowcust = 0;

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
	String phoneNo = request.getParameter("phoneNo");		//�ֻ�����
	String passWord = request.getParameter("passWord");		//��ѯ����
    String qryType = request.getParameter("qryType");		//�굥����
	String qryName = request.getParameter("qryName");		//�굥����
	String billBegin = request.getParameter("beginTime");	//��ʼʱ��
	String billEnd = request.getParameter("endTime");		//����ʱ��
	String in_towPassWord = request.getParameter("towPassWord");//��������
    String searchType = request.getParameter("searchType");
	String searchTime = request.getParameter("searchTime");
	String billTime = billBegin + "^" + billEnd + "^";     //ʱ�䴮
	if (searchType.equals("1")) {
	   billTime = searchTime;
	}

	String predictionNO = "65258723";                       //��ʧ��
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd_HH:mm:ss").format(new java.util.Date()); //��ǰʱ��
	String dateStr1 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	String custName = "";       //�ͻ�����	
    String outFile = "";

	//�Ƿ��ж�������
	boolean haveTwoPassWord = false;    
	//�û�����Ķ��������Ƿ��뷵��ֵ��ͬ
    boolean isTwoPassWordTrue = false;

	boolean	bChina = true;    

	String twoPassWord = "";

	String[] inParas = new String[]{""};
  	inParas[0] = "select b.cust_name, a.cust_id, a.user_passwd from dCustMsg a, dCustDoc b where a.phone_no not in (select phone_no from dServiceCtl) and a.cust_id = b.cust_id and substr(run_code,2,1) < 'a' and a.phone_no = '" + phoneNo + "'";
  	System.out.println("inParas[0]="+inParas[0]);
  	%>
  		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>"  outnum="3">
				<wtc:sql><%=inParas[0]%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="sVerifyTypeArr" scope="end" />
  	<%
  	result = sVerifyTypeArr;
		boolean haveCustName = false;
		if (result.length == 1) {
  		if (passWord != null) {
			String tcust_passwd = "";
			try{
				tcust_passwd =  Encrypt.encrypt(passWord);
			}catch(IllegalArgumentException e){
			}
		
		    String cust_name = result[0][0];	   
		    String cust_id = result[0][1];
		    String cust_passwd = result[0][2];
        
		    if (1 == Encrypt.checkpwd2(cust_passwd,tcust_passwd)) {
		      haveCustName = true;    
		    } else {
		      sErrorMessage = "��ѯ���벻��ȷ�����������룡";    
		    }
		}else{
		     haveCustName = true;
		}
	} else {
		System.out.println("result.length != 1");
		//sErrorMessage = "���û������ڣ����������룡";
		bChina = false;
		billCanView = true;
	}
	/*�����¼��־*/
	haveCustName = true;
	bChina = true;
	
	if (haveCustName&&bChina){
		System.out.println("���������û�"+phoneNo);
	  String[] inParass = new String[2];
    inParass[0] = phoneNo;
	  inParass[1] = workNo;
    
	   //�Ƿ���Ȩ��

%>
	      <wtc:service name="s1510_writeopr" routerKey="phone" routerValue="<%=phoneNo%>" outnum="3" >
				<wtc:param value="<%=inParass[0]%>"/>
				<wtc:param value="<%=inParass[1]%>"/>
				</wtc:service>
				<wtc:array id="s1510_writeoprArr" scope="end"/>
<%


			iErrorNo = retCode==""?999999:Integer.parseInt(retCode);
			sErrorMessage = retMsg;

       if (iErrorNo == 0) {
	       result = s1510_writeoprArr;
           if (result != null) {
	          if (in_towPassWord != null) {
			     //ȡ�ö�������
			     twoPassWord = result[0][2];
                 if (!twoPassWord.equals("")) {
				    //��֤��������
				    haveTwoPassWord = true;
                 
				    if (haveTwoPassWord) {
				       isTwoPassWordTrue =(1 == Encrypt.checkpwd1(in_towPassWord,twoPassWord));
				       if (isTwoPassWordTrue) {
					      billCanView = true;
					   }						
				    }				 
		         } else {
			        billCanView = true;  
			     }
			  } else {
			     billCanView = true;
			  }
	       }
	   }  
	}

	/**/
  	inParas[0] = "select a.phone_no from dKeepSecretPhone a where a.phone_no = '" + phoneNo + "'";
  	System.out.println("inParas[0]="+inParas[0]);
  	%>
  			<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>"  outnum="3">
				<wtc:sql><%=inParas[0]%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="sVerifyTypeArr2" scope="end" />
  	<%
  	result = sVerifyTypeArr2;
	if (result.length == 1) {
		sErrorMessage= "��ѯʧ��,�������Ա��ϵ!";
		billCanView = false;
	};  
	
	int icount = 0;
  	String tline = null;
	File temp = null;
	if (billCanView) {
		System.out.println("billCanView is true");
       inParas = new String[17];
       inParas[0] = phoneNo;
	   

	   try {
       //����·��,�������ļ���
	   String kshString = CGI_PATH + "clicp.sh" + " ";
	   String paramterString = workNo + " " + phoneNo + " " + qryType + " " + searchType + " " + billTime + " " + predictionNO + " " + dateStr + " " + "26 ";
	   outFile = phoneNo + qryType + dateStr1 + ".txt";
	   String exePath = "/usr/bin/ksh "+ CGI_PATH +"clicp.sh " + paramterString + DETAIL_PATH + outFile + " " + opCode;;
	    
       Runtime.getRuntime().exec(exePath);
       } catch(IOException ioe) {
		ioe.printStackTrace();		
	   }    	

	   //�õ�����ļ� 
  	   String txtPath = DETAIL_PATH;
  	   String totalLine = "";
  	   System.out.println("ningtn == fdet 1516 + " + txtPath + " , " + outFile + " , " + CGI_PATH);
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
<title> �������굥��ѯ-<%=qryName%></title>
<SCRIPT LANGUAGE="JavaScript">
<!--

function ifprint(){
     <% if (!billCanView) { %>           
		 <% if (haveTwoPassWord) {%>
            <%if (!isTwoPassWordTrue) {%>
               <% if (in_towPassWord.equals("")) {%>
                   rdShowMessageDialog("�������벻��Ϊ�գ������룡");
                   history.go(-1);
		       <% } else {%>
                   rdShowMessageDialog("�����������벻��ȷ�����������룡");
                   history.go(-1);
               <% } %>	           
		    <% } %>	         
		 <%} else {%>
            rdShowMessageDialog("<%=sErrorMessage%>");
            history.go(-1); 
		 <% } %>	     
     <% } %>	
}

function gohome() {
   document.location.replace("f1516_1.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>");
}
//-->
</SCRIPT>
</head>	
<body onload="ifprint()">

<%if (billCanView) {%>


<FORM method=post name="frm1500" OnSubmit=" ">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="opCode" value="<%=opCode%>" />
	<input type="hidden" name="opName" value="<%=opName%>" />
	<input type="hidden" name="phoneNo"  value="<%=phoneNo%>">
	<input type="hidden" name="billBegin"  value="<%=billBegin%>">
	<input type="hidden" name="billEnd"  value="<%=billEnd%>">
	<input type="hidden" name="qryType"  value="<%=qryType%>">
	<input type="hidden" name="qryName"  value="<%=qryName%>">
	<input type="hidden" name="dateStr"  value="<%=dateStr1%>">
	<input type="hidden" name="outFile"  value="<%=outFile%>">
	<div class="title">
		<div id="title_zi">�й��ƶ�ͨ�ſͻ�<%=qryName%>�굥</div>
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
      <table width="98%" border=0 align=center cellpadding="1" cellspacing=0>
				<tr align="center"> 
					<font class="orange">
						<td> �ܹ��� <%=(icount-1)/pageSize + ((icount-1) % pageSize == 0 ? 0 : 1)%> ҳ����ǰҳΪÿ 1 ҳ </td>
						<%if (beginLine + pageSize < icount-1) {%>    
						<td><a href="fDetQryPrint1.jsp?islowcust=<%=slowcust%>&qryName=<%=qryName%>&icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=<%=beginLine + pageSize%>&opCode=<%=opCode%>&opName=<%=opName%>&phoneNo=<%=phoneNo%>" >����һҳ�� </a> </td>
						
						<td><a href="fDetQryPrint1.jsp?islowcust=<%=slowcust%>&qryName=<%=qryName%>&icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=<%=((icount-1)/pageSize + ((icount-1) % pageSize == 0 ? 0 : 1)-1)*pageSize%>&opCode=<%=opCode%>&opName=<%=opName%>&phoneNo=<%=phoneNo%>" >�����һҳ�� </a> </td>
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

function payFee() {
    document.frm1500.action="/page/s5061/f1295_1.jsp?phoneNo=<%=phoneNo%>&op_code=1526";
    frm1500.submit();
    return true;
}
</script>
<% } %>
</body>
</html>

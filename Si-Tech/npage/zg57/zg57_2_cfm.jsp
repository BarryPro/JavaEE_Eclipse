<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<%
	String opCode = "zg57";
	String opName = "������ϢͶ�߹ػ�";   
	String orgcode=(String)session.getAttribute("orgCode");
	String regionCode=(String)session.getAttribute("regCode");
	String sysAccept=request.getParameter("sysAccept");
	String workno=(String)session.getAttribute("workNo");         //����
	String loginPwd = (String)session.getAttribute("password");
	
	String remark=request.getParameter("remark");
	String sSaveName=request.getParameter("sSaveName");
	String filename=request.getParameter("filename");
	
	String loginaccept =  "";
	String shandlingtype = request.getParameter("shandlingtype"); 
	String sSourceData = request.getParameter("sSourceData"); 
	String sSourceType = request.getParameter("sSourceType"); 
	String blackReason = request.getParameter("blackReason"); 
	String v_succ_no = request.getParameter("succ_no");
	String v_err_no = request.getParameter("err_no");
	String phoneNo = "" ;
	String err_msg = "";
	int	succ_no = 0;
	int	err_no  = 0;
  
  try{
     String path=request.getRealPath("/npage/tmp/");
     File fp=new File(path,filename);
     File fp_err=new File(path,filename+".err");
     FileReader freader=new FileReader(fp);
     BufferedReader bfdreader=new BufferedReader(freader);
     
     FileWriter fwriter=new FileWriter(fp_err,true);
     BufferedWriter bfwriter=new BufferedWriter(fwriter);
     
     request.setCharacterEncoding("GBK");
     
     String str_line=bfdreader.readLine();
     while(str_line!=null) {
        //out.println(str_line);
        //out.println("<br>");
			
			phoneNo = str_line ;
			String paraStr[] = new String[11];
			paraStr[0] = "";
			paraStr[1] = "01";
			paraStr[2] = opCode;
			paraStr[3] = workno;
			paraStr[4] = loginPwd;
			paraStr[5] = phoneNo;
			paraStr[6] = "";
			paraStr[7] = sSourceType;
			paraStr[8] = sSourceData;
			paraStr[9] = "05";
			paraStr[10] = blackReason;
%>
		<wtc:service name="szg57Cfm" routerKey="region" routerValue="<%=regionCode%>" retCode="initRetCode" retMsg="initRetMsg"  outnum="3">
			<wtc:param value="<%=paraStr[0]%>"/>
			<wtc:param value="<%=paraStr[1]%>"/>
			<wtc:param value="<%=paraStr[2]%>"/>
			<wtc:param value="<%=paraStr[3]%>"/>
			<wtc:param value="<%=paraStr[4]%>"/>
			<wtc:param value="<%=paraStr[5]%>"/>
			<wtc:param value="<%=paraStr[6]%>"/>
			<wtc:param value="<%=paraStr[7]%>"/>
			<wtc:param value="<%=paraStr[8]%>"/>
			<wtc:param value="<%=paraStr[9]%>"/>
			<wtc:param value="<%=paraStr[10]%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
			if(initRetCode.equals("0")||initRetCode.equals("000000")){
				//����������
				System.out.println("���÷���sBadInfoCfm in zg57_2_cfm.jsp phone_no:["+phoneNo+"]�ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
				succ_no++;
			}else{
				err_no++;
	      //д�����ļ�
	      err_msg = phoneNo+" | "+initRetMsg ;
				bfwriter.write(err_msg,0,err_msg.length());
				bfwriter.newLine();
				bfwriter.flush();
	  	}
      str_line=bfdreader.readLine();
     }
     bfdreader.close();
     freader.close();
     
     bfwriter.close();
     fwriter.close();
  }catch(IOException e) {
     out.println("�ļ���ȡ����");
  }
%>
<HEAD><TITLE>������BOSS-������ϢͶ�߹ػ�</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript">
<!--
	function gohome(){
		document.location.replace("zg57.jsp");
	}

	function seeInformation(){
		var path = "<%=request.getContextPath()%>/npage/zg57/zg57Error.jsp?fileName=<%=filename%>";
		window.open(path,"","height=500, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	}
-->
</script>
</HEAD>
<BODY>
<FORM action="zg57_2.jsp" method=post name=form>
   <%@ include file="/npage/include/header.jsp" %>
		<table cellspacing="0">
		  <tbody> 
		  <tr> 
		    <td class="blue" width="10%" align="center">��������</td>
		    <td width="40%">������ϢͶ�߹ػ��������빦��</td>
    
		  </tr>
		  </tbody> 
		</table>
		<table cellspacing="0">
		   <tbody> 
		    <tr > 
		      <td >
		        <div align="center">������Ӳ�����ϢͶ�߹ػ����ܡ�			
					  	<br> 					

						  	�ɹ�������<%=succ_no%>��

			           	����������'<%=err_no%>'��
					   
					     <br><input class="b_foot_long" name="seeInfo" type="button" value="ʧ����Ϣ�鿴" onClick="seeInformation()">
					 </div>
		      </td>
		    </tr>
		    </tbody> 
		</table>
		<table cellspacing="0">
		  <tbody> 
		  <tr id="footer"> 
		    <td align=center bgcolor="F5F5F5" width="100%">      
		      <input class="b_foot" name="goBack" type="reset" value="����" onClick="gohome()">
		      &nbsp; 
		    </td>
		  </tr>
		  </tbody> 
		</table>
		<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>

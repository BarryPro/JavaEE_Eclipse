<%
  /* 
   * ����:�������������ܺ������ۺ�������������Ĺ��� ��ȡ�ϴ��ļ�������
   * �汾: 1.0
   * ����: 2011/05/31
   * ����: huangrong
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<%
	String orgcode=(String)session.getAttribute("orgCode");
	String regionCode=(String)session.getAttribute("regCode");
	String sysAccept=request.getParameter("sysAccept");
%>
	
<%
	String filename=orgcode.substring(0,2)+sysAccept+".txt";
	String iErrorNo="";
	String sErrorMessage=" ";
	String remark=request.getParameter("remark");
	String delayType=request.getParameter("delayType");//huangrong add ��ȡ���ڱ�־ 2011-6-29
	String sSaveName=request.getRealPath("/npage/tmp/")+"/"+filename;
		String seled = request.getParameter("seled");
	//System.out.println("seed====="+seled);

	SmartUpload mySmartUpload = new SmartUpload();
	try
	{
		mySmartUpload.initialize(pageContext);
		mySmartUpload.upload();
	}
	catch(Exception ex) {
		iErrorNo="139045";
		sErrorMessage="�����ļ������г���";
	}
	try {
		com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);
		if(!myFile.isMissing()){
			myFile.saveAs(sSaveName);
		}
	}catch(Exception ex) {
		iErrorNo="139046";
		sErrorMessage="�����ļ��洢ʱ����";
	}
	
	ArrayList arlist2=new ArrayList();
	String paraAray[]=new String[2];
	paraAray[0]=filename;
	paraAray[1]=remark;
	
	String [][] result=new String[][]{};
	String [][] result2=new String[][]{};
	String  sReturnCode="";
	int	flag=0;
%>
	<wtc:service name="sbatchDel" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
	</wtc:service>
	<wtc:array id="arlist" scope="end" />
	<%
	if(errCode.equals("0")||errCode.equals("000000")){
		result=arlist;
	}
	iErrorNo=result[0][0];
	//System.out.println("*********:'"+iErrorNo+"'");
	sErrorMessage = result[0][1];

	if(iErrorNo.equals("000000")==false)
	{
    flag=-1;
	}

  FileReader fr = new FileReader(sSaveName);
  BufferedReader br = new BufferedReader(fr);   
  String phoneText="";
  String line=null;
  String paraAray2[]=new String[2];
	paraAray2[0]=filename;
	paraAray2[1]=phoneText;
  do {
      line=br.readLine();
      if(line==null) continue;       
      if(line.trim().equals("")) continue;   
      phoneText+=line+"\n"; 
      if(phoneText.length()>=1000){
%>
				<wtc:service name="sbatchWrite" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode2" retmsg="errMsg2"  outnum="2" >
				<wtc:param value="<%=paraAray2[0]%>"/>
				<wtc:param value="<%=paraAray2[1]%>"/>
				</wtc:service>
				<wtc:array id="resultArr" scope="end" />
<%
				result2=resultArr;
				iErrorNo=result2[0][0];
				sErrorMessage = result2[0][1];
				
				if(iErrorNo.equals("000000")==false)
				{
					flag=-1;
				}
				phoneText="";
      }
  }while (line!=null);        
  br.close();
  fr.close();
%>
  <wtc:service name="sbatchWrite" routerKey="region" routerValue="<%=regionCode%>" outnum="2" >
	<wtc:param value="<%=paraAray2[0]%>"/>
	<wtc:param value="<%=paraAray2[1]%>"/>
	</wtc:service>
	<wtc:array id="resultArr3" scope="end" />
<%
	result2=resultArr3;
	iErrorNo=result2[0][0];
	sErrorMessage=result2[0][1];

	if(iErrorNo.equals("000000")==false)
	{
    flag=-1;
	}
	// �жϴ����Ƿ�ɹ�
	if(flag == 0)
	{
		System.out.println("success!");
	}
	else
	{
		System.out.println("failed, ���� !");
	}
	
%>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<SCRIPT type=text/javascript>
	function ifprint(){
<% 
	
		if(flag==0){
%>
		frm_print_invoice.submit();
<% 
		}
		else{
%>
		rdShowMessageDialog("�ļ�׼��ʧ�ܡ�<br>������룺'<%=iErrorNo%>'��<br>������Ϣ��'<%=sErrorMessage%>'��",0);
		history.go(-1);
<%
  	}
%>
	} 						
</SCRIPT>
<html>
	<body onload="ifprint()">
		<form action="f6945_3Cfm.jsp" name="frm_print_invoice" method="post">
			<INPUT TYPE="hidden" name="remark" value="<%=remark%>">
			<INPUT TYPE="hidden" name="delayType" value="<%=delayType%>">			<!--huangrong add ���ڱ�־ 2011-6-29-->
			<INPUT TYPE="hidden" name="sSaveName" value="<%=sSaveName%>">
			<INPUT TYPE="hidden" name="filename" value="<%=filename%>">
			<INPUT TYPE="hidden" name="seled" value="<%=seled%>">
		</form>
	</body>
</html>

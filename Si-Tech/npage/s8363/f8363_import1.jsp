<%
  /* 
   * ����:Ӫҵ����mac��ַ��������������Ĺ��� ��ȡ�ϴ��ļ�������
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
	String regionCode=(String)session.getAttribute("regCode");
	String sysAccept=request.getParameter("sysAccept");
%>
	
<%
	String filename=regionCode.substring(0,2)+sysAccept+".txt";
	String iErrorNo="";
	String sErrorMessage=" ";
	String remark=request.getParameter("remark");
	String sSaveName=request.getRealPath("/npage/tmp/")+"/"+filename;

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
	<wtc:service name="sbatchDel" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
	</wtc:service>
	<wtc:array id="arlist" scope="end" />
	<%
	if(null!=arlist){
		result=arlist;
		iErrorNo=result[0][0];
		sErrorMessage = result[0][1];
		
		if(!"000000".equals(iErrorNo))
		{
			flag = -1;
			System.out.println("failed-------------8363-------sbatchDel����------");
		}
		
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
				<wtc:service name="sbatchWrite" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode2" retmsg="errMsg2"  outnum="2" >
				<wtc:param value="<%=paraAray2[0]%>"/>
				<wtc:param value="<%=paraAray2[1]%>"/>
				</wtc:service>
				<wtc:array id="resultArr" scope="end" />
<%
				
				if(null!=resultArr)
				{
					result2=resultArr;
					iErrorNo=result2[0][0];
					sErrorMessage = result2[0][1];
					
					if(!"000000".equals(iErrorNo))
					{
						flag = -1;
						System.out.println("failed-------------8363-------sbatchWrite����------");
					}
					
				}
				
				phoneText="";
      }
  }while (line!=null);        
  br.close();
  fr.close();
%>
  <wtc:service name="sbatchWrite" routerKey="regionCode" routerValue="<%=regionCode%>" outnum="2" >
	<wtc:param value="<%=paraAray2[0]%>"/>
	<wtc:param value="<%=paraAray2[1]%>"/>
	</wtc:service>
	<wtc:array id="resultArr3" scope="end" />
<%
	if(null!=resultArr3)
	{
		result2=resultArr3;
		iErrorNo=result2[0][0];
		sErrorMessage=result2[0][1];
		
		if(!"000000".equals(iErrorNo))
		{
			flag = -1;
			System.out.println("failed-------------8363-------sbatchWrite����2------");
		}
		
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
		window.location="f8363_3.jsp";
<%
  	}
%>
	} 						
</SCRIPT>
<html>
	<body onload="ifprint()">
		<form action="f8363_import2.jsp" name="frm_print_invoice" method="post">
			<INPUT TYPE="hidden" name="remark" value="<%=remark%>">
			<INPUT TYPE="hidden" name="sSaveName" value="<%=sSaveName%>">
			<INPUT TYPE="hidden" name="filename" value="<%=filename%>">
		</form>
	</body>
</html>

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

	String shandlingtype = request.getParameter("shandlingtype"); 
	String sSourceData = request.getParameter("sSourceData"); 
	String sSourceType = request.getParameter("sSourceType"); 
	String blackReason = request.getParameter("blackReason"); 
	
	String filename=orgcode.substring(0,2)+sysAccept+".txt";
	String iErrorNo="000000";
	String sErrorMessage="�ϴ��ɹ�";
	int	flag=0;
	
	String remark=request.getParameter("remark");
	String sSaveName=request.getRealPath("/npage/tmp/")+"/"+filename;

	SmartUpload mySmartUpload = new SmartUpload();
	mySmartUpload.initialize(pageContext);
	try{
			mySmartUpload.setAllowedFilesList("txt,TXT");//�����ϴ�������
			mySmartUpload.upload();
	}catch(Exception e){
%>
		<SCRIPT language=javascript>
			rdShowMessageDialog("ֻ�����ϴ�.txt�����ı��ļ���", 0);
			window.location.href = "zg57.jsp";
		</script>
<%
      return;
	}
	
	try{
		com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);
		if(!myFile.isMissing()){
			myFile.saveAs(sSaveName);
		}else{
%>
			<SCRIPT language=javascript>
					rdShowMessageDialog("�ļ���ʧ���ϴ����ɹ���", 0);
					window.location.href = "zg57.jsp";
			</script>
<%
	    return;	
		}
	}catch(Exception ex){
		iErrorNo="139046";
		sErrorMessage="�����ļ��洢ʱ����";
	}
	
	if(iErrorNo.equals("000000")==false){
    flag=-1;
	}
	
	System.out.println("==============�ļ��ϴ����==========");
%>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<SCRIPT type=text/javascript>
	function ifprint(){
<%	if(flag==0){%>
			frm_print_invoice.submit();
<%  }else{%>
		  rdShowMessageDialog("�ļ�׼��ʧ�ܡ�<br>������룺'<%=iErrorNo%>'��<br>������Ϣ��'<%=sErrorMessage%>'��",0);
		history.go(-1);
<%  }%>
	} 						
</SCRIPT>
<html>
	<body onload="ifprint()">
		<form action="zg57_2_cfm.jsp" name="frm_print_invoice" method="post">
			<INPUT TYPE="hidden" name="remark" value="<%=remark%>">
			<INPUT TYPE="hidden" name="sSaveName" value="<%=sSaveName%>">
			<INPUT TYPE="hidden" name="filename" value="<%=filename%>">
			<INPUT TYPE="hidden" name="shandlingtype" value="<%=shandlingtype%>">
			<INPUT TYPE="hidden" name="sSourceData" value="<%=sSourceData%>">
			<INPUT TYPE="hidden" name="sSourceType" value="<%=sSourceType%>">
			<INPUT TYPE="hidden" name="blackReason" value="<%=blackReason%>">
		</form>
	</body>
</html>

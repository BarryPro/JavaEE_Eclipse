<%
  /* 
   * 功能:垃圾短信与网管黑名单综合受理批量导入的功能 读取上传文件的数据
   * 版本: 1.0
   * 日期: 2011/05/31
   * 作者: huangrong
   * 版权: si-tech
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
	String sErrorMessage="上传成功";
	int	flag=0;
	
	String remark=request.getParameter("remark");
	String sSaveName=request.getRealPath("/npage/tmp/")+"/"+filename;

	SmartUpload mySmartUpload = new SmartUpload();
	mySmartUpload.initialize(pageContext);
	try{
			mySmartUpload.setAllowedFilesList("txt,TXT");//允许上传的类型
			mySmartUpload.upload();
	}catch(Exception e){
%>
		<SCRIPT language=javascript>
			rdShowMessageDialog("只允许上传.txt类型文本文件！", 0);
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
					rdShowMessageDialog("文件丢失或上传不成功！", 0);
					window.location.href = "zg57.jsp";
			</script>
<%
	    return;	
		}
	}catch(Exception ex){
		iErrorNo="139046";
		sErrorMessage="上载文件存储时出错！";
	}
	
	if(iErrorNo.equals("000000")==false){
    flag=-1;
	}
	
	System.out.println("==============文件上传完成==========");
%>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<SCRIPT type=text/javascript>
	function ifprint(){
<%	if(flag==0){%>
			frm_print_invoice.submit();
<%  }else{%>
		  rdShowMessageDialog("文件准备失败。<br>错误代码：'<%=iErrorNo%>'。<br>错误信息：'<%=sErrorMessage%>'。",0);
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

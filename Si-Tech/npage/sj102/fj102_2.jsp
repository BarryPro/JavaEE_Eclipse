<%
  /*
   * 功能:6995个人任务批量订购
   * 版本: 1.0
   * 日期: 2015/06/18
   * 作者: wangwg
   * 版权: si-tech
  */
%>

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.text.SimpleDateFormat;"%>
<%@ page import="java.util.*"%>
<%
	String workno = (String)session.getAttribute("workNo");
    String workname =  (String)session.getAttribute("workName");
	String orgcode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	
	String filename = "J102"+new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())+workno+".txt";
	String iErrorNo ="";
	String sErrorMessage = " ";
	String op_code = "J102"  ;
	String remark = request.getParameter("remark");
	String sSaveName=request.getRealPath("/npage/tmp/")+"/"+filename;
	SmartUpload mySmartUpload = new SmartUpload();
	try
	{
		mySmartUpload.initialize(pageContext);
        mySmartUpload.upload();
    }
    catch(Exception ex) {
        System.out.println("上载文件传输中出错！");
        iErrorNo = "139045";
		sErrorMessage = "上载文件传输中出错！";
    }
    System.out.println("########################## abcd");
	try {
		com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);
		if (!myFile.isMissing()){
			System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ abcd QQQQQQQQQQQQQQQQQQQ "+myFile);
		    myFile.saveAs(sSaveName);
		}
    }catch(Exception ex) {
        //System.out.println("上载文件存储时出错！");
        iErrorNo = "139046";
		sErrorMessage = "上载文件存储时出错！";
    }
	
	ArrayList arlist2 = new ArrayList();
	String paraAray[] = new String[2];
	paraAray[0] = filename;
	paraAray[1] = remark;
	String [][] result = new String[][]{};
	String [][] result2 = new String[][]{};
	String  sReturnCode = "";
	int		flag = 0;
%>
	<wtc:service name="sNBossDel" routerKey="regionCode" routerValue="<%=regionCode%>" 
					retcode="errCode" retmsg="errMsg"  outnum="2" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
	</wtc:service>
	<wtc:array id="arlist" scope="end" />
<%
	
	if(errCode.equals("0")||errCode.equals("000000")){
		result = arlist;
	}
	iErrorNo = result[0][0];
	System.out.println("*********:'"+iErrorNo+"'");
	sErrorMessage = result[0][1];
	System.out.println("*********:'"+ sErrorMessage+"'");

	if (iErrorNo.equals("000000")==false)
	{
        flag = -1;
	}
	
	FileReader fr = new FileReader(sSaveName);
    BufferedReader br = new BufferedReader(fr);   
    String phoneText="";
    String line = null;
	String paraAray2[] = new String[50];
	int linenum = 0;
	do {
		line = br.readLine();
        if (line==null) continue;       
        if (line.trim().equals("")) continue;
		phoneText+=line+"\n";
		if (phoneText.length()>=1000){
			paraAray2[linenum] = phoneText;
			phoneText="";
			linenum++;
			if(linenum == 40)
			{
				String tmp = ""+linenum;
%>
				<wtc:service name="sNBossWrite" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode2" retmsg="errMsg2"  outnum="2" >
					<wtc:param value="<%=filename%>"/>
					<wtc:param value="<%=tmp%>"/>
<%
				for(int j = 0;j<linenum;j++)
				{
%>
					<wtc:param value="<%=paraAray2[j]%>"/>
<%
				}
%>
				</wtc:service>
				<wtc:array id="resultArr" scope="end" />
<%
				linenum = 0;
				result2 = resultArr;
				iErrorNo = result2[0][0];
				System.out.println("*********:'"+iErrorNo+"'");
				sErrorMessage = result2[0][1];
				System.out.println("*********:'"+ sErrorMessage+"'");
				if (iErrorNo.equals("000000")==false)
				{
					flag = -1;
				}
			}
		}
	}while (line!=null);
	br.close();
	fr.close();
	String tmp = "";
	paraAray2[linenum] = phoneText;
	linenum++;	
	tmp = "" + linenum;
%>
	<wtc:service name="sNBossWrite" routerKey="regionCode" routerValue="<%=regionCode%>" outnum="2" >
		<wtc:param value="<%=filename%>"/>
		<wtc:param value="<%=tmp%>"/>
<%
		for(int j = 0;j<linenum;j++)
		{
%>
			<wtc:param value="<%=paraAray2[j]%>"/>
<%
		}
%>
	</wtc:service>
	<wtc:array id="resultArr3" scope="end" />
<%
	result2 = resultArr3;
	iErrorNo = result2[0][0];
	System.out.println("*********:'"+iErrorNo+"'");
	sErrorMessage = result2[0][1];
	System.out.println("*********:'"+ sErrorMessage+"'");

	if (iErrorNo.equals("000000")==false)
	{
		flag = -1;
	}
%>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<SCRIPT type=text/javascript>
	function ifprint(){
<% 
		if (flag == 0){
%>
			frm_print_invoice.submit();
<% 
		}else {
%>
			rdShowMessageDialog("文件准备失败。<br>错误代码：'<%=iErrorNo%>'。<br>错误信息：'<%=sErrorMessage%>'。",0);
			history.go(-1);
<%
		}
%>
	} 						
</SCRIPT>
<html>
<body onload="ifprint()">
	<form action="fj102_3.jsp" name="frm_print_invoice" method="post">
	<INPUT TYPE="hidden" name="sSaveName" value="<%=sSaveName%>">
	<INPUT TYPE="hidden" name="filename" value="<%=filename%>">
	<INPUT TYPE="hidden" name="remark" value="<%=remark%>">
</form>
</body>
</html>

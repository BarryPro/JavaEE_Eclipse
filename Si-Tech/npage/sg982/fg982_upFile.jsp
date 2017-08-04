<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<%
  String workno = (String)session.getAttribute("workNo");
  String workname =  (String)session.getAttribute("workName");
  String orgcode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
  String sysAccept = "";
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
  sysAccept = seq;
  
  String filename = orgcode.substring(0,2)+sysAccept+".txt";
  String iErrorNo ="";
  String sErrorMessage = " ";
  String op_code = "g982"  ;
  String phone_brand = request.getParameter("phone_brand");
  String phone_type = request.getParameter("phone_type");
  String begin_time = request.getParameter("begin_time");
  String end_time = request.getParameter("end_time");
  String remark = request.getParameter("remark");
  System.out.println("diling-11--phone_brand="+phone_brand+"--phone_type="+phone_type+"--begin_time="+begin_time+"---end_time="+end_time+"--remark="+remark);
  String sSaveName=request.getRealPath("/npage/tmp/")+"/"+filename;
  SmartUpload mySmartUpload = new SmartUpload();
  try{
    mySmartUpload.initialize(pageContext);
    mySmartUpload.upload();
  }catch(Exception ex){
    System.out.println("上载文件传输中出错！");
    iErrorNo = "139045";
    sErrorMessage = "上载文件传输中出错！";
  }
  try {
    com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);
     System.out.println("diling--myFile="+myFile);
    if (!myFile.isMissing()){
      System.out.println("diling--22---");
      myFile.saveAs(sSaveName);
    }
  }catch(Exception ex) {
    System.out.println("diling--上载文件存储时出错！");
    iErrorNo = "139046";
    sErrorMessage = "上载文件存储时出错！";
  }
  ArrayList arlist2 = new ArrayList();
  String paraAray[] = new String[2];
  paraAray[0] = filename;
  paraAray[1] = remark;
  
  String [][] result = new String[][]{};
  String [][] result2 = new String[][]{};
  String sReturnCode = "";
  int	flag = 0;
	%>
  <wtc:service name="sbatchDel" routerKey="regionCode" routerValue="01"  retcode="errCode" retmsg="errMsg"  outnum="2" >
  <wtc:param value="<%=paraAray[0]%>"/>
  <wtc:param value="<%=paraAray[1]%>"/>
  </wtc:service>
  <wtc:array id="arlist" scope="end" />
	<%
	if(errCode.equals("0")||errCode.equals("000000")){
		result = arlist;
	}
	iErrorNo = result[0][0];
	sErrorMessage = result[0][1];

	if (iErrorNo.equals("000000")==false)
	{
        flag = -1;
	}

  FileReader fr = new FileReader(sSaveName);
  BufferedReader br = new BufferedReader(fr);   
  String phoneText="";
  String line = null;
  String paraAray2[] = new String[2];
  paraAray2[0] = filename;
  paraAray2[1] = phoneText;
  do{
    line = br.readLine();
    if (line==null) continue;       
    if (line.trim().equals("")) continue;   
    phoneText+=line+"\n"; 
    if(phoneText.length()>=1000){
  %>
      <wtc:service name="sbatchWrite" routerKey="regionCode" routerValue="01" retcode="errCode2" retmsg="errMsg2"  outnum="2" >
      <wtc:param value="<%=paraAray2[0]%>"/>
      <wtc:param value="<%=paraAray2[1]%>"/>
      </wtc:service>
      <wtc:array id="resultArr" scope="end" />
  <%
      result2 = resultArr;
      iErrorNo = result2[0][0];
      sErrorMessage = result2[0][1];
  
      if (iErrorNo.equals("000000")==false){
        flag = -1;
      }
      phoneText="";
    }
  }while (line!=null);        
  br.close();
  fr.close();
%>
	<wtc:service name="sbatchWrite" routerKey="regionCode" routerValue="01" outnum="2" >
	<wtc:param value="<%=paraAray2[0]%>"/>
	<wtc:param value="<%=paraAray2[1]%>"/>
	</wtc:service>
	<wtc:array id="resultArr3" scope="end" />
<%
	result2 = resultArr3;
	iErrorNo = result2[0][0];
	sErrorMessage = result2[0][1];

	if (iErrorNo.equals("000000")==false)
	{
    flag = -1;
	}
	// 判断处理是否成功
	if (flag == 0)
	{
		//System.out.println("success!");
	}
	else
	{
		//System.out.println("failed, 请检查 !");
	}
	
%>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<SCRIPT type=text/javascript>
function ifprint(){
  <%if (flag == 0){%>
    frm_print_invoice.submit();
  <%}else{%>
    rdShowMessageDialog("文件准备失败。<br>错误代码：'<%=iErrorNo%>'。<br>错误信息：'<%=sErrorMessage%>'。",0);
    history.go(-1);
  <%}%>
} 						
</SCRIPT>
<html>
  <body onload="ifprint()">
    <form action="fg982_cfm.jsp" name="frm_print_invoice" method="post">
      <INPUT TYPE="hidden" name="phone_type" value="<%=phone_type%>">
      <INPUT TYPE="hidden" name="remark" value="<%=remark%>">
      <INPUT TYPE="hidden" name="sSaveName" value="<%=sSaveName%>">
      <INPUT TYPE="hidden" name="filename" value="<%=filename%>">
      <INPUT TYPE="hidden" name="phone_brand" value="<%=phone_brand%>">
      <INPUT TYPE="hidden" name="begin_time" value="<%=begin_time%>">
      <INPUT TYPE="hidden" name="end_time" value="<%=end_time%>">
    </form>
  </body>
</html>

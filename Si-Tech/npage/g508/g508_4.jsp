<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-19 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>


<%

	String return_code="";
	String ret_msg="";
	String return_page = "g508_3.jsp";
    String opCode = "g508";
	String opName = "ѡ������С��Ȩ������";
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);	
	
	String sysAccept = request.getParameter("sysAccept");
	String strFileName = "OFFER"+sysAccept ;
	String strSaveFilePath =request.getRealPath("/npage/tmp")+"/";
	//String file = strSaveFilePath+strFileName;
	File file = new File(strSaveFilePath+strFileName);
	FileReader fileReader = new FileReader(file);
	BufferedReader bufferReader = new BufferedReader(fileReader);
	
	String oneLine = "";
	String strStr = "";
	int line = 0;
	try
	{
		
		while( ((oneLine = bufferReader.readLine()) != null) && line<=300)
		{
			oneLine = oneLine.substring(0,oneLine.lastIndexOf("|"));
			strStr+=oneLine;
			strStr+=",";	
			line++;		
		}
	}catch(FileNotFoundException ex)
	{
		System.out.println(ex);
		ex.printStackTrace();
	}
	catch(Exception ex)
	{
		System.out.println(ex);
		ex.printStackTrace();
	}
	finally {
        if (bufferReader != null) {
            try
            {
                bufferReader.close();
				fileReader.close();
				//flle.close();
            }catch (IOException ex) 
            {
            	System.out.println(ex);
				ex.printStackTrace();
            }
        }
     }
    if(line > 200)
    {
%>
	 <script language="javascript">
		  rdShowMessageDialog("У��ʧ���������ݴ���200������");
		  history.go(-1);
	 </script>
<%   
    }
	if(strStr.length()>0)
	{
		strStr = strStr.substring(0,strStr.length()-1);
	}

	String [] inParas = new String[3];
	inParas[0]  = workno;
	inParas[1]  = opCode;
	inParas[2]  = strStr;
%>
	<wtc:service name="bs_g5082Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%	
   return_code = retCode;
   ret_msg = retMsg;
   
%>
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">

<body >
  <%	
	if (return_code.equals("000000"))
	{	
%>	
 <script language="javascript">
	  rdShowMessageDialog("ѡ������С��Ȩ������У��ɹ���");
	  window.location.href="<%=return_page%>"+"?sysAccept="+"<%=sysAccept%>"+"&flag2=1";
//	  history.go(-1);
 </script>


<%
}else{
%>
 <script language="javascript">
	  rdShowMessageDialog("<%=retMsg%>");
//	  window.location.href="<%=return_page%>";
	  history.go(-1);
 </script>
<%}
%>
</body></html>
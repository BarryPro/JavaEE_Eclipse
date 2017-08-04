<%
/********************
version v2.0
开发商: si-tech
update:zhangnc@2009-07-21 补充生成电子托收单
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

	String opCode = request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");	

	//托收年月
	String TPrintDate = request.getParameter("TPrintDate");
	//工号
	String workno =  request.getParameter("WorkNo");
	
	//取合同号    
	String DataCon0 = request.getParameter("TContract1");  
	String DataCon1 = request.getParameter("TContract2");  
	String DataCon2 = request.getParameter("TContract3");  
	String DataCon3 = request.getParameter("TContract4");  
	String DataCon4 = request.getParameter("TContract5");  
	String DataCon5 = request.getParameter("TContract6");  
	String DataCon6 = request.getParameter("TContract7");  
	String DataCon7 = request.getParameter("TContract8");  
	String DataCon8 = request.getParameter("TContract9");    
	String DataCon9 = request.getParameter("TContract10");   
	//取金额    
	String DataMon0 = request.getParameter("Money1");     
	String DataMon1 = request.getParameter("Money2");     
	String DataMon2 = request.getParameter("Money3");     
	String DataMon3 = request.getParameter("Money4");     
	String DataMon4 = request.getParameter("Money5");     
	String DataMon5 = request.getParameter("Money6");     
	String DataMon6 = request.getParameter("Money7");     
	String DataMon7 = request.getParameter("Money8");     
	String DataMon8 = request.getParameter("Money9");     
	String DataMon9 = request.getParameter("Money10");        
	//初始化     	
	String[] str = new String[10];   
	String CountNo="";
	
	//拼串
	if((DataCon0!=null && !DataCon0.equals("")) && (DataMon0!=null && !DataMon0.equals(""))){
		str[0] = TPrintDate+"|"+DataCon0+"|"+workno+"|"+DataMon0;}
	if((DataCon1!=null && !DataCon1.equals("")) && (DataMon1!=null && !DataMon1.equals(""))){
		str[1] = TPrintDate+"|"+DataCon1+"|"+workno+"|"+DataMon1;}
	if((DataCon2!=null && !DataCon2.equals("")) && (DataMon2!=null && !DataMon2.equals(""))){
		str[2] = TPrintDate+"|"+DataCon2+"|"+workno+"|"+DataMon2;}
	if((DataCon3!=null && !DataCon3.equals("")) && (DataMon3!=null && !DataMon3.equals(""))){
		str[3] = TPrintDate+"|"+DataCon3+"|"+workno+"|"+DataMon3;}
	if((DataCon4!=null && !DataCon4.equals("")) && (DataMon4!=null && !DataMon4.equals(""))){
		str[4] = TPrintDate+"|"+DataCon4+"|"+workno+"|"+DataMon4;}
	if((DataCon5!=null && !DataCon5.equals("")) && (DataMon5!=null && !DataMon5.equals(""))){
		str[5] = TPrintDate+"|"+DataCon5+"|"+workno+"|"+DataMon5;}
	if((DataCon6!=null && !DataCon6.equals("")) && (DataMon6!=null && !DataMon6.equals(""))){
		str[6] = TPrintDate+"|"+DataCon6+"|"+workno+"|"+DataMon6;}
	if((DataCon7!=null && !DataCon7.equals("")) && (DataMon7!=null && !DataMon7.equals(""))){
		str[7] = TPrintDate+"|"+DataCon7+"|"+workno+"|"+DataMon7;}
	if((DataCon8!=null && !DataCon8.equals("")) && (DataMon8!=null && !DataMon8.equals(""))){
		str[8] = TPrintDate+"|"+DataCon8+"|"+workno+"|"+DataMon8;}
	if((DataCon9!=null && !DataCon9.equals("")) && (DataMon9!=null && !DataMon9.equals(""))){
		str[9] = TPrintDate+"|"+DataCon9+"|"+workno+"|"+DataMon9;}


	//String[][] result = new String[][]{};
    
	String[] inParas = new String[11];
	int i,j;
	for(i=0,j=0;;)
	{
		if(str[j]!=null)
		{
			inParas[i]=str[j];
			i++;
			j++;		
			if(j==10)
				break;
		}
		else
		{

			j++;
			if(j==10)
				break;
			continue;		
		}

	}
	CountNo=""+i;
	inParas[10] = CountNo;
	
	//callRemoteResultValue = viewBean.callService("0",null, "s4426Cfm", "3", inParas);
%>
	<wtc:service name="s4426Cfm" retcode="retCode1" retmsg="retMsg1" outnum="3" >
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>		
		<wtc:param value="<%=inParas[5]%>"/>
		<wtc:param value="<%=inParas[6]%>"/>
		<wtc:param value="<%=inParas[7]%>"/>
		<wtc:param value="<%=inParas[8]%>"/>
		<wtc:param value="<%=inParas[9]%>"/>
		<wtc:param value="<%=inParas[10]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
	
<%  
	String errorCode = "";
	String errorMsg = "";
	String file_path = "";
	int resultSize = result.length;
	if (resultSize != 0) {
		errorCode = result[0][0];
		errorMsg = result[0][1];
		file_path = result[0][2];
	}
%>
<%if(resultSize == 0){%>
<script language="JavaScript">
	rdShowMessageDialog("补做托收失败！",0);
	history.go(-1);
</script>
<%}%>

<%if(!errorCode.equals("000000")){%>
<script language="JavaScript">
	rdShowMessageDialog("补做托收失败，错误代码:<%=errorCode%><%=errorMsg%>。",0);
	history.go(-1);
</script>
<%}else{%>
	<script language="JavaScript">
		rdShowMessageDialog("操作成功,文件位置及名称:<%=file_path%>。",2);
		window.location.href="s4426.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
	</script>
<%}%>

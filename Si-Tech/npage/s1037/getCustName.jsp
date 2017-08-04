<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
 
<%
    String opCode = "d510";
    String opName = "PBX信息录入";
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
    response.setDateHeader("Expires", 0); 
%>
<%
    String custid = request.getParameter("custid");
	 

	String sql = " select unit_name from dgrpcustmsg where cust_id =? ";
	 
%>
<wtc:pubselect name="TlsPubSelCrm" retcode="retCode1" retmsg="retMsg1" outnum="4">
	<wtc:sql><%=sql%></wtc:sql>
	<wtc:param value="<%=custid%>"/>
 
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%
 	
%>
	<%
	  System.out.println("11111111111111111sql  sql is "+sql);
	 if(result==null||result.length==0)
	{   
	 %>
 	    <SCRIPT LANGUAGE="JavaScript">
	    <!--
	         window.close();
	    //-->
	    </SCRIPT>
	<%
		
	}
	else if ( result.length==1 )
	{ 
 %>      	       
           <SCRIPT LANGUAGE="JavaScript">
             <!--
             
 window.returnValue="<%=result[0][0].trim()%>";	
			  window.close(); 

             //-->
             </SCRIPT>  
<%   
    }
			


%>

 


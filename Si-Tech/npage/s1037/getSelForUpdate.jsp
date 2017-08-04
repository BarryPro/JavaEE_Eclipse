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
	 

	String sql = " select to_char(zjx_num),account_rate,to_char(PBX_LINE_NUM),to_char(PBX_REAL_NUM),to_char(RENT_FEE),to_char(FUNC_FEE) from DPBX_GROUPINFO where cust_id =? and total_date = to_char(add_months(sysdate,-1),'YYYYMM')";
	 
%>
<wtc:pubselect name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:sql><%=sql%></wtc:sql>
	<wtc:param value="<%=custid%>"/>
 
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%
 	
%>
	<%
	//  System.out.println("11111111111111111sql  sql is "+sql);
	 if(result==null||result.length==0)
	{   
	 %>
 	    <script language="javascript">
	   
	    //rdShowMessageDialog("没有相关记录！");   
	    // alert("没有找到相关记录！");   
		window.close();
	    
	    </script>
	<%
		
	}
	else if ( result.length==1 )
	{ 
 %>      	       
           <SCRIPT LANGUAGE="JavaScript">
             <!--
           //  alert("d 01 is "+"<%=result[0][1].trim()%>");
 window.returnValue="<%=result[0][1].trim()%>";	
 //window.returnValue1="<%=result[0][1].trim()%>";
			  window.close(); 
 
             //-->
             </SCRIPT> 
 
<%   
    }
			


%>

 


 


<%
    /*************************************
    * ��  ��: 4A������¼��(����) e267 
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2011-9-16
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String regionCode= (String)session.getAttribute("regCode");
    String workNo = (String)session.getAttribute("workNo");
    String workNoOperated = request.getParameter("workNoOperated");
	String retCode = "";
	String retMsg = "";
	String[][] result = new String[][]{};
	String strSql2 = "select login_no,login_name from dloginmsg  where  vilid_flag = '1' and login_no='"+workNoOperated+"'";
    try{
        System.out.println("--------------e272  ��ѯ��������    begin----------------------");
%>
  <wtc:pubselect name="sPubSelect" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2">
        <wtc:sql><%=strSql2%></wtc:sql>         
    </wtc:pubselect>
    <wtc:array id="result1" scope="end"/> 
   	<%
       	result = result1;
       	retCode = retCode2;
       	retMsg = retMsg2;
       	}catch(Exception e){
       	   System.out.println("--------e272------error--------------");
       	}
       	  int leng =  result.length ;
       	  System.out.println("--------------e272  ��ѯ��������    end------------------------");
   	%>


   	<%
	if(!retCode.equals("000000"))
	{
	  %>
	   <script language="javascript">
	      rdShowMessageDialog("������Ϣ��<%=retMsg%><br>������룺<%=retCode%>", 0);
      	    window.location.href = "fe267_main.jsp?opCode=e267&opName=4A������¼��";
	   </script>
	  <%
	}else if(0 == leng){
		%>
			<script language="javascript">
	      rdShowMessageDialog("û�з��������Ĺ���", 0);
      	    window.location.href = "fe267_main.jsp?opCode=e267&opName=4A������¼��";	
	   	</script>
		<%
	}else{  
      	   %>
		<td  class="blue" >
			�������� : 
		</td>
		<td >
			<%=result[0][1]%>
		</td>
		<input type="hidden" id="operateWorkNo" name="operateWorkNo" value="<%=result[0][0]%>" />
   <%
	}
	%>

      	

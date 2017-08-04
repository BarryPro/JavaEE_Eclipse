<%
    /*************************************
    * 功  能: 4A白名单录入(单个) e267 
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-9-16
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
        System.out.println("--------------e272  查询单个工号    begin----------------------");
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
       	  System.out.println("--------------e272  查询单个工号    end------------------------");
   	%>


   	<%
	if(!retCode.equals("000000"))
	{
	  %>
	   <script language="javascript">
	      rdShowMessageDialog("错误信息：<%=retMsg%><br>错误代码：<%=retCode%>", 0);
      	    window.location.href = "fe267_main.jsp?opCode=e267&opName=4A白名单录入";
	   </script>
	  <%
	}else if(0 == leng){
		%>
			<script language="javascript">
	      rdShowMessageDialog("没有符合条件的工号", 0);
      	    window.location.href = "fe267_main.jsp?opCode=e267&opName=4A白名单录入";	
	   	</script>
		<%
	}else{  
      	   %>
		<td  class="blue" >
			工号名称 : 
		</td>
		<td >
			<%=result[0][1]%>
		</td>
		<input type="hidden" id="operateWorkNo" name="operateWorkNo" value="<%=result[0][0]%>" />
   <%
	}
	%>

      	

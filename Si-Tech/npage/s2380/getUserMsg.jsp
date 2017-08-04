<%
/********************
 version v2.0
开发商: si-tech
*
*create:zhangss@2010-07-12 页面
*
********************/
%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
	String opCode = "b040";
  String opName = "综合信息查询用户信息查询";
  

	String phoneNo=request.getParameter("phoneNo");
  System.out.println("--------zss---------"+phoneNo);
	String qrySql = "select b.cust_name,to_char(a.id_no),a.run_code,substr(a.open_time,0,8)  from dCustMsg a,dcustdoc b where phone_no='"+phoneNo+"'  and a.cust_id=b.cust_id" ;
	//ArrayList custConMsg = co.spubqry32("5",qrySql); 
%>
	<wtc:pubselect name="TlsPubSelBoss"  outnum="4">
	<wtc:sql><%=qrySql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%	

 if(result==null||result.length==0){
%>
	<script language="javascript">
		window.returnValue=0;
		window.close();
		
	</script>
<%
		
	}

%>

<HTML>
	<HEAD>
		<TITLE>客户-帐户对应关系</TITLE>
	</HEAD>
<body>

<FORM method=post name="f1500_custuser">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">用户信息展示&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
		</div>
  <TABLE id="mainTable" cellspacing="0">
    <TBODY>
      <TR align="center"> 
        <th>客户名称</th>
        <th>用户ID</th>
        <th>用户状态</th>
        <th>开户日期</th>
        
      </TR>
<%	   
			String tbClass="";   
			for(int y=0;y<result.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
%>
	        <tr align="center">
<%	        
				for(int j=0;j<result[0].length;j++){
%>
	          <td class="<%=tbClass%>"><%= result[y][j]%>&nbsp;</td>
<%	        
				}
%>
	        </tr>
<%	      
		}
%>
    </TBODY>
  </TABLE>
          
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
    	     
    	      &nbsp; <input class="b_foot" name=back onClick="window.close()" type=button value=关闭>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
      <%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>

<%
/********************
 version v2.0
开发商: si-tech
*
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
  System.out.println("------------------------------------zss------------------------------------");
	String opCode = "7549";
	String opName="客户费用冲销明细查询结果";
	String phone_no  = request.getParameter("phoneNo");
	
	String[][] result = new String [][]{};
	
	String paraAray[] = new String[1];
  paraAray[0] = phone_no;
%>
<wtc:service name="sVWResultQuery" outnum="14">
	<wtc:params value="<%=paraAray%>"/>
</wtc:service>
<wtc:array id="result1" scope="end" />

<%
	result = result1;
%>

<HTML><HEAD><TITLE>客户费用冲销明细查询结果</TITLE>
</HEAD>
<body>
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">客户费用冲销明细查询结果</div>
		</div>
    <TABLE cellSpacing="0">
<%
  System.out.println("------------------------------------"+result[0][0]);
	if(result[0][0].equals("000000")){
%>
      <TBODY>
        <TR >
          <th>用户号码</th>
          <th>用户姓名</th>
		      <th>帐户号码</th>
		      <th>预存款类型</th>
          <th>预存款名称</th>
          <th>一级账目项</th>
		      <th width="70">二级账目项  </th>
          <th>应收费用</th>
          <th>优惠费用</th>
          <th>当月划拨</th>
          <th>当前可用余额</th>
          <th>当前欠费金额</th>
        </TR>
<%	    
	
			String tbClass="";
			String temp="";
		  for(int y=0;y<result.length;y++){
		  		if(y%2==0){
			  		tbClass="Grey";
			  	}else{
			  		tbClass="";	
			  	}
%>
	        <tr align="center">
<%    	        
				for(int j=2;j<result[y].length;j++){
						System.out.println(result[y][j]);
						if(result[y][j]==null)
					{
					  
					%>
						 <td class="<%=tbClass%>"><%=temp.trim()%></td>
          <%
        
        }
        else
        {
        
%>
	          
	          <td class="<%=tbClass%>"><%=(result[y][j].trim())%></td>
<%	        
        }
				}
%>
	        </tr>
<%	      
			}
	}else if(result[0][0].equals("000001")){
%>
	<TBODY>
         <tr align="center">
          <th>用户号码</th>
          <th>用户姓名</th>
		  <th>帐户号码</th>
		  <th>预存款类型</th>
          <th>预存款名称</th>
          <th>一级账目项</th>
		  <th>二级账目项</th>
          <th>应收费用</th>
          <th>优惠费用</th>
            <th>当月划拨</th>
          <th>当前可用余额</th>
          <th>当前欠费金额</th>
        </TR>
   </TBODY>
<%
	}else{
%>
	<tr>
		<td align = "center"> <font color="red">错误代码：<%=result[0][0]%>&nbsp;&nbsp;&nbsp;错误信息：<%=result[0][1]%></font></td>	
	</tr>

        </TBODY>
<%
	}
%>
	    </TABLE>
          
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp;
    	      &nbsp; <input class="b_foot" name=back onClick="window.close()" type=button value=关闭>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
   </DIV>
</DIV>
</FORM>
</BODY></HTML>

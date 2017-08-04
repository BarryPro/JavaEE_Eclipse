<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">   
<!-------------------------------------------->
<!---日期   2008-7-7                     	---->
<!---作者   zhouzy                        ---->
<!---代码   f1500_qryCnttCfm           		---->
<!---功能   客户统一接触查询          		---->
<!-------------------------------------------->  	
<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
	String phoneNo  = request.getParameter("phoneNo");
	String workNo  = request.getParameter("workNo");
	String orgCode=request.getParameter("orgCode");
	String chnCode  = "01";
	String querylogin  = "aaaaxp";
	String op_code=request.getParameter("op_code");
	//String beginDateStr=request.getParameter("beginDateStr");
	//String endDateStr=request.getParameter("endDateStr");
	
   String opCode = "3794";
	String opName="接触关联信息查询";
%>
<wtc:service name="sQryCnttInfo" outnum="8" >
  	<wtc:param value="<%=phoneNo%>"/>
  	<wtc:param value="<%=chnCode%>"/>
 	<wtc:param value="<%=querylogin%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>	
<%	
	if(!retCode.equals("000000")){
%>
<script language="JavaScript">
	rdShowMessageDialog("<%=retMsg%>!",0);
	history.go(-1);
</script>
<%
return;	
}
System.out.println("_________________________________________________________________________");
	    for(int i=0;i<result.length;i++){
	      for(int j=0;j<result[i].length;j++){
	      System.out.println("############################result["+i+"]["+j+"]"+"   "+result[i][j]);
	      
	      }
	    
	    
	    }
System.out.println("_________________________________________________________________________");
if (result.length==0)
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("没有符合条件的数据!",0);
	history.go(-1);
</script>
<%
return;
}
%>
<HTML><HEAD><TITLE>客户统一接触查询</TITLE>
</HEAD>
<body>
<%@ include file="/npage/include/header.jsp" %>
 <div class="title"><div id="title_zi">接触关联信息查询</div></div>
    <TABLE cellSpacing=0>
       <tr align="center">
        <th>接触ID</th>
        <th>业务类型代码</th>
        <th>业务类型名称</th>
        <th>操作标识</th>
        <th>业务操作结果</th>
        <th>业务操作时间</th>
        <th>备注</th>
        <th>业务处理号码</th>
     	</tr>
     	<%for(int i=0;i<result.length;i++){%>
     		<tr>
     	
				<td class="Grey"><%=result[i][0]%></td>
				<td class="Grey"><%=result[i][1]%></td>
				<td class="Grey"><%=result[i][2]%></td>
				<td class="Grey"><%=result[i][3]%></td>
				<td class="Grey"><%=result[i][4]%></td>
				<td class="Grey"><%=result[i][5]%></td>
				<td class="Grey"><%=result[i][6]%></td>
				<td class="Grey"><%=result[i][7]%></td>
				
				
    	</tr>	
     	<%}%>	
     	</table>
     	<TABLE cellSpacing=0>
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
    	      &nbsp; <input class="b_foot" name=back onClick="parent._exttabref.removeTab('<%=opCode%>')" type=button value=关闭>
    	      &nbsp; 
    	    </td>
          </tr>
      </table>
<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>


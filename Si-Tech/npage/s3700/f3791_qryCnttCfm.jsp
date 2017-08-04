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
	String sContactId  = request.getParameter("sContactId");
	String beginDateStr=request.getParameter("beginDateStr");
	String endDateStr=request.getParameter("endDateStr");
	if(!beginDateStr.equals("")||beginDateStr!=null){
	beginDateStr=beginDateStr.substring(0,4)+beginDateStr.substring(5,7)+beginDateStr.substring(8);
	}
	if(!endDateStr.equals("")||endDateStr!=null){
	endDateStr=endDateStr.substring(0,4)+endDateStr.substring(5,7)+endDateStr.substring(8);
	}
	String opCode = "3791";
	String opName="接触轨迹查询";	
%>
<wtc:service name="sQryCnttTrack" outnum="9" >
  	<wtc:param value="<%=sContactId%>"/>	
  	<wtc:param value="<%=beginDateStr%>"/>	
  	<wtc:param value="<%=endDateStr%>"/>	
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
    <TABLE cellSpacing=0>
       <tr align="center">
        <th>接触ID</th>
        <th>业务流水标识</th>
        <th>轨迹标识</th>
        <th>接触轨迹类型</th>
        <th>接触轨迹内容</th>
        <th>IVR节点编号</th>
        <th>用户按键时间</th>
        <th>用户操作轨迹简要</th>
        <th>备注</th>
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
				<td class="Grey"><%=result[i][8]%></td>
     			

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


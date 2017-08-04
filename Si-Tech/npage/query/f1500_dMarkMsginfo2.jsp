<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-13 页面改造,修改样式
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "1500";
  String opName = "可兑换积分信息";
	
	String regionCode =  (String)session.getAttribute("regCode");
	String phoneNo  = request.getParameter("phone_no");
	String nianyue  = request.getParameter("nianyue");
	
	String orgCode = (String)session.getAttribute("orgCode");
	String work_no=(String)session.getAttribute("workNo");
	String workPwd = (String)session.getAttribute("password");
	%>
	<wtc:service name="sMarkPrepay" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="10" >
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=nianyue%>"/>		
	<wtc:param value="<%=work_no%>"/>
	<wtc:param value="<%=workPwd%>"/>

	</wtc:service>
	<wtc:array id="result2" scope="end" />

<%	

		if(!retCode1.equals("000000")) {
%>
	<script language="javascript">
		rdShowMessageDialog("调用sMarkPrepay查询失败,错误代码:<%=retCode1%><br>错误信息:<%=retMsg1%>!");
		window.close();
	</script>
<%
		return;
	}
%>


<HTML><HEAD><TITLE>查询信息</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_dMarkMsg">
	<%@ include file="/npage/include/header.jsp" %> 
		<div class="title">
			<div id="title_zi">查询信息</div>
		</div>

			<br>
    <table cellspacing="0">
    	<tbody>
        <tr align="center"> 

	        <th>账单金额(元)</th>
	        <th>自交费(元)</th>
	        <th>移动赠送(元)</th>

	      </tr>
		<%
			String tbClass="";
			for(int y=0;y<result2.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
		%>
						<tr align="center">
						<td class="<%=tbClass%>"><%=result2[y][4]%></td>
						<td class="<%=tbClass%>"><%=result2[y][2]%></td>
						<td class="<%=tbClass%>"><%=result2[y][3]%></td>
		</tr>
		<%
		    }
		%>
	</table>

      
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">

					&nbsp; <input class="b_foot" name=back onClick="window.close()" type=button value=关闭>
	    </td>
          </tr>
        </tbody> 
      </table>
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>
     
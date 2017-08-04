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
	String phoneNo  = request.getParameter("phoneNo");
	//phoneNo  ="13936181264";//13703633753 13936181264 13503637388
	String orgCode = (String)session.getAttribute("orgCode");
	String work_no=(String)session.getAttribute("workNo");
	%>
	<wtc:service name="sCoventQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="9" >
	<wtc:param value="0"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=work_no%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="result" scope="end"  start="0"  length="4"/>
	<wtc:array id="result2" scope="end"  start="4"  length="3"/>
	<wtc:array id="result3" scope="end"  start="7"  length="1"/>
	<wtc:array id="result4" scope="end"  start="8"  length="1"/>
<%	
	int iretCode=999999; 
	
	if(retCode1!=null&&!"".equals(retCode1)){
		iretCode=Integer.parseInt(retCode1);
	}
	if(iretCode!=0){
%>
	<script language="javascript">
		rdShowMessageDialog("服务未能成功,服务代码:<%=retCode1%><br>服务信息:<%=retMsg1%>!");
		history.go(-1);
	</script>
<%
		return;
	}else if(result==null||result.length==0){
%>
	<script language="javascript">
		rdShowMessageDialog("查询结果为空,积分生成记录不存在!");
		history.go(-1);
	</script>
<%
		return;
	}
%>


<HTML><HEAD><TITLE>可兑换积分信息</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_dMarkMsg">
	<%@ include file="/npage/include/header.jsp" %> 
		<div class="title">
			<div id="title_zi">可兑换积分信息</div>
		</div>
		<table>
			<tr>
				
				<td class="blue">客户号码</td><td><%=result[0][2]%></td>
				<td class="blue">客户品牌</td><td><%=result[0][3]%></td> 
			</tr>

			<table>
			<br>
    <table cellspacing="0">
    	<tbody>
        <tr align="center"> 

	        
	        <th>积分类型名称</th>
			<th>积分值</th>
			<th>到期日</th>
			
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
						<td class="<%=tbClass%>"><%=result4[y][0]%></td>
						<td class="<%=tbClass%>"><%=result2[y][1]%></td>
						<td class="<%=tbClass%>"><%=result2[y][2]%></td>  
		</tr>
		<%
		    }
		%>
		<tr>
			<td align="center">用户当前可用积分值</td>
			<td colspan="5"><%=result3[0][0]%></td>
		</tr>
	</table>

      
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
				<%
				String fromKF=request.getParameter("fromKF");
				if ( !fromKF.equals("Y") )
				{
				%>
				&nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
				&nbsp; <input class="b_foot" name=back onClick="parent.removeTab(<%=opCode%>)" type=button value=关闭>
				<%
				}
				else
				{%>
					&nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
					&nbsp; <input class="b_foot" name=back onClick="window.close()" type=button value=关闭>
				<%}
				%>    	    </td>
          </tr>
        </tbody> 
      </table>
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>
     
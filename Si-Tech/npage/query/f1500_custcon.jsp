<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-12 页面改造,修改样式
*
********************/
%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "1500";
	String opName = "综合信息查询之客户-帐户对应关系";
  
	String orgCode = (String)session.getAttribute("orgCode");
	String region_code = orgCode.substring(0,2);
	String cust_id=request.getParameter("custId");
	String cust_name=request.getParameter("custName");
	String work_no=request.getParameter("workNo");
	String recodeIDd=request.getParameter("recodeIDd");
	String work_name=request.getParameter("workName");
	String pwdcheck = request.getParameter("pwdcheck");
	String nopass = (String)session.getAttribute("password");
	/*
	if(pwdcheck=="Y" ||pwdcheck.equals("Y"))
	{
		System.out.println("证明通过了密码校验，或者工号免密，展示全部信息");
	}
	if(pwdcheck=="N" ||pwdcheck.equals("N"))
	{
		System.out.println("证明未通过了密码校验，展示部分信息");
	}*/
 
	//ArrayList custConMsg = co.spubqry32("5",qrySql); 
%>

<!--xl add for 替换原查询 sCustTypeQryE -->
<wtc:service name="sCustTypeQryE" routerKey="region" routerValue="<%=region_code%>"  retcode="retCode1" retmsg="retMsg1" outnum="5">
			<wtc:param value="0"/>
			<wtc:param value="01"/>
			<wtc:param value="1500"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=nopass%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=cust_id%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>

	 
<%	
	if(!retCode1.equals("000000")){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("服务未能成功,服务代码:<%=retCode1%><br>服务信息:<%=retMsg1%>!");
	</script>
<%
		return;
	}else if(result==null||result.length==0){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("查询结果为空,客户-帐户对应关系不存在!");
	</script>
<%
		return;
	}
%>

<HTML>
	<HEAD>
		<TITLE>客户-帐户对应关系</TITLE>
		<script language="javascript">
	$(document).ready(function(){
		try{
			parent.parent.oprInfoRecode('','','','',"<%=recodeIDd%>");
		}catch(e){
		}
	});
</script>		
	</HEAD>
<body>

<FORM method=post name="f1500_custuser">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">客户-帐户对应关系&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

			</div>
		</div>
  <TABLE id="mainTable" cellspacing="0">
    <TBODY>
      <TR align="center"> 

        <th>客户ID</th>
        <th>帐户ID</th>
        <th>开始时间</th>
        <th>结束时间</th>
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
			  //xl add 密码校验
 	
			  
			  for(int j=1;j<result[0].length;j++){
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
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
      <%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>

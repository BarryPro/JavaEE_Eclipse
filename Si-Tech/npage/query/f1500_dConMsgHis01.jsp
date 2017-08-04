<%
/********************
 version v2.0
开发商: si-tech
功能:综合信息查询之帐户历史信息
update:liutong@2008-8-13
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	//输入参数 用户ID、手机号码、操作工号、操作员、角色、部门
	 String opCode = "1500";
	 String opName = "综合信息查询之帐户历史信息";
	
	String contract_no  = request.getParameter("contractNo");
	String bank_cust  = request.getParameter("bankCust");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
   

   
	//xl add for zlc
	String pwdcheck = request.getParameter("pwdcheck");
	//pwdcheck="N";
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAA 1500 pwdcheck is "+pwdcheck+" and bankCust is "+bank_cust);
	
	String inLoginAccept="0";
	String inChnSource="01";
	String inOpCode="1500";
	String inLoginNo=work_no;
	String inLoginPwd = (String)session.getAttribute("password"); 
	String inPhoneNo = "";
	String inUserPwd="";
	
 
	String inOpNote="帐号"+contract_no+"进行1500下帐户历史信息查询";
	String s_flag="3";
%>

<wtc:service name="sCustTypeQryJ" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="5">
	<wtc:param value="<%=inLoginAccept%>"/>
	<wtc:param value="<%=inChnSource%>"/>	
	<wtc:param value="<%=inOpCode%>"/>
	<wtc:param value="<%=inLoginNo%>"/>
	<wtc:param value="<%=inLoginPwd%>"/>
	<wtc:param value="<%=inPhoneNo%>"/>
	<wtc:param value="<%=inUserPwd%>"/>
	
	<wtc:param value="<%=contract_no%>"/>
	<wtc:param value="<%=s_flag%>"/>
	<wtc:param value="<%=inOpNote%>"/>
	</wtc:service>
<wtc:array id="result" scope="end" />
		
<%	
	if(!retCode1.equals("000000")){
%>
		<script language="javascript">
			rdShowMessageDialog("服务未能成功,服务代码:<%=retCode1%><br>服务信息:<%=retMsg1%>");
			history.go(-1);
		</script>
<%
		return;
	}


	if (result==null||result.length==0)
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("没有符合条件的数据!");
	history.go(-1);
</script>
<%	}
%>
<HTML><HEAD><TITLE>帐户历史信息</TITLE>
<script laguage="javascript">
	function sendPost(postUrl,bt)
	{
		$("#postForm").empty();
		$("#postForm").attr("action",postUrl);
		if(postUrl == "f1500_dConMsgHis02.jsp"){
			$("#postForm").append("<input type='hidden' name='contract_no' value='<%=contract_no%>' />").append("<input type='hidden' name='pwdcheck' value='<%=pwdcheck%>' />").append("<input type='hidden' name='work_no' value='<%=work_no%>'/>"); 
		}
		//alert($("#postForm").attr);
		$("#postForm").submit();

		 
	}
</script>
</HEAD>
<body>
<FORM method=post name="f1500_dConMsgHis01">
      	<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">帐户历史信息</div>
			</div>
            <TABLE  cellSpacing="0">
              <TBODY>
                <tr align="center">
                  <th>帐户名称</th>
                  <th>操作模块</th>
                  <th>操作时间</th>
                  <th>操作工号</th>
                  <th>操作流水</th>
				  <th>操作</th>
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
					 
		%>
					  <%
						if(pwdcheck=="Y" ||pwdcheck.equals("Y"))
						{
							%>
							<td class="<%=tbClass%>"><%= result[y][0]%></td>
							<%
						}
						else
						{
							%>
							<td class="<%=tbClass%>"><%=result[y][0].substring(0,1)%>XX  </td>
							<%
						}
					  %>
					  
					  <td class="<%=tbClass%>"><%= result[y][1]%></td>
					  <td class="<%=tbClass%>"><%= result[y][2]%></td>
					  <td class="<%=tbClass%>"><%= result[y][3]%></td>
					  <td class="<%=tbClass%>"><%= result[y][4]%></td>
					  <td class="<%=tbClass%>"><input type="button" class="b_foot" value="查询" onclick="sendPost('f1500_dConMsgHis02.jsp')"></td>
		<%	         
%>
	        </tr>
<%	      }
%>
              </TBODY>
	    </TABLE>
       
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id=footer>
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
            <%@ include file="/npage/include/footer.jsp" %>
</FORM>
<form id="postForm" method="post">
  	
</form>
</BODY></HTML>

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
  String opName = "综合信息查询之客户-用户对应关系";
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String password = (String)session.getAttribute("password");

	String phoneNo = request.getParameter("phoneNo");
	
	String inParas[] = new String[4];
  inParas[0] = phoneNo;
  inParas[1] = workno;
  inParas[2] = password;
  inParas[3] = opCode;
	//list = viewBean.callFXService("s3066Query",inParas,"8","phone",inParas[0]);
%>
	<%--
		20100906 by lichaoa 关于在BOSS界面增加彩铃开通和到期时间查询功能的需求 
		新增3个输入参数
		begin
	--%>
	<wtc:service name="s3066Query" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="11" >
		<wtc:param value="0"/>
		<wtc:param value=""/>		
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="totalResult0" start="0" length="2" scope="end"/>
	<wtc:array id="totalResult"  start="2" length="9" scope="end"/>
	<wtc:array id="totalResult1"  start="7" length="1" scope="end"/>

<%
	System.out.println("1111111111111111111111111111111111111111a"+totalResult.length);
	System.out.println("1111111111111111111111111111111111111111a"+retCode1);
		int iretCode=Integer.parseInt(retCode1);
        String test[][] = totalResult;

        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
        for(int outer=0 ; test != null && outer< test.length; outer++)
        {
                for(int inner=0 ; test[outer] != null && inner< test[outer].length; inner++)
                {
                        System.out.print(" | "+test[outer][inner]);
                }
                System.out.println(" | ");
        }
        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");		
	if (iretCode != 0 && iretCode != 306602) {
%>
		  <script language="JavaScript">
		      rdShowMessageDialog("彩铃信息查询失败! ");
		      history.go(-1);
		  </script>
<% 
	}else{ 
	if( iretCode == 306602) 
	{
		totalResult = new String [1][8];
		totalResult[0][2] = "彩铃信息";
		totalResult[0][3] = "该用户不是彩铃用户";
		totalResult[0][4] = "";
		totalResult[0][5] = "";
		totalResult[0][6] = "";
		totalResult[0][7] = "0";
		totalResult[0][8] = "";
		totalResult[0][9] = "";
		totalResult[0][10] = "";
	}
%>
<HTML>
<HEAD>
<TITLE>彩铃信息查询</TITLE>
</HEAD>
<BODY leftmargin="0" topmargin="0">
<FORM method=post name=form>
  <%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">彩铃信息</div>
		</div>
    <table cellspacing="0">
      <tr align="center"> 
        <th>彩铃类型</th>
				<th>彩铃套餐</th>
				<th>当前是否有效</th>
				<th>彩铃产品开始时间</th>
				<th>彩铃产品结束时间</th>
				<th>彩铃开通时间</th>
				<th>彩铃到期时间</th>
				<th>业务到期后资费</th>
			 </tr>
		<%--
		20100906 by lichaoa 关于在BOSS界面增加彩铃开通和到期时间查询功能的需求 
		增加彩铃开通到期时间
		begin
		--%>
            <% 
            			
				for (int i=0;i<totalResult.length; i++) {
					if(totalResult[i][0]!=null){
			%>
        <tr>
			<td>
				<%=totalResult[i][0]%>
			</td>
			<td>
				<%=totalResult[i][1]%>
			</td>
			<td>
				<%
					if("Y".equals(totalResult[i][2]))
					{
						out.print("当前有效");
					}
					else if("N".equals(totalResult[i][2]))
					{
					  	out.print("预约生效");
					}
				%>
			</td>
			<td>
				<%=totalResult[i][3]%>
			</td>
			<td>
				<%=totalResult[i][4]%>
			</td>
			<td>
				<%=totalResult[i][6]%>
			</td>
			<td>
				<%=totalResult[i][7]%>
			</td>
			<td>
				<%=totalResult[i][8]%>
			</td>
		</tr>  
       <%--lichaoa 20100906 关于在BOSS界面增加彩铃开通和到期时间查询功能的需求
    	新增3个字段由于显示超出屏幕范围，将上面的代码替换成下面的代码。 
                <tr> 
                  <td width="20%" nowrap><%=totalResult[i][0]%>&nbsp;</td>
		  						<td width="20%" nowrap><%=totalResult[i][1]%>&nbsp;</td>
		  						<td width="20%" nowrap>
					  <%
					  	  if("Y".equals(totalResult[i][2]))
					  	  {
					  	  	out.print("当前有效");
					  	  }
					  	  else if("N".equals(totalResult[i][2]))
					  	  {
					  	  	out.print("预约生效");
					  	  }
					  %>
					  			&nbsp;
                 </td>
					  		 <td width="20%" nowrap><%=totalResult[i][3]%>&nbsp;</td>
					  		 <td width="20%" nowrap><%=totalResult[i][4]%>&nbsp;</td>
					  		 <td width="20%" nowrap><%=totalResult[i][6]%>&nbsp;</td>
					  		 <td width="20%" nowrap><%=totalResult[i][7]%>&nbsp;</td>
					  		 <td width="20%" nowrap><%=totalResult[i][8]%>&nbsp;</td>
					  		 
					  	</tr>
		20100906 by lichaoa 关于在BOSS界面增加彩铃开通和到期时间查询功能的需求 
		增加彩铃开通到期时间
		end
		--%>
					  <% }} %>
					    <tr>
					    	<td>彩铃秀信息</td>
					    	<td colspan="7" nowrap>
					  <%
					  	  if("0".equals(totalResult1[0][0])){
					  	  	out.print("该用户不是彩铃秀用户");
					  	  }else if("1".equals(totalResult1[0][0])){
					  	  	out.print("该用户是彩铃秀用户");
					  	  }
					  %>
                &nbsp;
                </td>
					    </tr>
           </table>

        <table cellspacing="0">
	        <tbody> 
	          <tr> 
	      	    <td id="footer">
	    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
	    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab(<%=opCode%>)" type=button value=关闭>
	    	    </td>
	          </tr>
	        </tbody> 
	      </table>
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>
<% } %>


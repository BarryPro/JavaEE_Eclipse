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
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "1500";
  String opName = "综合信息查询之客户历史信息";

	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String cust_id=request.getParameter("cust_id");
	String login_accept=request.getParameter("login_accept");
	String work_no=request.getParameter("work_no");
	String work_name=request.getParameter("work_name");
	
	//add by diling for 安全加固修改服务列表
	String loginNo = (String)session.getAttribute("workNo");
	String password = (String) session.getAttribute("password");
	
	String passValidateFlag = WtcUtil.repNull(request.getParameter("passValidateFlag"));//是否已经通过密码校验
/**
	ArrayList arlist = new ArrayList();
	try{
		s1550view viewBean = new s1550view();//实例化viewBean
		arlist = viewBean.s1500_custhis02(cust_id,login_accept,region_code); 
	}
	catch(Exception e)
	{
		//System.out.println("调用EJB发生失败！");
	}
	String [][] result = new String[][]{};
	result = (String[][])arlist.get(0);
	**/
	%>
	
	<wtc:service name="s1500_custhis02" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="32" >
		<wtc:param value="<%=login_accept%>"/>
  <wtc:param  value="01"/>
  <wtc:param  value="<%=opCode%>"/>
  <wtc:param  value="<%=loginNo%>"/>
  <wtc:param  value="<%=password%>"/>
  <wtc:param  value=""/>
  <wtc:param  value=""/>
	<wtc:param value="<%=cust_id%>"/>
	<wtc:param value="<%=regionCode%>"/>
	<wtc:param value="<%=passValidateFlag%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%	
	int iretCode=999999; //因为这里的服务写得不规范,正确的不一定返回六个零,所以要如此判断
	
	if(retCode1!=null&&!"".equals(retCode1)){
		iretCode=Integer.parseInt(retCode1);
	}
	if(iretCode!=0){
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
		rdShowMessageDialog("查询结果为空,该条客户历史详细信息为空!");
	</script>
<%
		return;
	}
	
	
	String return_code =result[0][0];
	String return_message =result[0][1];

	if (!return_code.equals("000000"))
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("<%=return_message%><br>服务代码代码:<%=return_code%>");
	history.go(-1);
</script>
<%	
	}
%>

<HTML><HEAD><TITLE>客户历史信息</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_custhis02">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">客户历史信息&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;客户名称:<%=result[0][3]%></div>
		</div>

      <TABLE cellSpacing="0">
        <TBODY>
          <TR>
            <TD class="blue">客户标识</td>
            <td><%=result[0][2]%>&nbsp;</TD>
            <TD class="blue">客户名称</td>
            <td colspan="3"><%=result[0][3]%>&nbsp;</TD>
          </TR>
          <TR>
            <TD class="blue">归属地区</td>
            <td><%=result[0][4]%>&nbsp;</TD>
            <TD class="blue">归属市县</td>
            <td><%=result[0][5]%>&nbsp;</TD>
            <TD class="blue">归属网点</td>
            <td><%=result[0][6]%>&nbsp;</TD>
          </TR>
          <TR>
            <TD class="blue">客户状态</td>
            <td><%=result[0][7]%>&nbsp;</TD>
            <TD class="blue">客户状态时间</td>
            <td><%=result[0][8]%>&nbsp;</TD>
            <TD class="blue">客户级别</td>
            <td><%=result[0][9]%>&nbsp;</TD>
          </TR>
          <TR>
            <TD class="blue">客户类别</td>
            <td><%=result[0][10]%>&nbsp;</TD>
            <TD class="blue">客户地址</td>
            <td colspan="3"><%=result[0][11]%>&nbsp;</TD>
          </TR>

	        <tr>
	          <TD class="blue">通讯地址</td>
	          <td><%=result[0][12]%>&nbsp;</TD>
	          <TD class="blue">客户证件类型</td>
	          <td colspan="3"><%=result[0][13]%>&nbsp;</TD>
	        </tr>

          <TR>
            <TD class="blue">证件号码</td>
            <td><%=result[0][14]%>&nbsp;</TD>
            <TD class="blue">证件地址</td>
            <td colspan="3"><%=result[0][15]%>&nbsp;</TD>
          </TR>
        </TBODY>

        <TBODY>
          <TR>
            <TD class="blue">证件有效期</td>
            <td><%=result[0][16]%>&nbsp;</TD>
            <TD class="blue">联系人姓名</td>
            <td><%=result[0][17]%>&nbsp;</TD>
            <TD class="blue">联系人电话</td>
            <td><%=result[0][18]%>&nbsp;</TD>
          </TR>
        </TBODY>

        <TBODY>
          <TR>
            <TD class="blue">邮政编码</td>
            <td><%=result[0][19]%>&nbsp;</TD>
            <TD class="blue">联系人地址</td>
            <td colspan="3"><%=result[0][20]%>&nbsp;</TD>
          </TR>

          <TR>
            <TD class="blue">联系人传真</td>
            <td><%=result[0][21]%>&nbsp;</TD>
            <TD class="blue">电子邮箱</td>
            <td><%=result[0][22]%>&nbsp;</TD>
            <TD class="blue">建档渠道标识</td>
            <td><%=result[0][23]%>&nbsp;</TD>
          </TR>
          <TR>
            <TD class="blue">建档时间</td>
            <td><%=result[0][24]%>&nbsp;</TD>
            <TD class="blue">销档时间</td>
            <td><%=result[0][25]%>&nbsp;</TD>
            <TD class="blue">上级客户</td>
            <td><%=result[0][26]%>&nbsp;</TD>
          </TR>
          <TR>
            <TD class="blue">更新时间</td>
            <td><%=result[0][27]%>&nbsp;</TD>
            <TD class="blue">操作工号</td>
            <td><%=result[0][28]%>&nbsp;</TD>
            <TD class="blue">更新类型</td>
            <td><%=result[0][29]%>&nbsp;</TD>
          </TR>
          <TR>
            <TD class="blue">更新流水</td>
            <td><%=result[0][30]%>&nbsp;</TD>
            <TD class="blue">操作代码</td>
            <td  colspan="3"><%=result[0][31]%>&nbsp;</TD>
          </TR>
        </TBODY>
	    </TABLE>
         
      <table cellspacing=0>
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
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

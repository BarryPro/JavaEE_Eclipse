	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	/*
	* name    : 
	* author  : changjiang@si-tech.com.cn
	* created : 2004-04-09
	* revised : 2004-04-09
	*
	*update:zhanghonga@2008-12-20 页面改造,修改样式
	*
	*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "1560";
	String opName = "当天费用查询";
	
    String workNo = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String dateStr1=new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
	
	//arlist = wrapper.s1560Init(workNo,belongName,dateStr1,dateStr1); 
%>
	<wtc:service name="s1560Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="9">
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=orgCode%>"/>
	<wtc:param value="<%=dateStr1%>"/>
	<wtc:param value="<%=dateStr1%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String retCode = result.length>0?result[0][0]:"999999";
	if (!retCode.equals("000000")||result.length<1) {
%>
	<script language="JavaScript">
		rdShowMessageDialog("<%=workNo%>当天费用查询失败！<br>错误代码：'<%=retCode%>'。",0);
		removeCurrentTab()
	</script>
<%
	return;
	}
%>

<HTML>
	<HEAD>
		<META content="text/html; charset=gb2312" http-equiv=Content-Type>
	</HEAD>
	<BODY>
		<FORM action="s1560.jsp" method=post name=form>
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">业务类型<>当天费用查询（<%=dateStr%> 00:00:00-<%=dateStr1%>）</div>
			</div>
              <table cellspacing="0">
                <tr align="center"> 
                  <th width="13%">类&nbsp;&nbsp;&nbsp;&nbsp;型</th>
                  <th>笔数（单位：笔）</th>
                  <th>金额（单位：元）</th>
                </tr>
                <tr> 
                  <td width="13%"> 
                    <div align="center">业务受理</div>
                  </td>
                  <td> 
                    <div align="center"><%=result[0][2].trim()%></div>
                  </td>
                  <td> 
                    <div align="center"><%=result[0][3].trim()%></div>
                  </td>
                </tr>
                <tr> 
                  <td width="13%" class="Grey"> 
                    <div align="center">缴&nbsp;&nbsp;&nbsp;&nbsp;费</div>
                  </td>
                  <td class="Grey"> 
                    <div align="center"><%=result[0][4].trim()%></div>
                  </td>
                  <td class="Grey"> 
                    <div align="center"><%=result[0][5].trim()%></div>
                  </td>
                </tr>
                <tr> 
                  <td width="13%"> 
                    <div align="center"><b>合&nbsp;&nbsp;&nbsp;&nbsp;计</b></div>
                  </td>
                  <td> 
                    <div align="center"><%=result[0][7].trim()%></div>
                  </td>
                  <td> 
                    <div align="center"><%=result[0][8].trim()%></div>
                  </td>
                </tr>
              </table>
              
            <table cellspacing="0">
              <tbody> 
              <tr> 
                <td id="footer"> 
                  <input class="b_foot" name=sure type="button" value=刷新 onClick="form.submit()">&nbsp;
                  <input class="b_foot" name=reset type="button" value=关闭 onClick="removeCurrentTab()">&nbsp; 
               </td>
              </tr>
             </tbody> 
           </table>
           <%@ include file="/npage/include/footer.jsp" %> 
		</FORM>
	</BODY>
</HTML>

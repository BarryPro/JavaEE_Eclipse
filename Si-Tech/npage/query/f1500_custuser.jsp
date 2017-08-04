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
  String opName = "综合信息查询之客户-用户对应关系";
	
	String region_code = ((String)session.getAttribute("orgCode")).substring(0,2);
	String cust_id=request.getParameter("custId");
	String cust_name=request.getParameter("custName");
	String work_no=request.getParameter("workNo");
	String recodeIDd=request.getParameter("recodeIDd");
	String work_name=request.getParameter("workName");
  //add by diling for 安全加固修改服务列表
	String loginNo = (String)session.getAttribute("workNo");
	String password = (String) session.getAttribute("password");
%>
	<wtc:service name="s1500_custuser" routerKey="region" routerValue="<%=region_code%>" retcode="retCode1" retmsg="retMsg1" outnum="9" >
	<wtc:param  value=""/>
  <wtc:param  value="01"/>
  <wtc:param  value="<%=opCode%>"/>
  <wtc:param  value="<%=loginNo%>"/>
  <wtc:param  value="<%=password%>"/>
  <wtc:param  value=""/>
  <wtc:param  value=""/>
	<wtc:param value="<%=cust_id%>"/>
	<wtc:param value="<%=region_code%>"/>
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
		rdShowMessageDialog("查询结果为空,客户-用户对应关系不存在!");
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
			rdShowMessageDialog("<%=return_message%><br>服务代码:<%=return_code%>.");
			history.go(-1);
		</script>
<%	
	}
%>

<HTML>
	<HEAD>
		<TITLE>客户-用户对应关系</TITLE>
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
			<div id="title_zi">客户-用户对应关系&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;客户名称:<%=cust_name%></div>
		</div>
    <table cellspacing="0">
      <tbody>
        <tr align="center"> 
          <th>服务号码</th>
          <th>服务类型</th>
          <th>运行状态</th>
          <th>状态时间</th>
          <th>代表标志</th>
          <th>集团标记</th>
          <th>归属地点</th>
        </tr>
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
					for(int j=2;j<result[0].length;j++){
%>
	          <td class="<%=tbClass%>"><%= result[y][j]%>&nbsp;</td>
<%	        
					}
%>
	        </tr>
<%	      
			}
%>
        </tbody>
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

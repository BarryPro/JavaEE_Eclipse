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
  String opName = "综合信息查询之客户-用户对应关系历史";
	
	String region_code = ((String)session.getAttribute("orgCode")).substring(0,2);

	//输入参数 客户ID、客户姓名、操作工号、操作员、角色、部门
	String cust_id=request.getParameter("custId");
	String cust_name=request.getParameter("custName");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	String recodeIDd=request.getParameter("recodeIDd");
	 //add by diling for 安全加固修改服务列表
	String loginNo = (String)session.getAttribute("workNo");
	String password = (String) session.getAttribute("password");

	/**
	ArrayList arlist = new ArrayList();
	try{
		s1550view viewBean = new s1550view();//实例化viewBean
		arlist = viewBean.s1500_custuserh(cust_id,region_code); 
	}
	catch(Exception e)
	{
		//System.out.println("调用EJB发生失败！");
	}
	**/
%>
	<wtc:service name="s1500_custuserh" routerKey="region" routerValue="<%=region_code%>" retcode="retCode1" retmsg="retMsg1" outnum="10" >
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
		rdShowMessageDialog("查询结果为空,客户-用户对应历史关系不存在!");
	</script>
<%
		return;
	}
	
	String return_code =result[0][0];
	String return_message =result[0][1];
	
	if (!return_code.equals("000000")){
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=return_message%><br>服务代码:<%=return_code%>");
			history.go(-1);
		</script>
<%	
	}
%>

<HTML><HEAD><TITLE>客户-用户对应关系历史信息</TITLE>
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
<FORM method=post name="f1500_custuserh">
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">客户-用户对应关系历史&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;客户名称:<%=cust_name%></div>
		</div>			

    <TABLE>
      <TBODY>
        <TR cellspacing="0" align="center">
          <th>服务号码</TD>
          <th>代表标志</TD>
          <th>集团标记</th>
          <th>更新时间</th>
          <th>操作工号</th>
          <th>操作代码</th>
          <th>更新类型</th>
          <th>更新流水</th>
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
					for(int j=2;j<result[0].length;j++){
%>
		  				<td class="<%=tbClass%>"> <%= result[y][j]%> &nbsp;</td>
<%		
					}
%>
          </tr>
<%	      
				}
%>
      </TBODY>
    </TABLE>
          
      <table cellspacing=0>
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
</BODY></HTML>

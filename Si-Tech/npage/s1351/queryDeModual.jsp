<%
/********************
 version v2.0
开发商: si-tech
功能:
create zhangss@2010-8-13
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	//输入参数 用户ID、手机号码、操作工号、操作员、角色、部门
	 	response.setHeader("Pragma","No-Cache");
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0);
	 
	 String opCode = "";
	 String opName = "个人账户统一账单默认模板配置";
	
	String contract_no  = request.getParameter("contractNo");
	String bank_cust  = request.getParameter("bankCust");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
 

   
	String sql_str="select b.region_name,b.region_code,a.show_mode,a.show_name from sDefaultModual a,sregioncode b where a.region_code=b.region_code";
	
	/**ArrayList arlist = new ArrayList();
	try{
	 	S1100View callView = new S1100View();
		arlist = callView.view_spubqry32("5",sql_str);
	}
	catch(Exception e)
	{
		//System.out.println("调用EJB发生失败！");
	}
	String [][] result = new String[][]{{"0","1","2","3","4"}};
	int result_row = Integer.parseInt((String)arlist.get(1));
	**/
%>

<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
	<wtc:sql><%=sql_str%></wtc:sql>
	</wtc:pubselect>
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
<HTML><HEAD><TITLE>个人账户统一账单默认模板配置</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_dConMsgHis01">
      	<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">个人账户统一账单默认模板配置</div>
			</div>
            <TABLE  cellSpacing="0">
              <TBODY>
                <tr align="center">
                  <th>地市代码</th>
                  <th>地市名称</th>
                  <th>模板代码</th>
                  <th>模板名称</th>
                  <th>操作</th>
                </TR>
<%	      
			String tbClass="";
			for(int y=0;y<result.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}
				else{
					tbClass="";
				}
%>
	 				<tr align="center">
<%    	        
				for(int j=0;j<result[y].length;j++)
	        {
%>
	          <td class="<%=tbClass%>"><%= result[y][j]%></td>
<%	        }
%>
	          <td class="<%=tbClass%>"> 
	         	<a href="makeDeModual.jsp?show_mode=<%=result[y][2]%>&action=select&modetype=0&flag=1">查看 </a>
	         	<a href="delDeModual.jsp?show_mode=<%=result[y][2]%>">删除 </a>
	         	</td>
	       
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
    	      &nbsp; <input class="b_foot" name=back onClick="javascript:window.location.replace('makeDeModual.jsp');" type=button value=新增>
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=关闭>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
            <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>

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
	String opCode = "1502";
  String opName = "综合信息历史查询之用户历史信息";
  
  String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String id_no  = request.getParameter("idNo");
	String phone_no  = request.getParameter("phoneNo");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	
%>
	<wtc:service name="sHisUserHis01" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="6">
		<wtc:param value="<%=id_no%>"/>
	</wtc:service>
	<wtc:array id="result" start="2" length="4" scope="end" />

<%
  if(!retCode1.equals("000000")){
%>
   <script language="javascript">
   	  rdShowMessageDialog("服务未能成功,服务代码:<%=retCode1%><br>服务信息:<%=retMsg1%>");
	<script>
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
<%
	return ;	
    }
%>
<HTML><HEAD><TITLE>用户历史信息</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_dCustMsgHis01">
<%@ include file="/npage/include/header.jsp" %>   
			<div class="title">
				<div id="title_zi">用户历史信息</div>
			</div>  	
            <table cellSpacing="0">
              <tbody>
                <tr align="center">
                  <th>操作模块</th>
                  <th>操作时间</th>
                  <th>操作工号</th>
                  <th>操作流水</th>
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
				for(int j=0;j<result[0].length;j++){
%>
	      <td class="<%=tbClass%>" style="background-color:#8EC6E2;"><a style="color:white;" href="f1502_dCustMsgHis02.jsp?id_no=<%=id_no%>&update_accept=<%=result[y][3]%>&work_no=<%=work_no%>&work_name=<%=work_name%>"><%=result[y][j]%></a></td>
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
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
    	    </td>
          </tr>
        </tbody> 
      </table>
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>


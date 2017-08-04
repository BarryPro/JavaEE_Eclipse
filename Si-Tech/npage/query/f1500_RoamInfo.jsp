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
  String opName = "综合信息查询之边界漫游投诉信息";
	
	String region_code = ((String)session.getAttribute("orgCode")).substring(0,2);
	String cust_id=request.getParameter("idNo");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
String recodeIDd=request.getParameter("recodeIDd");
	String qrySql = "select VISIT_PROV_CODE, MSC_ID, LAC_ID, CELL_ID, PROV_CODE, PROV_DISTRCIT_NO, to_char(STATE_TIME,'yyyymmdd hh24:mi:ss'), to_char(START_TIME,'yyyymmdd hh24:mi:ss'), to_char(END_TIME,'yyyymmdd hh24:mi:ss')  from dRoamStateInfo  where phone_no = (select phone_no from dCustMsg where id_no =" + cust_id + ") order by STATE_TIME desc";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>"  retcode="retCode1" retmsg="retMsg1" outnum="9">
	<wtc:sql><%=qrySql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%
	if (!retCode1.equals("000000"))
	{
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=retMsg1%><br>服务代码:<%=retCode1%>");
			history.go(-1);
		</script>
<%
		return;
	}else if(result==null||result.length==0){
%>
		<script language="JavaScript">
			rdShowMessageDialog("边界漫游投诉信息不存在!");
			history.go(-1);
		</script>
<%
		return;			
	}
%>

<HTML><HEAD><TITLE>边界漫游投诉信息</TITLE>
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
			<div id="title_zi">边界漫游投诉信息&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;客户名称:<%=result[0][3]%></div>
		</div>
    <TABLE cellspacing="0">
      <TBODY>
        <TR align="center"> 
          <th>被访省代码</th>
          <th>漫游MSC_ID</th>
          <th>漫游LAC_ID</th>
				  <th>漫游CELL_ID</th>
				  <th>被覆盖省代码</th>
				  <th>长途区号</th>
				  <th>投诉时间</th>
          <th>通话开始时间</th>
          <th>通话结束时间</th>
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
	</BODY>
</HTML>

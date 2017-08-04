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
  String opName = "综合信息查询之客户附加信息";
	//输入参数 客户ID、客户姓名、操作工号、操作员、角色、部门
	String cust_id  = request.getParameter("custId");
	String cust_name  = request.getParameter("custName");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	String recodeIDd=request.getParameter("recodeIDd");
	String sqlStr="select to_char(cust_id),sex_name,to_char(birthday,'yyyymmdd hh24 mi ss'),nvl(ltrim(rtrim(profession_name)),'NULL'),type_name,nvl(ltrim(rtrim(cust_love)),'NULL'),nvl(ltrim(rtrim(cust_habit)),'NULL') from dCustDocInAdd a,sSexCode b,sProfessionId c,sWorkCode d where a.cust_id="+cust_id+" and a.cust_sex=b.sex_code and a.profession_id=c.profession_id and d.region_code='0'||substr("+cust_id+",1,1) and a.edu_level=d.work_code";
	System.out.println("_________________________________________________");
	System.out.println(sqlStr);
	System.out.println("_________________________________________________");	
	/**
	ArrayList arlist = new ArrayList();
	try{
	 	S1100View callView = new S1100View();
		arlist = callView.view_spubqry32("7",sql_str);
	}
	catch(Exception e)
	{
		//System.out.println("调用EJB发生失败！");
	}
	
	String [][] result = new String[][]{{"0","1","2","3","4","5","6"}};
	***/
%>
	
	<wtc:pubselect name="sPubSelect" retcode="retCode1" retmsg="retMsg1" outnum="7">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
		
<%
	if (result.length==0){
%>
			<script language="JavaScript">
				rdShowMessageDialog("客户附加信息为空!");
				history.go(-1);
			</script>
<%	
		return;
	}
%>

<HTML><HEAD><TITLE>客户附加信息</TITLE>
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
<FORM method=post name="f1500_dCustDocInAdd">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">客户附加信息&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;客户名称:<%=cust_name%></div>
		</div>
		
      <TABLE cellspacing=0>
        <TBODY>
          <TR>
            <td class="blue">客户标识</td>
            <td><%=result[0][0]%></td>
            <td class="blue">性&nbsp&nbsp&nbsp&nbsp别</td>
            <td><%=result[0][1]%></td>
            <td class="blue">出生日期</td>
            <td><%=result[0][2]%></td>
          </TR>
          <TR>
            <td class="blue">职业类型</td>
            <td><%=result[0][3]%></td>
            <td class="blue">学&nbsp&nbsp&nbsp&nbsp历</td>
            <td colspan="3"><%=result[0][4]%></td>
          </TR>
          <TR>
            <td class="blue">客户习惯</td>
            <td colspan="5"><%=result[0][5]%></td>
          </TR>
          <TR>
            <td class="blue">客户爱好</td>
            <td colspan="5"><%=result[0][6]%></td>
          </TR>
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

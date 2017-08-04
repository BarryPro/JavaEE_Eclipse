<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>



<%
		String opCode = "i092";
		String opName = "强制预拆";
		String dateStr = new java.text.SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date());
 
	 	String[] inParas1 = new String[2];
		String[] inParas2 = new String[2];
		String regionCode = (String)session.getAttribute("regCode");
		String workno = (String)session.getAttribute("workNo");
		int	i=0;
		String sButtonName = "";
%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	

 function doclear() {
 		frm.reset();
 }


 
    
   function sel1()
   {
			window.location.href='i092_1.jsp';
   }
   function sel2()
   {
		   window.location.href='i092_2.jsp';
   }
   function sel3()
   {
		   window.location.href='i092_3.jsp';
   }
   function sel4()
   {
		   window.location.href='i092_4.jsp';
   }
   
function do_qry(op_accept)
{
	document.frm.action="i092_4_1.jsp?op_accept="+op_accept  ;

	document.frm.submit();	



	
	//document.frm.action="i092_3_1.jsp" ;

	//document.frm.submit();
	
}

function do_out(op_accept)
{
	document.frm.action="i092_4_2.jsp?op_accept="+op_accept  ;

	document.frm.submit();	
	
}
  
-->
 </script> 
 
<%     	

      	inParas1[0] = "SELECT op_time,rec_num,op_accept,deal_flag FROM ( " ;
      	//inParas1[0] += "SELECT to_char(op_time,'yyyymmdd HH24:MI:SS') op_time, to_char(rec_num) rec_num, to_char(op_accept) op_accept, to_char(deal_flag) deal_flag FROM dForceLogOutMsg WHERE login_no = :login_no and to_char(total_date) < to_char(sysdate,'yyyymm')||01 order by op_time desc " ; 
      	inParas1[0] += "SELECT to_char(op_time,'yyyymmdd HH24:MI:SS') op_time, to_char(rec_num) rec_num, to_char(op_accept) op_accept, to_char(deal_flag) deal_flag FROM dForceLogOutMsg WHERE login_no = :login_no order by op_time desc " ; 
      	inParas1[0] += ") WHERE rownum <=15 " ;

        inParas1[1]="login_no="+workno;

%>
      	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="4">
		    <wtc:param value="<%=inParas1[0]%>"/>
		    <wtc:param value="<%=inParas1[1]%>"/>
		    </wtc:service>
		    <wtc:array id="result" scope="end" />	    
<%
		if(result.length == 0)
		{
%>
			<SCRIPT type=text/javascript>
				rdShowMessageDialog("该工号目前没有可查询记录。",0);
				history.go(-1);
			</SCRIPT>
<%
		}
		else
		{

		
		}
%>
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY>
<form action="i092_3_1.jsp" method="post" name="frm" ENCTYPE="multipart/form-data">
		
	
	<%@ include file="/npage/include/header.jsp" %>   
  	
	<table cellspacing="0">
      <tbody> 
      <tr> 
        <td class="blue" width="15%">查询方式</td>
        <td colspan="4"> 
          <input name="busyType4" type="radio" onClick="sel1()" value="1" >按手机号码查询
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel2()" value="2">按地市查询
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel3()" value="3" >文件导入
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel4()" value="4" checked >文件处理结果查询
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  
		</td>
     </tr>
    </tbody>
  </table>
	
	<div class="title">
			<div id="title_zi">请选择要查询的记录</div>
		</div>
	<table cellspacing="0">
    

	<tr>
		<td class="blue" >
			导入时间
		</td>
		<td class="blue">
			记录数
		</td>
		<td class="blue">操作流水</td>
		<td class="blue">--</td>
	</tr>
	
<%
	for(i=0;i<result.length;i++)
	{
	
%>
	<tr>
		<td><%=result[i][0]%></td>
		<td><%=result[i][1]%></td>
		<td><%=result[i][2]%></td>
		<td>
			<input type="button" name="query"  value="查询" onclick=do_qry("<%=result[i][2]%>") >
			<input type="button" name="query"  value="导出" onclick=do_out("<%=result[i][2]%>") >
		</td>
	</tr>
<%
	}
%>
	 


  </table> 


  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
	        
          <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %> 
</form>
 </BODY>
</HTML>
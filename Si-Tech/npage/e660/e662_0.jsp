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
		String[] inParas1 = new String[2];
		String[] inParas2 = new String[2];
		String opCode = "e662";
		String opName = "手工系统充值查询";
		String regionCode = (String)session.getAttribute("regCode");
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");

    String region_code = request.getParameter("region_code") ;
	  String begin_ymd = request.getParameter("begin_ymd") ;
		String end_ymd = request.getParameter("end_ymd") ;
    String action_note = "";
    
		String	v_document_accept	= "" ;
		String	v_region_code			= "" ;
		String	v_document_name		= "" ;
		String	v_document_no			= "" ;
		String	v_all_user				= "" ;
		String	v_all_fee					= "" ;
		String	v_action_flag			= "" ;
		String	v_action_time			= "" ;
		String	v_return_msg			= "" ;
%>
<%
		if( region_code.equals("ZZ") )
			region_code="%";

		inParas1[0] = "SELECT to_char(document_accept), region_name, document_name, document_no,to_char(all_user),to_char(all_fee), "+
			"       to_char(action_flag), to_char(action_time,'yyyymmdd'), return_msg "+
			"  FROM pBackPay_check ,sRegionCode "+
			" WHERE pBackPay_check.region_code LIKE :region_code "+
			"   AND sRegionCode.region_code = pBackPay_check.region_code"+
			"   AND to_char(in_time, 'yyyymmdd') BETWEEN :begin_ymd AND :end_ymd "; 
		
		inParas1[1] ="region_code="+region_code+",begin_ymd="+begin_ymd+",end_ymd="+end_ymd ;

System.out.println("----------------------------zhaorh test1 :"+inParas1[0]);
System.out.println("----------------------------zhaorh test2 :"+inParas1[1]);
%>
		<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="9">
		<wtc:param value="<%=inParas1[0]%>"/>
		<wtc:param value="<%=inParas1[1]%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end" />	    
<%
		if(result.length == 0)
		{
%>
			<SCRIPT type=text/javascript>
				rdShowMessageDialog("未查询到指定信息，请检查输入条件。<br>错误代码：'<%=retCode%>'。<br>错误信息：'<%=retMsg%>'。",0);
				history.go(-1);
			</SCRIPT>
<%
		}
			
%>


<HTML>
<HEAD>
<script language="JavaScript">
	
function go_detail( document_accept )
{
	document.frm.action="e662_2.jsp?document_accept="+document_accept;

	document.frm.submit();
}
	
</script> 
<title>手工系统充值查询</title>
</head>
<BODY onload=""> 
<form action="e660_1.jsp" method="post" name="frm" >
		 
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">流程信息</div>
		</div>

  <table cellspacing="0">
    <tbody> 

     <tr> 
        <td class="blue" width="7%">地市代码:</td>
        <td class="blue" width="20%">公文名:</td>
				<td class="blue" width="20%">公文号:</td>
				<td class="blue" width="7%">总用户数:</td>
				<td class="blue" width="7%">总金额:</td>
				<td class="blue" width="10%">流程信息:</td>
				<td class="blue" width="10%">操作时间:</td>
				<td class="blue" width="">返回信息:</td>
				<td class="blue" width="5%">
				 操作：
				</td>
     </tr>     
     
		<%
			for( int i=0;i<result.length;i++ )
			{
				v_document_accept	= result[i][0] ;
				v_region_code			= result[i][1] ;
				v_document_name		= result[i][2] ;
				v_document_no			= result[i][3] ;
				v_all_user				= result[i][4] ;
				v_all_fee					= result[i][5] ;
				v_action_flag			= result[i][6] ;
				v_action_time			= result[i][7] ;
				v_return_msg			= result[i][8] ;
				
				if( v_action_flag.equals("1") )
					action_note="已上传未入库" ;
				else if( v_action_flag.equals("2") )
					action_note="待发布!" ;
				else if( v_action_flag.equals("3") )
					action_note="待审核!" ;
				else if( v_action_flag.equals("4") )
					action_note="审核通过!" ;
				else if( v_action_flag.equals("5") )
					action_note="进入返费流程!" ;
		%>
     <tr> 
        <td class="Grey" ><%=v_region_code%></td>
        <td class="Grey" ><%=v_document_name%></td>
				<td class="Grey" ><%=v_document_no%></td>
				<td class="Grey" ><%=v_all_user%></td>
				<td class="Grey" ><%=v_all_fee%></td>
				<td class="Grey" ><%=action_note%></td>
				<td class="Grey" ><%=v_action_time%></td>
				<td class="Grey" ><%=v_return_msg%></td>
				<td class="Grey" >
				 <input type="button" name="detail" class="b_foot" value="明细" onClick="go_detail(<%=v_document_accept%>)" >
				</td>
     </tr>    
		<%
			}
		%>
     
    </tbody>
  </table>
 

           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
          <input type="button" name="return1" class="b_foot" value="关闭" onclick="doclear()" >
          &nbsp;
  
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="返回" onClick="history.go(-1)" >
       </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>
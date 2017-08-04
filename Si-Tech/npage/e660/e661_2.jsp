<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
/********************
 version v2.0
开发商: si-tech
*
*e662  模糊查询分页。
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
		String opCode = "e661";
		String opName = "手工系统充值审核";
		String regionCode = (String)session.getAttribute("regCode");
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String ip_Addr =  (String)session.getAttribute("ipAddr");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
    String document_accept = request.getParameter("document_accept") ;
    String action_note = "";
%>
<%     	

      	inParas1[0] = "SELECT document_name, document_no, "+
				"       to_char(action_flag ), "+
				" to_char(action_time,'yyyymmdd hh24:mi:ss'), RETURN_MSG ,to_char(document_accept),active_name"+
				"  FROM pBackPay_check "+
				" WHERE document_accept = :document_accept " ;
				
        inParas1[1]="document_accept="+document_accept ;

%>
      	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="7">
		    <wtc:param value="<%=inParas1[0]%>"/>
		    <wtc:param value="<%=inParas1[1]%>"/>
		    </wtc:service>
		    <wtc:array id="result" scope="end" />	    
<%
		if(result.length == 0)
		{
%>
			<SCRIPT type=text/javascript>
				rdShowMessageDialog("指定的公文名，公文号查询不到。<br>错误代码：'<%=retCode%>'。<br>错误信息：'<%=retMsg%>'。",0);
				history.go(-1);
			</SCRIPT>
<%
		}
		
		if( result[0][2].equals("1") )
			action_note="已上传 未入库!" ;
		else if( result[0][2].equals("2") )
			action_note="已上传并入库，待发布!" ;
		else if( result[0][2].equals("3") )
			action_note="已发布待审核!" ;
		else if( result[0][2].equals("4") )
			action_note="审核通过!" ;
		else if( result[0][2].equals("5") )
			action_note="已进入返费流程!" ;
			
		String DOCUMENT_ACCEPT=result[0][5] ;
		
		
%>

<HTML>
<HEAD>
<script language="JavaScript">
	
function do_diff( document_accept )
{
	var document_name	= frm.document_name1.value ;
	var document_no		= frm.document_no1.value ;
	var	shortMsg1			= frm.shortmsg1.value;
	var	shortMsg2			= frm.shortmsg2.value;
	var	shortMsg_tmp1			= frm.shortmsg_tmp1.value;
	var	shortMsg_tmp2			= frm.shortmsg_tmp2.value;	
	
	if( frm.file_name.value == "" )
	{
		rdShowMessageDialog("必须导入核对文件！！");
		document.frm.file_name.focus();
		return false;
	}
	
	if( shortMsg1 != shortMsg_tmp1 )
	{
		rdShowMessageDialog("第一段短信模板与导入时的不一致。");
		document.frm.shortMsg1.focus();
		return false;
	}
	
	if( shortMsg2 != shortMsg_tmp2 )
	{
		rdShowMessageDialog("第二段短信模板与导入时的不一致。");
		document.frm.shortMsg2.focus();
		return false;
	}

	document.frm.action="e661_diff.jsp?document_name="+document_name+"&document_no="+document_no+"&document_accept="+document_accept ;

	document.frm.submit();

}
	
function do_submit( busi_flag , document_accept )
{
	
	
	document.frm.action="e662_3.jsp?document_accept="+document_accept+"&busi_flag="+busi_flag ;

	document.frm.submit();	
}
	
</script> 
<title>手工系统充值查询</title>
</head>
<BODY onload=""> 
<form action="e660_1.jsp" method="post" name="frm" ENCTYPE="multipart/form-data" >
		 
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">流程信息</div>
		</div>

  <table cellspacing="0">
    <tbody> 

     <tr> 
        <td class="blue" width="15%">公文名：</td>
        <td width="35%"> 
 					<input readonly class="InputGrey"type="text" name="document_name1" size="50" value="<%=result[0][0]%>" >  
				</td>
				<td class="blue" width="15%">公文文号：</td>
        <td width="35%"> 
 					<input readonly class="InputGrey"type="text" name="document_no1" size="50" value="<%=result[0][1]%>">  
				</td>
     </tr>     
     
     <tr>
        <td class="blue" width="15%">流程状态：</td>
        <td width="35%"> 
 					<input readonly class="InputGrey"type="text" name="action_flag" size="50" value="<%=action_note%>" >  
				</td>
				<td class="blue" width="15%">当前状态操作时间：</td>
        <td width="35%"> 
 					<input readonly class="InputGrey"type="text" name="active_name" size="50" value="<%=result[0][3]%>">  
				</td>			
     </tr>
     
    </tbody>
  </table>
  
  <table>
     <tr>
				<td class="blue" width="15%">营销代码：</td>
        <td > 
 					<input readonly class="InputGrey"type="text" name="active_name" size="50" value="<%=result[0][6]%>">  
				</td>
        <td class="blue" width="15%">操作异常说明：</td>
        <td > 
 					<input readonly class="InputGrey"type="text" name="active_name" size="50" value="<%=result[0][4]%>">  
				</td>
     </tr>
  </table>
  
 <%

		if( Integer.parseInt(result[0][2], 10) > 1 )
		{
		
			inParas2[0] = "SELECT to_char(ALL_USER), to_char(ALL_FEE), to_char(SUM_MAXFEE_USER), "+
					"       to_char(MAXFEE), UNIQ_FLAG, to_char(SUM_UNI_MAXFEE_USER), "+
					"       to_char(UNI_MAXFEE), to_char(UNI_ALL_USER), to_char(UNI_ALL_FEE), "+
					"       MIN_MONTH, MAX_MONTH, to_char(MIN_TURN), to_char(MAX_TURN), "+
					"       IN_LOGIN_NO, IN_LOGIN_NAME, IN_LOGIN_IP, to_char(IN_TIME, 'yyyymmdd'), "+
					"       CHK_LOGIN_NO, CHK_LOGIN_NAME, CHK_LOGIN_IP, "+
					"       to_char(CHK_TIME, 'yyyymmdd'), short_msg1, short_msg2 "+
					"  FROM pBackPayData_view "+
					" WHERE document_accept = :DOCUMENT_ACCEPT " ;
					
			inParas2[1]="DOCUMENT_ACCEPT="+DOCUMENT_ACCEPT ;
%>
			<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="23">
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
			</wtc:service>
			<wtc:array id="result2" scope="end" />	 
<%
			if(result2.length == 0)
			{
%>
				<SCRIPT type=text/javascript>
					rdShowMessageDialog("指定的流水 '<%=DOCUMENT_ACCEPT%>' 在数据表中无法查到。<br>导入数据未入库,或有异常! <br>错误代码：'<%=retCode%>'。<br>错误信息：'<%=retMsg%>'。",0);
					history.go(-1);
				</SCRIPT>
<%
			}
		
%>
 
		<div class="title">
			<div id="title_zi">基本信息:</div>
		</div>
  
  <table>
     <tr>
        <td class="blue" width="15%">用户数：</td>
        <td width="35%"> 
 					<input readonly class="InputGrey"type="text" name="active_name" size="50" value="<%=result2[0][0]%>">  
				</td>	
				<td class="blue" width="15%">金额：</td>
        <td width="35%"> 
 					<input readonly class="InputGrey"type="text" name="active_name" size="50" value="<%=result2[0][1]%>">  
				</td>			
     </tr>
      
     <tr>
        <td class="blue" width="15%">金额最高用户数：</td>
        <td width="35%"> 
 					<input readonly class="InputGrey"type="text" name="active_name" size="50" value="<%=result2[0][2]%>">  
				</td>
				<td class="blue" width="15%">金额最高用户金额：</td>
        <td width="35%"> 
 					<input readonly class="InputGrey"type="text" name="active_name" size="50" value="<%=result2[0][3]%>">  
				</td>			
     </tr>
	</table>

<%
	if( true == result2[0][4].equals("Y") )
	{
%>
 
  <div class="title">
			<div id="title_zi">有重复数据，合并后信息</div>
		</div>
		
  <table cellspacing="0">
    <tbody> 

     <tr> 
        <td class="blue" width="15%">合并后金额最高的用户数：</td>
        <td width="35%"> 
 					<input class="InputGrey"  readonly type="text" name="document_name" size="50" value="<%=result2[0][5]%>" >  
				</td>
				<td class="blue" width="15%">合并后金额最高的用户金额：</td>
        <td width="35%"> 
 					<input class="InputGrey" readonly type="text" name="document_no"size="50" value="<%=result2[0][6]%>">  
				</td>
     </tr>
     
     <tr>
        <td class="blue" width="15%">合并后总用户数：</td>
        <td width="35%"> 
 					<input class="InputGrey" readonly type="text" name="active_name" size="50" value="<%=result2[0][7]%>">  
				</td>
				<td class="blue" width="15%">合并后总金额：</td>
        <td width="35%"> 
 					<input class="InputGrey" readonly type="text" name="active_name" size="50" value="<%=result2[0][8]%>">  
				</td>			
     </tr>
   
    </tbody>
  </table>
<%
	}
%>

   <div class="title">
			<div id="title_zi">周期性充值信息</div>
	</div>
  <table cellspacing="0">
    <tbody> 

     <tr> 
        <td class="blue" width="15%">最短月份：</td>
        <td width="35%"> 
 					<input class="InputGrey" readonly type="text" name="document_name" size="50" value="<%=result2[0][9]%>">  
				</td>
				<td class="blue" width="15%">最长月份：</td>
        <td width="35%"> 
 					<input class="InputGrey" readonly type="text" name="document_no" size="50" value="<%=result2[0][10]%>">  
				</td>
     </tr>
     
     <tr>
        <td class="blue" width="15%">最小周期：</td>
        <td width="35%"> 
 					<input class="InputGrey" readonly type="text" name="active_name" size="50" value="<%=result2[0][11]%>" >  
				</td>	
				<td class="blue" width="15%">最长周期：</td>
        <td width="35%"> 
 					<input class="InputGrey" readonly type="text" name="active_name" size="50" value="<%=result2[0][12]%>" >  
				</td>			
     </tr>
     
      </table>
        
  <div class="title">
			<div id="title_zi">操作员及审核信息</div>
	</div>
  <table cellspacing="0">
     <tr>
        <td class="blue" width="15%">操作员工号：</td>
        <td width="35%"> 
 					<input class="InputGrey" readonly type="text" name="active_name" size="50" value="<%=result2[0][13]%>">  
				</td>
				<td class="blue" width="15%">姓名：</td>
        <td width="35%""> 
 					<input class="InputGrey" readonly type="text" name="active_name" size="50" value="<%=result2[0][14]%>">  
				</td>				
     </tr>     
     
     <tr>
        <td class="blue" width="15%">ip地址：</td>
        <td width="35%"> 
 					<input class="InputGrey" readonly  type="text" name="active_name" size="50" value="<%=result2[0][15]%>">  
				</td>
				<td class="blue" width="15%">时间：</td>
        <td width="35%"> 
 					<input class="InputGrey" readonly type="text" name="active_name" size="50" value="<%=result2[0][16]%>">  
				</td>				
     </tr>
     
     <tr>
        <td class="blue" width="15%">审核操作员工号：</td>
        <td width="35%"> 
 					<input class="InputGrey" readonly type="text" name="active_name" size="50" value="<%=result2[0][17]%>">  
				</td>
				<td class="blue" width="15%">审核操作员姓名：</td>
        <td width="35%""> 
 					<input class="InputGrey" readonly type="text" name="active_name" size="50" value="<%=result2[0][18]%>">  
				</td>				
     </tr>
     
     
        
     
     
     <tr>
        <td class="blue" width="15%">ip地址：</td>
        <td width="35%"> 
 					<input class="InputGrey" readonly  type="text" name="active_name" size="50" value="<%=result2[0][19]%>">  
				</td>
				<td class="blue" width="15%">审核时间：</td>
        <td width="35%"> 
 					<input class="InputGrey" readonly type="text" name="active_name" size="50" value="<%=result2[0][20]%>">  
				</td>				
     </tr>
        
		<input type="hidden" name="shortmsg_tmp1" value="<%=result2[0][21]%>">
		<input type="hidden" name="shortmsg_tmp2" value="<%=result2[0][22]%>">
     
    </tbody>
  </table>
  
  <div class="title">
			<div id="title_zi">短信模版</div>
	</div>
  <table cellspacing="0">
     <tr>
        <td width="35%"> 
 					<input class="button"  type="text" name="shortmsg1" size="100" value="">  
				</td>
			
     </tr>     
     
     <tr>
        <td width="35%"> 
 					<input class="button"   type="text" name="shortmsg2" size="100" value="">  
				</td>			
     </tr>
     
    </tbody>
  </table>
  
  <div class="title">
			<div id="title_zi">上传并核对公文</div>
	</div>
  
  <table cellspacing="0">
     <tr>
        <td class="blue" width="15%">原公文导入：</td>
    		<td>
    			<input type="file" name="file_name" size="30" class="button">
    			&nbsp;<input type="button" name="diff" class="b_foot" value="核对" onclick=do_diff("<%=DOCUMENT_ACCEPT%>")  >
    		</td>
    		<td>
    			 
    		</td>
     </tr> 
	</table>
 
<%
}
else
{
%> 
	<table cellSpacing="0">
		<tr>
			<td id="footer"> 
				文件未入库，请1小时之后再试！！
			</td>
		</tr>
	</table>

<%
}
%>

    
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
      		<%
      			String button_name = "";
      			String button_name2 = "";
      			String hidden_flag1 = "";
      			String hidden_flag2 = "";
      			
      			if( result[0][2].equals("1") ) {
      				button_name="无法发布";
      				hidden_flag1="disabled";
      				button_name2="删除";
      			}
      			else if( result[0][2].equals("2") ) {
      				button_name="确认发布";
      				button_name2="删除";
      			}
      			else if( result[0][2].equals("3") ) {
      				button_name="审核通过";
      				button_name2="打回";
      			}
      			else
      			{
      				button_name="提交";
      				button_name2="返回";
      				hidden_flag1="disabled";
      				hidden_flag2="disabled";
      			}
      		%>
<!-- 必须核对文件后才能提交所以封掉
           <input type="button" name="query" class="b_foot" value="<%=button_name%>" onclick=do_submit("B","<%=DOCUMENT_ACCEPT%>") <%=hidden_flag1%> >
          &nbsp;
---->
          <input type="button" name="return1" class="b_foot" value="<%=button_name2%>" onclick=do_submit("D","<%=DOCUMENT_ACCEPT%>") <%=hidden_flag2%> >
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

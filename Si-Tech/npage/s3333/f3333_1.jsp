<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<%
/********************
 version v3.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "3333";
 		String opName = "停机查询";
 		
		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String dtime = sdf.format(today.getTime());
    today.add(Calendar.MONTH,-3);
    /*默认，三个月之前*/
    String startTime = sdf.format(today.getTime());
		
%>

	<head>
		<title><%=opName%></title>
	<script language="javascript">	
		/**关闭页面**/
		function doClose(){
			parent.removeTab("<%=opCode%>");
		}			
		function doQuery()
		{
			if(!forDate(document.all.startMonth)){
	    	rdShowMessageDialog("时间输入格式不正确,请重新输入!");
	    	return false;
			}
			if(!forDate(document.all.endMonth)){
	    	rdShowMessageDialog("时间输入格式不正确,请重新输入!");
	    	return false;
			}

			if(!check(document.frm)) return false;
			var startMon = $("#startMonth").val();
			var endMon = $("#endMonth").val();
			if(startMon > endMon){
				rdShowMessageDialog("开始时间大于结束时间!");
	    	return false;
			}
			document.getElementById("qryInfoFrame").style.display="block"; 
			document.qryInfoFrame.location = "f3333_2.jsp?phone_no="+document.all.phone_no.value+"&startMonth="+ startMon + "&endMonth=" + endMon;
		}
	</script>		
	</head>
<body>	
	<form action="" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>
		
		<div class="title">
			<div id="title_zi">查询条件</div>
		</div>	
			<table cellspacing="0">
				<tr>
					<td width="15%" class="blue" nowrap>手机号码</td>
					<td colspan="3"><input type="text" name="phone_no" v_must="1" id="phone_no" v_type="mobphone"  size="18" value="">&nbsp;<font class="orange">*</font>&nbsp;&nbsp;</td>
				</tr>	
				<tr>
					<td class="blue">开始月份(格式：yyyyMM)</td>
					<td>
						<input type="text" name="startMonth" v_format="yyyyMM" id="startMonth" 
							v_must="1" size="18" value="<%=startTime%>" onblur="checkElement(this)" >&nbsp;
						<font class="orange">*</font>
					</td>
					<td class="blue">结束月份(格式：yyyyMM)</td>
					<td>
						<input type="text" name="endMonth" v_format="yyyyMM" id="endMonth" 
							v_must="1" size="18" value="<%=dtime%>" onblur="checkElement(this)" >&nbsp;
						<font class="orange">*</font>
					</td>
				</tr>
			</table>
			<table cellSpacing="0">
		      <tr> 
		        <td id="footer"> 
		           <input type="button" name="resetButton"  class="b_foot" value="重置" style="cursor:hand;" onclick="document.frm.reset()">&nbsp;
		           <input type="button" name="queryButton"  class="b_foot" value="查询" style="cursor:hand;" onclick="doQuery()">&nbsp;
		           <input type="button" name="closeButton" class="b_foot" value="关闭" style="cursor:hand;" onClick="doClose()">&nbsp;
		        </td>
		      </tr>
		    </table>	
		    
     		<table cellspacing="0">
				<tr>
					<td style="height:0;">
						<iframe frameBorder="0" id="qryInfoFrame" align="center" name="qryInfoFrame" scrolling="yes" style="height:300px;overflow-y:auto;overflow-x:hidden; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryInfoFrame').style.height=qryInfoFrame.document.body.scrollHeight+20+'px'"></iframe>
					</td>
				</tr>
				<tr>
			</table>		    
		<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>		    		
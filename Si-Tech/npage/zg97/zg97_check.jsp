<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/popup_window.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/public/checkPhone.jsp" %>
<%
		String opCode ="zg97"; 
		String opName = "国漫50M封顶办理"; 
	  String phoneNo = request.getParameter("phoneNo");
		String regionCode= (String)session.getAttribute("regCode"); 
		String workno=(String)session.getAttribute("workNo");
		String nopass= (String)session.getAttribute("password");
		String checkresult="";//0:未封顶；1：封顶
		String returnCode="";
		
%>
	<wtc:service name="zg52fd" routerKey="regionCode"   retcode="scode" retmsg="sret" outnum="4">
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=phoneNo%>"/> 
		<wtc:param value="0"/>
		<wtc:param value="0"/>
	</wtc:service>
	<wtc:array id="result" scope="end" /> 
<%
		if(result!=null&&result.length>0){
			returnCode=result[0][0];
			if(returnCode=="000000"||"000000".equals(returnCode)){			
				checkresult=result[0][2];
%>				
	<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>国漫50M封顶办理</TITLE></HEAD>
	<script language="JavaScript">		
	function doupdate(val){
		var fdType=val;
		document.frm1.action="zg97_2.jsp?fdType="+fdType;
		document.frm1.submit();
	}	
			
	</script> 
	<body>		
		<FORM method=post name="frm1">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">国漫50M封顶办理</div>
			</div>
			<div id="Operation_Table">
      <table cellspacing="0" id = "titles">
      	<tr>
      	  <td class="blue"> 服务号码</td>
       	 	<td colspan=5>
            <input type="text" name="phoneNo"  id="phoneNo" readonly maxlength="11" class="InputGrey" value="<%=phoneNo%>">
        	</td>
    		</tr>			
      	<tr>
      	  <td class="blue"> 封顶状态</td>
       	 	<td colspan=5>
       <%
				if(checkresult=="0"||"0".equals(checkresult)){			
       %>	 		
       	 <input type="text" name="fdType"  id="fdType" readonly maxlength="11" class="InputGrey" value="未封顶">
       <%
				}else{
       %>	
         <input type="text" name="fdType"  id="fdType" readonly maxlength="11" class="InputGrey" value="封顶">
      <%
      	}
      %>  	
      		</td>
    		</tr>	
    	 <tr id="footer"> 
      	    <td colspan="15">
      	    	  <%
				if(checkresult=="0"||"0".equals(checkresult)){			
       %>	 		
      	    <input class="b_foot" name=update onClick="doupdate('1')" type=button value="恢复封顶">
       <%
				}else{
       %>	
      	    <input class="b_foot" name=update onClick="doupdate('0')" type=button value="取消封顶">
      <%
      	}
      %>  	
    	      <input class="b_foot" name=back onClick="window.location = 'zg51_1.jsp' " type=button value=返回>
			 
			  
    	    </td>
          </tr>
      </table>		
<%@ include file="/npage/include/footer.jsp" %>
</FORM>      
      
  
</BODY></HTML>      
      
      
      		
<%				
			}else{
%>			
				<script language="javascript">
					rdShowMessageDialog("查询失败！错误代码"+"<%=result[0][0]%>"+",错误原因:"+"<%=result[0][1]%>");
					//window.location="zg97_1.jsp";
					history.go(-1);
				</script>
<%					
			}
		}else{
%>			
				<script language="javascript">
					rdShowMessageDialog("查询失败!,请与管理员联系！");
					history.go(-1);
				</script>
<%			
		}
%>
			


 

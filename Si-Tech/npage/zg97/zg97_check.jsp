<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/popup_window.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/public/checkPhone.jsp" %>
<%
		String opCode ="zg97"; 
		String opName = "����50M�ⶥ����"; 
	  String phoneNo = request.getParameter("phoneNo");
		String regionCode= (String)session.getAttribute("regCode"); 
		String workno=(String)session.getAttribute("workNo");
		String nopass= (String)session.getAttribute("password");
		String checkresult="";//0:δ�ⶥ��1���ⶥ
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
	<HEAD><TITLE>����50M�ⶥ����</TITLE></HEAD>
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
				<div id="title_zi">����50M�ⶥ����</div>
			</div>
			<div id="Operation_Table">
      <table cellspacing="0" id = "titles">
      	<tr>
      	  <td class="blue"> �������</td>
       	 	<td colspan=5>
            <input type="text" name="phoneNo"  id="phoneNo" readonly maxlength="11" class="InputGrey" value="<%=phoneNo%>">
        	</td>
    		</tr>			
      	<tr>
      	  <td class="blue"> �ⶥ״̬</td>
       	 	<td colspan=5>
       <%
				if(checkresult=="0"||"0".equals(checkresult)){			
       %>	 		
       	 <input type="text" name="fdType"  id="fdType" readonly maxlength="11" class="InputGrey" value="δ�ⶥ">
       <%
				}else{
       %>	
         <input type="text" name="fdType"  id="fdType" readonly maxlength="11" class="InputGrey" value="�ⶥ">
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
      	    <input class="b_foot" name=update onClick="doupdate('1')" type=button value="�ָ��ⶥ">
       <%
				}else{
       %>	
      	    <input class="b_foot" name=update onClick="doupdate('0')" type=button value="ȡ���ⶥ">
      <%
      	}
      %>  	
    	      <input class="b_foot" name=back onClick="window.location = 'zg51_1.jsp' " type=button value=����>
			 
			  
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
					rdShowMessageDialog("��ѯʧ�ܣ��������"+"<%=result[0][0]%>"+",����ԭ��:"+"<%=result[0][1]%>");
					//window.location="zg97_1.jsp";
					history.go(-1);
				</script>
<%					
			}
		}else{
%>			
				<script language="javascript">
					rdShowMessageDialog("��ѯʧ��!,�������Ա��ϵ��");
					history.go(-1);
				</script>
<%			
		}
%>
			


 

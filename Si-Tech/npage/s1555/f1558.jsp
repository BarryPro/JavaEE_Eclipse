 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-10 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GbK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
	<head>
		<title>�������콱</title>
<%
	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");	
 
%>

	<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
	<script language=javascript>
		  onload=function()
		  {
		    self.status="";
		    document.all.srv_no.focus();
		  }
		
		//----------------��֤���ύ����-----------------
		function doCfm(subButton)
		{
		  controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
		  if(!check(frm)) return false;
		  	frm.action="f1558_query.jsp";
		  	frm.submit();	  
		}
	</script>
</head>
<body>	
	<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>  
			<div class="title">
				<div id="title_zi">�������콱</div>
			</div>	
		<table cellspacing="0">       
	          <tr>
	            	<td  class="blue" nowrap>�ҽ�����</td>	
	            	<td>	            	
			              <select name="shorttype"  index="15">
			                <option value="0" selected >1 --> ����ʮ�����ܽ�</option>
			                <option value="1">2 --> ����ʮ�������˽�</option>
			                <option value="2">3 --> ����������</option>
			                <option value="3">4 --> �������ֽ�</option>
			                <option value="4">5 --> �͸��ؼ�֮���ֳ齱</option>
			                <option value="5">6 --> ����52�ܽ�</option>
			                <option value="6">7 --> һת�����½�</option>
			                <option value="7">8 --> �������ؽ�</option>
			                <option value="8">9 --> ������ף��</option>
			                <option value="9">10 --> ����52���°�</option>
			                <option value="10">11 --> ����52���°��½�</option>
			              </select>		              
	            	</td>
	          </tr>
          	<tr>
            		<td width="16%" nowrap class="blue">�ֻ�����</td>
            		<td nowrap >             
                		<input   type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone"   value =<%=activePhone%>  readonly class="InputGrey" maxlength="11" index="0" >
                		<font class="orange">*</font>
                	</td>
            
          	</tr>
          </table>
         <table cellspacing="0">       
	          <tr>
	            	<td id="footer">	             
	                	<input  type=button class="b_foot"  name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">
	                	<input  type=button class="b_foot" name=back value="���" onClick="frm.reset()">
	                	<input  type=button class="b_foot" name=qryP value="�ر�" onClick="removeCurrentTab()">
	            	</td>
	          </tr>
        </table>  
        <input type="hidden" name="opName" value="<%=opName%>">
        <input type="hidden" name="opCode" value="<%=opCode%>">
        <%@ include file="/npage/include/footer_simple.jsp" %>	
   </form>
</body>
</html>
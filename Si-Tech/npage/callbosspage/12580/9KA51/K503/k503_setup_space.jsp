<%
  /*
   * ����: 12580ԤԼ��������ʱ����
�� * �汾: 1.0.0
�� * ����: 2009/02/17
�� * ����: libin
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<script language="JavaScript" type="text/JavaScript" src="../../inputops.js"></script>

<html>
  <head>
    <%
     String num = (String)request.getParameter("times");
     
     String INTERV_TIME = (String)request.getParameter("interv_time");
     
     int js = Integer.parseInt(num);
     
     String[] rstr = new String[js];
     
     if(INTERV_TIME != null && INTERV_TIME.length() > 0){
     
     	rstr = (String[])INTERV_TIME.split(";");
     }
     
    %>
    <script language="javascript">
    	function setSpace(){
    		var rs = "";
    		var tag = document.getElementsByTagName("input");
    		for(var j = 0; j < tag.length; j++){
					if(tag[j].value != "" && tag[j].type == "text"){
						if(!isNumber(tag[j].value)){
							showTip(tag[j],"ʱ����ֻ��Ϊ���֣������ѡ�������");
							tag[j].focus();
		        	return;
						}
						rs += tag[j].value + ";";
					}else if(tag[j].value == "" && tag[j].type == "text"){
						
						showTip(tag[j],"ʱ��������Ϊ�գ������ѡ�������");
						tag[j].focus();
		        return;
						
					}
					
				}
    		window.returnValue = rs;
    		
    		window.close();
    	}
    </script>
  </head>
  
  <body>
    <form name="sitechform" id="sitechform">
    	<div id="Operation_Table">

				<div class="title">

					����ʱ����

				</div>
    	<table cellspacing="0">
    		<tr align="center">
    			<th>���</th>
    			<th>ʱ��(����)</th>
    		</tr>
    		<%
    			
	    	for(int i = 0; i < js; i++){
	    		if(i==0){
	    	%>
	    	<tr>
	    		<td>Լ��ʱ��~��<%=i+1 %>��</td><td><input name="space" value="<%=rstr[i].equals("0")?"0":rstr[i] %>" maxlength="2" disabled /></td>	    		
	    	</tr>
	    	<%	
	        }else	{
	      %>
	      <tr>
	    		 <td>��<%=i %>��~��<%=i+1 %>��</td><td><input name="space" value="5" maxlength="2" /></td>	    		
	    	</tr>
	      <%  	
	        }
	    	}
    		%>
    		<tr align="center">
    			<td colspan="2"><input type="button" class="b_foot" value="ȷ��" onClick="setSpace();"><input type="reset" class="b_foot" value="����"><input type="button" class="b_foot" value="�ر�" onClick="window.close();"></td>    			
    		</tr>
    	</table>
    	</div>
    </form>
  </body>
</html>

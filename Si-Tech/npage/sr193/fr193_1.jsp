<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
/*
 *�������������� 
 *
 *��Ȩ��si-tech
 *
 *update:fengcj 2014-11-5
 *
 *content:
 */
%>

<%
	String opCode = "r193";
	String opName = "��������������";
	String workNo = (String) session.getAttribute("workNo");
	String nopass = (String) session.getAttribute("password");
	String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
	String phone_no =  request.getParameter("activePhone");	

%>
<HTML>
	<HEAD>
		<TITLE><%=opName%></TITLE>
		<META content=no-cache http-equiv=Pragma>
		<META content=no-cache http-equiv=Cache-Control>
		<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
	</HEAD>
	<script language="javascript">

		
		function comm()
		{
			 if($.trim($("#phone_no").val()) == "")
		   {
		   	rdShowMessageDialog("������벻��Ϊ�գ�");
			  return false;
		   }
		   
		   document.fr193.action = "fr193_1.jsp?activePhone="+$("#phone_no").val();
		   document.forms[0].submit();
		
		}
		
		function update(){
			var text1 = document.fr193.text1.value ;
			if(text1==""||isNaN(text1)){
				rdShowMessageDialog("��������ȷ�ĺ���������",1);
				return false;
			}
			if(rdShowConfirmDialog("ȷ��Ҫ���и�����")==1){
				document.fr193.updateBtn.disabled = 'true';
				var packet = new AJAXPacket("fr193_2.jsp", "����ִ��,���Ժ�......");			
				packet.data.add("text1", text1);
				packet.data.add("phone_no", "<%=phone_no%>");
				core.ajax.sendPacket(packet,doUpdate,true);
				packet=null;
			}
		
		}
	
	function doUpdate(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		if(retCode=="000000"){
			
			rdShowMessageDialog("���³ɹ�",2);
			return false;
			window.location.reload();
		}else{
			document.fr193.updateBtn.disabled = 'false';
			rdShowMessageDialog("�������:["+retCode+"]<br/>������Ϣ:["+retMsg+" ]",0);
			return false;
		}
}

		</script>
	<body >
		<form method=post name="fr193" action="" >
			<input type=hidden id=workNo name=workNo value=<%=workNo%>>
			
			<%@ include file="/npage/include/header.jsp"%>
			<div class="title"><div id="title_zi"><%=opName%></div></div>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
          	<td width="40%" class="Blue">�ֻ�����</td>
          	<td width="60%">
							<input type="text" value="<%=phone_no%>" name="phone_no"  id="phone_no" v_must=0 v_minlength=1 v_maxlength=40 v_type="string" onblur="checkElement(this)">
         	 	</td>
          
        </tr>   
        <TR>
        	<TD align="middle"  colspan="2" id="footer">
						<input  name="selectbutton" index="3" type="button"
								class="b_foot" value="��ѯ" onclick="comm();">
							&nbsp;&nbsp;	
						<input class="b_foot" name="back" type="button"
								value="���" onclick="window.location='fr193_1.jsp'">

					</TD>
				</TR>
		</table>
	<%
	if(phone_no!=null && !"".equals(phone_no)){%>
		    <br>
				 <div id="div1"> 
				 <div class="title"><div id="title_zi">��ѯ���</div></div> 
				 		<table cellspacing="0">   
                <tr>						
                  <th>�ֻ�����</th>
                  <th>��ǰ����������</th>
                  <th>������������</th> 
                            
                </tr>
                
 <wtc:service name="sBlackNumQry" routerKey="phone" routerValue="<%=phone_no%>"  retcode="Code" retmsg="Msg"  outnum="3">                
        <wtc:param value="<%=phone_no%>" />
        <wtc:param value="" />
        <wtc:param value="<%=workNo%>" />
		</wtc:service>
		<wtc:array id="result" scope="end" />	
<%
	String errCode =Code;   
	String	errMsg=Msg;

	if(errCode.equals("000000"))
	{	
		int len = result.length;
		for(int i=0;i<len;i++){
			
		%>
		 <tr>
     
							  <td>
									<%=phone_no%>
								</td>
								<td>
									  <%=result[i][1]%>&nbsp;
								</td>
					      <td>
									<%=result[i][2]%>&nbsp;
								</td>
								
					    </tr>
		<%
		}
	}else{
		%>    
			<script language=javascript>	
				rdShowMessageDialog("��ѯ����![<%=errCode%>]<%=errMsg%>");
				document.location.replace("fr193_1.jsp?activePhone=<%=phone_no%>");
			</script>
	<%
	}
		%>      
					</table> 
					
					<br>
				 <div id="div1"> 
				 <div class="title"><div id="title_zi">����</div></div> 
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
          	<td width="30%" class="Blue">���º���������</td>
          	<td width="40%">
							<input type="text" value="" name="text1"  id="text1" v_must=0 v_minlength=1 v_maxlength=40 v_type="string" onblur="checkElement(this)">
							<font color="red">"1" ��ʾ������������һ;"0" ��ʾ������������0</font>
         	 	</td>
          	<td width="30%">
             <input class="b_foot" id="updateBtn" name="updateBtn" type="button" value="����" onclick="update()">
          	</td>
        </tr>   
        
				</TR>
		</table>
        <%}%>        
		</form>
		<%@ include file="/npage/include/footer.jsp" %> 
	</BODY>
</HTML>

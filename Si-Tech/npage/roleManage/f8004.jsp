 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-20 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	
	String password = (String)session.getAttribute("password");		
	String workNo = (String)session.getAttribute("workNo");//����
	String workname = (String)session.getAttribute("workName");	//��������
	
	String opCode = "8004";	
	String opName = "�޸�����";	//header.jsp��Ҫ�Ĳ���   
	
%>
<HTML>
	<HEAD>
		<TITLE>�޸Ĺ�������</TITLE>
		<script>
			function submitt(){				
				if(document.frm.newPass.value.length>6){
					rdShowMessageDialog("���볤�Ȳ�Ӧ����6��");
					return;
				}
				if(document.frm.newPass.value ==document.frm.oldPass.value){
					rdShowMessageDialog("�������ԭ���벻����ͬ��");
					return;
				}
				if(document.frm.newPass.value!=document.frm.cfmPass.value){
					rdShowMessageDialog("�������������벻һ�£�");
			}
				else{
					document.frm.submit.disabled=true;
					var myPacket = new AJAXPacket("modifyPassCfm.jsp","�����ύ�����Ժ�......");
					myPacket.data.add("work_no",document.frm.work_no.value);
					myPacket.data.add("nopass",document.frm.nopass.value);
					myPacket.data.add("op_code",document.frm.op_code.value);
					myPacket.data.add("oldPass",document.frm.oldPass.value);
					myPacket.data.add("newPass",document.frm.newPass.value);
					myPacket.data.add("cfmPass",document.frm.cfmPass.value);
				    core.ajax.sendPacket(myPacket);
				    myPacket=null;
				}
			}
			function doProcess(packet){
				var backGroupInfo = packet.data.findValueByName("backGroupInfo");
				//rdShowMessageDialog(backGroupInfo);
				rdShowMessageDialog(backGroupInfo);
				window.location="f8004.jsp";
			}
		</script>
	</HEAD>
	<body>
		<FORM action="" method=post name="frm" >
			<%@ include file="/npage/include/header.jsp" %>  
			<div class="title">
				<div id="title_zi">�޸�����</div>
			</div>				
			<table id=tbs9 cellspacing=0>			
				<TBODY>
			        <tr>
			        	<td class="blue">ԭ����</td>
			       		<td>
				 		<input class=button  id=Text2 type=password autocomplete="off"  size=12 name=oldPass maxlength=6>
				      	</td>
				     	<td class="blue">������</td>
				      	<td>
			 			<input class=button id=Text6 type=password autocomplete="off" size=12 name=newPass  maxlength=6>			  
			 		</td>
			              	<td class="blue">ȷ������</td>
			              	<td>
			                	<input class="button" name=cfmPass size=12 id=Text3 autocomplete="off" type=password maxlength=6>
			              	</td>
				</tr>
				 </TBODY>
			</table>		
			<table cellSpacing=0>
				<TBODY>
			            <TR>
			              <TD  id="footer">
				              	<input class="b_foot" name=submit  type=button value="ȷ��" onclick="submitt()" id=Button1>&nbsp;&nbsp;
				                <input class="b_foot" name=back  type=button value="���" id=Button2 onclick="document.frm.oldPass.value='';document.frm.newPass.value='';document.frm.cfmPass.value='';">&nbsp;&nbsp;
				                <input class="b_foot" name=back1  type=button value=�ر� id=Button2 onclick="removeCurrentTab()">
			                </TD>
			            </TR>
				</TBODY>
			</TABLE>		 
			<input type=hidden name=nopass value=<%=password%>>
			<input type=hidden name=op_code value="8004">
			<input type=hidden name=work_no value="<%=workNo%>">	
			<%@ include file="/npage/include/footer.jsp" %>		
		</FORM>	
	</BODY>
</HTML>


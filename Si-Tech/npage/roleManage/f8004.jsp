 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-20 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	
	String password = (String)session.getAttribute("password");		
	String workNo = (String)session.getAttribute("workNo");//工号
	String workname = (String)session.getAttribute("workName");	//工号名称
	
	String opCode = "8004";	
	String opName = "修改密码";	//header.jsp需要的参数   
	
%>
<HTML>
	<HEAD>
		<TITLE>修改工号密码</TITLE>
		<script>
			function submitt(){				
				if(document.frm.newPass.value.length>6){
					rdShowMessageDialog("密码长度不应大于6！");
					return;
				}
				if(document.frm.newPass.value ==document.frm.oldPass.value){
					rdShowMessageDialog("新密码和原密码不能相同！");
					return;
				}
				if(document.frm.newPass.value!=document.frm.cfmPass.value){
					rdShowMessageDialog("两次输入新密码不一致！");
			}
				else{
					document.frm.submit.disabled=true;
					var myPacket = new AJAXPacket("modifyPassCfm.jsp","正在提交，请稍候......");
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
				<div id="title_zi">修改密码</div>
			</div>				
			<table id=tbs9 cellspacing=0>			
				<TBODY>
			        <tr>
			        	<td class="blue">原密码</td>
			       		<td>
				 		<input class=button  id=Text2 type=password autocomplete="off"  size=12 name=oldPass maxlength=6>
				      	</td>
				     	<td class="blue">新密码</td>
				      	<td>
			 			<input class=button id=Text6 type=password autocomplete="off" size=12 name=newPass  maxlength=6>			  
			 		</td>
			              	<td class="blue">确认密码</td>
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
				              	<input class="b_foot" name=submit  type=button value="确认" onclick="submitt()" id=Button1>&nbsp;&nbsp;
				                <input class="b_foot" name=back  type=button value="清除" id=Button2 onclick="document.frm.oldPass.value='';document.frm.newPass.value='';document.frm.cfmPass.value='';">&nbsp;&nbsp;
				                <input class="b_foot" name=back1  type=button value=关闭 id=Button2 onclick="removeCurrentTab()">
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


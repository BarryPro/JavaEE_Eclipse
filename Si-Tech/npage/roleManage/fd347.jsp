 <%
	/********************
	 version v2.0
	������: si-tech
	update
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String password = (String)session.getAttribute("password");
	String workNo = (String)session.getAttribute("workNo");//����
	String workname = (String)session.getAttribute("workName");	//��������

	String opCode = "d347";
	String opName = "��Ȩ����";	

%>
<HTML>
	<HEAD>
		<TITLE>��Ȩ����</TITLE>
		<script language=javascript>
		  function submitt(){
            var chkPacket = new AJAXPacket ("getTab.jsp","��ȴ�������");
           	chkPacket.data.add("workNo" , $("#workNo").val());
           	chkPacket.data.add("byWorkNo" , $("#byWorkNo").val());
           	chkPacket.data.add("startTime" , $("#startTime").val());
           	chkPacket.data.add("endTime" , $("#endTime").val());
           	chkPacket.data.add("fileNo" , $("#fileNo").val());
           	core.ajax.sendPacketHtml(chkPacket,showMsg);
           	chkPacket =null;	
           	//$("#frameDiv").show();
           	//frm.action = "getTab.jsp?workNo="+$("#workNo").val()+"&byWorkNo="+$("#byWorkNo").val()+"&startTime="+$("#startTime").val()+"&endTime="+$("#endTime").val()+"&fileNo="+$("#fileNo").val();
           	//frm.target = "ifr";
           //	frm.submit();
            }
            function showMsg(data){
             	$("#frameDiv").empty().append(data);
           	    //$("#ifr").show();
           }
			
		</script>
	</HEAD>
	<body>
		<FORM action="" method="post" name="frm" id="frm" >
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">��Ȩ����</div>
			</div>
			<table id=tbs9 cellspacing=0>
			        <tr>
			        	<td class="blue">��Ȩ����</td>
			       		<td>
				 		<input   id="workNo" type="text" size=12 name="workNo" maxlength=6>
				      	</td>
				     	<td class="blue">����Ȩ����</td>
				      	<td>
			 			<input  id="byWorkNo" type="text" size=12 name="byWorkNo"  maxlength=6>
			 		    </td>
			 		</tr>
			 		<tr>
			              	<td class="blue">��ʼʱ��</td>
			              	<td>
			                	<input  name="startTime" size=12 id="startTime" type="text" v_type="date" maxlength=8>
			                	&nbsp;&nbsp;
			              	<font color="orange" >* ʱ���ʽ��20121230</font>
			              	</td>
			              	<td class="blue">����ʱ��</td>
			              	<td>
			                	<input  name="endTime" size=12 id="endTime" type="text" v_type="date" maxlength=8>
			                	&nbsp;&nbsp;
			              	<font color="orange" >* ʱ���ʽ��20121230</font>
			              	</td>
				</tr>
				<tr>
			              	<td class="blue">�ļ����</td>
			              	<td colspan="3">
			                	<input  name="fileNo" size=20 id="fileNo" type="text" maxlength=20>
			              	</td>
				</tr>
			</table>
			<table cellSpacing=0>
				<TBODY>
			            <TR>
			              <TD  id="footer">
				              	<input class="b_foot" name=aa  type=button value="ȷ��" onclick="submitt()" id=Button1>&nbsp;&nbsp;
				                <input class="b_foot" name=back  type=reset value="���" id=Button2 >&nbsp;&nbsp;
				                <input class="b_foot" name=back1  type=button value=�ر� id=Button2 onclick="removeCurrentTab()">
			                </TD>
			            </TR>
				</TBODY>
			</TABLE>
			</FORM>
		<!--<div id=frameDiv style="display:none">
		<iframe name=ifr width=100% height=300 align="center" cellspacing=0 src="">
		</iframe>
	</div>-->
			<div id=frameDiv >
	</div>
		    
		<%@ include file="/npage/include/footer.jsp" %>
	</BODY>
</HTML>


<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	String op_code="9127";
	String op_name = "SP������ϵ��ѯ";
	String opCode = op_code;
	String workNo = (String)session.getAttribute("workNo");
	String workpw = (String)session.getAttribute("password");
	String errcode="000000";
	String errmsg="";
	String[][] result=null;
	String beginDate = request.getParameter("beginDate");//��ʼ����
	beginDate = beginDate + "000000";
	String endDate = request.getParameter("endDate"); //��������
	endDate = endDate + "235959";
	String phoneNo = request.getParameter("phoneNo");//�绰����
	String iQryType = request.getParameter("iQryType");//��ѯ����
	String iFeeType = request.getParameter("iFeeType");//�շ�����
	iQryType=iQryType==null?"0":iQryType;
	iFeeType=iFeeType==null?"2":iFeeType;
%>
	<wtc:service name="splatBusiQry" outnum="12" routerKey="phone" routerValue="<%=phoneNo%>">
		<wtc:param value="0"/>
		<wtc:param value="02"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=workpw%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=iQryType%>"/>
		<wtc:param value="<%=iFeeType%>"/>
		<wtc:param value="<%=beginDate%>"/>
		<wtc:param value="<%=endDate%>"/>
	</wtc:service>
	<wtc:array id="r1" scope="end" />

	<!-- add by jiyk 2012-07-18 ���wangwg�ķ���-->
	<wtc:service name="sKFSpInfoQry" outnum="12" routerKey="phone" routerValue="<%=phoneNo%>">
		<wtc:param value="0"/>
		<wtc:param value="02"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=workpw%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=iQryType%>"/>
		<wtc:param value="<%=iFeeType%>"/>
		<wtc:param value="<%=beginDate%>"/>
		<wtc:param value="<%=endDate%>"/>
	</wtc:service>
	<wtc:array id="r2" scope="end" />
<%
	result=r1;
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=op_name%></TITLE>

<script language="javascript">
var SPNameArr = new Array();
function choose(checkBoxObj) {
	if (checkBoxObj.checked) {
		SPNameArr.push(checkBoxObj.value);
	} else {
		for (i=0; i < SPNameArr.length; i++) {
			if (SPNameArr[i]==checkBoxObj.value) {
				SPNameArr.splice(i, 1);
				break;
			}
		}
	}
}
	
<!-- add by jiyk 2012-07-26 -->
function toW001() {
	//ȡͶ�ߺ��롣��ȡΪ������룬���Ϊ�գ���ȡΪ���к���
	var phone_no = window.top.document.getElementById('acceptPhoneNo').value;
	if (phone_no == '') {
		phone_no = window.top.cCcommonTool.getCaller();
	}
	if(phone_no ==''){
		rdShowMessageDialog('�������Ϊ�գ�',1);
		return;
	}
	//ȡ���к���
	var caller_no = window.top.cCcommonTool.getCaller();
	//ҵ������:��������ͻ�Ͷ�ߡ�����ҵ����������š��������ҵ������������֪�鶨��
	var callcauseId = "1001010401010104";
	//SP����
	var SPNames = SPNameArr.toString();
	SPNames = SPNames.replace(/,/g, "��");
	//��������ģ��
	var content;
	if (SPNames == "") {
		content = "�ͻ�Ͷ�ߣ�δ���ƹ�***ҵ�񣬿ͻ�Ҫ��****";
	} else {
		content = "�ͻ�Ͷ�ߣ�δ���ƹ�"+SPNames+"ҵ�񣬿ͻ�Ҫ��****";
	}
	//������ַ��10.110.0.100:21000
	//���Ե�ַ��10.110.26.23:6600
	//׼������ַ��10.110.0.126:61100
	var path="http://10.110.0.100:21000/workflow/common/cspAuth.jsp?login_no=<%=workNo%>"
				+"&phone_no="+phone_no+"&caller_no="+caller_no
				+"&callcauseId="+callcauseId+"&content="+content;
	window.top.addTab(true,"w001","��������",path);
}

window.onload = function() {
	window.parent.ableOperate();
}
</script>
</HEAD>

<body>
<form  method=post name="form" >
<div id="Operation_Table">
	<div class="title">
		<div id="title_zi">SP������ҵ��ʹ�ò�ѯ���</div>
	</div>
	<table cellspacing="0">
		<tr>
			<th align=center width="5%;">ѡ��</th>
			<th align=center width="5%;">���</th>
			<th align=center width="8%;">������</th>
			<th align=center width="8%;">����ʱ��</th>
			<th align=center width="8%;">����ʱ��</th>
			<th align=center width="8%;">��ҵ����</th>
			<th align=center width="7%;">�������</th>
			<th align=center width="8%">����ҵ������</th>
			<th align=center width="10%;">ҵ������</th>
			<th align=center width="6%;">�շ�����</th>
			<th align=center width="8%;">ҵ�����</th>
			<th align=center width="8%;">����ҵ���ʶ</th>
			<th align=center width="6%;">��������</th>
			<th align=center width="12%;">����״̬</th>
			<th align=center width="20%;">����˵��</th>
			
		</tr>
<%
	if(r1.length<=0&&r2.length<=0) {
%>
		<tr><td colspan="15" align = "left"><b><font class="orange">�޲�ѯ���</font></td></tr>
<%
	} else if (r1.length>0) {
		for(int i=0;i<r1.length;i++){
%>
		<tr onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#E8E8E8';">
			<td><input type="checkbox" value="<%=result[i][4]%>" onclick="choose(this)" /></td>
			<td align=center><%=(i+1)%>&nbsp;</td>
			<td align=center><%=result[i][0]%>&nbsp;</td>
			<td align=center><%=result[i][1]%>&nbsp;</td>
			<td align=center><%=result[i][1]%>&nbsp;</td>
			<td align=center><%=result[i][2]%>&nbsp;</td>
			<td align=center><%=result[i][3]%>&nbsp;</td>
			<td align=center><%=result[i][4]%>&nbsp;</td>
			<td align=center><%=result[i][5]%>&nbsp;</td>
			<td align=center><%=result[i][6]%>&nbsp;</td>
			<td align=center><%=result[i][7]%>&nbsp;</td>
			<td align=center><%=result[i][8]%>&nbsp;</td>
			<td align=center><%=result[i][9]%>&nbsp;</td>
			<td align=center><%=result[i][10]%>&nbsp;</td>
			<td align=center><%=result[i][11]%>&nbsp;</td>
		</tr>
<%
		}
	} else if (r2.length>0) {
%>
	<!-add by jiyk  2012-07-18 ���wangwg�����ѯ���-->
<%
		result=r2;
		for(int j=0;j<r2.length;j++){
%>
		<tr onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#E8E8E8';">
			<td><input type="checkbox" value="<%=result[j][4]%>" onclick="choose(this)" /></td>
			<td><%=(j+1)%>&nbsp;</td>
			<td><%=result[j][0]==null?"":result[j][0]%>&nbsp;</td>
			<td><%=result[j][1]==null?"":result[j][1]%>&nbsp;</td>
			<td><%=result[j][1]==null?"":result[j][1]%>&nbsp;</td>
			<td><%=result[j][2]==null?"":result[j][2]%>&nbsp;</td>
			<td><%=result[j][3]==null?"":result[j][3]%>&nbsp;</td>
			<td><%=result[j][4]==null?"":result[j][4]%>&nbsp;</td>
			<td><%=result[j][5]==null?"":result[j][5]%>&nbsp;</td>
			<td>
<%
	    String fee=result[j][6]==null?"":result[j][6];
	    if(fee.equals("")){
	      out.print("����");
	    }else if(fee.trim().equals("0")){
	    	out.print("���");
	    }else if(fee.trim().equals("1")){
	    	out.print("����/����");
	    }else if(fee.trim().equals("2")){
	    	out.print("����");
	    }else if(fee.trim().equals("3")){
	    	out.print("��ʱ");
			}else if(fee.trim().equals("4")){
	    	out.print("����");
	    }else if(fee.trim().equals("5")){
	    	out.print("��Ŀ����");
			}else if(fee.trim().equals("7")){
	    	out.print("����");
	    }else if(fee.trim().equals("12")){
	    	out.print("����");
	    }
%>
			</td>
			<td><%=result[j][7]==null?"":result[j][7]%>&nbsp;</td>
			<td>
<%
			String isSelfBusi=result[j][8]==null?"":result[j][8];
			if(isSelfBusi.equals("")){
				out.print("");
			}else if(isSelfBusi.trim().equals("1")){
				out.print("����ҵ��");
			}else if(isSelfBusi.trim().equals("0")){
		  	out.print("������");
			}
%>
			</td>
			<td><%=result[j][9]==null?"":result[j][9]%>&nbsp;</td>
			<td><%=result[j][10]==null?"":result[j][10]%>&nbsp;</td>
			<td>
<%
			String specialDec=(result[j][11]==null?"":result[j][11]);
			if(specialDec.trim().equals("")||specialDec.trim().equals("0")){
				out.print("���ʷ�����");
		  }else{
				out.print(specialDec);
			}
%>
			</td>
			
		</tr>
<%
		}
	}
%>
		<tr>
		 	<td colspan="15" align="center">
		 		<input type="button" class="b_text" value="��ݳ�������" onclick="toW001()">
		 	</td>
		</tr>
	</table>
</div>
</form>
</BODY>
</HTML>
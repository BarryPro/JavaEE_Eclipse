<%
  /*
   * ����: 20130124
   * ����: zhouby
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.RoleManage.wrapper.*"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<html>
<head>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
  request.setCharacterEncoding("GBK");
  
	String opName = (String)request.getParameter("opName");
	String opCode = (String)request.getParameter("opCode");
	
	String workNo = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
	
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd HH:mm");
	String currentDate = dateFormat.format(new java.util.Date());
	
	comImpl comResult = new comImpl();
	String sql2 = "SELECT power_right,right_name FROM spowervaluecode";
	
//	ArrayList powerRightArr = RoleManageWrapper.getPowerRight();
	ArrayList powerRightArr = comResult.spubqry32("2",sql2);
	String[][] powerRight = (String[][])powerRightArr.get(0);
	
	String sql4 = "SELECT rpt_right,right_name FROM srptright";
	
//	ArrayList rptArr = RoleManageWrapper.getRptCode();
	ArrayList rptArr = comResult.spubqry32("2",sql4);
	String[][] rptCode = (String[][])rptArr.get(0);
%>
<title><%=opName%></title>
<script language="javascript">
	function controlBtn(flag) {
			$("#submitBtn").attr("disabled", flag);
			$("#closeBtn").attr("disabled", flag);
	}

	function doCfm() {
		if(!checkForm()){
				return false;
		}
		
		
		
		setupData();
		document.frm.submit();
	}
	
	function checkForm(){
		controlBtn('disabled');
		if (!forDate(document.getElementById("yallowBegin"))){
				controlBtn('');
				return false;
		}
		
		if (!forDate(document.getElementById("yallowEnd"))){
				controlBtn('');
				return false;
		}
		
		var chechboxes = document.getElementsByName('section');
		var flag = false;
		for (var i = 0; i < chechboxes.length; i++){
				if (chechboxes[i].checked == true){
						flag = true;
						break;
				}
		}
		if (!flag){
				rdShowMessageDialog("�������ٹ�ѡһ���޸��", 1);
				controlBtn('');
				return false;
		}
		
		if (document.getElementById("fileName").value.length == 0) {
				rdShowMessageDialog("��ѡ���ϴ����ļ���", 1);
				controlBtn('');
				return false;
		}
		if($("#oaNumber").val()==""){
			rdShowMessageDialog("������OA��ţ�");
			controlBtn('');
			return false;
		}
		if($("#oaTitle").val()==""){
			rdShowMessageDialog("������OA���⣡");
			controlBtn('');
			return false;
		}
		
		return true;
	}
	
	function setupData() {
		var actionString = 'fg443Cfm.jsp?';
		actionString += '&opCode=<%=opCode%>&opName=<%=opName%>';
		
		var iallowBegin = document.getElementById('iallowBegin').value;
		var iallowEnd = document.getElementById('iallowEnd').value;
		actionString += '&iallowBegin=' + iallowBegin + '&iallowEnd=' + iallowEnd;
		
		var ipowerRight = document.getElementById('ipowerRight').value;
		var irptRight = document.getElementById('irptRight').value;
		actionString += '&ipowerRight=' + ipowerRight + '&irptRight=' + irptRight;
		actionString+="&oaNumber="+$("#oaNumber").val()+"&oaTitle="+$("#oaTitle").val();
		var sections = document.getElementsByName('section');
		for (var i = 0; i < sections.length; i++){
				if (sections[i].checked == true){
						actionString += '&' + sections[i].op_flag + '=1';
				} else {
						actionString += '&' + sections[i].op_flag + '=0';
				}
		}
		document.frm.action = actionString;
	}
	
	function closeWindow() {
			if(window.opener == undefined) {
					removeCurrentTab();
			} else {
					window.close();
			}
	}
</script>
</head>
<body>
<form name="frm" method="post" enctype="multipart/form-data">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ѡ��¼���ļ�</div>
	</div>
	
	<table cellspacing="0">
		<tr>
			<td width="20%" class="blue">Ȩ��ֵ</td>
			<td>
				<select name="ipowerRight">
<%
					for(int i = 0 ; i < powerRight.length; i ++) {
%>
						<option value="<%=powerRight[i][0]%>"><%=powerRight[i][0]%>-><%=powerRight[i][1]%></option>
<%
					}
%>
				</select>
			</td>
			<td class="blue">����Ȩ��</td>
			<td>
					<select name="irptRight">
<%
						for(int i = 0 ; i < rptCode.length; i ++){
%>
							<option value="<%=rptCode[i][0]%>"><%=rptCode[i][1]%></option>
<%
						}
%>
				  </select>
			</td>
		</tr>
		<tr>
			<td width="20%" class="blue">��½����ʱ��</td>
			<td width="30%">
				<input type="text" size="20" id="yallowBegin" name="iallowBegin" id="iallowBegin" value="<%=currentDate%>" v_format="yyyyMMdd HH:mm">
			</td>
			<td width="20%"  class="blue">��½�������ʱ��</td>
			<td>
				<input type="text" size="20" id="yallowEnd" name="iallowEnd" id="iallowEnd" value="20500101 18:00" v_format="yyyyMMdd HH:mm">
			</td>
		</tr>
		<tr>
			<td class="blue">OA���</td>
			<td><input type="text" id="oaNumber" name="oaNumber" maxlength="30"/><font color="orange">*</font>
			</td>
			<td class="blue">OA����</td>
			<td><input type="text" id="oaTitle" name="oaTitle" maxlength="30"/><font color="orange">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">ѡ���޸�</td>
			<td colspan="3">
				<label>
  				<input type="checkbox" name="section" op_flag="ipowerChg" checked="true"/>�޸�Ȩ��ֵ
  			</label>
  			<label>
  				<input type="checkbox" name="section" op_flag="irptChg" checked="true"/>�޸ı���Ȩ��
  			</label>
  			<label>
  				<input type="checkbox" name="section" op_flag="iallowbChg" checked="true"/>�޸ĵ�¼����ʱ��
  			</label>
  			<label>
  				<input type="checkbox" name="section" op_flag="iallowEChg" checked="true"/>�޸ĵ�¼�������ʱ��
  			</label>
			</td>
		</tr>
		<tr>
			<td class="blue" width="20%">�ļ�</td>
			<td colspan="3">
				<input type="file" name="fileName" id="fileName" class="button" style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
			</td>
		</tr>
		<tr>
			<td class="blue">�ļ�˵��</td>
			<td colspan="3">&nbsp;
					һ.�������ļ�����Ϊ�ı��ļ�����׺.txt��.TXT��<br>&nbsp;
					��.ÿ��ֻ����һ������<br>&nbsp;
					��.һ�������������ޣ�200��<br>&nbsp;
					��.ʾ�����£�<br>&nbsp;
					aaaaa0<br>&nbsp;
				  aaaaa1<br>&nbsp;
				  aaaaa2<br>&nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center" id="footer">
				<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="�ϴ�" onClick="doCfm(this)">    
				<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�" onClick="closeWindow();">
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
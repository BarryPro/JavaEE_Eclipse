
<%
/********************
 version v2.0
������: si-tech
ningtn 2012-3-13 16:01:25 �°����
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<%@ page contentType="text/html; charset=GBK"%>
	<%@ include file="/npage/include/public_title_name.jsp"%>
	<%@ include file="/npage/client4A/connect4A.jsp" %>
<%@ include file="/npage/client4A/XMLHelper.jsp" %>
<%@ include file="/npage/client4A/BASE64Crypt.jsp" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
	<%@ page import="com.sitech.common.*" %>
	<HEAD>
		<TITLE>��������ͨ�굥��ѯ</TITLE>

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String loginNo = (String)session.getAttribute("workNo");
	String flag4A = (String)session.getAttribute("flag4A");
	String appSessionId = (String)session.getAttribute("appSessionId");
	if(flag4A == null){
		flag4A = "0";
	}
	if(appSessionId == null){
		appSessionId = "0";
	}

	/* ����ʱ�� requestTime�ڵ� */
	String currTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new Date());
	/* ��ȡ�������ݺ����в��� */
	String readPath = request.getRealPath("npage/properties")+"/treasury.properties";
	/* ��ԴID */
	String appId = readValue("treasury",opCode,"appId",readPath);
	/* ��Դ���� */
	String appName = readValue("treasury",opCode,"appName",readPath);
	/* ����ID sceneId */
	String sceneId = readValue("treasury",opCode,"sceneId",readPath);
	/* �����ó���ID������ɾ�� by zhangyta at 20120824*/
	/*sceneId = "ff808081395641c901395641c9220000";*/
	/* �������� sceneName */
	String sceneName = readValue("treasury",opCode,"sceneName",readPath);
	String ipAddr = (String)session.getAttribute("ipAddr");
%>

<%
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
%>
<%
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String workNo = baseInfo[0][2];
	String workName = baseInfo[0][3];
	String nopass = (String)session.getAttribute("password");	
	String Role = baseInfo[0][5];
	String orgCode = baseInfo[0][16];
	
	String[][] temfavStr=(String[][])arr.get(3);
	String[] favStr = new String[temfavStr.length];
	for(int i=0;i<favStr.length;i++) {
		favStr[i]=temfavStr[i][0].trim();
	}
	/* ʹ���µķ�ʽУ���Ƿ�������Ȩ�� */
	boolean pwrf = false;
	String pubOpCode = opCode;
	String pubWorkNo = loginNo;	
	%>
  	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
  <%
	
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String[] mon = new String[]{"","","","","",""};

	Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4)),
					(Integer.parseInt(dateStr.substring(4,6)) - 1),
					Integer.parseInt(dateStr.substring(6,8)));
	for(int i=0;i<=5;i++){
		if(i!=5){
			mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
			cal.add(Calendar.MONTH,-2);
		}
		else
			mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
	}                                       
%>
</HEAD>

<body>
<jsp:include page="/npage/client4A/treasuryStatus.jsp">
	<jsp:param name="opCode" value="<%=opCode%>"  />
	<jsp:param name="opName" value="<%=opName%>"  />
</jsp:include>
<SCRIPT language="JavaScript">
	function isNumberString (InString,RefString){
			if(InString.length==0) return (false);
			for (Count=0; Count < InString.length; Count++)  {
				TempChar= InString.substring (Count, Count+1);
				if (RefString.indexOf (TempChar, 0)==-1)  
				return (false);
			}
			return true;
	}
	
	function doCheck(){
		if(!forDate(document.frm1527.searchTime)){
		  rdShowMessageDialog("�������������ʽ����ȷ,����������!");
		  return false;
		}

		if(!check(document.frm1527)){
			return false;
		}
		if( document.frm1527.phoneNo.value.length<11) {	
			rdShowMessageDialog("������벻��С��11λ������������ !");
			document.frm1527.phoneNo.focus();
			return false;
		} else if (!document.frm1527.passWord.disabled) {
			if (document.frm1527.passWord.value.length == 0) {
				rdShowMessageDialog("��ѯ���벻��Ϊ�գ����������� !");
				document.frm1527.passWord.focus();
				return false;
			} else {
				document.frm1527.action="fDetQry1516.jsp?qryType="+document.frm1527.detType.value+"&qryName="
				+document.frm1527.detType.options[document.frm1527.detType.options.selectedIndex].text;
				
				frm1527.submit();
			}
		} else {
			document.frm1527.action="fDetQry1516.jsp?qryType="+document.frm1527.detType.value+"&qryName="
			+document.frm1527.detType.options[document.frm1527.detType.options.selectedIndex].text;
			var getdataPacket = new AJAXPacket("fAjax5085.jsp","���ڻ�����ݣ����Ժ�......");
				getdataPacket.data.add("loginNo","<%=loginNo%>");
				getdataPacket.data.add("sceneId","<%=sceneId%>");
				getdataPacket.data.add("sceneName","<%=sceneName%>");
				getdataPacket.data.add("phoneNo",document.frm1527.phoneNo.value);
				getdataPacket.data.add("currTime","<%=currTime%>");
				getdataPacket.data.add("appId","<%=appId%>");
				getdataPacket.data.add("appName","<%=appName%>");
				getdataPacket.data.add("flag4A","<%=flag4A%>");
				getdataPacket.data.add("appSessionId","<%=appSessionId%>");
				getdataPacket.data.add("ipAddr","<%=ipAddr%>");
				
				core.ajax.sendPacket(getdataPacket,doFileInput);
				getdataPacket = null;
		}
		return true;
	}
	function doFileInput(packet){
			var result = packet.data.findValueByName("result");
		   // alert("test result is "+result);
			var resultDesc = packet.data.findValueByName("resultDesc");
			if(result == "1"){
				/**���óɹ� */
				frm1527.submit();
			}else{
				/**����ʧ�� */
				rdShowMessageDialog("ִ��ʧ�ܣ�ʧ��ԭ��" + resultDesc);
				return false;
			}
		}
	function seltimechange() {
		if (document.frm1527.searchType.selectedIndex == 0) {
		   IList1.style.display = "";
		   IList2.style.display = "none";
		} else {
		   IList1.style.display = "none";
		   IList2.style.display = "";
		}
	}
	function doReset(){
		$("#resetBtn").click();
		seltimechange();
	}
</SCRIPT>

		<FORM method=post name="frm1527">
			<input type="hidden" name="opCode" value="<%=opCode%>" />
			<input type="hidden" name="opName" value="<%=opName%>" />
			
			<input type="hidden" name="monNum" value="1" />
	    <%@ include file="/npage/include/header.jsp" %>
	    <div class="title">
	        <div id="title_zi">��ѡ���ѯ����</div>
	    </div>
						<TABLE cellSpacing="0">
							<TR>
								<TD width=16% class="blue">
									�������
								</TD>
								<TD width=34%>
									<input type="text" name="phoneNo" size="20" maxlength="11" v_type="mobphone" v_must="1" onblur = "checkElement(this)"  />
									<font class="orange">*</font>
								</TD>
								<TD class="blue">
									��ѯ����
								</TD>
								<%if(pwrf) {%>
								<TD width=34%>
									<input type="password" class="button" name="passWord"
										size="20" maxlength="8" disabled>
								</TD>
								<% } else { %>
								<TD width=34%>
									<jsp:include page="/page/common/pwd_1.jsp">
										<jsp:param name="width1" value="16%" />
										<jsp:param name="width2" value="34%" />
										<jsp:param name="pname" value="passWord" />
										<jsp:param name="pwd" value="12345" />
									</jsp:include>
								</TD>
								<%}%>
							</TR>

							<TR>
								<TD width=16% class="blue">
									��ѯ����
								</TD>
								<TD width=34%>
									<select name="searchType" onchange="seltimechange()">
										<option value="0" selected>
											ʱ�䷶Χ
										</option>
										<option value="1">
											��������
										</option>
									</select>
								</TD>
								<TD width=16%></TD>
								<TD width=34%></TD>
							</TR>

							<TR id="IList1">
								<TD width=16% class="blue">
									��ʼ����
								</TD>
								<TD width=34%>
									<input type="text" name="beginTime" size="20" maxlength="8"
										 value="<%=mon[1]+"01"%>" v_type="date" onblur="checkElement(this)" />
								</TD>
								<TD width=16% class="blue">
									��������
								</TD>
								<TD width=34%>
									<input type="text" name="endTime" size="20" maxlength="8"
										 value="<%=dateStr%>" v_type="date" onblur="checkElement(this)" />
								</TD>
							</TR>

							<TR style="display:none;" id="IList2">
								<TD width=16% class="blue">
									��������
								</TD>
								<TD width=34%>
									<input type="text" class="button" name="searchTime" size="20"
										maxlength="6" value="<%=mon[1]%>" v_format="yyyyMM" onblur="checkElement(this)" />
								</TD>
								<TD width=16%></TD>
								<TD width=34%></TD>
							</TR>

							<TR>
								<TD class="blue">
									�굥����
								</TD>
								<TD>
									<select align="left" name="detType" width=50 index="4">
										<option class="button" value="0">
											ȫ��
										</option>
										<option class="button" value="1">
											��ͨ�����굥
										</option>
										<option class="button" value="2">
											�����������굥
										</option>
										<option class="button" value="3">
											����
										</option>
										<option class="button" value="4">
											�����л�������
										</option>
										<option class="button" value="5">
											��������
										</option>
										<option class="button" value="6">
											�����ж���
										</option>
										<option class="button" value="7">
											��ת
										</option>
									</select>
								</TD>
								<TD width=16% class="blue">
									��������
								</TD>

								<%if(pwrf) {%>
								<TD width=34%>
									<input type="password" class="button" name="towPassWord"
										size="20" maxlength="8" disabled>
								</TD>
								<% } else { %>
								<TD width=34%>
									<jsp:include page="/page/common/pwd_1.jsp">
										<jsp:param name="width1" value="16%" />
										<jsp:param name="width2" value="34%" />
										<jsp:param name="pname" value="towPassWord" />
										<jsp:param name="pwd" value="12345" />
									</jsp:include>
								</TD>
								<%}%>
							</TR>
						</TABLE>

					<!------------------------>

					<table cellspacing="0">
						<tr>
							<td id="footer">
								&nbsp; <input class="b_foot" name=Button1 type="button"
									onClick="doCheck()" value=��ѯ />
								&nbsp; <input class="b_foot" name=reset type="button" onClick="doReset()"
									value=��� />
									<input name="resetBtn" id="resetBtn" type="reset" style="display:none;" />
								&nbsp; <input class="b_foot" name=back
									onClick="removeCurrentTab();" type=button value=�ر� />
								&nbsp; 
							</td>
						</tr>
					</table>
					<%@ include file="/npage/include/footer.jsp" %>
					<jsp:include page="/page/common/pwd_comm.jsp" />
		</FORM>
	</BODY>
</HTML>

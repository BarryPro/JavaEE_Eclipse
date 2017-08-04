<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-13
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%@ page import="java.util.ArrayList" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	String opName = "���ſͻ���ѯ";
	//�õ��������
	ArrayList retArray = new ArrayList();
	ArrayList retArray1 = new ArrayList();
	String return_code,return_message;
	String[][] result = new String[][]{};
	String[][] allNumStr =  new String[][]{};

	String pageTitle = WtcUtil.repNull(request.getParameter("pageTitle"));
	String fieldNum = "";
	String fieldName = WtcUtil.repNull(request.getParameter("fieldName"));
	String customerNumber = WtcUtil.repNull(request.getParameter("customerNumber"));
	String toOperate = WtcUtil.repNull(request.getParameter("toOperate"));
	
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	
	String selType = WtcUtil.repNull(request.getParameter("selType"));
	String retQuence = WtcUtil.repNull(request.getParameter("retQuence"));
	if(selType.compareTo("S") == 0) {
		selType = "radio";
	}
	if(selType.compareTo("M") == 0) {
		selType = "checkbox";
	}
	if(selType.compareTo("N") == 0) {
		selType = "";
	}
	
	int chPos = 0;
	String typeStr = "";
	String inputStr = "";
	String valueStr = "";   
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>������BOSS-������ת״̬ͬ�������ѯ</TITLE>
<SCRIPT type=text/javascript>
	function saveTo() {
		var rIndex;        //ѡ�������
		var retValue = ""; //����ֵ
		var chPos;         //�ַ�λ��
		var obj;
		var fieldNo;        //���������к�
		var retFieldNum = document.fPubSimpSel.retFieldNum.value;
		var retQuence = document.fPubSimpSel.retQuence.value;  //�����ֶ��������
		var retNum = retQuence.substring(0,retQuence.indexOf("|"));
		retQuence = retQuence.substring(retQuence.indexOf("|")+1);
		var tempQuence;
		if(retFieldNum == "") {
			return false;
		}
		//���ص�����¼
		for(i=0;i<document.fPubSimpSel.elements.length;i++) {
			if (document.fPubSimpSel.elements[i].name=="List") {    //�ж��Ƿ��ǵ�ѡ��ѡ��
				if (document.fPubSimpSel.elements[i].checked==true) {     //�ж��Ƿ�ѡ��
					//alert(document.fPubSimpSel.elements[i].value);
					rIndex = document.fPubSimpSel.elements[i].RIndex;
					tempQuence = retQuence;
					for(n=0;n<retNum;n++) {
						chPos = tempQuence.indexOf("|");
						fieldNo = tempQuence.substring(0,chPos);
						//alert(fieldNo);
						obj = "Rinput" + rIndex + "0" + fieldNo;
						retValue = retValue + document.all(obj).value + "|";
						tempQuence = tempQuence.substring(chPos + 1);
					}
					window.returnValue= retValue;
				}
			}
		}
		if(retValue =="") {
			rdShowMessageDialog("��ѡ����Ϣ�");
			return false;
		}
		//opener.document.getElementById("businessMode").value = $("#businessMode").val();
		opener.getProductOrderValue(retValue);
		window.close(); 
	}

	function allChoose() {   //��ѡ��ȫ��ѡ��
		for(i=0;i<document.fPubSimpSel.elements.length;i++) { 
			if(document.fPubSimpSel.elements[i].type=="checkbox") {    //�ж��Ƿ��ǵ�ѡ��ѡ��
				document.fPubSimpSel.elements[i].checked = true;
			}
		}
	}

	function cancelChoose() {   //ȡ����ѡ��ȫ��ѡ��
		for(i=0;i<document.fPubSimpSel.elements.length;i++) {
			if(document.fPubSimpSel.elements[i].type =="checkbox") {    //�ж��Ƿ��ǵ�ѡ��ѡ��
				document.fPubSimpSel.elements[i].checked = false;
			}
		}
	}
</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">   
<%@ include file="/npage/include/header_pop.jsp" %>
<div class="title">
	<div id="title_zi">��ѯ���</div>
</div>
<table cellspacing="0">
<TR align=center>
	<!--TH nowrap>��Ʒ������</TH>
	<TH nowrap>��ǰ״̬</TH>
	<TH nowrap>��ǰ״̬������</TH>
	<TH nowrap>�绰</TH>
	<TH nowrap>���ڵ�λ������</TH>
	<TH nowrap>״̬ͬ��ʱ��</TH>
	<TH nowrap>��ע</TH-->
	<TH nowrap>��Ʒ������</TH>
	<TH nowrap>EC���ſͻ�����</TH>
	<TH nowrap>��Ʒ������</TH>
	<TH nowrap>��ǰ״̬</TH>
	<TH nowrap>״̬ͬ��ʱ��</TH>
	<TH nowrap>��ע</TH>
</TR> 
<%  //���ƽ����ͷ  
	chPos = fieldName.indexOf("|");
	out.print("");
	String titleStr = "";
	int tempNum = 0;
	while(chPos != -1) {
		valueStr = fieldName.substring(0,chPos);
		titleStr = "";
		out.print(titleStr);
		fieldName = fieldName.substring(chPos + 1);
		tempNum = tempNum +1;
		chPos = fieldName.indexOf("|");
	}
	out.print("");
	fieldNum = String.valueOf(tempNum);
	System.out.println("====wanghfa====fPubSel.jsp==== EC��� = " + customerNumber);
	System.out.println("====wanghfa====fPubSel.jsp==== �������� = " + toOperate);
%>
	<wtc:service name="sStaPOListQry" routerKey="region" routerValue="<%=regionCode%>"
			retcode="retCode1" retmsg="retMsg1" outnum="7">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="e555"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=customerNumber%>"/>	<!--EC���-->
		<wtc:param value="<%=toOperate%>"/>	<!--��������-->
	</wtc:service>
	<wtc:array id="retArr1" start="0" length="7" scope="end"/>
<%
	if (retCode1.equals("000000")){
		result = retArr1;
	} else {
		%>
		<script type=text/javascript>
			rdShowMessageDialog("sStaPOListQry������룺<%=retCode1%>��������Ϣ��<%=retMsg1%>", 0);
			window.close();
		</script>
		<%
	}
	System.out.println("====wanghfa====fPubSel.jsp==== result.length = " + result.length);
	for (int i = 0; i < result.length; i ++) {
		for (int j = 0; j < result[i].length; j ++) {
			System.out.println("====wanghfa====fPubSel.jsp==== result["+i+"]["+j+"] = " + result[i][j]);
		}
	}

	int recordNum = result.length;
	for(int i=0;i<recordNum;i++) {
		typeStr = "";
		inputStr = "";
		out.print("<TR align=center>");
		for(int j = 0; j < 7; j ++) {
			if (j == 0) {
				typeStr = "<TD>";
				if(selType.compareTo("") != 0) {
					typeStr = typeStr + "<input type='" + selType +  
						"' name='List' style='cursor:hand' RIndex='" + i + "'" + 
						"onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
				}
				typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
					" id='Rinput" + i + "0" + j + "' class='button' value='" + 
					(result[i][j]).trim() + "'readonly></TD>";          		            
			} else if (j == 6) {
				inputStr = inputStr + "<TD style='display:none'>" + (result[i][j]).trim() + "<input type='hidden' " +
					" id='Rinput" + i + "0" + j + "' class='button' value='" + 
					(result[i][j]).trim() + "'readonly></TD>";
			} else {   
				inputStr = inputStr + "<TD>" + (result[i][j]).trim() + "<input type='hidden' " +
					" id='Rinput" + i + "0" + j + "' class='button' value='" + 
					(result[i][j]).trim() + "'readonly></TD>";
			}
		}
		out.print(typeStr + inputStr);
		out.print("</TR>");
	}
	
%>   
</table>

<!------------------------------------------------------>
<TABLE cellSpacing=0>
	<TR id="footer"> 
		<TD align=center>
			<%
			if(selType.compareTo("checkbox") == 0) {
				out.print("<input class='b_foot' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=ȫѡ>&nbsp");
				out.print("<input class='b_foot' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=ȡ��ȫѡ>&nbsp");       
			}
			if(selType.compareTo("") != 0) {
				%>
				<input class="b_foot" name=commit onClick="saveTo()" type=button value=ȷ��>
				<%
			}
			%>             
			<input class="b_foot" name=back onClick="window.close()" type=button value=����>        
		</TD>
	</TR>
</TABLE>
<!------------------------> 
<input type="hidden" name="retFieldNum" id="retFieldNum" value=<%=fieldNum%>>
<input type="hidden" name="retQuence" id="retQuence" value=<%=retQuence%>>
<!------------------------>
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY>
</HTML>    

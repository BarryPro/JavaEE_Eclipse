<%
  /*
   * ����: ���������ѯ 1100
   * �汾: 1.0
   * ����: 2014/11/3
   * ����: diling
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	
	String workNo = (String)session.getAttribute("workNo");		//��������
	String password = (String)session.getAttribute("password");	//��������
	String regCode = (String)session.getAttribute("regCode");
  String opCode 	= request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String opNote = workNo+"������"+opCode+"[���������ѯ]����";
%>
<%!
	public static String subString(String text, int length, String endWith) {
		int textLength = text.length();
		int byteLength = 0;
		StringBuffer returnStr = new StringBuffer();
		for (int i = 0; i < textLength && byteLength < length ; i++) {
			String str_i = text.substring(i, i + 1);
			if (str_i.getBytes().length == 1) {// Ӣ��
				byteLength++;
			} else  {// ����
				if(byteLength>length-2){
					break;
				}else{
					byteLength += 2;
				}
			}
			returnStr.append(str_i);
		}
		try {
			if (byteLength < text.getBytes("GBK").length) {// getBytes("GBK")ÿ�����ֳ�2��getBytes("UTF-8")ÿ�����ֳ���Ϊ3
				returnStr.append(endWith);
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return returnStr.toString();
	}
%>

	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
		
	<wtc:service name="sM196Qry" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="11">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=opNote%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
	if(!"000000".equals(retCode)){
%>
		<SCRIPT type=text/javascript>
			alert("���������ѯʧ�ܣ�������룺<%=retCode%>������Ϣ��<%=retMsg%>");
			window.close();
		</SCRIPT>
<%
	}
String endWith="";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<SCRIPT type=text/javascript>
			function saveToQryInfo(){
				var selListReltsVal = $("input[@name=selListRelts][@checked]").val();
				var v_orderStatus = $("input[@name=selListRelts][@checked]").attr("v_orderStatus"); //���ǽ��ն�����ʱ�򣬶���״̬
				var v_orderReslt = $("input[@name=selListRelts][@checked]").attr("v_orderReslt"); //���Ź淶���أ��Ƿ�ͨ������ʱ
				if(typeof(selListReltsVal) == "undefined"){
					rdShowMessageDialog("��ѡ��һ���ѯ��������ύ��");
				  return false;
				}
				if(v_orderStatus == "U" || v_orderStatus == "J"){ //����״̬���������߼����·�����
					if(v_orderReslt != "1"){ //��֤��ͨ�������߳�ʱ 
						rdShowMessageDialog("������֤��ͨ��������֤��ʱ���������������ҵ��");
					  return false;
					}
				}else{ //��ʱ
					rdShowMessageDialog("����״̬��ʱ���������������ҵ��");
				  return false;
				}
				
				var v_custName = $("input[@name=selListRelts][@checked]").attr("v_custName");//�ͻ����� 
				var v_idIccid = $("input[@name=selListRelts][@checked]").attr("v_idIccid"); //�ͻ�����
				var v_idAddr = $("input[@name=selListRelts][@checked]").attr("v_idAddr"); //�ͻ���ַ
				var v_validDate = $("input[@name=selListRelts][@checked]").attr("v_validDate"); //֤����Ч��
				var v_loginacceptJT = $("input[@name=selListRelts][@checked]").attr("v_loginacceptJT"); //֤����Ч��
				var v_validDates = "";
				if(v_validDate.indexOf("-") != -1){
					v_validDate = v_validDate.split("-");
					if(v_validDate.length >= 3){
						v_validDates = v_validDate[0]+v_validDate[1]+v_validDate[2]; 
					}
				}
				window.returnValue=v_custName+"~"+v_idIccid+"~"+v_idAddr+"~"+v_validDates+"~"+v_loginacceptJT;
				window.close(); 
			}
		</SCRIPT>
		<TITLE>���������ѯ</TITLE>
	</HEAD>

	<BODY>
		<FORM method=post name="fPubSimpSel">   
		<%@ include file="/npage/include/header_pop.jsp" %>

			<div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">���������ѯ</div>
			</div>
			<table cellspacing="0" name="t1" id="t1" vColorTr='set'>
				<tr>
					<th></th>
					<th>�ͻ�����</th>
					<th>֤������</th>
					<th>֤����ַ</th>
					<th>��֤���</th>
					<th>��֤��ͨ������</th>
					<th>��֤�����������</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='7'>");
					out.println("û���κμ�¼��");
					out.println("</td></tr>");
				}else if(ret.length>0){
					for(int i=0;i<ret.length;i++){
						if(!"".equals(ret[i][0])){ //�����·����Ŵ��ڣ���һ��������Ϣ
						String idAddr = ret[i][3];
							if(idAddr.getBytes("GBK").length>60){
								idAddr =subString(idAddr,60,endWith);
							}
%>
							<tr align="center" id="row_<%=i%>">
								<td><input type="radio" id="selListRelts<%=i%>" name="selListRelts" value="<%=ret[i][0]%>" v_custName="<%=ret[i][1]%>" v_idIccid="<%=ret[i][2]%>" v_idAddr="<%=idAddr%>" v_orderStatus="<%=ret[i][8]%>" v_orderReslt="<%=ret[i][5]%>" v_validDate="<%=ret[i][9]%>" v_loginacceptJT="<%=ret[i][10]%>" /></td>
								<td><%=ret[i][1]%></td>
								<td><%=ret[i][2]%></td>
								<td><%=idAddr%></td>
								<td>
									<%if("1".equals(ret[i][5])){%>
											��֤ͨ��
									<%}else if("2".equals(ret[i][5])){%>
											��֤��ͨ��
									<%}else{%>
											��֤��ʱ
									<%}%>
								</td>
								<td>
									<%if("".equals(ret[i][6])){%>
											��
									<%}else{%>
											<%=ret[i][6]%>
									<%}%>
								</td>
								<td>
									<%if("".equals(ret[i][7])){%>
											��
									<%}else{%>
											<%=ret[i][7]%>
									<%}%>
								</td>
							</tr>
<%
						}
					}
				}
%>
				<tr>
				  <td colspan="7" align="center" id="footer">
				    <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="ȷ��" onClick="saveToQryInfo()" />   
				    <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="�ر�" onClick="window.close();" />
				  </td>
				</tr>
			</table>
	</div>
</div>
		<%@ include file="/npage/include/footer_pop.jsp" %>
		</FORM>
	</BODY>
</HTML>    

<%
  /*
   * ����: m201����ʡ��ҵӦ�úڰ�������ѯ
   * �汾: 1.0
   * ����: 2014/11/17
   * ����: diling
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
    
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName"); 
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
	<script language="JavaScript">
		// �б�
		function query(){
		  if(!check(frm)){return false;};
			var myPacket = new AJAXPacket("fm201_ajax_qryInfo.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
		  myPacket.data.add("phoneNo",$("#phoneNo").val());
		  myPacket.data.add("opCode","<%=opCode%>");
		  myPacket.data.add("opName","<%=opName%>");
		  core.ajax.sendPacketHtml(myPacket,doQuery);
		  getdataPacket = null;
		}
	
		function doQuery(data){
			var markDiv=$("#intablediv"); 
			markDiv.empty();
			markDiv.append(data);
		  var retCode = $("#retCode").val();
		  var retMsg = $("#retMsg").val();
		  if(retCode!="000000"){
				rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
				window.location.href="fm201_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		  }
		}
		
		/* ������н�����ʽ */
		$("table[vColorTr='set']").each(function(){
			$(this).find("tr").each(function(i,n){
				$(this).bind("mouseover",function(){
					$(this).addClass("even_hig");
				});
				
				$(this).bind("mouseout",function(){
					$(this).removeClass("even_hig");
				});
				
				if(i%2==0){
					$(this).addClass("even");
				}
			});
		});
	
	</script> 
	<title><%=opName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form name="frm"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">           
    <tr>
    	<td class="blue">�ֻ�����</td>
    	<td>
	    	<input type="text" id="phoneNo" name="phoneNo" value="" v_must="1" maxlength="18" v_type="0_9" />
    	</td>
	  </tr>
		<tr> 
			<td align="center" id="footer" colspan="2"> 
				<input type="button" name="qryBtn"  class="b_foot" value="��ѯ" onclick="query()">
				&nbsp;
				<input type="button" name="closeBtn1" class="b_foot" value="�ر�" onclick="removeCurrentTab()">
			</td>
		</tr>
	</table>
	<div id="intablediv"></div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%
  /*
   * ����: ���ⷴ��
�� * �汾: v1.0
�� * ����: 2008��12��20��
�� * ����: wuxy
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<!--�·�ҳ�õ�����-->
<%@ page import="com.sitech.crmpd.core.wtc.util.*" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
	String opCode = WtcUtil.repNull(request.getParameter("pageOpCode"));	
	String opName = WtcUtil.repNull(request.getParameter("pageOpName"));	
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	String workName = (String)session.getAttribute("workName");
	String ipAddr = (String)session.getAttribute("ipAddr");
	String orgCode = (String)session.getAttribute("orgCode");
	String productId = request.getParameter("productID");
	System.out.println("productID="+productId);
	String orderSource = request.getParameter("orderSource");
	System.out.println("orderSource="+orderSource);
	String operType = request.getParameter("operType");
	String regionCode = orgCode.substring(0,2);
	String sqlStr="";
	String tMemberProperty = "";
	
	String workNo = (String)session.getAttribute("workNo");
	String loginPwd  = (String)session.getAttribute("password");
	
	/**��ҳҪ�õĴ���**/
    Map map = request.getParameterMap();
    String totalNumber = "";
    String currentPage = request.getParameter("currentPage") == null ? "1" : request.getParameter("currentPage");
    String pageSize = "11";
    /******************/    
	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<link href="s2002.css" rel="stylesheet" type="text/css">
	<script>
	
	function getPropertyMember(imemberNo,obj){
		var winUrl = "f2035_6.jsp?memberNo="+imemberNo+"&productId=<%=productId%>";
		var winResult=window.showModalDialog(winUrl,"","scroll:yes;dialogHeight:700px;dialogWidth:600px;dialogTop:458px;dialogLeft:166px");
	}
	
	</script>
<!--************************��ҳ����ʽ��**************************-->
<link rel="stylesheet" type="text/css" href="/nresources/default/css/fenye.css" media="all"/>
</head>
<body>
<form name="form1" method="post">
	<input type="hidden" name="pageOpCode" value="<%=opCode%>">
	<input type="hidden" name="pageOpName" value="<%=opName%>">
<%@ include file="/npage/include/header.jsp" %>

<div id="productList" >
<div class="title"><div id="title_zi">��Ա��Ϣ�б�</div></div>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
	
<wtc:service name="s2035MemberQry" routerKey="region" routerValue="<%=regionCode%>" 
	retcode="retCode" retmsg="retMsg" outnum="7">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=loginPwd%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=productId%>"/> 
	<wtc:param value="0"/><%/* �������ͣ�0-ʵʱ���ݲ�ѯ��1-�첽���ݵ��� */%>
</wtc:service>
<wtc:array id="rows"  scope="end"/>
<%
	if(!"000000".equals(retCode)){
%>
		<script>
			rdShowMessageDialog("������룺<%=retCode%><br>������Ϣ��<%=retMsg%>",0);
			window.location.href="f2035_1.jsp";
		</script>
<%
	}else{
		System.out.println("rows.length="+rows.length);
	}
%>
	
	
<table cellspacing="0" id="productTab" >
    <tr align="center">
        <th nowrap>��Ա����</th>
        <th nowrap>��Ա���� </th>
        <th nowrap>��ԱȺ��</th>   
        <th nowrap>��ʼʱ��</th>   
        <th nowrap>����ʱ��</th> 
        <th nowrap>��Ա״̬</th> 
        <th nowrap>�Ƿ�鵵</th>
        <th nowrap>����</th>
    </tr>
    <%
       for(int i=0;i<rows.length;i++){
       tMemberProperty = "";
       System.out.println(rows[i][0]);
       System.out.println(rows[i][1]);
       System.out.println(rows[i][2]);
       System.out.println(rows[i][3]);
       System.out.println(rows[i][4]);
       System.out.println(rows[i][5]);
       System.out.println(rows[i][6]);
    %>
    <tr align="center">

 <td nowrap>
        	<input type="hidden" name="tMemberProperty" id="tMemberProperty" value="<%=tMemberProperty%>" >
        	<input type="hidden" name="tMemberNo" value="<%=rows[i][0]%>" ><%=rows[i][0]%>
        </td>
        <td nowrap><input type="hidden" name="tMemberType" value="<%=rows[i][1]%>" ><%=rows[i][1]%></td>
        <td nowrap><input type="hidden" name="tMemberGroup" value="<%=rows[i][2]%>" ><%=rows[i][2]%></td>   
        <td nowrap><input type="hidden" name="tBeginTime" value="<%=rows[i][3]%>" ><%=rows[i][3]%></td>   
        <td nowrap><input type="hidden" name="tEndTime" value="<%=rows[i][4]%>" ><%=rows[i][4]%></td>
        <td nowrap><input type="hidden" name="tpoductstatus" value="<%=rows[i][5]%>" ><%=rows[i][5]%></td> 
        <td nowrap><input type="hidden" name="tguidangstatus" value="<%=rows[i][6]%>" ><%=rows[i][6]%></td> 
        <td nowrap>
        	
        	<input type="button" name="b_getProperty" onclick="getPropertyMember('<%=rows[i][0]%>',this)" class="b_text" value="�鿴��Ա����" >
        </td>
    </tr>
    <%
       }
    %>
</table>
</div>

<table cellSpacing=0> 
  <tr>
    <td align="center" id="footer" colspan="4">
    	<input type="button"  id="exportBtn" class='b_foot' value="ȫ������" name="exportBtn" />
      <input class="b_foot" name=next id=nextoper type=button value="����" onclick="history.go(-1)" >
      <input class="b_foot" name=reset type=button value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
    </td>
  </tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
<script type=text/javascript>
	$('#exportBtn').click(function() {
		var myPacket = new AJAXPacket("syncExport.jsp","���ڻ�ü�¼���������Ժ�...");
		myPacket.data.add("opCode","<%=opCode%>");
		myPacket.data.add("productId", "<%=productId%>");
		
		core.ajax.sendPacket(myPacket, function(packet){
			var errorCode = packet.data.findValueByName('retCode');
			var errorMsg = packet.data.findValueByName('retMsg');
			if (errorCode == '000000'){
				rdShowMessageDialog("���������¼�ɹ����뵽g079ģ���ѯ���������");
			}else{
				rdShowMessageDialog("����ʧ�ܣ�" + errorCode + errorMsg);
			}
		});
		myPacket=null;
	});
</script>
</BODY>
</HTML>

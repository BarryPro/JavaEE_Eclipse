<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-19
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<%
    String opCode = "1994";
    String opName = "���ſͻ�����";
	Logger logger = Logger.getLogger("f1994_main.jsp");
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	
	String workName = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String org_code = orgCode;
	String nopass  = (String)session.getAttribute("password");
	String regionCode=org_code.substring(0,2);
	String op_name="���ſͻ�����";
	
	//yyyyMMdd��ʽ�ĵ�ǰ����
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>���ſͻ�����</title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
window.onkeydown(window.event) 
</SCRIPT>
</head> 
<script language=javascript>
function onkeydown(event) 
{
	if (event.srcElement.type!="button")
	{
		if (event.keyCode == 13)
		{
			event.keyCode = 9;
		}
	}
}

var fontcode="1";
//-----�任������ѡ���͵���ɫ-----
function showtbs(font)
{	
	fontcode=font;
	
	

	if(document.form1.cust_id.value=="")
	{
		if(fontcode==1 )
		{
			tbs1.style.display="";
			tbs2.style.display="none";
			document.all.query_type.value="0";
			document.all.cust_id.v_type="0_9";
			document.all.cust_id.v_name="�������";
			document.all.cust_id.value="";
			document.all.cust_id.maxLength="10";
			rdShowMessageDialog("�������뼯����ţ�");
			document.form1.cust_id.focus();
			return;
		}
		else
		{
			if(document.all.query_type.value=="0")
			{
				rdShowMessageDialog("�������뼯����ţ�");
			}
			else
			{
				rdShowMessageDialog("���������ֻ����룡");
			}
		}
		document.form1.cust_id.focus();
		return;
	}
	document.form1.action="<%=request.getContextPath()%>/npage/s1994/f1994"+fontcode+"_list.jsp";
	document.form1.target="listFrame";	
	document.form1.submit();
	parent.document.body.rows="160,*";
}

	function getAfterPrompt()
	{
		var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","���Ժ�...");
		packet.data.add("opCode" ,"<%=opCode%>");
	  core.ajax.sendPacket(packet,doGetAfterPrompt,false);//ͬ��
		packet =null;
	}
	
	function doGetAfterPrompt(packet)
	{
    var retCode = packet.data.findValueByName("retCode"); 
    var retMsg = packet.data.findValueByName("retMsg"); 
    if(retCode=="000000"){
    	promtFrame(retMsg);
    }
	}
function showList()
{
	document.form1.action="<%=request.getContextPath()%>/npage/s1994/f1994"+fontcode+"_list.jsp";
	document.form1.target="listFrame";	
	document.form1.submit();
	parent.document.body.rows="160,*";
}
	
function showDel()
{	        
    getAfterPrompt();
	if(document.form1.cust_id.value!="")
	{
    if(rdShowConfirmDialog("����ȷ�ϼ���û�в�Ʒ���û���Ҫ������")==1)
       {
         document.form1.action="<%=request.getContextPath()%>/npage/s1994/f1994_del.jsp";
	       document.form1.target="listFrame";	
	       document.form1.submit();
	       parent.document.body.rows="160,*";   
	      } 
 }
 else
 {
  rdShowMessageDialog("�������뼯����ţ�");
 }
}

function doChange()
{
	if(fontcode==1 )
	{
		if(document.all.query_type.value=="1")
		{
			rdShowMessageDialog("����Ϣֻ����ͨ��������Ų�ѯ");
			document.all.query_type.value="0";
			document.form1.cust_id.focus();
		}
	}
	else
	{	
		if(document.all.query_type.value=="0")
		{
			tbs1.style.display="";
			tbs2.style.display="none";
			document.all.cust_id.v_type="0_9";
			document.all.cust_id.v_name="�������";
			document.all.cust_id.value="";
			document.all.cust_id.maxLength="10";
		}
		else
		{
			tbs1.style.display="none";
			tbs2.style.display="";	
			document.all.cust_id.v_type="mobphone";
			document.all.cust_id.v_name="�ֻ�����";
			document.all.cust_id.value="";
			document.all.cust_id.maxLength="11";
		}
	}
}	

</script>
<body>

<form name="form1"  method="get">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�ͻ���ѯ</div>
</div>

<TABLE cellspacing="0">
    <TBODY>
    <TR id="line_1"> 
        <TD class=blue>��ѯ����</TD>
        <TD>
            <select name="query_type" onchange="doChange()">
                <option value="0">�����ű��</option>
            </select>
        </TD>
        <TD class=blue>
            <div id=tbs1 style="display:">
                �������
            </div>
            <div id=tbs2 style="display:none">
                �ֻ�����
            </div>
        <TD>
            <input type=text v_type="0_9" v_must=1 id="cust_id" name="cust_id" maxlength=10>
        </TD> 
    </TR>
    </TBODY>
</TABLE> 
<TABLE cellSpacing=0>
    <TR id="footer"> 
        <TD> 
            <input name="queryButton" type="button" class="b_foot" value="��ѯ" onClick="if(check(form1)) showList()" >
            <input name="addButton" type="button" class="b_foot" value="����" onClick="showDel()" >
        </TD>
    </TR>
</TABLE>
	<div id="relationArea" style="display:none"></div>
				<div id="wait" style="display:none">
				<img  src="/nresources/default/images/blue-loading.gif" />
			</div>
			<div id="beforePrompt"></div>
		</DIV>             
</DIV>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

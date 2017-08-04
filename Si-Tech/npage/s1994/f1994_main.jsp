<%
/********************
 * version v2.0
 * 开发商: si-tech
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
    String opName = "集团客户销户";
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
	String op_name="集团客户销户";
	
	//yyyyMMdd形式的当前日期
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>集团客户销户</title>
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
//-----变换上面所选类型的颜色-----
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
			document.all.cust_id.v_name="集团序号";
			document.all.cust_id.value="";
			document.all.cust_id.maxLength="10";
			rdShowMessageDialog("请先输入集团序号！");
			document.form1.cust_id.focus();
			return;
		}
		else
		{
			if(document.all.query_type.value=="0")
			{
				rdShowMessageDialog("请先输入集团序号！");
			}
			else
			{
				rdShowMessageDialog("请先输入手机号码！");
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
		var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","请稍后...");
		packet.data.add("opCode" ,"<%=opCode%>");
	  core.ajax.sendPacket(packet,doGetAfterPrompt,false);//同步
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
    if(rdShowConfirmDialog("请先确认集团没有产品、用户，要销户吗？")==1)
       {
         document.form1.action="<%=request.getContextPath()%>/npage/s1994/f1994_del.jsp";
	       document.form1.target="listFrame";	
	       document.form1.submit();
	       parent.document.body.rows="160,*";   
	      } 
 }
 else
 {
  rdShowMessageDialog("请先输入集团序号！");
 }
}

function doChange()
{
	if(fontcode==1 )
	{
		if(document.all.query_type.value=="1")
		{
			rdShowMessageDialog("此信息只可以通过集团序号查询");
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
			document.all.cust_id.v_name="集团序号";
			document.all.cust_id.value="";
			document.all.cust_id.maxLength="10";
		}
		else
		{
			tbs1.style.display="none";
			tbs2.style.display="";	
			document.all.cust_id.v_type="mobphone";
			document.all.cust_id.v_name="手机号码";
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
	<div id="title_zi">客户查询</div>
</div>

<TABLE cellspacing="0">
    <TBODY>
    <TR id="line_1"> 
        <TD class=blue>查询条件</TD>
        <TD>
            <select name="query_type" onchange="doChange()">
                <option value="0">按集团编号</option>
            </select>
        </TD>
        <TD class=blue>
            <div id=tbs1 style="display:">
                集团序号
            </div>
            <div id=tbs2 style="display:none">
                手机号码
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
            <input name="queryButton" type="button" class="b_foot" value="查询" onClick="if(check(form1)) showList()" >
            <input name="addButton" type="button" class="b_foot" value="销户" onClick="showDel()" >
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

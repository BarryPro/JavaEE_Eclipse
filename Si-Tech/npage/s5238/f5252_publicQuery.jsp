<%
   /*
   * 功能: 集团产品配置-公共选择模块
　 * 版本: v1.0
　 * 日期: 2007/03/13
　 * 作者: hexy
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@page contentType="text/html;charset=gb2312"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page errorPage="/page/common/error.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="org.apache.log4j.Logger"%>
<%
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String[][] otherInfoSession = (String[][])arrSession.get(2);
	String loginName = baseInfoSession[0][3];
	String orgCode = baseInfoSession[0][16];
	String loginNo = baseInfoSession[0][2];
	String ip_Addr = request.getRemoteAddr();
	String org_code = baseInfoSession[0][16];
	String[][] pass = (String[][])arrSession.get(4);
	String nopass  = pass[0][0];
	String regionCode=org_code.substring(0,2);
	
	String title_name = request.getParameter("title_name");
	String element_name = request.getParameter("element_name");
	String element_return = request.getParameter("element_return");
	String sql_str = request.getParameter("sql_str");
	String element_num = request.getParameter("element_num");
	String return_num = request.getParameter("return_num");
	String op_name = request.getParameter("op_name1");
	String page_name = request.getParameter("page_name");	
	
	
	String param_element = request.getParameter("param_element");
	String target_id = request.getParameter("target_id");
	String option_type = request.getParameter("option_type");
	String public_flag = request.getParameter("public_flag");
	
	System.out.println("target_id=="+target_id);
	System.out.println("title_name="+title_name);
	System.out.println("element_name="+element_name);
	System.out.println("element_return="+element_return);
	System.out.println("sql_str="+sql_str);
	System.out.println("element_num="+element_num);
	System.out.println("return_num="+return_num);
	System.out.println("option_type="+option_type);
	System.out.println("public_flag="+public_flag);
	
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList retList = new ArrayList();
	
	retList = impl.sPubSelect(element_num,sql_str,"region",regionCode);
	String[][] retListString = (String[][])retList.get(0);
	int errCode=impl.getErrCode();
	String errMsg=impl.getErrMsg();
	
	System.out.println(" errCode=="+errCode);
	System.out.println(" errMsg=="+errMsg);
	System.out.println(" retListString=="+retListString.length);
	
	int len = Integer.parseInt(element_num);				  //显示列数
	int return_len = Integer.parseInt(return_num);			  //返回列数
	//int len =1;
	
	//输入参数  服务组
	String[] parain_title_name		= new String[len];
	String[] parain_element_name	= new String[len];
	String[] parain_element_return	= new String[return_len];
	
	if(len==1){
	  	StringTokenizer st0 = new StringTokenizer(title_name,",");
		StringTokenizer st1 = new StringTokenizer(element_name,",");
		
		parain_title_name[0] 		=	st0.nextToken();
		parain_element_name[0] 		=	st1.nextToken();
		
		System.out.println(" parain_title_name[0]=="+parain_title_name[0]); 
		System.out.println(" parain_element_name[0]=="+parain_element_name[0]);
	}else{
		StringTokenizer st0 = new StringTokenizer(title_name,",");
		StringTokenizer st1 = new StringTokenizer(element_name,",");
		for(int i=0; i<len;i++)
		{
			parain_title_name[i]	= st0.nextToken();
			parain_element_name[i] 	= st1.nextToken();
			
			System.out.println(" parain_title_name["+i+"]=="+parain_title_name[i]); 
			System.out.println(" parain_element_name["+i+"]=="+parain_element_name[i]);
		}
	}
	if(return_len==1){
	  StringTokenizer st2 = new StringTokenizer(element_return,",");
		
		parain_element_return[0]	=	st2.nextToken();
		
		System.out.println(" parain_element_return[0]=="+parain_element_return[0]);
	}else{
		StringTokenizer st2 = new StringTokenizer(element_return,",");
		
		for(int i=0; i<return_len;i++)
		{
			parain_element_return[i]	=	st2.nextToken();
			
			System.out.println(" parain_element_return[0]=="+parain_element_return[0]);
		}
	}
%>

<html>
<head>
<title><%=op_name%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">

<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_image.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_single.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<link href="<%=request.getContextPath()%>/css/jl.css"  rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/tablabel.css">
</head>
<body>
<form name="frm" method="POST" >
<table width="99%" id="tab1" border="0" align="center" cellpadding="1" cellspacing="1">
	<tr bgColor="#eeeeee">
		<td height="26" align="center">
			选择
		</td>
		<%for(int i=0;i<len;i++){
			out.println("<td align='center'>"+parain_title_name[i]+"</td>");
		}%>
	</tr>
</table>
<table width="99%" border="0" align="center" cellpadding="1" cellspacing="1">
	<tr>
		<td>
			<div align="center">
		      <input type="button" name="commit" onClick="doCommit();" value=" 确定 ">
		      &nbsp;
		      <input type="button" name="back" onClick="doClose();" value=" 关闭 ">
		    </div>
		</td>
	</tr>
</table>
</form>
</body>
</html>
<script>
<%for(int i=0;i < retListString.length;i++){ %>
	var str='';
	<%for(int k=0;k<len;k++){%>
		str+='<input type="hidden" name="<%=parain_element_name[k]%>" value="<%=retListString[i][k]%>">';
	<%}%>

	var rows = document.getElementById("tab1").rows.length;
	var newrow = document.getElementById("tab1").insertRow(rows);
	newrow.bgColor="#f5f5f5";
	newrow.height="20";
	newrow.align="center";
	newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
	<%for(int k=0;k<len;k++){%>
		newrow.insertCell(1+<%=k%>).innerHTML = '<%=retListString[i][k]%>';
	<%}%>

<%}%>

function doCommit()
{
	var return_tmp="";
	if("<%=retListString.length%>"=="0"){
		rdShowMessageDialog("没查到您要选择的数据集！");
		return false;
	}
	else if("<%=retListString.length%>"=="1"){//值为一时不需要用数组
		if(document.all.num.checked){
			<%for(int j=0;j<return_len;j++){%>
				window.opener.form1.<%=parain_element_return[j]%>.value=document.all.<%=parain_element_name[j]%>.value;
			<%}%>
			return_tmp=document.all.<%=parain_element_name[0]%>.value;
		}
		else{
			rdShowMessageDialog("您必须选择一行数据!");
			return false;
		}
	}
	else{//值为多条时需要用数组
		var a=-1;
		for(i=0;i<document.all.num.length;i++){
			if(document.all.num[i].checked){
				a=i;
				break;
			}
		}
		if(a!=-1){
			<%for(int j=0;j<return_len;j++){%>
				window.opener.form1.<%=parain_element_return[j]%>.value=document.all.<%=parain_element_name[j]%>[a].value;
			<%}%>
			return_tmp=document.all.<%=parain_element_name[0]%>[a].value;
			window.close();
		}
		else{
			rdShowMessageDialog("您必须选择一行数据!");
			return false;
		}
	}
	
	window.opener.form1.action="<%=page_name%>?product_code="+return_tmp+"&option_type=<%=option_type%>&public_flag=<%=public_flag%>";
	window.opener.form1.target="<%=target_id%>";
	window.opener.form1.submit();
	
	window.close();
}

function doClose()
{
	window.close();
}
</script>
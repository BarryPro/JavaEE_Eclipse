<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
/********************
version v3.0
开发商: si-tech
ningtn 2012-4-9 09:29:41
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<head>
	<title>资费革命</title>
	<link href="css/prodRevoStyle.css" rel="stylesheet" type="text/css" />	
</head>
<%@ include file="/npage/login/dispatch.jsp" %>
<%
	String regionCode= (String)session.getAttribute("regCode");
	
	String getFuncSql = "SELECT a.function_code, a.function_name, a.form_name, b.open_way "+
  			"FROM sfunccodenew a, sfunccodeadd b "+
 				"WHERE a.parent_code = '99232' AND a.function_code = b.function_code order by memu_order";
%>
	<wtc:pubselect name="sPubSelect" outnum="4"  
		routerKey="region" routerValue="<%=regionCode%>">
		<wtc:sql><%=getFuncSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="arrProdFunc" scope="end"/> 	
<%

	String[] prodFuncArr=new String[arrProdFunc.length];
	for(int i = 0; i < arrProdFunc.length; i++){
		for(int j = 0; j < arrProdFunc[i].length; j++){
			System.out.println("ningtn fe761 " + arrProdFunc[i][j]);
		}
	}
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] temfavStr=(String[][])arrSession.get(1);
	String[] favStr=new String[temfavStr.length];
	for(int i=0;i<favStr.length;i++){
		favStr[i]=temfavStr[i][1].trim();
		for(int j = 0; j < arrProdFunc.length; j++){
		
			if(arrProdFunc[j][0].equals(favStr[i])){
				prodFuncArr[j] = "Y";
			}
		}
	}
	
	for(int i = 0; i < prodFuncArr.length; i++){
		System.out.println("ningtn fav " + prodFuncArr[i]);
	}
%>
<script language="javascript">
	$(document).ready(function(){
		$("span").click(function(){
			/*alert($(this).attr("spanVal"));*/
			<%
				for(int i = 0; i < arrProdFunc.length; i++){
					String tmpUrl = getLink(arrProdFunc[i][3],arrProdFunc[i][2],arrProdFunc[i][0],session,request,arrProdFunc[i][1]);
			%>
			if($(this).attr("spanVal") == "<%=arrProdFunc[i][0]%>"){
				/*alert("<%=tmpUrl%>");*/
				if("4" != "<%=arrProdFunc[i][3]%>"){
					window.location.href = "/npage/<%=tmpUrl%>?opCode=<%=arrProdFunc[i][0]%>&opName=<%=arrProdFunc[i][1]%>";
				}else{
					parent.L("<%=arrProdFunc[i][3]%>","<%=arrProdFunc[i][0]%>","<%=arrProdFunc[i][1]%>","<%=tmpUrl%>","000");
				}
			}
			<%
				}
			%>
		});
	});
</script>
<body>
	<form name="form1" method="post">
		<div id="index-left">
			<%
				for(int i = 0; i<arrProdFunc.length; i++){
					if("Y".equals(prodFuncArr[i]) && !"e761".equals(arrProdFunc[i][0])){
					System.out.println("ningtn you l " + arrProdFunc[i][0]);
%>
					<a>
						<span spanVal="<%=arrProdFunc[i][0]%>" style="cursor:hand;">
							<img src="images/<%=arrProdFunc[i][0]%>.png" alt="<%=arrProdFunc[i][1]%>"/>
							<br/>
							<%=arrProdFunc[i][1]%>
						</span>
					</a>
<%
					}
				}
			%>
	</div>
	</form>
</body>
</html>
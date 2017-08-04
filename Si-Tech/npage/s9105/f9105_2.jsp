<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
    String opCode = "9105";
    String opName = "自动校验规则查询";
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");	
	String op_name = "自动校验规则查询";
	String regionCode = (String)session.getAttribute("regCode");
    	//ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
    	//String[][] baseInfoSession = (String[][])arrSession.get(0);
    	//String[][] otherInfoSession = (String[][])arrSession.get(2);
	String orgCode = (String)session.getAttribute("rogCode");
	    //String[][] pass = (String[][])arrSession.get(4);
	String password  = (String)session.getAttribute("password");
	
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	
	String sqlStr1 = "";
	String sqlStr2 = "";
	String verifyType=request.getParameter("verifyType");
	String message=request.getParameter("message");
	if(verifyType.equals("0")){
	sqlStr1 = "select * from (select check_id,check_name,func_code,check_rule,localcode,err_code,err_desc,rownum id from sdsmprulecode where nvl(func_code,' ') like '%"+message+"%') where id <"+iEndPos+" and id>="+iStartPos;
	sqlStr2 = "select nvl(count(*),0) num from sdsmprulecode where  nvl(func_code,' ') like '%"+message+"%'";
	}
else if(verifyType.equals("1")){
	sqlStr1 = "select * from (select check_id,check_name,func_code,check_rule,localcode,err_code,err_desc,rownum id from sdsmprulecode where nvl(check_name,' ') like '%"+message+"%') where id <"+iEndPos+" and id>="+iStartPos;
	sqlStr2 = "select nvl(count(*),0) num from sdsmprulecode where  nvl(check_name,' ') like '%"+message+"%'";
	}
else{
	sqlStr1 = "select check_id,check_name,func_code,check_rule,localcode,err_code,err_desc from sdsmprulecode";
	sqlStr2 = "select nvl(count(*),0) num from sdsmprulecode";
	}
	
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retval="val1" outnum="8">
<wtc:sql><%=sqlStr1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" property="val1" scope="end" />
	
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retval="val2" outnum="1">
<wtc:sql><%=sqlStr2%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" property="val2" scope="end" />
	
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">
<!--
function checkId(i){
   var num = <%=result1[0][0]%>;
   var check_id;
   if(num>1){
   	check_id = document.frm.check_id[i].value;
   	var check_name  = document.frm.check_name[i].value;
		var func_code = document.frm.func_code[i].value;
		var check_rule  = document.frm.check_rule[i].value;
		var local_flag  = document.frm.localcode[i].value;
		var err_code = document.frm.err_code[i].value;
		var err_desc = document.frm.err_desc[i].value;
    document.frm1.check_id.value = check_id;
		document.frm1.check_name.value = check_name;
		document.frm1.func_code.value = func_code;
		document.frm1.check_rule.value = check_rule;
		document.frm1.local_flag.value = local_flag;
		document.frm1.err_code.value = err_code;
		document.frm1.err_desc.value = err_desc;
   	
   	document.frm1.check_id.value = check_id;
   	
  }else{	
    check_id = document.frm.check_id.value;
		var check_name  = document.frm.check_name.value;
		var func_code = document.frm.func_code.value;
		var check_rule  = document.frm.check_rule.value;
		var local_flag  = document.frm.localcode.value;
		var err_code = document.frm.err_code.value;
		var err_desc = document.frm.err_desc.value;
    document.frm1.check_id.value = check_id;
		document.frm1.check_name.value = check_name;
		document.frm1.func_code.value = func_code;
		document.frm1.check_rule.value = check_rule;
		document.frm1.local_flag.value = local_flag;
		document.frm1.err_code.value = err_code;
		document.frm1.err_desc.value = err_desc;
  }}
-->
</script>
</head>
<body>
<form name="frm" method="POST" action="">
		<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
<%@ include file="/npage/include/header.jsp"%>
<div class="title">
	<div id="title_zi">自动校验规则查询结果</div>
</div>
<table cellSpacing="0">

			<tr>
				<td align="center" colspan="7">
					   <%
            	  int recordNum = Integer.parseInt(result1[0][0].trim());
						    int iQuantity =recordNum;
						    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
								PageView view = new PageView(request,out,pg); 
						   	view.setVisible(true,true,0,1); 
            	%>
				</td>
			</tr>
			<tr class="title">
        	<th align="center">选择</th>
        	<th align="center">功能代码</th>
			    <th align="center">校验编码</th>              
			    <th align="center">校验名称</th>      
			    <th align="center">错误编码</th>
		      <th align="center">本地业务标志</th>
      </tr>
      <%  
      String localcode = "";
         for(int i=0;i<result.length;i++){   
         String tdClass = "";            
         if (i%2==0){
             tdClass = "Grey";
         }

      %>
        <tr>
        	<td class="<%=tdClass%>"><div align="center"><input type="radio" name="checknum" value="<%=result[i][0]%>" onclick="checkId('<%=i%>')">&nbsp;</div></td>
        	<input type="hidden" name="check_id" value="<%=result[i][0]%>">
        	<input type="hidden" name="check_name"  value="<%=result[i][1]%>">
        	<input type="hidden" name="func_code"  value="<%=result[i][2]%>">
        	<input type="hidden" name="check_rule"  value="<%=result[i][3]%>">
        	<input type="hidden" name="err_code"  value="<%=result[i][5]%>">
        	<input type="hidden" name="err_desc"  value="<%=result[i][6]%>">
        	<td class="<%=tdClass%>" align="center" height="20"><%=result[i][2]%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" height="20"><%=result[i][0]%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" height="20"><%=result[i][1]%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" height="20"><%=result[i][5]%>&nbsp;</td>
        <%	
        localcode = result[i][4];

        if(localcode.equals("0")){
       %>
        	<td class="<%=tdClass%>" align="center"  height="20">本地</td>
        		<input type="hidden" name=localcode value="本地">
        <%	}
        	else{%>
        	<td class="<%=tdClass%>" align="center" name=localcode height="20">全网</td>
						<input type="hidden" name=localcode value="全网">
        	<%}%>
       </tr> 
		<%
       }
     %> 
				
		</form>
		</table>
		</div>

<div id="Operation_Table">
<div class="title">
	<div id="title_zi">规则信息</div>
</div>

<table cellSpacing="0"> 
		<form name="frm1" method="post" action="">
			<tr>
				<td class="blue">
				    业务类别编码
				</td>
				<td align="left" colspan="3">
					<input class="likebutton4" type="text" name="func_code">
				</td>
			</tr>
			<tr>
				<td class="blue">
				    校验编码
				</td>
				<td align="left" >
					<input class="likebutton4" type="text" name="check_id">
				</td>
				<td class="blue">
				    校验名称
				</td>
				<td align="left" >
					<input class="likebutton4" type="text" name="check_name">
				</td>
			</tr>
			<tr>
				<td class="blue">
				    校验规则
				</td>
				<td align="left" colspan="3">
					<input class="likebutton4" type="text" name="check_rule" size="83">
				</td>
			</tr>
			<tr>
				<td class="blue">
				    错误代码
				</td>
				<td align="left">
					<input class="likebutton4" type="text" name="err_code">
				</td>
				<td class="blue">
				    本地业务标志
				</td>
				<td align="left">
					<input class="likebutton4" type="text" name="local_flag">
				</td>				
			</tr>
			<tr>
				<td class="blue">
				    错误描述
				</td>
				<td align="left" colspan="3">
					<input class="likebutton4" type="text" name="err_desc" size="83">
				</td>
			</tr>
	
		</table>
<table cellSpacing="0"> 
			<tr>
				<td id="footer">
					<div align="center">
						<input type="reset" name="reset" value="清除" class="b_foot"/>
						<input type="button" name="goback" value="返回" class="b_foot" onClick="location='f9105_1.jsp'"/>
						<input type="button" name="close" value="关闭" class="b_foot" onclick="removeCurrentTab()"/>
					</div>
				</td>
			</tr>
		</table>
	</form>
		<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

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
	String opCode = "g374";
	String opName = "农信通百事易功能受理";
	String workNo =  (String)session.getAttribute("workNo");
	String login_passwd = (String)session.getAttribute("password");//工号密码
	String regionCode = (String)session.getAttribute("regCode");
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneno"));
	String spid = WtcUtil.repNull(request.getParameter("spid"));
	String bizcode = WtcUtil.repNull(request.getParameter("bizcode"));
	
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	String beginPos=String.valueOf(iStartPos);
	String MaxNum=String.valueOf(iPageSize);
	
	String ret_code = "";
	String ret_meg = "";
	String result[][] = null;
	String result1[][] = null;
	
	int recNum = 0 ;
	
	String [] inputParam = new String [11] ;
	inputParam[0]="0";
	inputParam[1]="08";
	inputParam[2]="g374";
	inputParam[3]=workNo;
	inputParam[4]=login_passwd;
	inputParam[5]=phoneNo;
	inputParam[6]="";
	inputParam[7]=beginPos;
	inputParam[8]=MaxNum;
	inputParam[9]=spid;
	inputParam[10]=bizcode;
%>
<wtc:service name="sg374Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="47">
	<wtc:param value="<%=inputParam[0]%>"/>
	<wtc:param value="<%=inputParam[1]%>"/>
	<wtc:param value="<%=inputParam[2]%>"/>
	<wtc:param value="<%=inputParam[3]%>"/>
	<wtc:param value="<%=inputParam[4]%>"/>
	<wtc:param value="<%=inputParam[5]%>"/>
	<wtc:param value="<%=inputParam[6]%>"/>
	<wtc:param value="<%=inputParam[7]%>"/>
	<wtc:param value="<%=inputParam[8]%>"/>
	<wtc:param value="<%=inputParam[9]%>"/>
	<wtc:param value="<%=inputParam[10]%>"/>
</wtc:service>
<wtc:array id="r0" start="0" length="3" scope="end" />
<wtc:array id="r1" start="3" length="3" scope="end" />
<wtc:array id="r2" start="6" length="10" scope="end"/>
<%
	ret_code = retCode;
	ret_meg = retMsg;
	result = r2;
	result1 = r1;
	if(!ret_code.equals("000000")&&!ret_code.equals(""))
	{
%>
	<script language='jscript'>
		rdShowMessageDialog('<%=ret_meg%>' + '[' + '<%=ret_code%>' + ']',0);
		history.go(-1);
	</script>
<%
	}else{
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script language='javascript'>
	function selectSp(conCode,conName){
		window.opener.form1.spCode.value=conCode;
		window.opener.form1.spCodeName.value=conName;
		window.close();
	}
	</script>
</head>
<body>
<FORM action="fg374_Qry.jsp" method=post name=form>
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">百事易内容编码查询</div>
</div>
<table cellspacing="0" id="ShowId">
	<tr id="ShowTotalId">
		<th>序号</th>
		<th><div align="center">内容代码</div></th>
		<th><div align="center">内容名称</div></th>
		<th><div align="center">内容类型</div></th>
		<th><div align="center">计费类型</div></th>
	</tr>
<%
		if(result!= null){
			recNum = result.length ;
		}
		if(recNum<1){
%>
	<tr>
		<td colspan="12" align = "center"><b><font class="orange">无查询结果</font></td>
	</tr>
<%		}else{
			for(int i=0;i<recNum;i++){
                String tdClass = "";            
                if (i%2==0){
                     tdClass = "Grey";
                }
%>
	<tr onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#E8E8E8';;this.style.cursor='hand'" onmousedown='<%="selectSp(\""+result[i][3]+"\",\""+result[i][4]+"\")"%>'  \>
		<td class="<%=tdClass%>"><div align="center"><%=(iStartPos+i+1)%>&nbsp;</div></td>
		<td class="<%=tdClass%>"><div align="center"><%=result[i][3]%>&nbsp;</div></td>
		<td class="<%=tdClass%>"><div align="center"><%=result[i][4]%>&nbsp;</div></td>
		<td class="<%=tdClass%>"><div align="center"><%=result[i][2]%>&nbsp;</div></td>
		<td class="<%=tdClass%>"><div align="center"><%=result[i][5]%>&nbsp;</div></td>
	</tr>
<%			}
		}
%>
	<tr id="footer">
        <td colspan="11" align="right">
<%	
		int iQuantity=0;
		if(result1!=null){
		    iQuantity = Integer.parseInt(result1[0][0]);
		}
		Page pg = new Page(iPageNumber,iPageSize,iQuantity);
		PageViewCn view = new PageViewCn(request,out,pg); 
		view.setVisible(true,true,0,1);        
%>
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer.jsp"%> 
</FORM>
</BODY>
</HTML>
<%}%>
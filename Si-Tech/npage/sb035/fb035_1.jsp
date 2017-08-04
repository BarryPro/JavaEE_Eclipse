<%
/********************
version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<head>
	<title>补发电子凭证功能</title>
	
<%
	String opCode = "b035";
	String opName = "补发电子凭证功能";
	String phone_no = request.getParameter("activePhone");
	String regionCode = (String)session.getAttribute("regCode");
	
	System.out.println("phone_no : " + phone_no);
	System.out.println("opCode : " + opCode);
	
	//关于分页
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 20;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	//查询总共数量
	String allNumSql = "select count(*) from wWinAward a,ssaleaction b ,ssaleproject c,ssalegrade d, dcustmsg e "
					 + " where a.action_code = b.action_code and a.action_code = c.action_code " 
					 + " and a.project_code = c.project_code and a.project_code = d.project_code " 
					 + " and a.grade_code = d.grade_code and a.id_no = e.id_no and e.phone_no = " + phone_no;
	//查询具体信息sql
	String searchSql = "select * from (SELECT my_table.*, ROWNUM AS my_rownum  from (select b.action_name,c.project_name,d.grade_name,a.login_no,a.op_time " +
	"from wWinAward a,ssaleaction b ,ssaleproject c,ssalegrade d, dcustmsg e " + 
	"where a.action_code = b.action_code and a.action_code = c.action_code and " +
	"a.project_code = c.project_code and a.project_code = d.project_code " + 
	"and a.grade_code = d.grade_code and a.id_no = e.id_no) my_table WHERE ROWNUM < " + iEndPos + ") WHERE my_rownum > " + iStartPos;
	System.out.println("yuanqs.........searchSql : " + searchSql);
%>
	
	<wtc:service name="sQrCodeAgainQry" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="7">
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value="<%=String.valueOf(iStartPos)%>"/>
		<wtc:param value="<%=String.valueOf(iEndPos)%>"/>
	</wtc:service>
	<wtc:array id="resultArr" scope="end" />
		
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=allNumSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="allNum" scope="end" />
<%
	String[][] allNumStr = allNum;
	if(retCode1.equals("000000") && retCode1.equals("000000")){
		System.out.println("fb035_2.jsp 调用 sPubSelect 成功");
	}else{
	}
%>
<script language="javascript" type="text/javascript">
	function modifyInfo(){
		var updatePacket = new AJAXPacket("fb035_2.jsp","正在提交数据，请稍候......");
		updatePacket.data.add("phone_no","<%=phone_no%>");
		core.ajax.sendPacket(updatePacket,sendMsg);
		getdataPacket = null;
	}
	function sendMsg(packet){
		var result = packet.data.findValueByName("result");
		var retcode = packet.data.findValueByName("retcode");
		var retmsg = packet.data.findValueByName("retmsg");
		if(result == 1){
			rdShowMessageDialog("操作成功！");
		}else{
			rdShowMessageDialog("操作失败！" + retcode + retmsg);
		}
		
	}
</script>
</head>
<body>
<form name="getMoreFrm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi">补发电子凭证功能</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td colspan=5 align="center">
				<input type="button" id="modify" var="update" value="补发电子凭证" 
						class="b_text" onclick="modifyInfo()" />
			</td>
		</tr>
		<tr>
			<th>营销活动</th>
			<th>销案</th>
			<th>等级</th>
			<th>操作工号</th>
			<th>办理时间</th>
		</tr>
		<%
		System.out.println("=======" + resultArr.length);
		for(int i = 0; i < resultArr.length; i++){
		System.out.println("yuanqs=============" + resultArr[i][0]);
		%>
		<tr>
			<td>
				<input type="text" id="inputLoginNo<%=i%>" value="<%=resultArr[i][0]%>" 
						class="InputGrey" readOnly="readOnly" />
			</td>
			<td>
				<%=resultArr[i][1]%>
			</td>
			<td>
				<%=resultArr[i][2]%>
			</td>
			<td>
				<%=resultArr[i][3]%>
			</td>
			<td>
				<%=resultArr[i][4]%>
			</td>
		</tr>
		<%
		}
		%>
	</table>
	<%
	    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
	    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
	    PageView view = new PageView(request,out,pg);
	%>
	<div style="position:relative;font-size:12px;" align="center">
	<%
	   	view.setVisible(true,true,0,0);
	%>
	</div>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

<%
/*************************************
* 功  能: 智能V网二次确认短信结果查询 4869
* 版  本: version v1.0
* 开发商: si-tech
* 创建者: shengzd @ 2010-03-22
**************************************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		String opCode     =  request.getParameter("opCode");
    String opName     =  request.getParameter("opName");
    String workNo     = (String)session.getAttribute("workNo");
    String regionCode = (String)session.getAttribute("regCode");
    String op_strong_pwd = (String) session.getAttribute("password");
    String iPhoneNo = activePhone;
    String groupNo = request.getParameter("groupNo");
    String beginNo = request.getParameter("beginNo");
    String endNo   = request.getParameter("endNo");
    boolean qryFlag = false;

%>
	<wtc:service name="se767UnitQry" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode" retmsg="retMsg" outnum="3">
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>	
		<wtc:param value="<%=op_strong_pwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=groupNo%>"/>
	</wtc:service>
	<wtc:array id="qryArr"  scope="end"/>
<%
	if(retCode.equals("000000")) {
					qryFlag = true;
	}

%>
            	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
</head>

<script type=text/javascript>
  $(function() {
  		if(<%=qryFlag%>) {
				window.parent.listQry();
			}else {
					 rdShowMessageDialog("错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
					 //隐藏父页面的遮罩
					 window.parent.hideBox();
			}
  });
  
  function showTable() {
  	$('#tabList2').css('display','block');
  	$(window.parent.document).find("iframe[@id='groupIframe']").css('height',$("body").height() + 'px');		
  }
  function clearTable() {
  		$('#tabList2').empty();
  }
</script>

<body>
<form name="frm2" action="" method="post" >
		<div id="Operation_Table">
				<table id="tabList2" cellspacing=0 style="display:none">
						<tr>				
							<th>集团编码</th>
							<th>集团名称</th>
						</tr>
						<%
								if(qryFlag) {
									for( int i=0;i<qryArr.length;i++) {
											System.out.println("---liujian---qryArr[i][0]" + qryArr[i][0]);
											System.out.println("---liujian---qryArr[i][1]" + qryArr[i][1]);
											out.println("<tr><td>" + qryArr[i][0] + "</td>" +
																		  "<td>" + qryArr[i][1] + "</td></tr>");
									}
								}
						%>
						
				</table>
		</div>
</form>
</body>
</html>
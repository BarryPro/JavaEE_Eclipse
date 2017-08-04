<%
/*************************************
* 功  能: 产品销售代理商显示
* 版  本: version v1.0
* 开发商: si-tech
* 创建者: liujian @ 2012-7-12 11:30:02
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
    String proType = request.getParameter("proType");
    String iPhoneNo = activePhone;
	//设置变量
	boolean qryFlag = false;
	String[][] tempArr = new String[][]{};
%>
			<wtc:service name="se931Qry" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode" retmsg="retMsg" outnum="3">
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workNo%>"/>	
				<wtc:param value="<%=op_strong_pwd%>"/>
				<wtc:param value="<%=iPhoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=proType%>"/>
			</wtc:service>
			<wtc:array id="tempArr2"  scope="end"/>	
	<%	
			if(retCode.equals("000000")) {
				qryFlag = true;
				tempArr = tempArr2;
				System.out.println("-----tempArr2.length---" + tempArr2.length);
				System.out.println("-----tempArr2[0].length---" + tempArr2[0].length);
			}
	%>
	         	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
</head>
<body>
<form name="frm" action="" method="post" >
	<div id="Operation_Table" style="padding-top:0px">
		<table id="tabList" cellspacing=0 style="display:none;">
			<tr>				
				<th style="width:30%">选择&nbsp;&nbsp;&nbsp;&nbsp;(选中代表已配置此产品销售代理商属性)</th><th>品牌名称</th>
			</tr>
				<%
					if(qryFlag) {
						for( int i=0;i<tempArr.length;i++) {
							if(tempArr[i][2] != null && !tempArr[i][2].equals("1")) {
								out.println("<tr><td><input type='checkbox' name='proAttrCb' /></td><td>" + tempArr[i][1] + "</td><td style='display:none'>" + tempArr[i][0] + "</td></tr>");
							}else if(tempArr[i][2] != null && tempArr[i][2].equals("1")) {
								out.println("<tr><td><input type='checkbox' name='proAttrCb'  checked/></td><td>" + tempArr[i][1] + "</td><td style='display:none'>" + tempArr[i][0] + "</td></tr>");
							}
						}
					}
				%>
		</table>
	</div>
</form>
</body>
</html>

<script type=text/javascript>
  $(function() {
  		if(<%=qryFlag%>) {
			$('#tabList').css('display','block');		
		  	//设置父页面的高度
			$(window.parent.document).find("iframe[@id='attrIframe']").css('height',$("body").height() + 'px');
		}else {
			if('<%=retCode%>' != '000000') {
				 rdShowMessageDialog("错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
			}
		}
		$('input[type="checkbox"][name="proAttrCb"]').click(function () {
				$(this).toggleClass("judge");
			}
		);
		$('input[type="checkbox"][name="allCbox"]').click(function () {
				if(typeof $(this).attr('checked') == 'undefined') {
					$('input[type="checkbox"][name="proAttrCb"][@checked]').each(function(){
						$(this).click();
					});
				}else {
					$('input[type="checkbox"][name="proAttrCb"][checked=""]').each(function(){
						$(this).click();
					});
				}
			}
		);
		$(window.parent.document).find('table[id="footerTable"]').css('display','block');
		//隐藏父页面的遮罩
		//window.parent.hideBox();
  });
  /*
  function showTable() {
  	$('#tabList').css('display','block');		
  	//设置父页面的高度
	$(window.parent.document).find("iframe[@id='attrIframe']").css('height',$("body").height() + 'px');
  }
  */
  
  function submitRst() {
		//判断变化的产品销售代理商
		var valArray = new Array();
		var checkedArray = new Array();
		$(".judge").each(function() {
			valArray.push($(this).parent().parent().find('td').eq(2).text());
			if($(this).attr("checked")) {
				checkedArray.push("1");	
			}else {
				checkedArray.push("0");		
			}
		});
		if(valArray.length > 0) {
			var valRst = valArray.join('|') + '|';
			$(window.parent.document).find('input[id="valText"]').val(valRst);
			var checkedRst = checkedArray.join('|') + '|';
			$(window.parent.document).find('input[id="checkedText"]').val(checkedRst);
			window.parent.submit();
		}else {
			rdShowMessageDialog("没有改变产品销售代理商");
			return false;	
		}	
  }
  
  function clearTable() {
  	$('#tabList').empty();
  }
</script>
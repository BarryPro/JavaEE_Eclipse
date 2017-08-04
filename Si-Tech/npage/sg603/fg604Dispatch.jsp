<%
  /*
   * 关于加快推进门户网站统一销售工作的通知
   * 日期: 2013-04-15
   * 作者: zhouby
   */
%>

<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<meta http-equiv="Expires" content="0">
	
	<script language="javascript">
			var authority = {};
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
 
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String workNo = (String)session.getAttribute("workNo");
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());

	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] temfavStr = (String[][])arrSession.get(1);
	String[] favStr = new String[temfavStr.length];
	
	for(int i = 0;i < favStr.length; i++){
			favStr[i] = temfavStr[i][1].trim();
			/**
			if ("g604".equals(favStr[i])){
					System.out.println("zhouby --" + favStr[i]);
			}*/
%>
			authority['favStr[i]'] = '1';
<%		
	}
%>
	function checkAuthority(targetOpCode){
			//TODO
			return true;
			if (authority[targetOpCode] == '1'){
					return true;
			} else {
					rdShowMessageDialog('对不起，您没有该操作权限');
					return false;
			}
	}

	$(function(){
		//liujian2013-4-22 14:30:06 加入通过opcode判断操作类型选中项 begin
		var opcode = '<%=opCode%>';
		if(opcode == 'g605') {
			$('input[name="opFlag"]').get(0).checked = true;	
		}else if(opcode == 'g606') {
			$('input[name="opFlag"]').get(1).checked = true;	
		}else if(opcode == 'g607') {
			$('input[name="opFlag"]').get(2).checked = true;		
		}else if(opcode == 'g609') {
			$('input[name="opFlag"]').get(3).checked = true;		
		}
		//liujian2013-4-22 14:30:06 加入通过opcode判断操作类型选中项 begin
			$('#dispatch').click(function(e){
					e.preventDefault();
					e.stopPropagation();
					
					$('input[name="opFlag"]').each(function(){
							var t = $(this);
							if (t.is(':checked')){
									var s = t.attr('code');
									if (!checkAuthority(s)){
											return;
									}
									$('form').attr('action', 'f' + s + 'Main.jsp?opCode=' 
										+ s + '&opName=' + t.attr('opName')).submit();
									return;
							}
					});
			});
			
			$("#closeBtn").click(function(e){
          e.stopPropagation();
          e.preventDefault();
          
         	if(window.opener == undefined) {
		          removeCurrentTab();
		      } else {
		          window.close();
		      }
      });
	});
	</script>
</head>
<body >
	<form name="frm" method="POST" action="default">
	<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		
		<table cellspacing=0>
			<tr>
				<td class="blue" width="20%">操作类型</td>
				
        <td>
        	<input type="radio" name="opFlag" code="g605" opName="写卡" checked>写卡&nbsp;&nbsp;
        	<input type="radio" name="opFlag" code="g606" opName="快递单号填写">快递单号填写&nbsp;&nbsp;
        	<input type="radio" name="opFlag" code="g607" opName="配送结果反馈">配送结果反馈&nbsp;&nbsp;
        	<!--<input type="radio" name="opFlag" code="g608" opName="销户">销户&nbsp;&nbsp;
        	-->
        	<input type="radio" name="opFlag" code="g609" opName="外呼失败撤单">外呼失败撤单
        </td>
			</tr>
		</table>

	 	<table cellspacing="0">
		<tr>
			<td id="footer">
				<div align="center">
	 				<input type="button" class="b_foot" value="确认" id="dispatch">
	 				<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭">
				</div>
			</td>
		</tr>
	</table> 
 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
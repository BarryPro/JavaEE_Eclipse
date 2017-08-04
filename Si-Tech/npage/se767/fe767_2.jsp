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
    /**************** 分页设置 ********************/
		int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
		int iPageSize = 10;
		int iStartPos = (iPageNumber-1)*iPageSize;
		int iEndPos = iPageNumber*iPageSize;
		String[][] allNumStr = new String[][]{};
		String num = "0";
		int pageCount = 0;
		System.out.println("---liujian---iPageNumber=" + iPageNumber);
		System.out.println("---liujian---iPageSize=" + iPageSize);
		//设置一些变量
		String[][] tempArr = new String[][]{};
		String retCodeQry = "";
		String retMsgQry = "";
		//测试
		//String[][] tempArr = {{"aaaa","bbbb","cccc"},{"aaaaa","bbbbb","ccccc"},{"aaaaaa","bbbbbb","cccccc"}};
		/**********************************************/
%>
			<wtc:service name="se767Qry" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeQry2" retmsg="retMsgQry2" outnum="2">
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workNo%>"/>	
				<wtc:param value="<%=op_strong_pwd%>"/>
				<wtc:param value="<%=iPhoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=groupNo%>"/>
				<wtc:param value="<%=beginNo%>"/>
				<wtc:param value="<%=endNo%>"/>
				<wtc:param value="<%=Integer.toString(iPageNumber)%>"/>	
				<wtc:param value="<%=Integer.toString(iPageSize)%>"/>
			</wtc:service>
			<wtc:array id="tempArr2"  scope="end"/>	
	<%	
			retCodeQry = retCodeQry2;
			retMsgQry = retMsgQry2;
			if(retCodeQry.equals("000000")) {
					qryFlag = true;
					tempArr = tempArr2;
			}
	%>
	



            	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
</head>



<body>
<form name="frm" action="fe767_2.jsp" method="post" >
		<div id="Operation_Table" style="padding-top:0px">
				<table id="tabList" cellspacing=0 style="display:none;">
						<tr>				
							<th>空号清单</th>
						</tr>
						<%
							if(qryFlag) {
								System.out.println("------liujian--sss=" + tempArr.length);
									num = tempArr[0][1] + "";
									for( int i=0;i<iPageSize;i++) {
											if(i < tempArr.length) {
													out.println("<tr><td>" + tempArr[i][0] + "</td></tr>");
											}	
									}
							}
						%>
		      	
		      	<tr>	
						<td colspan="10">
							<div id="page0" style="position:relative;font-size:12px;">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		           <%	
							    //实现分页
							    if(num!=null && !"0".equals(num)){
							    int iQuantity = Integer.parseInt(num.trim());
							    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
								  PageView view = new PageView(request,out,pg); 
							   	view.setVisible(true,true,0,0);    
							   	}
							 %>
							</div>
						</td>
					</tr>
					<tr id="footer">
			    <td colspan="10">
    			    <input class="b_foot_long" name=print onClick="printxls()" type=button value=导出数据>
    			</td>
			</tr>
				</table>
		</div>
</form>
</body>
</html>

<script type=text/javascript>
  $(function() {
  		if(<%=qryFlag%>) {
				window.parent.showIfTable();  
			}else {
				if('<%=retCodeQry%>' != '000000') {
					 rdShowMessageDialog("错误代码：<%=retCodeQry%>，错误信息：<%=retMsgQry%>",0);
				}
			}
			$('#page0 a').click(function() {
				window.parent.showBox();
			});
			//隐藏父页面的遮罩
			window.parent.hideBox();
  });
  
  function showTable() {
  	$('#tabList').css('display','block');		
  	//设置父页面的高度
		$(window.parent.document).find("iframe[@id='middle']").css('height',$("body").height() + 'px');
  }
  
  function clearTable() {
  	$('#tabList').empty();
  }
  
	function printxls(){
		var packet = new AJAXPacket("fe767_printxls.jsp","正在下载文件，请稍候......");
		var _data = packet.data;
		_data.add("opCode",'<%=opCode%>');
		_data.add("groupNo",'<%=groupNo%>');
		_data.add("beginNo",'<%=beginNo%>');
		_data.add("endNo",'<%=endNo%>');
		_data.add("iPhoneNo",'<%=iPhoneNo%>');
		_data.add("pageSize",'<%=num%>');
		core.ajax.sendPacket(packet);
		packet = null;	
	}	
	
	function doProcess(packet) {
		var retCode = packet.data.findValueByName("retcode");
		var retMsg = packet.data.findValueByName("retmsg");
		if(retCode == "000000") {
			rdShowMessageDialog(retMsg);
		}else {
			rdShowMessageDialog("错误代码："+retCode+"，错误信息："+retMsg,0);
			return false;
		}	
	}
</script>
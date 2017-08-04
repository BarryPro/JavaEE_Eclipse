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
	<title>三码合一查询</title>
<%
	String opCode = "b631";
	String opName = "二码合一查询";
	String regionCode= (String)session.getAttribute("regCode");
	String loginAccept = "0";
	String chnSource = "01";
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String phoneNo = (String)request.getParameter("phoneNo");
	String userPwd = "";
	String beginTime = (String)request.getParameter("beginTime");;
	String endTime   = (String)request.getParameter("endTime");;
	String out_Note="";
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	
	String paraAray[] = new String[11];
	paraAray[0] = loginAccept;
	paraAray[1] = chnSource;
	paraAray[2] = opCode;
	paraAray[3] = workNo;
	paraAray[4] = password;
	paraAray[5] = phoneNo;
	paraAray[6] = userPwd;
	paraAray[7] = beginTime;
	paraAray[8] = endTime;
	paraAray[9] = "" + iPageNumber;
	paraAray[10] = "" + iPageSize;
	
	System.out.println("================ ningtn =========" + phoneNo);
%>
<wtc:service name="s631Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" 
			retcode="errCode" retmsg="errMsg"  outnum="19">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
		<wtc:param value="<%=paraAray[10]%>"/>
</wtc:service>
<wtc:array id="result" scope="end" start="2" length="8"/>
<wtc:array id="result2" scope="end" start="10" length="1"/>
<wtc:array id="result3" scope="end" start="11" length="6"/>
<wtc:array id="result4" scope="end" start="17" length="2"/>
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		//System.out.println("================ ningtn =========查询成功" + errCode);
		String[][] allNumStr = result2;
		%><script language="javascript">//alert("allNumStr "+"<%=allNumStr[0][0]%>");</script><%
		System.out.println("1111111111111111111111111111========== xl =========" + result.length+" and result3 is "+result3.length);
		
		for(int i = 0; i < result.length ; i++)
		{
			System.out.println("====== " + result[i][0]);
			System.out.println("====== " + result[i][1]);
			System.out.println("====== " + result[i][2]);
			System.out.println("====== " + result[i][3]);
			System.out.println("====== " + result[i][4]);
			System.out.println("====== " + result[i][5]);
			System.out.println("====== " + result[i][6]);
			String sql_content="select packagecontent  from dbchnterm.DCHNONEBOSSPROMOTPACKAGE where packagecode='?' ";
			String conCode=result[0][4];
			%>
			<wtc:pubselect name="TlsPubSelCrm"    retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:sql><%=sql_content%></wtc:sql>
			<wtc:param value="<%=conCode%>"/>
			</wtc:pubselect>
			<wtc:array id="ret_val" scope="end" />
			<%
				if(ret_val!=null&&ret_val.length==1)
				{
					out_Note=ret_val[0][0];
				}
		}
		
%>
</head>
<script language="javascript">
	function updateMsg(rowId){
		var msgArr = new Array();
		<%
			for(int i = 0; i < result.length; i++){
				if(result[i][5]!="111"&&!result[i][5].equals("111"))
				{
					%>msgArr[<%=i%>] = "<%=result[i][5]%>";<%
				}
				else
				{
					
					
					%>
					 	
					msgArr[<%=i%>] = "<%=out_Note%>";<%
				}
		%>
				
				
		<%
			}
		%>
		$("#msgDiv").children("span").text(msgArr[rowId]);
	}
	$(document).ready(function(){
		 
		var msgNode = $("#msgDiv").css("border","1px solid #999").width("360px")
            .css("position","absolute").css("z-index","99")
            .css("background-color","#dff6b3").css("padding","8");
        msgNode.hide();
		
		var as = $("a[@space='bindBag']");
        as.css("cursor","hand").css("font-weight","600");
        as.mouseover(function(event){
    		//获取当前准备显示的行数
            var aNode = $(this);
            aNode.css("color","#3366CC");
            var divNode = aNode.parent();
            sid = divNode.attr("rowId");
            updateMsg(sid);
            var myEvent = event || windows.event;
			var divY = 0;
			divY = myEvent.clientY + msgNode.height();
			if(divY > 430){
				//alert("gaole");
				divY = 345 - msgNode.height();
			}else{
				divY = myEvent.clientY - 70;
			}
        	msgNode.css("left",myEvent.clientX - 390 + "px").css("top",divY + "px");
        	//浮动框显示
        	msgNode.show();
    	});
    	as.mouseout(function(){
    		var aNode = $(this);
            aNode.css("font-weight","600").css("color","#333333");
        	msgNode.hide();
    	});
	});
	
</script>
<body>
<form name="getMoreFrm" method="POST" action="">
<div id="Operation_Table">
	<div style="height:340px;">
	<div class="title">
		<div id="title_zi">二码合一返费查询</div>
	</div>
	<table cellspacing="0" id="queryMsgTab">
		<tr>
			<th>用户姓名</th>
			<th>激活时间</th>
			<th>品牌机型</th>
			<th>IMEI码</th>
			<th>捆绑包</th>
			<th>是否返费</th>
			 
		</tr>
		<%
			for(int i = 0; i < result.length; i++){
		%>
		<tr>
			<td><%=result[i][0]%></td>
			<td><%=result[i][1]%></td>
			<td><%=result[i][2]%><%=result[i][7]%></td>
			<td><%=result[i][3]%></td> 
			<td><span rowId="<%=i%>"><a space="bindBag"><%=result[i][4]%></a></span></td>
			<td>
				<%if("1".equals(result[i][6])){%>已返费<%}else{%>未返费<%}%>
			</td>
		</tr>
		<%
				//xl add for wpay展示返费信息
				if(("1".equals(result[i][6])) &&(Integer.parseInt(allNumStr[0][0])<2))
				//if(("1".equals(result[i][6])) )
				{
					%>
						<table>
						<tr><td colspan=6 align=center>已返费信息展示</td></tr>
						<tr>
							<th>手机号码</th>
							<th>返费时间</th>
							<th>操作类型</th>
							<th>返费类型</th>
							<th>返费金额</th>
							<th>是否拆包</th> 
						</tr>
						
						
		 
						<%
							for(int k=0;k<result3.length;k++)
							{
								%>
								<tr>
									<td><%=result3[k][3]%></td>
									<td><%=result3[k][2]%></td>
									<td><%=result3[k][1]%></td>
									<td><%=result3[k][4]%></td>
									<td><%=result3[k][0]%></td>
									<td><%=result3[k][5]%></td>
								</tr>
								<%
							}
							//xl add 20121107
							for(int m=0;m<result4.length;m++)
							{
								if(result4[m][0]=="show" ||result4[m][0].equals("show"))
								{
									%>
										<tr>
											<td><font color="red"><%=phoneNo%></font></td>
											<td><font color="red"><%=result4[m][1]%></font></td>
											<td colspan="4" align="right"><font color="red">拆包(刷码)</font></td>
										</tr>
									<%
								}
							}
							
						%>
						

						</table>
					<%
				}
				
			}
			if(Integer.parseInt(allNumStr[0][0])>1)
				{
					%>
						<tr>
							<td colspan="6" align=center>该用户存在多组返费信息；请通过IMEI码或开始结束时间对返费记录进行唯一性限制后再查询!</td>
						</tr>
					<%
				}
		%>
		<tr><td colspan=6 align=center><font color="red">注：当月激活，次月返费。当月拆包，次月不返费（首月激活不判拆包）。</font></td></tr>
	</table>
    <div id="msgDiv">
        捆绑包信息：<span></span>
    </div>
    </div>
    <%
	    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
	    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
	    PageView view = new PageView(request,out,pg);
	%>
	<br><br><br><br><br> 
	<div style="position:relative;font-size:12px;" align="center">
	<%
	   //	view.setVisible(true,true,0,0);
	%>
	</div>
</div>
</form>
</body>
</html>
<%
	}else{
		System.out.println("=========== ningtn ===== " + errCode + " : " + errMsg);
%>
	<script language="JavaScript">
	rdShowMessageDialog("二码合一查询失败!(<%=errCode%><%=errMsg%>",0);
	parent.closeDiv();
	</script>
<%
	}
%>

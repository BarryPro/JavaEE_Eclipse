<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	String opCode="zgar";
	String opName="前台电子发票打印";
	String work_no = (String)session.getAttribute("workNo"); 
	String qrytype = request.getParameter("qrytype");
	String qryvalue = request.getParameter("qryvalue");
	String beginym = request.getParameter("beginym");
	String endym = request.getParameter("endym");
	String contract_no = request.getParameter("contract_no");
	  
	
%>
<wtc:service name="sInvInfoQry" routerKey="region" routerValue="<%=regionCode%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="11" >
    <wtc:param value="<%=contract_no%>"/>
    <wtc:param value="<%=qryvalue%>"/>
	<wtc:param value=""/> 
    <wtc:param value="<%=beginym%>"/> 
	<wtc:param value="<%=endym%>"/>
	<wtc:param value="<%=qrytype%>"/>
	<wtc:param value="e"/> 
</wtc:service>
<wtc:array id="sretcode" scope="end" start="0"  length="1" />
<wtc:array id="sretinfo" scope="end" start="1"  length="10" />
<%
	String retCode= s4141CfmCode;
	String retMsg = s4141CfmMsg;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
	
    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");

	String errMsg = s4141CfmMsg;
	if (retCode.equals("000000") ||retCode=="000000")
	{
		int maxlines = sretinfo.length;  
		System.out.println("success");
%>
	<HTML>
		<HEAD><TITLE>黑龙江BOSS-电子发票查询</TITLE>
			<META content="text/html; charset=gb2312" http-equiv=Content-Type>
			<META content=no-cache http-equiv=Pragma>
			<META content=no-cache http-equiv=Cache-Control>
	<BODY>
	<script language="javascript">
		function docheck()
		{
			//我需要的是发票号码 发票代码 
			var login_accept;
            var totaldate;
            var invoice_number
            var invoice_code;
            var login_no ;
            var lines =<%=maxlines%>;
			var s_phone_no="<%=contract_no%>";
			//alert("lines is "+lines);
			var s_date ;
			if (lines == 1)
            {
                login_accept = document.form1.radiobutton.value;
                invoice_number=document.form1.invoice_number.value;
				invoice_code=document.form1.invoice_code.value;
				invoice_accept=document.form1.invoice_accept.value ;
				s_dates = document.form1.s_dates.value ;
            }
			else
			{
				for (var i = 0; i < lines; i++)
				if (document.form1.radiobutton[i].checked == true)
				{
					login_accept = document.form1.radiobutton[i].value;
					invoice_number=document.form1.invoice_number[i].value;
					invoice_code=document.form1.invoice_code[i].value;
					invoice_accept=document.form1.invoice_accept[i].value ;
					s_dates = document.form1.s_dates[i].value ;
				}
			}
			
			//调用电子发票开具接口
			document.form1.action = "zgar_3.jsp?s_phone_no="+s_phone_no+"&invoice_number="+invoice_number+"&invoice_code="+invoice_code+"&invoice_accept="+invoice_accept+"&s_dates="+s_dates;
		//	alert(document.form1.action);
			document.form1.submit();
		}
		function doget(i,phone_no,fphm,fpdm,ls,s_dates)
		{
			//alert("test i is "+i);
			var pactket2 = new AJAXPacket("sget_dzfp.jsp","正在进行发票获取，请稍候......");
			pactket2.data.add("phone_no",phone_no);
			pactket2.data.add("i",i);
			pactket2.data.add("fphm",fphm);
			pactket2.data.add("fpdm",fpdm);
			pactket2.data.add("ls",ls);
			pactket2.data.add("s_dates",s_dates);
			core.ajax.sendPacket(pactket2,fpGet);
		}
		function fpGet(packet)
		{
			var s_flag = packet.data.findValueByName("s_flag");
			var i = packet.data.findValueByName("i");
			//alert("s_flag is "+s_flag+" and i is "+i);
			if(s_flag=="0")
			{
				document.getElementById("doprint"+i).disabled=false;
			}
			else
			{
				rdShowMessageDialog("shell脚本调用失败!标志位:"+s_flag);
				return false;
			}
			
		}
		function dopdf(i,phone_no,fphm,fpdm,ls,s_dates)
		{
			//alert("1");
			document.form1.action = "zgar_3.jsp?s_phone_no="+phone_no+"&invoice_number="+fphm+"&invoice_code="+fpdm+"&invoice_accept="+ls+"&s_dates="+s_dates;
		//	alert(document.form1.action);
			document.form1.submit();
		}
		function bts(phone_no,fpdm,fphm,ls,sdate)
		{
			//alert("bts phone_no is "+phone_no+" and fpdm is "+fpdm+" and fphm is "+fphm+" and ls is "+ls +" and sdate is"+sdate);
			document.form1.action = "zgar_bts.jsp?s_phone_no="+phone_no+"&invoice_number="+fphm+"&invoice_code="+fpdm+"&invoice_accept="+ls+"&s_dates="+sdate;
		//	alert(document.form1.action);
			document.form1.submit();
		}	
	</script>
	<FORM action="" method=post name=form1>
	<%@ include file="/npage/include/header.jsp" %>
	
	<div id="Operation_Table"> 
	<div class="title">
		<div id="title_zi">电子发票历史信息</div>
	</div>
	<table cellspacing="0">
		<tr>
			<!--<th>选择</th>-->
			<th>发票代码</th>
			<th>发票号码</th>
			<th>发票类型</th>
			<th>电子发票开具流水</th>
			<th>发票开具时间</th>
			<th>系统操作流水</th>
			<th>发票状态</th>
			<th>业务操作名称</th>
			<th>业务操作工号</th>
			<th>发票金额</th>
			<th colspan="3">操作</th>
	 
		</tr>
		<%
			for(int i=0;i<sretinfo.length;i++)
			{
				%>
					<tr>
					<!--
						<td><input type="radio" name="radiobutton" value="<%=sretinfo[i][3]%>" <%if(i==sretinfo.length-1){%>checked<%}%>></td>-->
						<td><%=sretinfo[i][0]%></td>
						<td><%=sretinfo[i][1]%></td>
						<td>
						<%
							if(sretinfo[i][2]=="0"||sretinfo[i][2].equals("0"))
							{
								%>未开具<%
							}
							else if(sretinfo[i][2]=="1"||sretinfo[i][2].equals("1"))
							{
								%>通用机打<%
							}
							else if(sretinfo[i][2]=="2"||sretinfo[i][2].equals("2"))
							{
								%>自助终端<%
							}
							else if(sretinfo[i][2]=="6"||sretinfo[i][2].equals("6"))
							{
								%>纸质发票预占<%
							}
							else if(sretinfo[i][2]=="e"||sretinfo[i][2].equals("e"))
							{
								%>电子发票<%
							}
							else if(sretinfo[i][2]=="r"||sretinfo[i][2].equals("r"))
							{
								%>纸质收据<%
							}
							else if(sretinfo[i][2]=="z"||sretinfo[i][2].equals("z"))
							{
								%>增值税专票<%
							}
							else
							{
								%>无<%
							}
						%>
						</td>
						<td>
						<%=sretinfo[i][3]%>
						</td>
						<td><%=sretinfo[i][4]%></td>
						<td><%=sretinfo[i][5]%></td>
						<td><%=sretinfo[i][6]%></td>
						<td><%=sretinfo[i][7]%></td>
						<td><%=sretinfo[i][8]%></td>
						<td><%=sretinfo[i][9]%></td>
						<td><input type="button" value="获取" class="b_foot" onclick="doget('<%=i%>','<%=contract_no%>','<%=sretinfo[i][1]%>','<%=sretinfo[i][0]%>','<%=sretinfo[i][3]%>','<%=sretinfo[i][4]%>')"></td>
						<td><input type="button" value="打印" id="doprint<%=i%>" class="b_foot" disabled onclick="dopdf('<%=i%>','<%=contract_no%>','<%=sretinfo[i][1]%>','<%=sretinfo[i][0]%>','<%=sretinfo[i][3]%>','<%=sretinfo[i][4]%>')"></td>
						<td><input type="button" value="补推送" class="b_foot" onclick="bts('<%=contract_no%>','<%=sretinfo[i][0]%>','<%=sretinfo[i][1]%>','<%=sretinfo[i][3]%>','<%=sretinfo[i][4].substring(0,8)%>')"></td>
					</tr>
				<input type="hidden" name="invoice_code" value="<%=sretinfo[i][0]%>">
				<input type="hidden" name="invoice_number" value="<%=sretinfo[i][1]%>">
				<input type="hidden" name="invoice_accept" value="<%=sretinfo[i][3]%>">
				<input type="hidden" name="s_dates" value="<%=sretinfo[i][4]%>">
				
				<%
			}
		%>
	</table>
	 
	<table cellspacing="0">
		<tbody>
			<tr>
				<td id="footer">
				<!--
					<input class="b_foot" name=sure type=button value=打印 onClick="docheck()">
					&nbsp;
					--><input class="b_foot" name=clear type=button value=返回 onClick="window.location.href='zgar_1.jsp'">
				</td>
			</tr>
		</tbody>
	</table>
	 
	<%@ include file="/npage/include/footer.jsp" %>
	</FORM>
	</BODY>
	</HTML>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("发票查询处理失败: <%=retMsg%>",0);
	window.location="zgar_1.jsp";
	</script>
<%}
%>


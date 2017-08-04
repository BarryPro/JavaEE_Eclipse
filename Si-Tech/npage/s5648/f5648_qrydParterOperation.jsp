<%
   /*名称：集团客户项目申请 - 查询dParterOperation
　 * 版本: v1.0
　 * 日期: 2007/2/7
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   * 2009-09-24    qidp        新版集团产品改造
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%

	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	 
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
	
	String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());

	String parterId = request.getParameter("parterId");
	String checkdocId = request.getParameter("checkdocId");
	
	System.out.println("parterId = "+parterId);
	System.out.println("checkdocId = "+checkdocId);
	String opCode = "5648";
	String opName = "SI定购关系查询";

	ArrayList acceptList = new ArrayList();
	String[][] colNameArr = new String[][]{};

	System.out.println("######## parterId = "+parterId);
	try{
	%>
        <wtc:service name="s5648OperEXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="5" >
        	<wtc:param value="5648"/>
        	<wtc:param value="<%=workNo%>"/> 
        	<wtc:param value="<%=parterId%>"/>       	        		
        </wtc:service>
        <wtc:array id="retArr1" scope="end"/>
    <%
        if("000000".equals(retCode1)){
            if(retArr1.length>0){
                colNameArr = retArr1;
            }else{
                System.out.println("没有查到相关记录");
                %>
        			<script language='jscript'>
        				rdShowMessageDialog("没有查到相关记录！",0);
        			</script>
                <%
            }
        }else{
            %>
    			<script language='jscript'>
    				rdShowMessageDialog("错误代码：<%=retCode1%>,错误信息：<%=retMsg1%>",0);
    			</script>
            <%
        }
        
        if (colNameArr != null && colNameArr.length>0)
		{
			System.out.println("luxc:colNameArr"+colNameArr[0][0]);
			if ("".equals(colNameArr[0][0])) 
			{
				colNameArr = null;
			}
		}
		
    }catch(Exception e){
        e.printStackTrace();
        %>
			<script language='jscript'>
				rdShowMessageDialog("调用服务失败！",0);
			</script>
        <%
    }
	//String[][] colNameArr = (String[][])acceptList.get(0);	
	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>
<script language="javascript">
	//core.loadUnit("rpccore");
	onload=function()
	{
			//core.rpc.onreceive = doProcess;//为function()函数设立监听器
	}
	
		function doProcess(myPacket)
	{
		var errCode    = myPacket.data.findValueByName("errCode");
		var retMessage = myPacket.data.findValueByName("errMsg");//声明返回的信息
		var retFlag    = myPacket.data.findValueByName("retFlag");
				
		if (errCode==000000)
		{  
			if(retFlag=="queryMod")
			{			
				rdShowMessageDialog("操作成功！");
				window.parent.document.all.queryBusiBtn.onclick();
			}
		}
		
		//-----如果返回错误代码-----
		if(errCode!=000000)
		{
			rdShowMessageDialog(retMessage);	
		}
	}
	//显示增加业务信息表格
	function showAddBusiInfo()
	{	
		tabAddBtn.style.display="none";
	}
	
	/************************ 增加业务信息 ***********************/
	function addCfm()
	{
		/****************** 通用校验  begin ********************/		
		if(!check(form1)) return false;	
				
		if(document.form1.oprEffTime.value == "")
		{
			rdShowMessageDialog("请输入“操作生效时间”！");
			return false;
		}
				
		if(!validDate(document.all.oprEffTime))	return false;
		
		if(parseInt(document.all.oprEffTime.value) < parseInt("<%=strDate%>"))
		{
			rdShowMessageDialog("“操作生效时间”不能小于系统当天时间！");
			return false;
		}
		
		if(document.form1.provURL.value == "")
		{
			rdShowMessageDialog("请输入“SIProvision的URL”！");
			return false;
		}
		
		if(document.form1.introURL.value == "")
		{
			rdShowMessageDialog("请输入“业务的介绍网址”！");
			return false;
		}
						
		/****************** 通用校验  end ********************/		

		document.form1.action="f6312_modCfm.jsp?OprCode=01";
		document.form1.submit();					
	}
	
		//变更
	function  queryMod(v_id)
	{				
			var str = "?operId=" + document.form1["operId" +v_id].value +  "&parterId=" +document.form1["parterId" +v_id].value+ "&trId=" + v_id;
			var url="f5648_qry.jsp" + str;
			window.open(url,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=auto,status=yes,location=no,menubar=no');
	}
	
	
	//显示某条业务信息
	function showInfo(v_id)
	{  
        //var str = "?operId=" + document.form1["operId" +v_id].value +  "&parterId=" +document.form1["parterId" +v_id].value+ "&trId=" + v_id;
        //var path="f2896_showInfo.jsp" + str;
        var str = "?operId=" + document.form1["operId" +v_id].value +  "&parterId=" +document.form1["parterId" +v_id].value+ "&trId=" + document.all.vflag.value;
        var path="../s2889/f2889_showInfo.jsp" + str;
		window.open(path,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=auto,status=yes,location=no,menubar=no');
	}

</script>

<body>
<form name="form1" method="post" action="">	
<input type="hidden" name="vflag" value="<%=checkdocId.trim()%>">
<input type="hidden" name="StartTime" value="">
<input type="hidden" name="EndTime" value="">
<input type="hidden" name="MOCode" value="">
<input type="hidden" name="CodeMathMode" value="">
<input type="hidden" name="MOType" value="">
<input type="hidden" name="DestServCode" value="">
<input type="hidden" name="ServCodeMathMode" value="">
<input type="hidden" name="bizType" value="">
<div id="Operation_Table">
	<%
	if(colNameArr!=null && colNameArr.length>0)
 	{	
	%>
	
	<TABLE width="100%" id="tabList" border=0 align="center" cellSpacing=0 bgcolor="#EEEEEE">			
	
<div class="title">
	<div id="title_zi">业务信息</div>
</div>
		<TABLE id="tabList" cellSpacing=0>			
			<tr>				
				<th nowrap align='center'>业务编码</th>
				<th nowrap align='center'>业务类型</th>
				<th nowrap align='center'>合作伙伴代码</th>
				<th nowrap align='center'>业务名称</th>
				<th nowrap align='center'>业务状态</th>
				<th nowrap align='center'>操作方式</th>
			</tr>
	<%	
		int len = colNameArr.length;	
		for(int i = 0; i < len; i++)
		{		  
		System.out.println("iiiiiiiiiiiiiiiii="+len);
		System.out.println("iiiiiiiiiiiiiiiii="+colNameArr[0].length);
	%>			
			<tr id="tr<%=i+1%>">
				<input type="hidden" name="operId<%=i+1%>" value="<%=colNameArr[i][0].trim()%>">
				<input type="hidden" name="parterId<%=i+1%>" value="<%=colNameArr[i][2].trim()%>">
							
				<td nowrap align='center'><a style="CURSOR: hand; TEXT-DECORATION: none" href="javascript:showInfo(<%=i+1%>)"><%=colNameArr[i][0].trim()%></a></td>
				<td nowrap align='center'><%=colNameArr[i][1].trim()%></td>
				<td nowrap align='center'><%=colNameArr[i][2].trim()%></td>
				<td nowrap align='center'><%=colNameArr[i][3].trim()%></td>
				<td nowrap align='center'><%=colNameArr[i][4].trim()%></td>
				<td nowrap align='center'>
			        <input name="operator<%=i+1%>" style="cursor:hand" type="button" value="查询" class="b_text" onclick="queryMod(<%=i+1%>)">		
				
				</td> 
			</tr>
			
	<%
		}
	%>		
		</TABLE>
<%}%>		
	
	 	   	
	</div>   
</form>
</body>
</html>

           
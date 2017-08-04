<%
   /*
   * 功能: 查询地区代码
　 * 版本: v1.0
　 * 日期: 2007/10/25
　 * 作者: sunzg
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   * 2009-09-07   qidp       集团新版产品改造
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
		Logger logger = Logger.getLogger("f2893info.jsp");
		ArrayList retArray = new ArrayList();
		String[][] result = new String[][]{};
		 
		String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
		String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
		String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
		String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
		String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
		String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
		
		/**************** 分页设置 ********************/
		int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
		int iPageSize = 10;
		int iStartPos = (iPageNumber-1)*iPageSize;
		int iEndPos = iPageNumber*iPageSize;
	/**********************************************/
	
		//SPubCallSvrImpl impl = new SPubCallSvrImpl();
		ArrayList retList = new ArrayList(); 
		ArrayList retList1 = new ArrayList();  
		String sqlStr="";
		String sqlStr1="";
		String whereSql="";
		String[][] allNumStr = new String[][]{};
		String[][] result1 = new String[][]{};
	  String spCode = WtcUtil.repNull((String)request.getParameter("spCode"));
	  String bizCode = WtcUtil.repNull((String)request.getParameter("bizCode"));
	  String phoneNo = WtcUtil.repNull((String)request.getParameter("phoneNo"));
	  
	  //liujian 2012-8-30 14:07:03 添加操作时间 begin
	  String op_strong_pwd  = (String)session.getAttribute("password");//登陆密码
	  String oprDate = WtcUtil.repNull((String)request.getParameter("oprDate"));
	  if(oprDate == null) {
	  	oprDate = "";
	  }
	  System.out.println("------liujian-----iStartPos= " + iStartPos);
	  System.out.println("------liujian-----iEndPos= " + iEndPos);
	  String countNum = "0";
	  //liujian 2012-8-30 14:07:03 添加操作时间 end
		System.out.println("spCode= " + spCode);
		System.out.println("bizCode= " + bizCode);
		System.out.println("phoneNo= " + phoneNo);

%>
		<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
		<%
			String[] params = new String[13];
			params[0] = loginAccept;
			params[1] = "01";
			params[2] = "2893";
			params[3] = loginNo;
			params[4] = op_strong_pwd;
			params[5] = phoneNo;
			params[6] = "";
			params[7] = spCode;
			params[8] = bizCode;
			params[9] = oprDate;
			params[10] = iStartPos + "";
			params[11] = iEndPos + "";
			params[12] = "0";//查询0；打印1
			for(int i=0;i<params.length;i++) {
				System.out.println("-----liujian----params[" + i + "]=" + params[i]);
			}
		%>
		<wtc:service name="s2893Qry" routerKey="phone" routerValue="<%=phoneNo%>"
			retcode="retCode" retmsg="retMsg" outnum="9">
			<wtc:param value="<%=params[0]%>"/>
			<wtc:param value="<%=params[1]%>"/>
			<wtc:param value="<%=params[2]%>"/>
			<wtc:param value="<%=params[3]%>"/>
			<wtc:param value="<%=params[4]%>"/>
			<wtc:param value="<%=params[5]%>"/>
			<wtc:param value="<%=params[6]%>"/>
			<wtc:param value="<%=params[7]%>"/>
			<wtc:param value="<%=params[8]%>"/>
			<wtc:param value="<%=params[9]%>"/>
			<wtc:param value="<%=params[10]%>"/>
			<wtc:param value="<%=params[11]%>"/>
			<wtc:param value="<%=params[12]%>"/>
		</wtc:service>
		<wtc:array id="qryRst1"  start="0" length="1" scope="end"/>	
		<wtc:array id="qryRst2"  start="1" length="8" scope="end"/>		
			
<%
		if(retCode.equals("000000")) {
			if(qryRst1 != null && qryRst1.length > 0) {
				allNumStr = qryRst1;
				if(allNumStr==null || allNumStr.length == 0 || "0".equals(allNumStr[0][0])){
            %>
				<script language="javascript">
				 	rdShowMessageDialog("没有查到相关记录！",0);
				 	parent.location="f2893_1.jsp";
				</script>
            <%
			    }else {
			    	countNum = allNumStr[0][0]+"";
		    		result1   = qryRst2;
			    }
			}
		}else {
	%>
			<script language="javascript">
			 	rdShowMessageDialog("查询黑白名单失败！",0);
			 	parent.location="f2893_1.jsp";
			</script>
	<%	
		}	
	%>	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script type=text/javascript>
		
	//控制窗体的移动
	function initAd() 
	{		
		document.all.page0.style.posLeft = -200;
		document.all.page0.style.visibility = 'visible'
		MoveLayer('page0');
	}
	
	function MoveLayer(layerName) 
	{
		var x = 10;
		var x = document.body.scrollLeft + x;		
		eval("document.all." + layerName + ".style.posLeft = x");
		setTimeout("MoveLayer('page0');", 20);
	}

	function printxls(){
		var packet = new AJAXPacket("f2893info_printxls.jsp","正在下载文件，请稍候......");
		var _data = packet.data;
		_data.add("spCode",'<%=spCode%>');
		_data.add("bizCode",'<%=bizCode%>');
		_data.add("phoneNo",'<%=phoneNo%>');
		_data.add("oprDate",'<%=oprDate%>');
		_data.add("countNum",'<%=countNum%>');
		core.ajax.sendPacket(packet);
		packet = null;	
	}	
	
	function doProcess(packet) {
		var retCode = packet.data.findValueByName("retcode");
		var retMsg = packet.data.findValueByName("retmsg");
		if(retCode == "000000") {
			rdShowMessageDialog("导出申请记录成功，请到g079模块查询导出结果!");
		}else {
			rdShowMessageDialog("错误代码："+retCode+"，错误信息："+retMsg,0);
			return false;
		}	
	}
</script>
</head>
<body >
<form name="form1" method="post" action="">	
	<div id="Operation_Table">	
		<table id="tabList" cellspacing=0 >			
			<tr>		
				<th>集团编码</th>		
				<th>企业代码</th>
				<th>业务代码</th>
				<th>业务名称</th>
				<th>手机号码</th>
				<th>操作类型</th>
				<th>期望生效日期</th>
				<th>操作时间</th>
			</tr>
	<%	
		for(int i = 0; i < result1.length; i++)
		{
	%>			
			<tr>		
				<td nowrap><%=result1[i][7].trim()%>&nbsp;</td>	
				<td nowrap><%=result1[i][0].trim()%>&nbsp;</td>
				<td nowrap><%=result1[i][1].trim()%>&nbsp;</td>
				<td nowrap><%=result1[i][2].trim()%>&nbsp;</td>
				<td nowrap><%=result1[i][3].trim()%>&nbsp;</td>
				<td nowrap><%=result1[i][4].trim()%>&nbsp;</td>
				<td nowrap><%=result1[i][5].trim()%>&nbsp;</td>
				<td nowrap><%=result1[i][6].trim()%>&nbsp;</td>
			</tr>
	<%
		}
	%>		
			<tr>	
				<td colspan="10">
					<div id="page0" style="position:relative;font-size:12px;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           <%	
					    //实现分页
					    if(allNumStr!=null && allNumStr.length > 0 && !"0".equals(allNumStr[0][0])){
					    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
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
<script language="javascript" type="text/javascript">
    var flag;
    var goodKind = ""; //靓号类型
jQuery(
	function (){
	window.parent.UnLoad();
});
</script>	
</form>
</body>
</html>
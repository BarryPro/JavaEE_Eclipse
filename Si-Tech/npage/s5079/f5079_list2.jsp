<%
   /*
   * 功能: 集团产品查询 - 列表(全部数据)
　 * 版本: v1.0
　 * 日期: 2006/10/30
　 * 作者: shibo
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   * 2009-09-21    qidp        新版集团产品改造
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="org.apache.log4j.Logger"%>


<%	
	//读取用户session信息
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                //工号
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));               //工号姓名
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));                  //登陆密码
	
	Logger logger = Logger.getLogger("f5079_list2.jsp");
	
	String QryValues = request.getParameter("turnValue");
	String QryFlag = request.getParameter("QryFlag");             /*wuxy add 20090208*/
	String QryValues1 = request.getParameter("QryValues");        /*wuxy add 20090208*/
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList acceptList = new ArrayList();
	 
	String[][] result = new String[][]{};
	
	//wuxy alter 20090208 如果按成员号码查询，需要多传入一个成员号码值
	String paraArr[] = new String[5];
	paraArr[0] = "5079";
	if(QryFlag.equals("4"))
	{
		paraArr[1] =QryValues1;
    }
    else
    {  	
		paraArr[1] = "";
	}
	paraArr[2] = workNo;
	paraArr[3] = nopass;
	paraArr[4] = QryValues;
	
	String errCode = "";
	String errMsg = "";
	
	try{
	    
	    %>
            <wtc:service name="s5079GrpMEXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="40" >
            	<wtc:param value="<%=paraArr[0]%>"/>
            	<wtc:param value="<%=paraArr[1]%>"/> 
                <wtc:param value="<%=paraArr[2]%>"/> 
                <wtc:param value="<%=paraArr[3]%>"/> 
                <wtc:param value="<%=paraArr[4]%>"/> 
            </wtc:service>
            <wtc:array id="retArr1" scope="end"/>
        <%
            errCode = retCode1;
            errMsg = retMsg1;
	        if("000000".equals(errCode)){
                if(retArr1.length>0){
    	            result = retArr1;
    	        }else{
    	            %>
        	            <script type=text/javascript>
        	                rdShowMessageDialog("没有相关数据!",0);
        	            </script>
        	        <%
    	        }
            }else{
	            %>
    	            <script type=text/javascript>
    	                rdShowMessageDialog("错误代码：<%=errCode%>,错误信息：<%=errMsg%>",0);
    	            </script>
    	        <%
            	System.out.println("# return from f5079_list2.jsp by s5079GrpMEXC -> retCode = " + errCode);
            	System.out.println("# return from f5079_list2.jsp by s5079GrpMEXC -> retMsg  = " + errMsg);
	        }
	}catch(Exception e){
	    %>
            <script type=text/javascript>
                rdShowMessageDialog("调用服务s5079GrpMEXC失败！",0);
            </script>
        <%
	    e.printStackTrace();
	}
	
	//acceptList = impl.callFXService("s5079GrpM",paraArr,"7");
	//int errCode=impl.getErrCode();   
	//String errMsg=impl.getErrMsg(); 
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	var oldrow = -1;
	var nowrow = -1;

	//鼠标点击某行处理函数
	function rowClick(objname,flag){
		var o = eval(objname);
		if(flag == 1)
			o.className = "opened";
		else
			o.className = "unopen";
	}
	
	//鼠标移到某行
	function rowMouseOver(node){
		if(node.className != "opened")
			node.className = "mouseover";
	}
	
	//鼠标移出某行
	function rowMouseOut(node){
		if(node.className != "opened")
			node.className = "unopen";
	}
	
	//鼠标点击某行
	function trfunc1(node){
		nowrow = parseInt(node.id.substring(3,node.id.length));  
		if(oldrow != nowrow){
			if(oldrow != -1) 
				rowClick("row" + oldrow,0);
			rowClick("row" + nowrow,1);
			oldrow = nowrow;
		}
	}
		function printxlslist(){
			window.open("f5079_print2xls.jsp?turnValue=<%=QryValues%>&QryFlag=<%=QryFlag%>&QryValues=<%=QryValues1%>");
	}
	
</script>
</head>

<body>
<div id="Operation_Table">
		<table cellspacing="0">
			<tr>
			<!-- wuxy add 20090209 展示统付账户余额 -->
				<td colspan="7"><input type="button" name="printxls" class="b_text" value="导出为XLS表格" onclick="printxlslist()"/></td>
			</tr>
			<tr>
				<th class="listformtop">集团名称</th>
				<th class="listformtop">客户经理</th>
				<th class="listformtop">集团产品ID</th>
				<th class="listformtop">成员号码</th>
				<th class="listformtop">机主姓名</th>
				<th class="listformtop">开始时间</th>
				<th class="listformtop">结束时间</th>				
			</tr>
<%
		if("000000".equals(errCode)){
		/*
			String[][] tmpresult0=(String[][])acceptList.get(0);
			String[][] tmpresult1=(String[][])acceptList.get(1);
			String[][] tmpresult2=(String[][])acceptList.get(2);
			String[][] tmpresult3=(String[][])acceptList.get(3);
			String[][] tmpresult4=(String[][])acceptList.get(4);
			String[][] tmpresult5=(String[][])acceptList.get(5);
			String[][] tmpresult6=(String[][])acceptList.get(6);
        */

//			out.println(tmpresult0.length);

		for(int i = 0; i < result.length; i++)
		{	
			
            String tdClass = "";
            if (i%2==0){
                tdClass = "Grey";
            }
%>
        <tr>
				<td class="<%=tdClass%>"><%=result[i][0]%></td>
				<td class="<%=tdClass%>"><%=result[i][1]%></td>
				<td class="<%=tdClass%>"><%=result[i][2]%></td>
				<td class="<%=tdClass%>"><%=result[i][3]%></td>
				<td class="<%=tdClass%>"><%=result[i][4]%></td>		
				<td class="<%=tdClass%>"><%=result[i][5]%></td>		
				<td class="<%=tdClass%>"><%=result[i][6]%></td>			
		</tr>
<%
		}
	}	
	else{

}
%>	
		</table>
</div>
</body>
</html>


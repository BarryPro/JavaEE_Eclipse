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
<%@ page import="java.text.DecimalFormat"%>


<%	
  //控制格式
	DecimalFormat df = new DecimalFormat("#.00");
	//读取用户session信息
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));              //工号
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));        //工号姓名
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String[][] result = new String[][]{};
	
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));                    //登陆密码
	String strHuaboym = "";
	Logger logger = Logger.getLogger("f5079_list4.jsp");
	//是从f5079_query页面查询到的contract_pay
	String QryValues = (String)request.getParameter("turnValue")==null?"":(String)request.getParameter("turnValue");
	String QryFlag = (String)request.getParameter("QryFlag")==null?"":(String)request.getParameter("QryFlag");             /*wuxy add 20090208*/
	String QryValues1 = (String)request.getParameter("QryValues")==null?"":(String)request.getParameter("QryValues");        /*wuxy add 20090208*/
	
	String huaboym = (String)request.getParameter("huaboym")==null?"":(String)request.getParameter("huaboym");
	String tongfulb = (String)request.getParameter("tongfulb")==null?"":(String)request.getParameter("tongfulb");
	System.out.println("------------f5079_list4.jsp-----------huaboym="+huaboym);
	System.out.println("------------f5079_list4.jsp-----------tongfulb="+tongfulb);
	//控制显示的数字
    if("0".equals(tongfulb)){
        strHuaboym = "被统付帐户";
    }else{
        strHuaboym = "成员ID";
    }
	
	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList acceptList = new ArrayList();
	
	String paraArr[] = new String[8];
	paraArr[0] = workNo;
	paraArr[1] = nopass;
	paraArr[2] = "5079";
	paraArr[3] = QryValues;
	paraArr[4] = huaboym;
	paraArr[5] = tongfulb;
	paraArr[6] = QryFlag;
	paraArr[7] = QryValues1;
	
	String errCode = "";
	String errMsg = "";
	try{
    	%>
            <wtc:service name="s5079Query" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="6" >
            	<wtc:param value="<%=paraArr[0]%>"/>
            	<wtc:param value="<%=paraArr[1]%>"/> 
                <wtc:param value="<%=paraArr[2]%>"/> 
                <wtc:param value="<%=paraArr[3]%>"/> 
                <wtc:param value="<%=paraArr[4]%>"/> 
                <wtc:param value="<%=paraArr[5]%>"/> 
                <wtc:param value="<%=paraArr[6]%>"/> 
                <wtc:param value="<%=paraArr[7]%>"/> 
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
            	System.out.println("# return from f5079_list4.jsp by s5079Query -> retCode = " + errCode);
            	System.out.println("# return from f5079_list4.jsp by s5079Query -> retMsg  = " + errMsg);
	        }
    }catch(Exception e){
        %>
            <script type=text/javascript>
                rdShowMessageDialog("调用服务s5079Query失败！",0);
            </script>
        <%
        e.printStackTrace();
    }
    
	//acceptList = impl.callFXService("s5079Query",paraArr,"6");
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
			window.open("f5079_print4xls.jsp?turnValue=<%=QryValues%>&QryFlag=<%=QryFlag%>&QryValues=<%=QryValues1%>&huaboym=<%=huaboym%>&tongfulb=<%=tongfulb%>");
	}
	
</script>
</head>

<body>
<div id="Operation_Table">
<table cellspacing="0">
    <tr>
		  <!-- diling add 增加导出表格功能 @2012/5/25 -->
			<td colspan="6"><input type="button" name="printxls" class="b_text" value="导出为XLS表格" onclick="printxlslist()"/></td>
		</tr>
    <tr>
        <th>统付关系</th>
        <th>统付帐户</th>
        <th><%=strHuaboym%></th>
        <th> 成员号码</th>
        <th>付费时间</th>
        <th>金额</th>
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
		*/
		



		for(int i = 0; i < result.length; i++)
		{	
			String tdClass = "";
            if (i%2==0){
                tdClass = "Grey";
            }

			String stra="";
			if("0".equals(result[i][0])){
				stra="定额统付";
			}else{
				stra="全额统付";
			}
%>
		<tr>
			<td class="<%=tdClass%>"><%=result[i][0]%></td>
			<td class="<%=tdClass%>"><%=result[i][1]%></td>
			<td class="<%=tdClass%>"><%=result[i][2]%></td>
			<td class="<%=tdClass%>"><%=result[i][3]%></td>
			<td class="<%=tdClass%>"><%=result[i][4]%></td>		
			<td class="<%=tdClass%>"><%=df.format(Float.parseFloat(result[i][5]))%></td>		
		</tr>
<%
		}
	}	
	else{

}
%>	


</table>
<div>
</body>
</html>



<%
   /*
   * 功能: 查询基本接入号信息
　 * 版本: v1.0
　 * 日期: 2009/3/6
　 * 作者: wuxy
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   * 2009-09-24    qidp        新版集团产品改造
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	 
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	
	String op_name = "基本接入号信息列表";
	
	String opName = "基本接入号信息列表";
	//-----------------------------------------------
	
	String queryType = request.getParameter("queryType");
	String queryInfo = request.getParameter("queryInfo");	
	
	System.out.println("queryType="+queryType);
	System.out.println("queryInfo="+queryInfo);
	
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();

	ArrayList retList = new ArrayList();
	/*	
	String sqlStr = "";		
	
	if(queryType.equals("0"))//合作伙伴编码
	{
		sqlStr = "select baseservcode,decode(trim(baseservcodeprop),'01','短信','02','彩信','未知') a ,decode(basecodestatus,'1','正常','3','暂停','未知') b from daccessnomsg "
		       +" where ecsiid='"+queryInfo+"' ";
                        
	}else if(queryType.equals("1"))//EC客户ID
	{
		sqlStr = "select baseservcode,decode(trim(baseservcodeprop),'01','短信','02','彩信','未知') a ,decode(basecodestatus,'1','正常','3','暂停','未知') b from daccessnomsg "
		       +" where dcu_ecsiid='"+queryInfo+"' ";
	}
	*/
	String[][] colNameArr = new String[][]{};
	//retList = callView.sPubSelect("3",sqlStr);
	//System.out.println("# return from f5648_querydBaseCode.jsp sql -> "+sqlStr);
	try{
    	%>
        <wtc:service name="s5648BaseEXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4" >
        	<wtc:param value="5648"/>
        	<wtc:param value="<%=workNo%>"/> 
        	<wtc:param value="<%=queryType%>"/>
        	<wtc:param value="<%=queryInfo%>"/>         		
        </wtc:service>
        <wtc:array id="retArr1" scope="end"/>
        <%
        System.out.println("# return from f5648_querydBaseCode.jsp by sPubSelect -> retCode = "+retCode1);
        System.out.println("# return from f5648_querydBaseCode.jsp by sPubSelect -> retMsg  = "+retMsg1);
        System.out.println("# return from f5648_querydBaseCode.jsp by sPubSelect -> retArr.length  = "+retArr1.length);
        if("000000".equals(retCode1)){
            if(retArr1.length>0){
                colNameArr = retArr1;
            }else{
                System.out.println("没有查到相关记录");
                %>
        			<script language='jscript'>
        				rdShowMessageDialog("没有查到相关记录！",0);
        				window.close();
        			</script>
                <%
            }
        }else{
            %>
    			<script language='jscript'>
    				rdShowMessageDialog("错误代码：<%=retCode1%>,错误信息：<%=retMsg1%>",0);
    				window.close();
    			</script>
            <%
        }
	    
		if (colNameArr != null && colNameArr.length>0)
		{
			if (colNameArr[0][0].equals("")) 
			{
				colNameArr = null;
				System.out.println("colNameArr = null");
			}
		}
		
    }catch(Exception e){
        e.printStackTrace();
        %>
			<script language='jscript'>
				rdShowMessageDialog("调用服务失败！",0);
				window.close();
			</script>
        <%
    }
    
	//String[][] colNameArr = (String[][])retList.get(0);
	    
	    	    
	    
if (colNameArr != null && colNameArr.length>0)
{
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
window.onkeydown(window.event) 
</SCRIPT>
</head>
<body>
<form name="frm" method="POST" >
<div id="Operation_Table">
<TABLE id="tab1" cellspacing="0">
	<tr>
		<th nowrap>
			基本接入号
		</th>
		<th nowrap>
			类型
		</th>
		<th nowrap>
			状态
		</th>
	</tr>
</table>
<table cellspacing="0">
<tr id="footer">
	<td>
        <input type="button" name="back" class="b_foot" style="cursor:hand" onClick="doClose();" value=" 关闭 ">
	</td>
</tr>
</table>
</div>
</form>
</body>
</html>

<script>
	  
	<%for(int i=0;i < colNameArr.length;i++){ %>
		var str='<input type="hidden" name="parterId" value="<%=colNameArr[i][0]%>">';
		str+='<input type="hidden" name="parterName" value="<%=colNameArr[i][1]%>">';
		str+='<input type="hidden" name="spTel" value="<%=colNameArr[i][2]%>">';
					
		var rows = document.getElementById("tab1").rows.length;
		var newrow = document.getElementById("tab1").insertRow(rows);
	  	newrow.insertCell(0).innerHTML = '<%=colNameArr[i][0]%>';
	  	newrow.insertCell(1).innerHTML = '<%=colNameArr[i][1]%>';
	  	newrow.insertCell(2).innerHTML = '<%=colNameArr[i][2]%>';
	  	
	<%}%>

	function onkeydown(event) 
	{
		if (event.srcElement.type!="button")
		{
			if (event.keyCode == 13)
			{
				doCommit();
			}
		}
	}
	function doClose()
	{
		window.close();
	}
</script>

<%            
    }
%>


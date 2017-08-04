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
	//读取用户session信息
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                 //工号
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));               //工号姓名
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));                    //登陆密码
	
	Logger logger = Logger.getLogger("f5079_list3.jsp");
	String sqlStr2="";                                             //wuxy add 20090209
	ArrayList retList2 = new ArrayList();                          //wuxy add 20090209
	String[][] result2 = new String[][]{};                         //wuxy add 20090209
	DecimalFormat df = new DecimalFormat("#0.00");                 //wuxy add 20090209

    String[][] result = new String[][]{};

	String QryValues = request.getParameter("turnValue");
	String QryFlag = request.getParameter("QryFlag");             /*wuxy add 20090208*/
	String QryValues1 = request.getParameter("QryValues");        /*wuxy add 20090208*/
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList acceptList = new ArrayList();
	
	sqlStr2=" select nvl(sum(prepay_fee),0) from dconmsgpre where contract_no=:QryValues and begin_dt<=to_char(sysdate,'yyyymmdd') "+
	           " and end_dt>=to_char(sysdate,'yyyymmdd') ";
	String [] paraIn1 = new String[2];
	paraIn1[0]=sqlStr2;
	paraIn1[1]="QryValues="+QryValues;
	           
	try
    {
	  	//retList2=impl.sPubSelect("1",sqlStr2, "region", regionCode);
	  	%>
             <wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2"  outnum="1">
			<wtc:param value="<%=paraIn1[0]%>"/>
 			<wtc:param value="<%=paraIn1[1]%>"/>
 			</wtc:service>
			<wtc:array id="retArr2" scope="end"/>
        <%
        if("000000".equals(retCode2) && retArr2.length>0){
            result2 = retArr2;
        }
    }catch(Exception e)	
    {
        System.out.println("\n==================\n error1");
        e.printStackTrace();
    }
	

	//wuxy alter 20090208 如果按成员号码查询，需要多传入一个成员号码值
	String paraArr[] = new String[5];
	paraArr[0] = workNo;
	paraArr[1] = nopass;
	paraArr[2] = "5079";
	if(QryFlag.equals("4"))
	{
		paraArr[3] =QryValues1;
    }
    else
    {  	
		paraArr[3] = "";
	}
	paraArr[4] = QryValues;
	
	//acceptList = impl.callFXService("s5079GrpR",paraArr,"11"); /*武星燕　修改多取一个值，以前为１０个20090208*/
	//int errCode=impl.getErrCode();   
	//String errMsg=impl.getErrMsg(); 
	
	String errCode = "";
	String errMsg = "";
	try{
    	%>
            <wtc:service name="s5079GrpR" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="11" >
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
            	System.out.println("# return from f5079_list3.jsp by s5079GrpR -> retCode = " + errCode);
            	System.out.println("# return from f5079_list3.jsp by s5079GrpR -> retMsg  = " + errMsg);
	        }
    }catch(Exception e){
        %>
            <script type=text/javascript>
                rdShowMessageDialog("调用服务s5079GrpR失败！",0);
            </script>
        <%
        e.printStackTrace();
    }
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
	
//-------显示明细页面--------
function showModify(idNo,feeType,contractNo)
{ 
	if(feeType=="N")
	{
		rdShowMessageDialog("此帐号没有资费明细！");
		return;
	}
	var url = "f5079_detail.jsp?idNo=" + idNo + "&contractNo="+contractNo;
	window.open(url,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
}	
	function printxlslist(){
			window.open("f5079_print3xls.jsp?turnValue=<%=QryValues%>&QryFlag=<%=QryFlag%>&QryValues=<%=QryValues1%>");
	}
</script>
</head>

<body>
<div id="Operation_Table">
		<table cellspacing="0">
			<tr>
			<!-- wuxy add 20090209 展示统付账户余额 -->
				<td class='blue' nowrap>付费账户余额</td>
				<td><%=df.format(Float.parseFloat(result2.length < 1?"0":result2[0][0]))%> 元  </td>
				<td colspan="5"><input type="button" name="printxls" class="b_text" value="导出为XLS表格" onclick="printxlslist()"/></td>
			</tr>
			<tr>
				<th>电话号码</th> 
				<th>用户ID</th> 
				<th>付费帐户</th> 
				<th>帐单顺序</th>
				<th>开始年月日</th>
				<th>结束年月日</th>
				<th>帐单限额</th>
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
			String[][] tmpresult7=(String[][])acceptList.get(7);
			String[][] tmpresult8=(String[][])acceptList.get(8);
			String[][] tmpresult9=(String[][])acceptList.get(9);
			String[][] tmpresult10=(String[][])acceptList.get(10);
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
				<td class="<%=tdClass%>"><a href="javascript:showModify('<%=result[i][0].trim()%>','<%=result[i][10]%>','<%=result[i][1]%>')"><%=result[i][2]%></a></td>
				<td class="<%=tdClass%>"><%=result[i][0]%></td>
				<td class="<%=tdClass%>"><%=result[i][1]%></td>
			    <td class="<%=tdClass%>"><%=result[i][3]%></td>
				<td class="<%=tdClass%>"><%=result[i][4]%></td>
			    <td class="<%=tdClass%>"><%=result[i][6]%></td>
			    <td class="<%=tdClass%>"><%=result[i][8]%></td>
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


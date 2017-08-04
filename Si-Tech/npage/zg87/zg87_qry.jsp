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
    String opCode="zg87";
	String opName="积分计算要素管理";	
 
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
	String contextPath = request.getContextPath();
	String pass = (String)session.getAttribute("password");
	
	//服务入参 
	String dsxx = request.getParameter("dsxx");
	String ppxx = request.getParameter("ppxx");
	String jflx = request.getParameter("jflx");
	String jsys = request.getParameter("jsys");
	String sxzt = request.getParameter("sxzt1");
	String beizhu = "";//request.getParameter("beizhu");
	String jfjhmc = request.getParameter("jfjhmc1");

	System.out.println("AAAAAAAAAAAAAAAAAA dsxx is "+dsxx+" and sxzt is "+sxzt);

	String paraAray[] = new String[16];
	paraAray[0]="q";
	paraAray[1]=dsxx;
	paraAray[2]=ppxx;
	paraAray[3]=jflx;
	paraAray[4]=jsys;
	paraAray[5]="";
	paraAray[6]="";
	paraAray[7]="";
	paraAray[8]="";
	paraAray[9]="";
	paraAray[10]="";
	paraAray[11]="";
	paraAray[12]="";
	paraAray[13]=sxzt;
	paraAray[14]=beizhu;
	paraAray[15]=jfjhmc;
%>

<wtc:service name="sCompConf" routerKey="region" routerValue="<%=regionCode%>" retcode="g089CfmCode" retmsg="g089CfmMsg" outnum="17" >
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
	<wtc:param value="<%=paraAray[11]%>"/>
	<wtc:param value="<%=paraAray[12]%>"/>
	<wtc:param value="<%=paraAray[13]%>"/>
	<wtc:param value="<%=paraAray[14]%>"/>
	<wtc:param value="<%=paraAray[15]%>"/>
    
</wtc:service>
<wtc:array id="r_return_code" scope="end" start="0"  length="2" />
<wtc:array id="r_return_detail" scope="end" start="2"  length="15" />
<%
	String retCode= g089CfmCode;
	String retMsg = g089CfmMsg;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
%>
 
<%
   

	String errMsg = g089CfmMsg;
	if ( g089CfmCode.equals("000000"))
	{
 
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>自助终端查询结果</TITLE>
</HEAD>
<body>


<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">查询结果</div>
</div>

      <table cellspacing="0" id = "PrintA">
                <tr> 
                  <th>规则类型规范</th>
				  <th>地市信息</th>
                  <th>品牌信息</th> 
				  <th>积分类型</th>
				  <th>计算要素</th>
				  <th>计算要素值</th>
				  <th>最小值</th>
				  <th>最大值</th>
				  <th>积分倍率</th>
				  <th>生效时间</th>
				  <th>失效时间</th>
				  <th>更新时间</th>
				  <th>更新工号</th>
				  <th>生效状态</th>
				  <th>备注</th>
                </tr>
<%
				for(int i=0;i<r_return_detail.length;i++)
				{
					%>
						<tr>
							<td><%=r_return_detail[i][0]%></td>
							<td><%=r_return_detail[i][1]%></td>
							<td><%=r_return_detail[i][2]%></td>
							<td><%=r_return_detail[i][3]%></td>
							<td><%=r_return_detail[i][4]%></td>
							<td><%=r_return_detail[i][5]%></td>
							<td><%=r_return_detail[i][6]%></td>
							<td><%=r_return_detail[i][7]%></td>
							<td><%=r_return_detail[i][8]%></td>
							<td><%=r_return_detail[i][9]%></td>
							<td><%=r_return_detail[i][10]%></td>
							<td><%=r_return_detail[i][11]%></td>
							<td><%=r_return_detail[i][12]%></td>
							<td><%=r_return_detail[i][13]%></td>
							<td><%=r_return_detail[i][14]%></td> 
 
						</tr>
					<%
				}

%>

         
          <tr id="footer"> 
      	    <td colspan="15">
    	      <input class="b_foot" name=back onClick="window.location = 'zg87_1.jsp' " type=button value=返回>
    	      <input class="b_foot" name=back onClick="window.close();" type=button value=关闭>
	 
    	    </td>
          </tr>
          
      </table>
      <tr id="footer"> 
      	   
          </tr>
    
      	
    	    
        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("查询失败: <%=retMsg%>,<%=g089CfmCode%>",0);
	window.location="zg87_1.jsp?opCode=g089&opName=集团红黑名单管理";
	</script>
<%}
%>

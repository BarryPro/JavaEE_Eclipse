<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>集团信息查询</TITLE>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
    String opCode = "5082";
	String opName = "集团信息查询";
    
	String idNo = request.getParameter("idNo");//查询条件
	String sm_code = request.getParameter("sm_code");//查询条件
	String outNum = "8";
	if("JD".equals(sm_code)){
		outNum = "12";
	}
	
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	String vStartPos = ""+iStartPos;
	String vEndPos = ""+iEndPos;
	
	System.out.println("idNo:"+idNo);
	System.out.println("vStartPos:"+vStartPos);
	System.out.println("vEndPos:"+vEndPos);
    String status = "";
    
    //查询唯一标识
		String sqlStr = "select field_value from dgrpusermsgadd where id_no = :v1 and field_code = '1010'";
		String param = "v1=" +  idNo;
%>		
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retStatusCode" retmsg="retStatusMsg" outnum="1"> 
			<wtc:param value="<%=sqlStr%>"/>
			<wtc:param value="<%=param%>"/> 
		</wtc:service>  
		<wtc:array id="rstStatus"  scope="end"/>
<%
		
		if("000000".equals(retStatusCode) && rstStatus.length > 0) {
			status = rstStatus[0][0];
		}
    String[][] result1 = new String[][]{};
    int recordNum = 0;
    try{
    %>
    
    	<wtc:service name="sGrpMemQryEXC"  outnum="<%=outNum%>" retcode="errcode" retmsg="errmsg" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=idNo%>" />
    	<wtc:param value="<%=vStartPos%>" />
    	<wtc:param value="<%=vEndPos%>" />
    	</wtc:service>
    	<wtc:array id="retArr1" scope="end"/>
    
    <%
        if("000000".equals(errcode)){
            if(retArr1.length>0){
                result1 = retArr1;
                for(int i = 0;i<result1.length;i++) {
            		for(int j = 0;j<result1[0].length;j++)
            		    System.out.println("liujian5082---result1["+i+"]["+j+"]"+result1[i][j]);
        	    }
        	    recordNum = Integer.parseInt(result1[0][7].trim());
        	}
        }else{
            %>
                <script type=text/javascript>
                    rdShowMessageDialog("错误代码：<%=errcode%>,错误信息：<%=errmsg%>",0);
                    history.go(-1);
                </script>
            <%
        }
    }catch(Exception e){
        %>
            <script type=text/javascript>
                rdShowMessageDialog("调用服务sGrpMemQry失败！",0);
            </script>
        <%
        e.printStackTrace();
    }
%>
</HEAD>
<% if (!(result1.length>0) ){%>
<script language="javascript">
	rdShowMessageDialog("没有找到任何数据",0);
	history.go(-1);
</script>
<%}else{%>
<body>
<FORM method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">集团信息查询</div>
</div>
    <table cellspacing="0">
      <tr>
      	<!--<td>成员序号</td> -->
        <th>成员名称</th>
		<th>成员资费名称</th>
        <th>成员号码</th>
        <th>成员帐号</th>
        <th>运行状态</th>
        <th>加入集团时间</th>
        <%if("JD".equals(sm_code)){
        %>
        <th>宽带号</th>
        <th>联系电话</th>
        <th>联系人</th>
        <th>合同有效期</th>
        
        <%
        
        }%>
      </tr>
	  <%
		for(int y=0;y<result1.length;y++){
	  %>
		  		<tr>
		  <%  
			for(int j=1;j<result1[0].length-1;j++){
				if(status.equals("214")) {
				%>
					<td><a href="f5082_214.jsp?idNo=<%=result1[y][0]%>" /><%=result1[y][j]%></a></td>
				<%
				}else {
					if(j == 3){
				%>	
						<td><a href="f5082_sports.jsp?idNo=<%=result1[y][0]%>" /><%=result1[y][j]%></a></td>
				<%
					}else if(j>=7 && "JD".equals(sm_code)){
						%>
						<td><%=result1[y][j+1]%></td>
						<%
					}else{
				%>	
						<td><%=result1[y][j]%></td>
				<%	
					}
				} 
		  %>
		    
		  <%
			}
	   	  %>
	   			</tr>
	   	  <%
	    }
	  %>
    </table>

 <table cellspacing="0" id=contentList>
	<tr>
	 <td>
<%	
    //int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    //int iQuantity = 500;
    Page pg = new Page(iPageNumber,iPageSize,recordNum);
	PageView view = new PageView(request,out,pg); 
   	view.setVisible(true,true,0,0);       
%>
     </TD>
    </TR>
 </TABLE>

    <table cellspacing=0>
      <tr id="footer"> 
		<td>
			  <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
			  <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
			  <input class="b_foot_long" name=print onClick="printxls()" type=button value=导出数据>
		</td>
	  </tr>
	</table>
<script>
	function printxls(){
		var packet = new AJAXPacket("f5082_3_printxls.jsp","正在下载文件，请稍候......");
		var _data = packet.data;
		_data.add("idNo",'<%=idNo%>');
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
<%@ include file="/npage/include/footer.jsp" %>
</FORM></BODY></HTML>
<%}%>
<%
    /********************
     * @ OpCode    :  8564
     * @ OpName    :  拆包费用查询
     * @ Services  :  s8564FeeQry,
     * @ Pages     :  s8564/f8564.jsp,
     * @ CopyRight :  si-tech
     * @ Author    :  huangrong
     * @ Date      :  2011-03-23
     * @ Update    :  
     ********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
  String opCode = "8564";
  String opName = "IMEI拆包查询";
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");	
	String op_name = "拆包费用查询";
	String regionCode = (String)session.getAttribute("regCode");
	String orgCode = (String)session.getAttribute("rogCode");
	String password  = (String)session.getAttribute("password");
	String phoneNo  = request.getParameter("phoneNo");	
	String functionname  = request.getParameter("functionname");	//营销案信息
	String imei_no="";

	String[] infos=functionname.split("~");
  String function_name=infos[0];
  String op_code=infos[1];  
 //查询imei码 
	String sqlStr=" select imei_no from "+
								" (select imei_no  ,ROW_NUMBER() over(order by OP_TIME desc ) imeicount from wmachsndopr a ,dcustmsg b where "+ 
								"	a.id_no=b.id_no and    op_code='"+op_code+"' and a.id_no=(select id_no from dcustmsg where phone_no='"+phoneNo+"')  ) "+ 
                " where imeicount=1"; 
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1" retcode="retCode" retmsg="retMsg">
   <wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="resultStr" scope="end"/>


<%  
  if(retCode.equals("000000"))
  {
  	if(resultStr!=null && resultStr.length>0)
  	{
  		imei_no=resultStr[0][0];
  	}
  }		
  
  String first ="N";
  String second="N";	
	String[] paraAray1 = new String[9];  
  paraAray1[0] = "";	    /* 操作流水   */
  paraAray1[1] = "01";	    /* 渠道代码   */  
  paraAray1[2] = opCode; 	    /* 操作代码   */
  paraAray1[3] = workNo;	    /* 操作工号   */  
  paraAray1[4] = password;	    /* 工号密码   */  
  paraAray1[5] = phoneNo;		/* 手机号码   */ 
  paraAray1[6] = "";		/* 用户密码   */ 
  paraAray1[7] = "";	    /* 备注   */
  paraAray1[8] = op_code;	    /* 营销案名称   */
  for(int i=0; i<paraAray1.length; i++){		
		if( paraAray1[i] == null ){
		  paraAray1[i] = "";
		}
  }	
%>
		<wtc:service name="s8564FeeQry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="7" >
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=paraAray1[3]%>"/>
		<wtc:param value="<%=paraAray1[4]%>"/>
		<wtc:param value="<%=paraAray1[5]%>"/>
		<wtc:param value="<%=paraAray1[6]%>"/>
		<wtc:param value="<%=paraAray1[7]%>"/>			
		<wtc:param value="<%=paraAray1[8]%>"/>				
		</wtc:service>
		<wtc:array id="s8564FeeQryArr"  scope="end"/>
      	
<%
	  String errCode = retCode1;
	  String errMsg = retMsg1;
	  System.out.println("-----------------errCode-------------------------"+errCode);
	  System.out.println("-----------------s8564FeeQryArr-------------------------"+s8564FeeQryArr.length);
  	if(!errCode.equals("000000")){
 %>
		<script language="JavaScript">
			<!--
	  		rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>");
	  	 	history.go(-1);
	  	//-->
	  </script>
<%
  		return;
  	}else
  	{ 
  		if(s8564FeeQryArr.length ==0)
  		{
%>
		<script language="JavaScript">
			<!--
	  		rdShowMessageDialog("没有查到相应的数据，你的专款可能过期");
	  	//-->
	  </script>
<%   
			}
    }
%>

    <wtc:service name="sSpcDtQry" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=phoneNo%>"/>
    </wtc:service>
    <wtc:array id="sSpcDtQryArr1" start="0" length="2" scope="end"/>
    <wtc:array id="sSpcDtQryArr2" start="2" length="4" scope="end"/>

    <%
    System.out.println("-----------------sSpcDtQryArr2-------------------------"+sSpcDtQryArr2.length);
    String retCode3=sSpcDtQryArr1[0][0];
    String retMsg3=sSpcDtQryArr1[0][1];    
    if(!"000000".equals(retCode3)){
    %>
        <script type="text/javascript">
            rdShowMessageDialog("<%=retMsg3%>,<%=retCode3%>",0);
            removeCurrentTab();
        </script>
    <%
    }
%>

    <wtc:service name="sBackFeeQry"  outnum="7" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=phoneNo%>"/>
    </wtc:service>
    <wtc:array id="sBackFeeQryArr1" start="0" length="2" scope="end"/>
    <wtc:array id="sBackFeeQryArr2" start="2" length="5" scope="end"/>

    <%
    	  System.out.println("-----------------sBackFeeQryArr2-------------------------"+sBackFeeQryArr2.length);
    String retCode2=sBackFeeQryArr1[0][0];
    String retMsg2=sBackFeeQryArr1[0][1];     
    if(!"000000".equals(retCode2)){
    	if("001001".equals(retCode2))
    	{
    %>
        <script type="text/javascript">
        	  rdShowMessageDialog("<%=retMsg2%>！",1);
        </script>
    <%
    }else
    	{
    %>    	
        <script type="text/javascript">
            rdShowMessageDialog("<%=retMsg2%>,<%=retCode2%>",0);
            removeCurrentTab();
        </script>    	
    <%  
    }  	
    }
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">
<!--

-->
</script>
</head>
<body>
<form name="frm" method="POST" action="">
<%@ include file="/npage/include/header.jsp"%>

<div class="title">
	<div id="title_zi">拆包费用查询</div>
</div>

<table cellSpacing="0"> 
	<% if(imei_no!="" && op_code!="" && sSpcDtQryArr2.length>0){ %>
	
			<tr class="title">
        	<th align="center">手机号</th>
			    <th align="center">营销案名称</th>              
			    <th align="center">开始时间</th>      
			    <th align="center">结束时间</th>
		      <th align="center">当前绑定的IMEI码</th>
      </tr>
      <%  
      System.out.println("---------op_code------------------------"+op_code);
        for(int j=0;j<sSpcDtQryArr2.length;j++ ) 
        {
              System.out.println("---------sSpcDtQryArr2.length------------------------"+sSpcDtQryArr2.length);
              System.out.println("---------sSpcDtQryArr2[j][2].length------------------------"+sSpcDtQryArr2[j][2]);
	         String tdClass = "";            
	         if (j%2==0){
	             tdClass = "Grey";
	         }
       		 if(op_code.equals(sSpcDtQryArr2[j][2]))
       		 {    
       		 	first="Y";  		             		 
      %>
		        <tr>
		        	<td class="<%=tdClass%>" align="center" height="20"><%=phoneNo%>&nbsp;</td>
		        	<td class="<%=tdClass%>" align="center" height="20"><%=function_name%>&nbsp;</td>
		        	<td class="<%=tdClass%>" align="center" height="20"><%=sSpcDtQryArr2[j][0]%>&nbsp;</td>
		        	<td class="<%=tdClass%>" align="center" height="20"><%=sSpcDtQryArr2[j][1]%>&nbsp;</td>
		        	<td class="<%=tdClass%>" align="center" height="20"><%=imei_no%>&nbsp;</td>       
		       </tr> 
<%
			}}}
			if(first=="N")
			{
%>
			<tr>
			    <td colspan="6" style="color:red;text-align:center;">没有符合条件的数据!</td>
			</tr>
<% } %>      
		</table>
		
		</div>

<div id="Operation_Table">
<div class="title">
	<div id="title_zi">当月起前6个月的IMEI拆包查询数据信息</div>
</div>

<table cellSpacing="0">
	<% if(s8564FeeQryArr.length > 0 && sBackFeeQryArr2.length>0 && op_code!=null ){ 
	      System.out.println("---------op_code------------------------"+op_code);
	%>			
			<tr class="title">
        	<th align="center">月份</th>
			    <th align="center">是否拆包</th>              
			    <th align="center">是否返费</th>      
			    <th align="center">是否重新绑定</th>
		      <th align="center">重新绑定IMEI的时间</th>
      </tr>
       <%  
         for(int i=0;i<s8564FeeQryArr.length;i++){  
           for(int j=0;j<sBackFeeQryArr2.length;j++ )
           {
              System.out.println("---------sSpcDtQryArr2.length------------------------"+sSpcDtQryArr2.length);
              System.out.println("---------sBackFeeQryArr2[j][1]------------------------"+sBackFeeQryArr2[j][1]);
							if(s8564FeeQryArr[i][0].equals(sBackFeeQryArr2[j][2]))
							{   
							 System.out.println("---------s时间------------------------"+s8564FeeQryArr[i][0]);
							  System.out.println("---------x时间------------------------"+sBackFeeQryArr2[j][2]);
								 second="Y";      		
				         String tdClass = "";            
				         if (i%2==0){
				             tdClass = "Grey";
				         }
      %>
        <tr>
        	<td class="<%=tdClass%>" align="center" height="20"><%=s8564FeeQryArr[i][0]%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" height="20"><%=sBackFeeQryArr2[j][0]%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" height="20"><%=sBackFeeQryArr2[j][1]%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" height="20"><%=s8564FeeQryArr[i][1]%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" height="20"><%=s8564FeeQryArr[i][2]%>&nbsp;</td>     
       </tr> 
<%
			}}}}if(second=="N"){ %>
			<tr>
			    <td colspan="6" style="color:red;text-align:center;">没有符合条件的数据!</td>
			</tr>
<% } %>      
		</table>

		
<table cellSpacing="0"> 
			<tr>
				<td id="footer">
					<div align="center">
						<input type="button" name="goback" value="返回" class="b_foot" onClick="location='f8564.jsp?activePhone=<%=phoneNo%>'"/>
						<input type="button" name="close" value="关闭" class="b_foot" onclick="removeCurrentTab()"/>
					</div>
				</td>
			</tr>
		</table>
	</form>
		<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

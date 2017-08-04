<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.16
 模块:集团订购信息管理(修改)
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
	String custId  = request.getParameter("custId");
	String idNo    = request.getParameter("idNo");
	String sm_code = request.getParameter("sm_code");	
	String loginNo = (String)session.getAttribute("workNo");
	String regionCode=(String)session.getAttribute("regCode");
	String iCount = "0";
  String iMonthFee="0";         /*无线监控的基本月租费 */
    String iFlag = "Y";

	String paramsIn[] = new String[2];
 	paramsIn[0] = loginNo;       //工号
 	paramsIn[1] = "2885";        //操作代码
 	
	ArrayList acceptList = new ArrayList();
	String errCode = "";
	String errMsg ="";
	
	String discountMsgVal = "";//打折信息
	
%>
	<wtc:service name="sFuncCheck" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
	<wtc:param value="<%=paramsIn[0]%>"/>
	<wtc:param value="<%=paramsIn[1]%>"/>	
	</wtc:service>	
	<wtc:array id="acceptListTemp"  scope="end"/>
<%
	errCode = retCode1;
	errMsg = retMsg1;;
	
	iCount = acceptListTemp[0][0];
 	
	/**************** 分页设置 ********************/
		int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
		int iPageSize = 10;
		int iStartPos = (iPageNumber-1)*iPageSize;
		int iEndPos = iPageNumber*iPageSize;
	/**********************************************/

	String sqlStr="";
	String sqlStr1="";
	String sqlStr2="";
	String whereSql="";
	String[][] allNumStr = new String[][]{};
	String[][] result1 = new String[][]{};
	String[][] result2 = new String[][]{};
	String[][] result3 = new String[][]{};
	String[][] result4 = new String[][]{};
	String[][] result5 = new String[][]{};

	
	//查询总记录数
	sqlStr = "select count(*) from dGrpSrvMsgAdd a, sProductAttrCode b "
	  + " where  a.SERVICE_ATTR = b.PRODUCT_ATTR  and  id_no =" + idNo;
	if(sm_code.equals("AD")||sm_code.equals("ML")||sm_code.equals("MA")||sm_code.equals("FK")){
%>
		<wtc:service name="s2885EXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="6">			
		<wtc:param value="<%=idNo%>"/>	
		<wtc:param value="<%=sm_code%>"/>	
		</wtc:service>	
		<wtc:array id="retList1" scope="end"/>
<%
	try{
	   result1 = retList1;
	}		
	    catch(Exception e)
	{
		System.out.println("\n==================\nerror3");
	}
			
	if(result1==null || result1.length == 0){
	    iFlag = "N";
%>
		<script language="javascript">
		 	rdShowMessageDialog("没有查到相关记录！");
		 	//parent.location="f2893_1.jsp";		
		 	history.go(-1);
		</script>
<%						 			
     }
    }else if("va".equals(sm_code)){
    %>
		<wtc:service name="s2885EXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3" retmsg="retMsg3" outnum="6">			
		<wtc:param value="<%=idNo%>"/>	
		<wtc:param value="<%=sm_code%>"/>	
		</wtc:service>
		<wtc:array id="retList2" start="0" length="4" scope="end"/>
		<wtc:array id="retList3" start="4" length="2" scope="end"/>
    <%
        try{
            if("000000".equals(retCode3)){
        	   result2 = retList2;
        	   result3 = retList3;
    	    }
    	}		
    	    catch(Exception e)
    	{
    		System.out.println("\n==================\nerror4");
    	}
    	
        if(result2==null || result2.length == 0){
            iFlag = "N";
%>
		<script language="javascript">
		 	rdShowMessageDialog("没有查到相关记录！");
		 	//parent.location="f2893_1.jsp";		
		 	history.go(-1);
		</script>
<%						 			
        }
    }else if("DL".equals(sm_code)){
    %>
		<wtc:service name="s2885EXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode4" retmsg="retMsg4" outnum="1">			
		<wtc:param value="<%=idNo%>"/>	
		<wtc:param value="<%=sm_code%>"/>	
		</wtc:service>
		<wtc:array id="retList4" scope="end"/>
    <%
        try{
            if("000000".equals(retCode4)){
              if(retList4.length>0){
                result4 = retList4;
                discountMsgVal = result4[0][0];
              }
    	    }
    	  }catch(Exception e){
    		System.out.println("\n==================\nerror4");
    	  }
        if(result4==null || result4.length == 0){
            iFlag = "N";
%>
        		<script language="javascript">
        		 	rdShowMessageDialog("没有查到相关记录！");
        		 	//parent.location="f2893_1.jsp";		
        		 	history.go(-1);
        		</script>
<%						 			
        }
    }else if("TR".equals(sm_code)){
    %>
    <wtc:service name="s2885EXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode5" retmsg="retMsg5" outnum="6">			
		<wtc:param value="<%=idNo%>"/>	
		<wtc:param value="<%=sm_code%>"/>	
		</wtc:service>
		<wtc:array id="retList5" scope="end"/>
		<%if("000000".equals(retCode5) && retList5.length > 0){
			result5 = retList5;
		}%>
    <%	
    	
    }else{
        iFlag = "N";
    }
	%>
		
<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">

</head>

<script type=text/javascript>
    onload=function(){
        <%if("N".equals(iFlag)){%>
            rdShowMessageDialog("没有查到相关记录！");
            //parent.location="f2893_1.jsp";		
            history.go(-1);
        <%}%>
        
        $("select").find("option:not(:selected)").remove();
        $("input[type='text']").addClass('InputGrey');
        $("input[type='text']").attr("readOnly",true);
    }
</script>

<body>

<form name="form1" method="post" action="">	
	<div id="Operation_Table">	
	    <%if(sm_code.equals("AD")||sm_code.equals("ML")||sm_code.equals("MA")||sm_code.equals("FK")){%>
		<table id="tabList" cellspacing="0">			
			<tr>				
				<th nowrap><div ><b>产品ID</b></div></th>
				<th nowrap><div ><b>产品代码</b></div></th>
				<th nowrap><div ><b>属性代码</b></div></th>
				<th nowrap><div ><b>属性名称</b></div></th>
				<th nowrap><div ><b>属性值</b></div></th>
			</tr>
	<%	
try{	

   System.out.println("result1.length=="+result1.length);
		for(int i = 0; i < result1.length; i++)
		{	          
		
	%>			
			<tr>				
				<td nowrap><%=result1[i][0].trim()%>&nbsp;</td>
				<td nowrap><%=result1[i][1].trim()%>&nbsp;</td>
				<td nowrap><%=result1[i][2].trim()%>&nbsp;</td>
				<td nowrap><%=result1[i][3].trim()%>&nbsp;</td>
	             <% if (result1[i][2].trim().equals("00003")){		  %> 
	                 <td nowrap align=>
	                 	<select name="attrValue"  <% if(sm_code.equals("AD")||sm_code.equals("ML")||sm_code.equals("MA")){} else if((!result1[i][2].equals("51")&&!result1[i][2].equals("58")) || iCount.equals("0")){out.print("disable");}%> >  	                 		 
	                 		<option value="0" <%if("0".equals(result1[i][4].trim())){%>selected<%}%>>不支持</option>  
	                 		<option value="1" <%if("1".equals(result1[i][4].trim())){%>selected<%}%>>支持</option>
	                 	</select>
	                 	</td>         
	              
	             <%}%>
	             
	              <% if (result1[i][2].trim().equals("00008")){		  %> 
	                 <td nowrap >
	                 	<select name="attrValue"  <% if(sm_code.equals("AD")||sm_code.equals("ML")||sm_code.equals("MA")){} else if((!result1[i][2].equals("51")&&!result1[i][2].equals("58")) || iCount.equals("0")){out.print("disable");}%> >  
	                 		<option value="0" <%if("0".equals(result1[i][4].trim())){%>selected<%}%>>英文</option>  
	                 		<option value="1" <%if("1".equals(result1[i][4].trim())){%>selected<%}%>>中文</option>
	                 	</select>
	                 	</td>         
	              
	             <%}%>
	             
				<%if (!result1[i][2].trim().equals("00008")&&!result1[i][2].trim().equals("00003")) {  %>
					<td nowrap ><input name="attrValue" type="text" class="button" value="<%=result1[i][4].trim()%>"  <% if(sm_code.equals("AD")||sm_code.equals("ML")||sm_code.equals("MA")){} else if((!result1[i][2].equals("51")&&!result1[i][2].equals("58")) || iCount.equals("0")){out.print("readonly");}%> maxlength=20> &nbsp;</td>
				
				<%}%>
			</tr>
	<%
		}
    }catch(Exception e){
	   e.printStackTrace();
	}
	%>
</table>
<%}else if("va".equals(sm_code)){%>
    <table id="tabList" cellspacing="0">			
		<tr>				
			<td class='blue' nowrap width='18%'>集团名称</td>
			<td width='32%'><input type='text' id='unit_name' name='unit_name' value='<%=result2[0][0]%>' size='28'/></td>
			<td class='blue' nowrap width='18%'>计费编号</td>
			<td><input type='text' id='aa' name='aa' value='<%=result2[0][1]%>' /></td>
		</tr>
		<tr>				
			<td class='blue' nowrap>主资费代码</td>
			<td><input type='text' id='mainProductCode' name='mainProductCode' value='<%=result2[0][2]%>' /></td>
			<td class='blue' nowrap>主资费名称</td>
			<td><input type='text' id='mainProductName' name='mainProductName' value='<%=result2[0][3]%>' /></td>
		</tr>
	</table>
	<%if(result3.length>0){%>
	</div>
    <div id="Operation_Table">
    <div class="title">
    	<div id="title_zi">附加资费列表</div>
    </div>
    <table cellspacing=0>
        <tr>
            <th nowrap>附加资费代码</th>
            <th nowrap>附加资费名称</th>
        </tr>
    <%for(int i = 0; i < result3.length; i++){%>			
		<tr>
			<td nowrap><%=result3[i][0].trim()%></td>
			<td nowrap><%=result3[i][1].trim()%></td>
	    </tr>
	<%}%>
    </table>
    <%}%>
<%}else if("DL".equals(sm_code)){%>
    <table id="tabList" cellspacing="0">			
		<tr>				
			<td class='blue' nowrap width='18%'>打折信息</td>
			<td width='32%'><input type='text' id='discountMsg' name='discountMsg' value='<%=discountMsgVal%>' size='28'/></td>
		</tr>
	</table>
<%}else if("TR".equals(sm_code)){%>
    <table id="tabList" cellspacing="0">			
		<tr>				
			<th nowrap>绑定手机号码</th>
      <th nowrap>车牌号</th>
      <th nowrap>车架号</th>
      <th nowrap>发动机号</th>
      <th nowrap>号牌类型</th>
		</tr>
		<%
		if(result5.length > 0){
		for(int i=0;i<result5.length;i++){
		%>
			<tr>
				<td><%=result5[i][0]%></td>
				<td><%=result5[i][1]%></td>
				<td><%=result5[i][2]%></td>
				<td><%=result5[i][3]%></td>
				<td><%=result5[i][4]%></td>
			</tr>	
		<%	
	}}%>
	</table>
<%}%>
<%if("Y".equals(iFlag)){%>
<table cellspacing=0>
    <tr id='footer'>
        <td colspan='5'>
            <input type='button' class='b_foot' id='bBack' name='bBack' value='返回' onClick='history.go(-1)'/>
        </td>
    </tr>
</table>	
<%}%>	
</div>   
</form>
</body>
</html>
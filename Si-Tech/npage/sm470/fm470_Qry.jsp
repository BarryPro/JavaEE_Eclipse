<%
/********************
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------duming 2017.4.13------------------
 关于新固话产品账期调整情况及现存问题报备的函  融合通信暂停与恢复业务
 
 
 -------------------------后台人员：gudd--------------------------------------------
 
********************/
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String opName         = WtcUtil.repNull(request.getParameter("opName"));
	String unitid         = WtcUtil.repNull(request.getParameter("unitid"));		                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	//标准化入参
	String paraAray[] = new String[8];
	
	paraAray[0] = "";                                       //流水
	paraAray[1] = "";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = "";                                	 	 //手机号码
	paraAray[6] = "";                                       //号码密码
	paraAray[7] = unitid;                                       //集团编码
	

	String serverName = "sm470Qry";

%>
		<wtc:service name="<%=serverName%>" outnum="9" retcode="sRetCode" retmsg="sRetMsg" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----duming-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="result_t1" scope="end"   />
<%

	if(result_t1.length>0){
		retCode = result_t1[0][7];
		retMsg  = result_t1[0][8];
	}

%> 	
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE></TITLE>
<SCRIPT language=JavaScript>

function chose(){
	
	
	
		var recode = $("input[name='radio_b']:checked").attr('v_code');
		var remsg = $("input[name='radio_b']:checked").attr('v_msg');
		//alert(recode);
		//alert(remsg);
		
	
		var obj = $("input[name='radio_b']:checked").parent().parent();
		var iccid= obj.find("th:eq(0)").text().trim();//证件号码
		var unit_name = obj.find("th:eq(1)").text().trim();//集团名称
		var unit_id = obj.find("th:eq(2)").text().trim();//集团编码
		var id_no = obj.find("th:eq(3)").text().trim();//产品编码
		var user_name = obj.find("th:eq(4)").text().trim();//产品名称
		var account_id = obj.find("th:eq(5)").text().trim();//产品账号
		var run_code = obj.find("th:eq(6)").text().trim();//业务状态
				
				var myarray=new Array();
				myarray[0]=iccid;
				myarray[1]=unit_name;
				myarray[2]=unit_id;
				myarray[3]=id_no;
				myarray[4]=user_name;
				myarray[5]=account_id;
				myarray[6]=run_code;
		
		
		//alert(myarray);
		window.opener.tableshow();
		window.opener.doreturn(myarray);
		//alert(myarray.length);
		//alert(myarray[0]);
		//if(){
			
		//	}
		
		window.close();
	
		
		
	}


</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>
<div class="title"><div id="title_zi">信息列表</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th width="15%">证件号码</th>
        <th width="25%">集团客户名称</th>
        <th width="15%">集团ecid</th>
        <th width="15%">产品代码</th>	
        <th width="15%">产品名称</th>	
        <th width="15%" >账户id</th>
        <th width="5%" >业务状态</th>		
    </tr>
    
   <%
   if(result_t1.length>0){
   	for(int i=0;i<result_t1.length;i++){
 	 %>  	
   	  <tr>
        <th width="15%"><input type="radio" name="radio_b" id="radio" v_code=<%=result_t1[0][7]%> v_msg=v_code=<%=result_t1[0][8]%> /><%=result_t1[i][0]%></th>
        <th width="25%"><%=result_t1[i][1]%></th>
        <th width="15%"><%=result_t1[i][2]%></th>
        <th width="15%"><%=result_t1[i][3]%></th>	
        <th width="15%"><%=result_t1[i][4]%></th>	
        <th width="15%"><%=result_t1[i][5]%></th>
        <th width="5%" ><%=result_t1[i][6]%></th>		
   	 </tr>
   <%	
   	}
		}
   %>
</table>


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="确定" onclick="chose()"          />
			<input type="button" class="b_foot" value="关闭" onclick="window.close();"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
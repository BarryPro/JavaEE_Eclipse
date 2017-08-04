 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
 
<%
    String opName     = "亲情长话";
    String opCode     = WtcUtil.repNull(request.getParameter("opCode"));
    String custName   = WtcUtil.repNull(request.getParameter("custName"));
    String phoneNo    = WtcUtil.repNull(request.getParameter("phoneNo"));
    String workNo     = (String)session.getAttribute("workNo");
    String password   = (String)session.getAttribute("password");
 	String regionCode = (String)session.getAttribute("regCode");
 	
	String vKinNum   = "";         //亲情号码个数                  
	String vKinPhone = "";         //亲情号码                      
	String op_login  = "";         //操作工号                      
	String op_total  = "";         //操作日期                      
	String vMaxKinNum= "";         //最大亲情号码数量              
	String vHandFee  = "";		   //手续费      
	String vKinPhoneD= "";         //大众亲情号码
	String op_totalD = "";         //大众亲情号码日期    
	String oprType = "";                 
	 
%>                                                                 
		<wtc:service name="sGetUserMsg" outnum="4"   retmsg="msg2" retcode="code2" >
		    <wtc:param value="<%=workNo%>"/>
		    <wtc:param value="<%=password%>"/>	
		    <wtc:param value="1005"/>	
		    <wtc:param value=""/>					
		    <wtc:param value="<%=phoneNo%>"/>		
		</wtc:service>
		<wtc:array id="result3" scope="end" />
		<wtc:service name="sPCSelService" outnum="4"   retmsg="msg1" retcode="code1" >
			<wtc:param value="0"/>
			<wtc:param value="01"/>
		    <wtc:param value=""/>
		    <wtc:param value="<%=workNo%>"/>
		    <wtc:param value="<%=password%>"/>	
		    <wtc:param value="<%=phoneNo%>"/>		
		    <wtc:param value=""/>			
		    <wtc:param value="5015"/>				
		</wtc:service>
		<wtc:array id="result2" scope="end" />
         <wtc:service name="s1239Qry" outnum="10" retmsg="msg" retcode="code" >
         	<wtc:param value="0" />
			<wtc:param value="01" />
			<wtc:param value="5556" />	
			<wtc:param value="<%=workNo%>" />	
			<wtc:param value="<%=password%>" />	
			<wtc:param value="<%=phoneNo%>" />	
			<wtc:param value="" />	
			<wtc:param value="fj@@Gccc" />					
		</wtc:service>
		<wtc:array id="result_t1"  scope="end" start="0"  length="3"  />
		<wtc:array id="result_t2"  scope="end" start="3"  length="3"  />	
		<wtc:array id="result_t3"  scope="end" start="6"  length="4"  />	
			
		<wtc:service name="s1272WebQry" outnum="10" retmsg="msg4" retcode="code4" >
         	<wtc:param value="0" />
			<wtc:param value="01" />
			<wtc:param value="5556" />	
			<wtc:param value="<%=workNo%>" />	
			<wtc:param value="<%=password%>" />	
			<wtc:param value="<%=phoneNo%>" />	
			<wtc:param value="" />	
			<wtc:param value="fj@@Gccc" />					
		</wtc:service>
		<wtc:array id="result_t4" scope="end" />

<%
	    for(int iii=0;iii<result_t4.length;iii++){
				for(int jjj=0;jjj<result_t4[iii].length;jjj++){
					System.out.println("---------------------result_t4["+iii+"]["+jjj+"]=-----------------"+result_t4[iii][jjj]);
				}
		}
		
		System.out.println("--------code-----s1239Qry-------------"+code);
		System.out.println("--------msg------s1239Qry-------------"+msg);
		System.out.println("--------code1----sPCSelService--------"+code1);
		System.out.println("--------msg1-----sPCSelService--------"+msg1);
		System.out.println("--------code2----sGetUserMsg----------"+code2);
		System.out.println("--------msg2-----sGetUserMsg----------"+msg2);
		System.out.println("--------code4----s1272WebQry----------"+code4);
		System.out.println("--------msg4-----s1272WebQry----------"+msg4);
		if(code4.equals("000000")){
			msg4 = "没有开通亲情长话业务，请先开通亲情长话业务，设置亲情长话号码，再查询亲情长话号码";
		}
		if(result_t1.length>0){
			code = result_t1[0][0];
			msg  = result_t1[0][1];
			if(result_t1[0][2]!=null){
				vKinNum   = result_t1[0][2];  
			}
		}
		if(code1.equals("000000")){
			oprType = result2[0][1];
		}
		if(code2.equals("000000")&&result3.length>0){
			vKinPhoneD = result3[0][0];
			op_totalD  = result3[0][1];
		}
		
		if(vKinNum==null)   vKinNum   = "";
		if(vKinPhone==null) vKinPhone = "";
		if(op_login==null)  op_login  = "";
		if(op_total==null)  op_total  = "";
		if(vHandFee==null)  vHandFee  = "";
%>
<html>
<head>
<title>亲情长话</title>
</head>


<body>
<form name="form1">
<%@ include file="/npage/include/header_pop.jsp" %>
<div class="title"><div id="title_zi">亲情长话用户受理状态</div></div>
   <table  cellspacing="0">
   	  <tr>
   	   	<td class="blue" width="15%">受理状态</td>
   	   	<td><input type="text" name="oprType"  id="oprType" readOnly value="<%=oprType%>"></td>
   	  </tr> 
   	</table>
  <div class="title"><div id="title_zi">亲情长话用户号码（不提供）</div></div> 	
  <table  cellspacing="0">
  	<tr>
  		<th>亲情号码</th>
  		<th>亲情号码个数</th>
  		<th>操作工号</th>
  		<th>操作日期</th>
  	</tr>
  	
  	<tr <%if(code.equals("000000")) out.print("style=\"display:none\"");%>>
  		<td colspan="4" align="center">
  			错误信息：<%=msg4%>
  		</td>
  	</tr>
  	
  	<%
  	String tempStr = "";
  	for(int ih=0;ih<result_t2.length;ih++){
  		if(result_t2[ih][0]!=null){
			tempStr = result_t2[ih][0];
		}
		if((!"".equals(tempStr))&&(!"null".equals(tempStr))){
  	%>
  	<tr>
  		<td><%= result_t2[ih][0]%></td>
  		<td><%= vKinNum%></td>
  		<td><%= result_t2[ih][1]%></td>
  		<td><%= result_t2[ih][2]%></td>
  	</tr>
  	<%}}%>
</table>
  <div class="title"><div id="title_zi">大众卡亲情号码查询（不提供）</div></div>
   <table  cellspacing="0">
  	<tr>
  		<th>亲情号码</th>
  		<th>办理日期</th>
  	</tr>
  	<tr <%if(!code2.equals("000000")) out.print("style=\"display:none\"");%>>
  		<td><%=vKinPhoneD%></td>
  		<td><%=op_totalD%></td>
  	</tr>
  	<tr <%if(code2.equals("000000")) out.print("style=\"display:none\"");%>>
  		<td colspan="2" align="center">
  			对不起，没有查找到符合的记录:<%=msg2%>
  		</td>
  	</tr>
</table>
   	 <table  cellspacing="0">  
   	   <tr>
   	   	<td id="footer">
   	   		<input  type="button" class="b_text" value="关闭" onclick="window.close()">
   	   	</td>
   	  </tr>
   </table>
<%@ include file="/npage/include/footer_pop.jsp" %>   
 </form>
</body>
</html>

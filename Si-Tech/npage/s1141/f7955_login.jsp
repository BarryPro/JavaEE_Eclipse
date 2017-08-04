<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");
  
  try{
DataOutputStream out2 = 
new DataOutputStream(
new BufferedOutputStream(
new FileOutputStream("data.txt")));

out2.writeChars("\naaa\n");

out2.close();

}
catch(EOFException e){
System.out.println("End of stream");
}

%>
<html>
<head>
<title>购机赠话费（按月返还）</title>
<%
  		String opCode = "7955";
		String opName = "购机赠话费（按月返还）";
    String workNoFromSession=(String)session.getAttribute("workNo");
	String userPhoneNo=(String)session.getAttribute("userPhoneNo");
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;
	  
    String work_no = (String)session.getAttribute("workNo");
    String loginName =  (String)session.getAttribute("workName");
    String org_Code =  (String)session.getAttribute("orgCode");
String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String[][] temfavStr=(String[][])session.getAttribute("favInfo");
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
     favStr[i]=temfavStr[i][0].trim();
    boolean pwrf=false;
    
	  pwrf=true;
%>
<%
  String sql = " select  unique sale_type,sale_type||'-->'||trim(sal_name) from sSaleType ";
  System.out.println("sql====="+sql);
  String[][] agentCodeStr = new String[][]{};
%>
  <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode1" retmsg="RetMsg1" outnum="2">
	<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="ret1" scope="end" />
	<%
			if(RetCode1.equals("000000"))
		{
		  agentCodeStr=ret1;
		  
		}
	%>
	
	
	
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
		/* 营销案加工号权限判断 @ ningtn 20100426 start */
	  String qxglOpCode = "7955";  //获取打开标签的opcode
	  String qxglGroupId = (String)session.getAttribute("groupId");	//获取登陆工号的groupid
	  String qxgl_getCountByGroupId = "SELECT count(*) FROM dChnGroupMsg a,dbChnAdn.sChnClassMsg b WHERE a.group_id='" + qxglGroupId + "' AND a.is_active='Y' AND a.class_code=b.class_code AND b.class_kind='2'";
	  String qxgl_getIsGroup = "SELECT is_group FROM dbchnterm.schnressaleplantype WHERE sale_op_code = '" + qxglOpCode + "' OR out_op_code = '" + qxglOpCode + "'";
	
  	String[][] qxgl_getCount = new String[][]{};
  
		%>
		  <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode2" retmsg="RetMsg2" outnum="1">
	<wtc:sql><%=qxgl_getCountByGroupId%></wtc:sql>
</wtc:pubselect>
<wtc:array id="ret2" scope="end" />
	<%
	    String qxgl_Count = "";
			if(RetCode2.equals("000000"))
		{
		  qxgl_getCount=ret2;
		  
		}
			
  	 if(qxgl_getCount.length > 0){
			qxgl_Count = qxgl_getCount[0][0];
		}
	%>
	
  	<%
  	String[][] qxgl_getCount2 = new String[][]{};
  	String qxgl_IsGroup = "";
  
		
	%>	
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode3" retmsg="RetMsg3" outnum="1">
	<wtc:sql><%=qxgl_getIsGroup%></wtc:sql>
  </wtc:pubselect>
<wtc:array id="ret3" scope="end" />
	<%
	     qxgl_IsGroup = "";
			if(RetCode3.equals("000000"))
		{
		  qxgl_getCount2=ret3;
		  
		}
			
  		if(qxgl_getCount2.length > 0){
			qxgl_IsGroup = qxgl_getCount2[0][0];
		}
	%>
	
		<%
		
  	//开始对工号打开tab权限进行判断
		if(("0".equals(qxgl_Count) && "0".equals(qxgl_IsGroup)) || ("1".equals(qxgl_Count) && "1".equals(qxgl_IsGroup))){
			System.out.println(qxglOpCode + "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%不可以打开");
%>
				<script language="JavaScript">              
					rdShowMessageDialog("此工号不允许使用此功能！");
					window.close();
				</script>                                   
<%
		}else{
			//可以打开opcode对应的tab，不做限制
			System.out.println(qxglOpCode + "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%可以打开");
		}
		/* 营销案加工号权限判断 @ ningtn 20100426 end */
%>	
<script language=javascript>
  onload=function()
  {
    opchange();
  }

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
 

 var radio1 = document.getElementsByName("opFlag");
 
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	  	
	    	frm.action="f7955_1.jsp";
	    	document.all.opcode.value="7955";

	    	
	    	
	  }else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	alert("请输入业务流水！");
	    	return;
	    }
	   
	    	frm.action="f7956_1.jsp";
	    	document.all.opcode.value="7956";
	    	
	  }
	}
  }
  frm.submit();	
  return true;
}
function opchange(){
	document.all.backaccept_id.style.display = "";
	  	document.all.bltys.style.display = "none";

}

</script>
</head>
<body >
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
 <input type="hidden" name="opcode" >
 	<%@ include file="/npage/include/header.jsp" %>  
     <div class="title">
		<div id="title_zi">购机赠话费（按月返还）</div>
	 </div>



      <table cellspacing="0" >
       
	  <TR > 
	          <TD width="16%" class="blue">操作类型：</TD>
              <TD >
		
		<input type="radio" name="opFlag" value="two" onclick="opchange()" checked>冲正
	          </TD>
	        
         </TR>    
         <tr> 
            <td width="16%"  > 
              <div align="left" class="blue">手机号码：</div>
            </td>
            <td > 
            <div align="left"> 
                <input   type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1  
                v_name="服务号码" maxlength="11" index="0" readOnly  Class="InputGrey" value ="<%=activePhone%>">
                <font class='orange'>*</font></div>
            </td>
         
       
         </tr>
         <TR style="display:none" id="backaccept_id"> 
	          <TD width="16%" class="blue">业务流水：</TD>
              <TD >
			<input  type="text" name="backaccept" v_must=1 >
			<font class='orange'>*</font>
	          </TD>
	         
         </TR>    
           
           	  <TR id="bltys" style="display:block" > 
	          <TD width="16%" class="blue">业务办理类型</TD>
              <TD >
							<select id="banlitype" name="banlitype" >
						<option value="0">前台办理</option>
						<option value="1">网站预约</option>
							</select>
	          </TD>
	        
         </TR> 
        
         <tr > 
            <td colspan="5" > 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
              <input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="window.close();">
              </div>
           </td>
        </tr>
      </table>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>

 <%@ include file="/npage/include/footer.jsp" %>
   </form>
  
</body>
</html>

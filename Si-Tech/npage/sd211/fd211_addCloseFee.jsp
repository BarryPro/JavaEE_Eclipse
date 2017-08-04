<%
  /*
   * 功能: 智能网vpmn闭合群资费管理 d211
   * 版本: 1.8.2
   * 日期: 2011/2/24
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>

              
<%
  String opCode = "d211";
  String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.RoleManage.wrapper.*"%>



<%

	String powerCode2=(String)session.getAttribute("powerCode");
	ArrayList arr = RoleManageWrapper.getPowerCode1(powerCode2);
	ArrayList powerRightArr = RoleManageWrapper.getPowerRight();
		String[][] powerRight = (String[][])powerRightArr.get(0);


	 String region_name = "";
	 String regionName="";
	 String regionNameSql = "";
	String region_code = request.getParameter("add_region_code");
	String provinceFlg = request.getParameter("provinceFlg");
	  if(region_code!=null && region_code.length()<2){
	   region_code = "0"+region_code;
    }
    
 /*   
	if("100".equals(region_code)){
		region_name = "全省地市";
	}else{
    regionNameSql ="  select region_name from sregioncode where region_code = "+region_code+"";
  }
 
 */
 
 	if("1".equals(provinceFlg)){
		regionName="select region_code,region_name from sregioncode where region_code in('01','02','03','04','05','06','07','08','09','10','11','12','13') order by to_number(region_code)";
	}else{
		regionName="select region_code,region_name from sregioncode where region_code='"+region_code+"'";
	}
  

	 %>
	 
	    	

	
	
<html>
<head>
<base target="_self">
<title>添加智能网vpmn闭合群资费</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">   
	
	function iframeClose(){
		var div_body = document.getElementById("divBody");
			div_body.style.display="none";
	}
	function add_submit(){
	
		
		var closeFee_code = document.form1.closeFee_code.value;
		var closeFee_name = document.form1.closeFee_name.value;
		var stop_time = document.form1.stop_time.value;
		var region_code = document.form1.region_code.value;
		if(region_code=='$$$$$$'){
			rdShowMessageDialog("请选择所要添加的地市!");
			return false;
		}
		if(closeFee_code==''){
			rdShowMessageDialog("资费编号不能为空,请重新输入!");
			return false;
		}
		if(closeFee_name==''){
			rdShowMessageDialog("资费名称不能空,请重新输入!");
			return false;
		}
					if(stop_time==''){
				rdShowMessageDialog("请输入该资费结束时间!")
			  return false;
			}else{
				if(isNaN(stop_time)){
					rdShowMessageDialog("资费结束时间不是数字,请您重新输入");
					return false;
				}else{
					if(stop_time.length!=8){
						rdShowMessageDialog("资费结束时间的格式为:YYYYMMDD,请您重新输入!");
					  return false;
					}
				}
			}
		parent.add_submit11();
	}
</script>
</head>

<body>
	<div id="divBody">

  <form name="form1"  method="post" action="fd211_addCloseFee_submit.jsp">
     
	 
   <DIV id="Operation_Table">                     


	<div class="title">
		<div id="title_zi">添加智能网VPMN的资费</div>
	</div>


				<table cellspacing="0" >
					<tr  height="22">				
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;地市</TD>
	  					<TD width="34%" >
	  							<select name="region_code" v_name="地市">
	  							<option value="$$$$$$">请选择</option>
	  							<%
	  							if("1".equals(provinceFlg)){
	  							%>
	  							<option value="00">黑龙江</option>
	  							<%
	  							}
	  							%>
	  							
	  						
	  						<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=regionName%></wtc:sql>
 	              </wtc:pubselect>
	             <wtc:array id="result_t" scope="end"/>
	             <%
 							
 								String[][] retListString = new String[][]{};
 								if(code.equals("000000")&&result_t.length>0)
 								retListString = result_t;
								for(int i=0;i < retListString.length;i ++)
								{
							%>
    		          				<option value='<%=retListString[i][0]%>'><%=retListString[i][1]%></option>
							<%		
								}
							%>
	  					</select>&nbsp;<font class="orange">*<font>
	  		
	  						
	  						</TD>
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;资费编号</TD>
	  					<TD width="34%" >
	  						<input type="text" name="closeFee_code"/>&nbsp;<font class="orange">*<font>
	  						&nbsp;</TD>
	  		 </tr>		
	  		 
	  		 <tr  height="22">				
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;资费名称</TD>
	  					<TD width="34%" >
	  							<input type="text" name="closeFee_name"/>&nbsp;<font class="orange">*<font>
	  						&nbsp;</TD>
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;资费停止时间</TD>
	  					<TD width="34%" >
	  						<input type="text" name="stop_time"/>&nbsp;<font class="orange">*(格式为YYYYMMDD)<font>
	  						&nbsp;</TD>
	  		 </tr>
	  		  <tr  height="22">				
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;权限</TD>
	  					<TD width="34%" colspan="3">
	  							<select  name="power_right">
									<%
									for(int i = 0 ; i<powerRight.length; i ++)
									{ %>
										<option value="<%=powerRight[i][0]%>" > <%=powerRight[i][0]+"->"+powerRight[i][1]%> </option>
									<%
									}
									%>
								</select>
	  						&nbsp;</TD>
	  						
	  					
	  		 </tr>
	  		
				  
			
				</table>
				
				<TABLE cellSpacing="0">
    <TBODY>
        <TR>
        	  <TD id="footer">
                <input class='b_foot' name=back onClick="add_submit()" style="cursor:hand" type=button value=提交>
           
          
                <input class='b_foot' name=back style="cursor:hand" type=reset value=重置>
            
          
                <input class='b_foot' name=back onClick="iframeClose()" style="cursor:hand" type=button value=关闭>
            </TD>
        </TR>
    </TBODY>
</TABLE>	

	 <%@ include file="/npage/include/footer.jsp" %>
	  </form>
 </div>
</body>
</html>



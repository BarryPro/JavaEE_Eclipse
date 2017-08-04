 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-10 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
	<head>
	<title>自有业务宣传名单管理</title>
<%
  	String opCode = "7378";		
	String opName = "自有业务宣传名单管理";	//header.jsp需要的参数   
%>

	<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
	<script language=javascript>
	  onload = function(){
	      document.all.srv_no.focus();
	  }
		
		function setupAction(){
        if(document.all.opFlag[0].checked==true){
            frm.action="f7378_2.jsp";
        }
        if(document.all.opFlag[1].checked==true){
            frm.action="f7378_4.jsp";
        }
        if(document.all.opFlag[2].checked==true){	 	
            frm.action="f7378_5.jsp";
        }
        if(document.all.opFlag[3].checked==true){	 	
            frm.action="f7378_batchOperation.jsp";
        }
        if(document.all.opFlag[4].checked==true){	 	
            frm.action="f7378_export.jsp";
        }
	  }

		function docomm(){
        if(!check(frm)) return false; 
 
        setupAction();
  		  frm.submit();	
		}
	</script>
</head>
<body>	
	<form name="frm" method="POST" onKeyUp="chgFocus(frm)">		
		 <%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">自有业务宣传名单管理 </div>
		</div>
    
    <table  cellspacing="0" >          
   		<tr> 
    		<TD width="16%" class="blue">操作类型</TD>
      	  <TD width="34%" >		
  					<input type="radio" name="opFlag" value="two" checked>增加&nbsp;&nbsp;
  					<input type="radio" name="opFlag" value="three">删除&nbsp;&nbsp;
  					<input type="radio" name="opFlag" value="one">查询
  					<input type="radio" name="opFlag" value="one">批量添加和删除
  					<input type="radio" name="opFlag" value="one">批量导出
        	</TD>	          
      </tr>    
     	
     	<tr> 
  			<td width="16%"  nowrap class="blue"> 
    				手机号码
  			</td>
  			<td nowrap  width="34%" >             
      			<input  type="text" size="12" name="srv_no" id="srv_no"
      			   v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   
      			   maxlength="11" index="0" value =<%=activePhone%>  readonly class="InputGrey">
      			<font class="orange">*</font>
  			</td>     
     	</tr>       
    
     	<TR id="listtype_id">
    		<TD width="16%" class="blue">名单类型</TD>
      	  <TD width="34%">
  					<select name="listtype">
  						<option value="W">白名单</option>
  						<option value="B">黑名单</option>
  					</select>
			      <font class="orange">*</font>
          </TD>         
     	</TR>    
    </table>
    
    <table  cellspacing="0" >          
     	<tr> 
        <td id="footer">              
      		<input type=button name="confirm"class="b_foot"  value="确认" onClick="docomm()" index="2">    
      		<input type=button name=back value="清除" class="b_foot" onClick="frm.reset()">
          <input type=button name=qryP value="关闭" class="b_foot" onClick="removeCurrentTab();">             
        </td>
    	</tr>
    </table>
      
    <%@ include file="/npage/include/footer.jsp" %>   
  </form>
</body>
</html>
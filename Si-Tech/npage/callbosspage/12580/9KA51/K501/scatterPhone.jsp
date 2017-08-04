<%
  /*
   * 功能: 离散输入号码
　 * 版本: 1.0.0
　 * 日期: 2009/02/14
　 * 作者: libin
　 * 版权: sitech
   * update:
　 */
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
  <head>
  	<base target="_self">
		<script language="javascript">
			function onkeyuptext(str){
				if(str==1){
						var lenstr = document.getElementById("phone1").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone1").value = lenstr.substring(0,11);
					  }
			  }
			  if(str==2){
						var lenstr = document.getElementById("phone2").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone2").value = lenstr.substring(0,11);
					  }
			  }
			  if(str==3){
						var lenstr = document.getElementById("phone3").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone3").value = lenstr.substring(0,11);
					  }
			  }
			  if(str==4){
						var lenstr = document.getElementById("phone4").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone4").value = lenstr.substring(0,11);
					  }
			  }
			  if(str==5){
						var lenstr = document.getElementById("phone5").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone5").value = lenstr.substring(0,11);
					  }
			  }
			  if(str==6){
						var lenstr = document.getElementById("phone6").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone6").value = lenstr.substring(0,11);
					  }
			  }
			  if(str==7){
						var lenstr = document.getElementById("phone7").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone7").value = lenstr.substring(0,11);
					  }
			  }
			  if(str==8){
						var lenstr = document.getElementById("phone8").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone8").value = lenstr.substring(0,11);
					  }
			  }
			  if(str==9){
						var lenstr = document.getElementById("phone9").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone9").value = lenstr.substring(0,11);
					  }
			  }
			  if(str==10){
						var lenstr = document.getElementById("phone10").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone10").value = lenstr.substring(0,11);
					  }
			  }
			  if(str==11){
						var lenstr = document.getElementById("phone11").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone11").value = lenstr.substring(0,11);
					  }
			  }
			  if(str==12){
						var lenstr = document.getElementById("phone12").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone12").value = lenstr.substring(0,11);
					  }
			  }
			  if(str==13){
						var lenstr = document.getElementById("phone13").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone13").value = lenstr.substring(0,11);
					  }
			  }
			  if(str==14){
						var lenstr = document.getElementById("phone14").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone14").value = lenstr.substring(0,11);
					  }
			  }
			  if(str==15){
						var lenstr = document.getElementById("phone15").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone15").value = lenstr.substring(0,11);
					  }
			  }
			  if(str==16){
						var lenstr = document.getElementById("phone16").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone16").value = lenstr.substring(0,11);
					  }
			  }
			  if(str==17){
						var lenstr = document.getElementById("phone17").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone17").value = lenstr.substring(0,11);
					  }
			  }
			  if(str==18){
						var lenstr = document.getElementById("phone18").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone18").value = lenstr.substring(0,11);
					  }
			  }
			  if(str==19){
						var lenstr = document.getElementById("phone19").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone19").value = lenstr.substring(0,11);
					  }
			  }
			  if(str==20){
						var lenstr = document.getElementById("phone20").value;
						var len = lenstr.length;
						if(len>11){	
							 document.getElementById("phone20").value = lenstr.substring(0,11);
					  }
			  }
		  }
			function f_check_mobile(obj){      
			  //var regu =/(^13[0-9]{9}$)/;
                          var regu = /^[1]([3][4-9]{1}|59|58|50|57|51|52|88|47)[0-9]{8}$/;   
			  var re = new RegExp(regu);   
			  if (re.test( obj.value )) {   
			    return true;
			  }
			  return false;      
			}
			function writephone(){
				
				var vphone="";
				
				var tag = document.getElementsByTagName("input");
				
				var flag = true;
				
				for(var j = 0; j < tag.length; j++){
					
					if(tag[j].value != "" && tag[j].type == "text"){
						
						if(!f_check_mobile(tag[j])){
						
							flag = false;
							rdShowMessageDialog("电话号码格式不正确！",0);
							return;
							
						}
					}	
					
				}
				
				if(flag){
					for(var i = 0; i < tag.length; i++){
					
						if(tag[i].type == "text"){
							
							if(tag[i].value != ""){
								vphone += tag[i].value+" ";
							}						
						}								
					}
				}
				
				window.returnValue = vphone;
				window.close();
				
			}	
			function gohis(){
				document.sitenform.action="plCh.jsp";
				document.sitenform.submit();
			}
		</script>
  </head>
  
  <body>
  	<form name="sitenform" action="" method="post" target="">
  	<BR>
  	<div id="Operation_Table">
  	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	  <tr align="center">
	    <td>用户号码1</td>
	    <td>&nbsp;<input name="phone1" id='phone1' onkeyup="onkeyuptext(1);"/></td>
	    <td>用户号码2</td>
	    <td>&nbsp;<input name="phone2" id='phone2' onkeyup="onkeyuptext(2);"/></td>
	  </tr>
	  <tr align="center">
	    <td>用户号码3</td>
	    <td>&nbsp;<input name="phone3" id='phone3' onkeyup="onkeyuptext(3);"/></td>
	    <td>用户号码4</td>
	    <td>&nbsp;<input name="phone4" id='phone4' onkeyup="onkeyuptext(4);"/></td>
	  </tr>
	  <tr align="center">
	    <td>用户号码5</td>
	    <td>&nbsp;<input name="phone5" id='phone5' onkeyup="onkeyuptext(5);"/></td>
	    <td>用户号码6</td>
	    <td>&nbsp;<input name="phone6" id='phone6' onkeyup="onkeyuptext(6);"/></td>
	  </tr>
	  <tr align="center">
	    <td>用户号码7</td>
	    <td>&nbsp;<input name="phone7"  id='phone7' onkeyup="onkeyuptext(7);"/></td>
	    <td>用户号码8</td>
	    <td>&nbsp;<input name="phone8" id='phone8' onkeyup="onkeyuptext(8);"/></td>
	  </tr>
	  <tr align="center">
	    <td>用户号码9</td>
	    <td>&nbsp;<input name="phone9" id='phone9' onkeyup="onkeyuptext(9);"/></td>
	    <td>用户号码10</td>
	    <td>&nbsp;<input name="phone10" id='phone10' onkeyup="onkeyuptext(10);"/></td>
	  </tr>
	  <tr align="center">
	    <td>用户号码11</td>
	    <td>&nbsp;<input name="phone11" id='phone11' onkeyup="onkeyuptext(11);"/></td>
	    <td>用户号码12</td>
	    <td>&nbsp;<input name="phone12" id='phone12' onkeyup="onkeyuptext(12);"/></td>
	  </tr>
	  <tr align="center">
	    <td>用户号码13</td>
	    <td>&nbsp;<input name="phone13" id='phone13' onkeyup="onkeyuptext(13);"/></td>
	    <td>用户号码14</td>
	    <td>&nbsp;<input name="phone14" id='phone14' onkeyup="onkeyuptext(14);"/></td>
	  </tr>
	  <tr align="center">
	    <td>用户号码15</td>
	    <td>&nbsp;<input name="phone15" id='phone15' onkeyup="onkeyuptext(15);"/></td>
	    <td>用户号码16</td>
	    <td>&nbsp;<input name="phone16" id='phone16' onkeyup="onkeyuptext(16);"/></td>
	  </tr>
	  <tr align="center">
	    <td>用户号码17</td>
	    <td>&nbsp;<input name="phone17" id='phone17' onkeyup="onkeyuptext(17);"/></td>
	    <td>用户号码18</td>
	    <td>&nbsp;<input name="phone18" id='phone18' onkeyup="onkeyuptext(18);"/></td>
	  </tr>
	  <tr align="center">
	    <td>用户号码19</td>
	    <td>&nbsp;<input name="phone19" id='phone19' onkeyup="onkeyuptext(19);"/></td>
	    <td>用户号码20</td>
	    <td>&nbsp;<input name="phone20" id='phone20' onkeyup="onkeyuptext(20);"/></td>
	  </tr>
	  <tr align="center">
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
	  </tr>
	  <tr align="center">
	    <td colspan="4"><input type="button" class="b_foot" value="上一步" onClick="gohis();">&nbsp;<input type="button" class="b_foot" value="确定" onClick="writephone();">&nbsp;<input type="button" class="b_foot" value="取消" onClick="window.close();"></td>	    
	  </tr>
	</table>
	</div>
	</form>
  </body>
</html>

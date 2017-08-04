 <%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-01-13 页面改造,修改样式
********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		String iFlags = request.getParameter("flags");	
		String opCode = "3210";	
		String opName = "用户功能权限集";	//header.jsp需要的参数 
%>
<html>
	<head>
		<title>用户功能权限集</title>
		<script language="JavaScript">
		<!--
			//定义应用全局的变量
			var SUCC_CODE	= "0";   		//自己应用程序定义
			var ERROR_CODE  = "1";			//自己应用程序定义
			var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改
		
			var flags = "<%=iFlags%>";
			
		            
			function fillSelectUseValue_noArr(fillObject,indValue)
			{	
					for(var i=0;i<document.all(fillObject).options.length;i++){
						if(document.all(fillObject).options[i].value == indValue){
							document.all(fillObject).options[i].selected = true;
							break;
						}
					}							
			}
			
			function init()
			{
		
				fillSelectUseValue_noArr("FLAGS1",flags.substring(0,1) );
				fillSelectUseValue_noArr("FLAGS2",flags.substring(1,2) );
				fillSelectUseValue_noArr("FLAGS3",flags.substring(2,3) );
				fillSelectUseValue_noArr("FLAGS4",flags.substring(3,4) );
				fillSelectUseValue_noArr("FLAGS5",flags.substring(4,5) );
				fillSelectUseValue_noArr("FLAGS6",flags.substring(5,6) );
				fillSelectUseValue_noArr("FLAGS7",flags.substring(6,7) );
				fillSelectUseValue_noArr("FLAGS8",flags.substring(7,8) );
				fillSelectUseValue_noArr("FLAGS9",flags.substring(8,9) );
				fillSelectUseValue_noArr("FLAGS10",flags.substring(9,10) );
				fillSelectUseValue_noArr("FLAGS11",flags.substring(10,11) );
				fillSelectUseValue_noArr("FLAGS12",flags.substring(11,12) );
				fillSelectUseValue_noArr("FLAGS13",flags.substring(12,13) );
				fillSelectUseValue_noArr("FLAGS14",flags.substring(13,14) );
				fillSelectUseValue_noArr("FLAGS15",flags.substring(14,15) );
				fillSelectUseValue_noArr("FLAGS16",flags.substring(15,16) );
				fillSelectUseValue_noArr("FLAGS17",flags.substring(16,17) );
				fillSelectUseValue_noArr("FLAGS18",flags.substring(17,18) );
				fillSelectUseValue_noArr("FLAGS19",flags.substring(18,19) );
				fillSelectUseValue_noArr("FLAGS20",flags.substring(19,20) );
				fillSelectUseValue_noArr("FLAGS21",flags.substring(20,21) );
				fillSelectUseValue_noArr("FLAGS22",flags.substring(21,22) );
				fillSelectUseValue_noArr("FLAGS23",flags.substring(22,23) );
				fillSelectUseValue_noArr("FLAGS24",flags.substring(23,24) );
				fillSelectUseValue_noArr("FLAGS25",flags.substring(24,25) );
				fillSelectUseValue_noArr("FLAGS26",flags.substring(25,26) );
				fillSelectUseValue_noArr("FLAGS27",flags.substring(26,27) );
				//fillSelectUseValue_noArr("FLAGS28",flags.substring(27,28) );
				//fillSelectUseValue_noArr("FLAGS29",flags.substring(28,29) );
				//fillSelectUseValue_noArr("FLAGS30",flags.substring(29,30) );
				fillSelectUseValue_noArr("FLAGS31",flags.substring(30,31) );
				//fillSelectUseValue_noArr("FLAGS32",flags.substring(31,32) );
				//fillSelectUseValue_noArr("FLAGS33",flags.substring(32,33) );
				//fillSelectUseValue_noArr("FLAGS34",flags.substring(33,34) );
				//fillSelectUseValue_noArr("FLAGS35",flags.substring(34,35) );
				//fillSelectUseValue_noArr("FLAGS36",flags.substring(35,36) );
			}
			
		
		
			function save_to(){			
				var str="";
				for(i=0;i<document.frm.elements.length;i++){
					if(document.frm.elements[i].tagName=="SELECT"){
						str = str + document.frm.elements[i].value;
					}
				}
			
				str = str + "00000000" ;   //共36位
				//alert(str);
				window.returnValue=str;
				window.close(); 
			}		
			function quit(){
				window.close(); 
			}					
						
		//-->
</script>
</head>


<body onLoad="init()">
<form name="frm" method="post" action="">     
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">用户功能权限集</div>
	</div>   
        <table  cellspacing="0" >
          <tr> 
            <td class="blue">网内去话</td>
            <td >
            	<select name="FLAGS1" id="FLAGS1">
                <option value="0">0--&gt;禁止</option>
                <option value="1">1--&gt;市话</option>
                <option value="2">2--&gt;市话+省内</option>
                <option value="3">3--&gt;市话+省内+省外</option>
                <option value="4">4--&gt;市话+省内+省外+国际</option>
              	</select> 
             </td>
            <td class="blue">网内来话</td>
            <td>
            	<select name="FLAGS2" id="FLAGS2">
                <option value="0">0--&gt;禁止</option>
                <option value="1">1--&gt;市话</option>
                <option value="2">2--&gt;市话+省内</option>
                <option value="3">3--&gt;市话+省内+省外</option>
                <option value="4">4--&gt;市话+省内+省外+国际</option>
              </select> 
            </td>
          </tr>
          <tr > 
            <td class="blue">网间去话</td>
            <td><select name="FLAGS3" id="select2">
                <option value="0">0--&gt;禁止</option>
                <option value="1">1--&gt;市话</option>
                <option value="2">2--&gt;市话+省内</option>
                <option value="3">3--&gt;市话+省内+省外</option>
                <option value="4">4--&gt;市话+省内+省外+国际</option>
              </select></td>
            <td class="blue">网间来话</td>
            <td><select name="FLAGS4" id="select3">
                <option value="0">0--&gt;禁止</option>
                <option value="1">1--&gt;市话</option>
                <option value="2">2--&gt;市话+省内</option>
                <option value="3">3--&gt;市话+省内+省外</option>
                <option value="4">4--&gt;市话+省内+省外+国际</option>
              </select></td>
          </tr>
          <tr> 
            <td class="blue">网外去话</td>
            <td ><select name="FLAGS5" id="select4">
                <option value="0">0--&gt;禁止</option>
                <option value="1">1--&gt;市话</option>
                <option value="2">2--&gt;市话+省内</option>
                <option value="3">3--&gt;市话+省内+省外</option>
                <option value="4">4--&gt;市话+省内+省外+国际</option>
              </select></td>
            <td class="blue">网外来话</td>
            <td><select name="FLAGS6" id="select5">
                <option value="0">0--&gt;禁止</option>
                <option value="1">1--&gt;市话</option>
                <option value="2">2--&gt;市话+省内</option>
                <option value="3">3--&gt;市话+省内+省外</option>
                <option value="4">4--&gt;市话+省内+省外+国际</option>
              </select></td>
          </tr>
          <tr > 
            <td class="blue">网外号码组去话</td>
            <td><select name="FLAGS7" id="select6">
                <option value="0">0--&gt;禁止</option>
                <option value="1">1--&gt;市话</option>
                <option value="2">2--&gt;市话+省内</option>
                <option value="3">3--&gt;市话+省内+省外</option>
                <option value="4">4--&gt;市话+省内+省外+国际</option>
              </select></td>
            <td class="blue">网外号码组来话</td>
            <td><select name="FLAGS8" id="select7">
                <option value="0">0--&gt;禁止</option>
                <option value="1">1--&gt;市话</option>
                <option value="2">2--&gt;市话+省内</option>
                <option value="3">3--&gt;市话+省内+省外</option>
                <option value="4">4--&gt;市话+省内+省外+国际</option>
              </select></td>
          </tr>
          <tr > 
            <td  class="blue">主叫漫游权限</td>
            <td ><select name="FLAGS9" id="FLAGS9">
                <option value="0">0--&gt;禁止</option>
                <option value="1">1--&gt;省内</option>
                <option value="2">2--&gt;省内+省外</option>
              </select></td>
            <td class="blue">被叫漫游权限</td>
            <td><select name="FLAGS10" id="FLAGS10">
                <option value="0">0--&gt;禁止</option>
                <option value="1">1--&gt;省内</option>
                <option value="2">2--&gt;省内+省外</option>
              </select></td>
          </tr>
          <tr > 
            <td class="blue">闭合用户群功能</td>
            <td><select name="FLAGS11" id="FLAGS11">
                <option value="0">0--&gt;不提供</option>
                <option value="1">1--&gt;提供优惠群</option>
                <option value="2">2--&gt;提供闭合优惠群</option>
              </select></td>
            <td class="blue">网外号码组使用类型</td>
            <td><select name="FLAGS12" id="FLAGS12">
                <option value="0">0--&gt;不使用</option>
                <option value="1">1--&gt;使用集团定义号码</option>
                <option value="2">2--&gt;使用个人定义号码</option>
              </select></td>
          </tr>
          <tr > 
            <td class="blue">个人短消息</td>
            <td ><select name="FLAGS13" id="FLAGS13">
                <option value="0">0--&gt;不允许</option>
                <option value="1">1--&gt;允许</option>
              </select></td>
            <td class="blue">群组短消息</td>
            <td><select name="FLAGS14" id="FLAGS14">
                <option value="0">0--&gt;不允许</option>
                <option value="1">1--&gt;允许</option>
              </select></td>
          </tr>
          <tr > 
            <td class="blue">资费套餐功能</td>
            <td><select name="FLAGS15" id="FLAGS15">
                <option value="0">0--&gt;不提供</option>
                <option value="1">1--&gt;提供</option>
              </select></td>
            <td class="blue">呼叫超出呼叫权限的处理</td>
            <td><select name="FLAGS16" id="FLAGS16">
                <option value="0">0--&gt;个人付费</option>
                <option value="1">1--&gt;终止呼叫</option>
              </select></td>
          </tr>
          <tr > 
            <td class="blue">呼叫超出呼叫限额的处理</td>
            <td ><select name="FLAGS17" id="FLAGS17">
                <option value="0">0--&gt;个人付费</option>
                <option value="1">1--&gt;终止呼叫</option>
              </select></td>
            <td class="blue">能否漫游出归属分区</td>
            <td><select name="FLAGS18" id="FLAGS18">
                <option value="0">0--&gt;不允许</option>
                <option value="1">1--&gt;允许</option>
              </select></td>
          </tr>
		  <tr > 
            <td class="blue">能否使用集团预埋IP功能</td>
            <td ><select name="FLAGS19" id="FLAGS19">
                <option value="0">0--&gt;不使用</option>
                <option value="1">1--&gt;使用(默认值1)</option>
              </select></td>
            <td class="blue">回铃音业务功能标识</td>
            <td><select name="FLAGS20" id="FLAGS20">
                <option value="0">0--&gt;关闭</option>
                <option value="1">1--&gt;开通</option>
              </select></td>
          </tr>
		  <tr > 
            <td class="blue">总机用户呼叫集团外用户时号码显示特性</td>
            <td ><select name="FLAGS21" id="FLAGS21">
                <option value="1">1--&gt;显示真实号码</option>
                <option value="2">2--&gt;显示集团总机号码</option>
                <option value="3">3--&gt;移动网用户显示总机+分机，其他网用户显示总机</option>
              </select></td>
            <td class="blue">是否支持连续异常发送短信通知功能</td>
            <td ><select name="FLAGS22" id="FLAGS22">
                <option value="0">0--&gt;不支持</option>
                <option value="1">1--&gt;支持</option>
              </select></td>
          </tr>
	  <tr > 
            <td class="blue">网内IP去话</td>
            <td ><select name="FLAGS23" id="FLAGS23">
                <option value="0">0--&gt;禁止</option>
                <option value="1">1--&gt;市话</option>
                <option value="2">2--&gt;市话+省内</option>
                <option value="3">3--&gt;市话+省内+省外</option>
                <option value="4">4--&gt;市话+省内+省外+国际</option>
              </select></td>
            <td class="blue">网间IP去话</td>
            <td><select name="FLAGS24" id="FLAGS24">
                <option value="0">0--&gt;禁止</option>
                <option value="1">1--&gt;市话</option>
                <option value="2">2--&gt;市话+省内</option>
                <option value="3">3--&gt;市话+省内+省外</option>
                <option value="4">4--&gt;市话+省内+省外+国际</option>
              </select></td>
          </tr>
		  <tr > 
            <td class="blue">网间IP去话</td>
            <td><select name="FLAGS25" id="FLAGS25">
                <option value="0">0--&gt;禁止</option>
                <option value="1">1--&gt;市话</option>
                <option value="2">2--&gt;市话+省内</option>
                <option value="3">3--&gt;市话+省内+省外</option>
                <option value="4">4--&gt;市话+省内+省外+国际</option>
              </select></td>
            <td class="blue">网外号码组IP去话</td>
            <td><select name="FLAGS26" id="FLAGS26">
                <option value="0">0--&gt;禁止</option>
                <option value="1">1--&gt;市话</option>
                <option value="2">2--&gt;市话+省内</option>
                <option value="3">3--&gt;市话+省内+省外</option>
                <option value="4">4--&gt;市话+省内+省外+国际</option>
              </select></td>
          </tr>
		  <tr > 
            <td class="blue">是否使用仅通过人|总机转接功能</td>
            <td ><select name="FLAGS27" id="FLAGS27">
                <option value="0">0--&gt;使用</option>
                <option value="1">1--&gt;不使用</option>
              </select></td>
            <td class="blue">是否支持集团总机用户拨打特殊字冠固定显示真实号码特性</td>
            <td><select name="FLAGS31" id="FLAGS31">
                <option value="0">0--&gt;不支持</option>
                <option value="1">1--&gt;支持（此类呼叫始终SCP计费）</option>
              </select></td>
          </tr>        
        </table> 
        <table cellspacing="0">
			    <tr> 
			    	<td id="footer"> 
			    		<input name="confirm" type="button" class="b_foot" value="保存" onClick="save_to()">
			    		&nbsp;
			                <input name="back"  class="b_foot"  type="button" value="返回"  onClick="quit()">
			   	</td>
			    </tr>
  	</table>
  	<%@ include file="/npage/include/footer.jsp" %>	
</form>
</body>
</html>




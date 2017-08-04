<%
/********************
version v2.0
开发商: si-tech
zhouby
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String flags = request.getParameter("flags");	
	String opCode = "7896";	
	String opName = "服务属性";
	
	//String x[] = flags.split(",");
	//System.out.println(" zhouby java的split会根据最后一位是否为空判断，如果是空的话，那么会少一位，js不会" + x.length);
%>
<html>
  <head>
    <title>服务属性</title>
	<script language="JavaScript">
	
	$(function(){
	    var flags = "<%=flags%>";
	    var targetFlags = flags.split(",");
	    var targetElements = $('.elementTarget');
	    var tlength = targetFlags.length;
	    $.each(targetFlags, function(i, e){
	        if (i == (tlength - 1)){//js因为最后的","会多产生一位，所以下标为最后的一个应该去掉
	            return false;
	        }
	        
	        var targetElement = $(targetElements[i]);
	        if (targetElement.is('textarea')){
	            targetElement.text(targetFlags[i].replace(/\|/g, '\r'));
	        } else {
	            targetElement.val(targetFlags[i]);
	        }
	    });
	});
	
	function validate(){
	    var flag = true;
	    var $invalid = null;
	    $('.elementTarget').each(function(i, e){
		    if ($(this).is('textarea')){//验证电话号最多为5个
		        var targetValue = $(this).val();
		        
		        if (targetValue != ''){
            	    targetValues = targetValue.split(/\n+/g);
            	    var index = 0;
            	    $.each(targetValues, function(i, e){
            	        if (e == ''){
            	            return false;
            	        } else {
            	            index++;
            	        }
            	    });
            	    
            	    if (index > 5){
            	        $invalid = $(this);
            	        rdShowMessageDialog('电话号码不能超过5个！');
            	        flag = false;
            	    }
                }
		    }
		});
	    
	    if (!flag){
	        $invalid.focus();
	        return false;
	    }
	    
	    return true;
	}
	
	function setupData(){
	    var str = "";
	    $('.elementTarget').each(function(i, e){
		    if ($(this).is('textarea')){
		        var targetValue = $(this).val();
		        str += buildTextArea(targetValue);
		    } else{
		        var targetValue = $(this).val();
		        str += targetValue + ',';
		    }
		});
		
	    return str;
	}
	
	function buildTextArea(targetValue){
        var str = '';
	    if (targetValue != ''){
    	    targetValues = targetValue.split(/\n+/g);
    	    $.each(targetValues, function(i, e){
    	        if (e == ''){
    	            return false;
    	        } else {
    	            str += e + '|';
    	        }
    	    });
        }
        str = str.replace(/\|$/, '');
        str += ',';
        
	    return str;
	}
	
	function saveForm(){			
		if (!validate()){
		    return;
		}
		
		var result = setupData();
	    
		window.returnValue = result;
		window.close(); 
	}		
	function quit(){
		window.close(); 
	}
  </script>
</head>

<body>
<form name="frm" method="post" action="">     
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">服务属性</div>
	</div>
        <table>
          <tr>
            <td class="blue">V网内呼叫</td>
            <td>
              <select name="" class="elementTarget">
                <option value="3">开通</option>
              </select> 
            </td>
            
            <td class="blue">V网外呼叫</td>
            <td>
              <select name="" class="elementTarget">
                <option value="0">禁止</option>
                <option value="1">本地</option>
                <option value="2">省内</option>
                <option value="3">省外</option>
                <option value="4">国际</option>
                
              </select> 
            </td>
          </tr>
          
          <tr> 
            <td class="blue">V网外呼入</td>
            <td>
              <select name="" class="elementTarget">
                <option value="4">开通</option><!--wuxy 20151013 Centrex接口默认属性规则优化 从3变为4 -->
                <!--
                <option value="1">关闭</option>
                -->
              </select> 
            </td>
            
            <td class="blue">主叫号码显示</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">开通</option>
                <option value="false">关闭</option>
              </select> 
            </td>
          </tr>
          
          <tr> 
            <td class="blue">主叫号码显示限制</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">开通</option>
                <option value="false">关闭</option>
              </select> 
            </td>
            
            <td class="blue">主叫号码显示限制逾越</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">开通</option>
                <option value="false">关闭</option>
              </select> 
            </td>
          </tr>
          
          <tr> 
            <td class="blue">缩位拨号</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">开通</option>
                <option value="false">关闭</option>
              </select> 
            </td>
            
            <td class="blue">呼叫等待</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">开通</option>
                <option value="false">关闭</option>
              </select> 
            </td>
          </tr>
          
          <tr> 
            <td class="blue">呼叫保持</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">开通</option>
                <option value="false">关闭</option>
              </select> 
            </td>
            
            <td class="blue">盲转</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">开通</option>
                <option value="false">关闭</option>
              </select> 
            </td>
          </tr>
          
          <tr> 
            <td class="blue">询问转接</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">开通</option>
                <option value="false">关闭</option>
              </select> 
            </td>
            
            <td class="blue">指定代答</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">开通</option>
                <option value="false">关闭</option>
              </select> 
            </td>
          </tr>
          
          <tr> 
            <td class="blue">轮选组</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">开通</option>
                <option value="false">关闭</option>
              </select> 
            </td>
            
            <td class="blue">三方通话</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">开通</option>
                <option value="false">关闭</option>
              </select> 
            </td>
          </tr>
          
          <tr>            
            <td class="blue">主叫黑名单</td>
            <td>
              <textarea class="elementTarget"></textarea>
              <br>
              <font class="red">每个号码一行</font>
            </td>
            
            <td class="blue">被叫黑名单</td>
            <td>
              <textarea class="elementTarget"></textarea>
              <br>
              <font class="red">每个号码一行</font>
            </td>
          </tr>
          
          <tr> 
            <td class="blue">闭锁所有呼出</td>
            <td>
              <select name="" class="elementTarget">
                <option value="1">闭锁</option>
                <option value="0">不闭锁</option>
              </select> 
            </td>
            
            <td class="blue">闭锁所有呼入</td>
            <td>
              <select name="" class="elementTarget">
                <option value="2">闭锁</option>
                <option value="0">不闭锁</option>
              </select>
            </td>
          </tr>
        </table> 
        
        <table cellspacing="0">
	      <tr> 
	    	<td id="footer"> 
	    		<input name="confirm" type="button" class="b_foot" value="保存" onClick="saveForm()">
	            <input name="back"  class="b_foot"  type="button" value="返回"  onClick="quit()">
	   	    </td>
	      </tr>
  	    </table>
  	<%@ include file="/npage/include/footer.jsp" %>	
</form>
</body>
</html>
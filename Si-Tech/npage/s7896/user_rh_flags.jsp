<%
/********************
version v2.0
������: si-tech
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
	String opName = "��������";
	
	//String x[] = flags.split(",");
	//System.out.println(" zhouby java��split��������һλ�Ƿ�Ϊ���жϣ�����ǿյĻ�����ô����һλ��js����" + x.length);
%>
<html>
  <head>
    <title>��������</title>
	<script language="JavaScript">
	
	$(function(){
	    var flags = "<%=flags%>";
	    var targetFlags = flags.split(",");
	    var targetElements = $('.elementTarget');
	    var tlength = targetFlags.length;
	    $.each(targetFlags, function(i, e){
	        if (i == (tlength - 1)){//js��Ϊ����","������һλ�������±�Ϊ����һ��Ӧ��ȥ��
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
		    if ($(this).is('textarea')){//��֤�绰�����Ϊ5��
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
            	        rdShowMessageDialog('�绰���벻�ܳ���5����');
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
		<div id="title_zi">��������</div>
	</div>
        <table>
          <tr>
            <td class="blue">V���ں���</td>
            <td>
              <select name="" class="elementTarget">
                <option value="3">��ͨ</option>
              </select> 
            </td>
            
            <td class="blue">V�������</td>
            <td>
              <select name="" class="elementTarget">
                <option value="0">��ֹ</option>
                <option value="1">����</option>
                <option value="2">ʡ��</option>
                <option value="3">ʡ��</option>
                <option value="4">����</option>
                
              </select> 
            </td>
          </tr>
          
          <tr> 
            <td class="blue">V�������</td>
            <td>
              <select name="" class="elementTarget">
                <option value="4">��ͨ</option><!--wuxy 20151013 Centrex�ӿ�Ĭ�����Թ����Ż� ��3��Ϊ4 -->
                <!--
                <option value="1">�ر�</option>
                -->
              </select> 
            </td>
            
            <td class="blue">���к�����ʾ</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">��ͨ</option>
                <option value="false">�ر�</option>
              </select> 
            </td>
          </tr>
          
          <tr> 
            <td class="blue">���к�����ʾ����</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">��ͨ</option>
                <option value="false">�ر�</option>
              </select> 
            </td>
            
            <td class="blue">���к�����ʾ������Խ</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">��ͨ</option>
                <option value="false">�ر�</option>
              </select> 
            </td>
          </tr>
          
          <tr> 
            <td class="blue">��λ����</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">��ͨ</option>
                <option value="false">�ر�</option>
              </select> 
            </td>
            
            <td class="blue">���еȴ�</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">��ͨ</option>
                <option value="false">�ر�</option>
              </select> 
            </td>
          </tr>
          
          <tr> 
            <td class="blue">���б���</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">��ͨ</option>
                <option value="false">�ر�</option>
              </select> 
            </td>
            
            <td class="blue">äת</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">��ͨ</option>
                <option value="false">�ر�</option>
              </select> 
            </td>
          </tr>
          
          <tr> 
            <td class="blue">ѯ��ת��</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">��ͨ</option>
                <option value="false">�ر�</option>
              </select> 
            </td>
            
            <td class="blue">ָ������</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">��ͨ</option>
                <option value="false">�ر�</option>
              </select> 
            </td>
          </tr>
          
          <tr> 
            <td class="blue">��ѡ��</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">��ͨ</option>
                <option value="false">�ر�</option>
              </select> 
            </td>
            
            <td class="blue">����ͨ��</td>
            <td>
              <select name="" class="elementTarget">
                <option value="true">��ͨ</option>
                <option value="false">�ر�</option>
              </select> 
            </td>
          </tr>
          
          <tr>            
            <td class="blue">���к�����</td>
            <td>
              <textarea class="elementTarget"></textarea>
              <br>
              <font class="red">ÿ������һ��</font>
            </td>
            
            <td class="blue">���к�����</td>
            <td>
              <textarea class="elementTarget"></textarea>
              <br>
              <font class="red">ÿ������һ��</font>
            </td>
          </tr>
          
          <tr> 
            <td class="blue">�������к���</td>
            <td>
              <select name="" class="elementTarget">
                <option value="1">����</option>
                <option value="0">������</option>
              </select> 
            </td>
            
            <td class="blue">�������к���</td>
            <td>
              <select name="" class="elementTarget">
                <option value="2">����</option>
                <option value="0">������</option>
              </select>
            </td>
          </tr>
        </table> 
        
        <table cellspacing="0">
	      <tr> 
	    	<td id="footer"> 
	    		<input name="confirm" type="button" class="b_foot" value="����" onClick="saveForm()">
	            <input name="back"  class="b_foot"  type="button" value="����"  onClick="quit()">
	   	    </td>
	      </tr>
  	    </table>
  	<%@ include file="/npage/include/footer.jsp" %>	
</form>
</body>
</html>
<%
   /***********************************************
   * 功能: 修改语种
　 * 版本: 1.0
　 * 版权: sitech
   * 修改：tangxlc
   * 日期：2010/03/10 
   * 内容：修改语种为汉语或者是英语
 　************************************************/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*"%>
<%
    String opCode = "K315";
    String opName = "修改语种";
  
    ArrayList retArray = (ArrayList)session.getAttribute("allArr");
    String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String orgName = (String)session.getAttribute("orgName");
		String deptCode = (String)session.getAttribute("deptCode");
		String orgId = (String)session.getAttribute("orgId");
		String groupId = (String)session.getAttribute("groupId");
		String powerCode = (String)session.getAttribute("powerCode");
		String powerRight = (String)session.getAttribute("powerRight");
		String orgCode = (String)session.getAttribute("orgCode");
		String contactID = (String)session.getAttribute("contactID");
		String login_name = (String)session.getAttribute("login_name");
		
		
		
		String aaa = (String)session.getAttribute("workNo");
System.out.print("tangxlc-------aaaa---------userId: \n"+aaa);
%>                 
<html>
<head>
<title>修改语种</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script language=javascript>
        
        $(document).ready
        (
            function()
            {
                $("td").not("[input]").addClass("blue");
                $("#footer input:button").addClass("b_foot");
                $("td:not(#footer) input:button").addClass("b_text");
                $("input:text[@v_type]").blur(checkElement2);   
                
                $("a").hover
                (
                    function() 
                    {              
                        $(this).css("color", "orange");
                    },function() 
                    {
                        $(this).css("color", "blue");
                    }
                );
            }
        );
        function checkElement2()
        { 
            checkElement(this); 
        }       
//=========================================================================
// 判断字符串是否是数字
//=========================================================================
function isDigital(str)         
{   
	    var ilen;
      for(ilen=0;ilen<str.length;ilen++)   
      {   
          if(str.charAt(ilen)<'0' || str.charAt(ilen) >'9')   
          {   
             return   false;   
          }         
      }   
      return   true;   
}
//=========================================================================
// 用户输入正确性检查
//=========================================================================
function submitInputCheck(sqlFilter)
{
	  //输入的电话号码
	  var phone_no =document.sitechform.phone_number.value;
	  
	  //判断电话号码是否为空
	  if(phone_no =="")
    {
       showTip(document.sitechform.phone_number,"受理号码不能为空");  
       sitechform.phone_number.focus();
       return ;       
    }
    //判断用户输入电话号码是否够11位纯数字
    if(phone_no.length != '11' || !isDigital(phone_no))
    {
   	   showTip(document.sitechform.phone_number,"请输入十一位纯数字的电话号码！");
       sitechform.phone_number.focus(); 
       return;
    }
    hiddenTip(document.sitechform.phone_number);
    submitMe();
}
//=========================================================================
// 提交表单
//=========================================================================
function submitMe()
{  
   //查询语种
   var mypacket = new AJAXPacket("K315_cancelDefLangQry_Select.jsp","正在查询语种，请稍候......");
   var phoneno = window.sitechform.phone_number.value ;
	 mypacket.data.add("telphoneno",phoneno);
   core.ajax.sendPacket(mypacket,doProcessSelect,false);
	 mypacket=null;
}
//=========================================================================
// 处理查询反馈结果
//=========================================================================
function doProcessSelect(packet)
{
  var langcode="";
  var table_op="";
	var telphoneno = packet.data.findValueByName("telphoneno");
  var lang = packet.data.findValueByName("lang");
	if (lang =="1")langcode="中文";
	else langcode="英文";
	
	if(telphoneno=="FAILURE")
	{
      table_op =           "<table  cellSpacing='0'  >";
      table_op =table_op + "<br><br><div class='title' align='center'>查询结果</div> "; 
      table_op =table_op + " <tr><th align='center'><font color='orange'>无此手机号码<font></th></tr>";
      table_op =table_op + "</table>";
	}
	else
  {
      table_op =           "<table  cellSpacing='0' >";
      table_op =table_op + "<br><br><div class='title' align='center'>查询结果</div> "; 
      table_op =table_op + "<tr >";
      table_op =table_op + "  <th align='center' class='blue' width='40%' > 手机号码 </th>";
      table_op =table_op + "  <th align='center' class='blue' width='40%' > 默认语种 </th>";
      table_op =table_op + "</tr>";
      table_op =table_op + "<tr>";
      table_op =table_op + "	<th id='phone' align='center' class='blue' width='40%'>"+telphoneno;
      table_op =table_op + "	</th>";
      table_op =table_op + "	<th id='languagecode' align='center' class='blue' width='40%'>"+langcode ;
      table_op =table_op + "	</th>	";
      table_op =table_op + " </tr>";
      table_op =table_op + "</table>";
  }
  document.getElementById("Reserch_Table").innerHTML=table_op;
}
//=========================================================================
// SUBMIT Update TO THE SERVELET
//=========================================================================
function UpdateLang()
{
	 //输入的电话号码
	 var phone_no =document.sitechform.phone_number.value;
	 
	 //判断电话号码是否为空
	 if(phone_no =="")
   {
       showTip(document.sitechform.phone_number,"受理号码不能为空");  
       sitechform.phone_number.focus();
       return false;       
   }
   //判断用户输入电话号码是否够11位纯数字
	 if(phone_no.length != '11' || !isDigital(phone_no))
   {
   	   showTip(document.sitechform.phone_number,"请输入十一位纯数字的电话号码！");
   	   sitechform.phone_number.focus(); 
   	   return;
   }
   hiddenTip(document.sitechform.phone_number);
   
   //判断是否已经选择了语种
   if (window.sitechform.selectLangFlag.value==3)
   {
   	   showTip(document.sitechform.selectLangFlag,"请选择语种"); 
       sitechform.selectLangFlag.focus();  
       return false;   
   }   	 
	 hiddenTip(document.sitechform.selectLangFlag);

   //确认修改语种
	 if(rdShowConfirmDialog("确认修改语种？")!= 1) return ;
   var mypacket = new AJAXPacket("K315_cancelDefLangQry_update.jsp","正在修改语种，请稍候......");
   var phoneno = window.sitechform.phone_number.value ;
   var languagetype =window. sitechform.selectLangFlag.value ;
	 mypacket.data.add("telphoneno",phoneno);
	 mypacket.data.add("languagetype",languagetype);
	 mypacket.data.add("wordNo","<%=workNo%>");
	 mypacket.data.add("workName","<%=workName%>");
	 mypacket.data.add("contactID","<%=contactID%>");
   core.ajax.sendPacket(mypacket,doProcess,false);
	 mypacket=null;
	 submitMe();
}

//=========================================================================
// Clear page recodes.
//=========================================================================
function clearValue()
{
	
	document.getElementById("Reserch_Table").innerHTML="<br>";
	var e=window.sitechform;
  for(var i=0;i<e.length;i++)
  {
    if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden")
    {
    	  if(e[i].type=="select-one")
    	  {
    	  	e[i].value="3";
    	  }
    	  else
        {
        	e[i].value="";
        	hiddenTip(e[i]);
        }
    }
    if(e[i].type=="checkbox")
    {
        e[i].checked=false;
    }
  }

}
//=========================================================================
// DoProcess.
//=========================================================================
function doProcess(packet)
{
	var retCode = packet.data.findValueByName("retCode");
	if(retCode=="000000")
	{
	   rdShowMessageDialog("语种修改成功！",1);
	   return;
	}
  rdShowMessageDialog("此手机号码无语种记录，修改失败!",1);
}
function changeOthers()
{
    hiddenTip(document.sitechform.phone_number);
    hiddenTip(document.sitechform.selectLangFlag);
}
</script>
</head>
<body >
<form id=sitechform name=sitechform>
  <div id="Operation_Table">
    <table cellspacing="0"> 	
    	<tr><%@ include file="/npage/include/header.jsp"%></tr>
      <tr >
        
     	  <div class="title" ></div>
        <td >手机号码</td>
        <td >
          <input id="phone_number" name="phone_number" type="text" maxlength='11'>
          <font color="orange">*</font>
        <td > 修改语种为 </td>
        <td >
        	<SELECT name="selectLangFlag" class="button" id="selectLangFlag" onChange="changeOthers()">
						<option value="3" selected>请选择语种</option>
						<option value="1" >中文</option>
						<option value="2" >英文</option>
					</SELECT>
        </td>
      </tr>
      <!-- ICON IN THE MIDDLE OF THE PAGE-->
      <tr >
        <td colspan="8" align="center" id="footer">	
      	  <input name="search" type="button"  id="search" value="查询" onClick="submitInputCheck();return false;">
      	  <input name="search" type="button"  id="search" value="修改" onClick="UpdateLang();return false;">
      	  <input name="delete_value" type="button"  id="add" value="重设" onClick="clearValue();return false;">
        </td>
      </tr>
    </table>     
    <div id="Reserch_Table"> 
    </div>
  </div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>


<%
/********************
 version v2.0
开发商: si-tech
create by wanglm 20110321
********************/
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String current_timeNAME=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
		String regionCode= (String)session.getAttribute("regCode");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
  onload=function()
  {
  
  }

 function doCfm(){
    
   
 var radio1 = document.getElementsByName("opFlag");
 var opFlag="";
 var sm= new Array();
 var phonenos="";
 var jinee="";
 var liushis="";
 var custnamess="";
 var simstatuss="";
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	   opFlag = radio1[i].value;
	   	sm =opFlag.split("<-!->");
			phonenos=sm[0];
			jinee=sm[1];
			liushis=sm[2];
			custnamess=sm[3];
			simstatuss=sm[4];
	}
	
  }  		
  
    if(opFlag=="") {
						rdShowMessageDialog("请选择要操作的项！",1);
						return false;
		}
		$("#phonenos").val(phonenos);
		$("#jinee").val(jinee);
		$("#liushis").val(liushis);
		$("#custnamess").val(custnamess);
		$("#simstatuss").val(simstatuss);
		
	    		
				document.form1.confirm.disabled=true;
	     
				document.form1.action = "fm265Cfm.jsp";
   			document.form1.submit();
   		
 }
 
		
		function doQry()
{
		var phoneNo = $("#zr_phone").val();
	  var yewuliushui = $("#yewuliushui").val().trim();	
		
		if(yewuliushui=="") {
	      rdShowMessageDialog("业务流水不能为空！");
   			return false;					
		}
	
    var myPacket = new AJAXPacket("fm265Qry.jsp", "正在查询客户信息，请稍候......");
    myPacket.data.add("phoneNo", phoneNo);
    myPacket.data.add("yewuliushui", yewuliushui);
    core.ajax.sendPacketHtml(myPacket,querinfo);
    myPacket = null;
    document.form1.confirm.disabled=false;
    
}

   function querinfo(data){
				//找到添加表格的div
				var markDiv=$("#showTab"); 
				markDiv.empty();
				markDiv.append(data);

				
		}

 	function resetPage(){
 		window.location.href = "fm265.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
	}
	
	
 
  				function querinfo(data){
				//找到添加表格的div
				var markDiv=$("#showTab"); 
				markDiv.empty();
				markDiv.append(data);
				
		}
		

</script>
</head>
<body>
<form name="form1" id="form1" method="POST" >
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
      <table cellspacing="0">
         <tr> 
            <td width="16%"  > 
              <div align="left" class="blue">手机号码</div>
            </td>
            <td colspan="3"> 
            <div align="left"> 
                <input class="InputGrey" type="text" name="zr_phone" id="zr_phone" v_type="mobphone" v_must=1 value="<%=activePhone%>"  maxlength=11 index="3" readonly />
                </div>
            </td>
         
              <td width="16%"  > 
              <div align="left" class="blue">业务流水</div>
            </td>
            <td colspan="3"> 
            <div align="left"> 
                <input  type="text" name="yewuliushui" id="yewuliushui" v_type="string"  value=""  maxlength=20 index="3"  /><font class="orange">*</font>
                </div>
            </td>     
         </tr>
                 
	</table>

	<div id="showTab" ></div>
	

              <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
              <input class="b_foot" type=button name="doquery" value="查询" onClick="doQry(this)" >
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" disabled>
              <input class="b_foot" type=button name=back value="清除" onClick="resetPage()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
              </div>
            </td>
          </tr>
        </table>
      <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
      <input type="hidden" name="opName" id="opName" value="<%=opName%>" />
      <input type="hidden" name="phonenos" id="phonenos" />
      <input type="hidden" name="jinee" id="jinee" />
      <input type="hidden" name="liushis" id="liushis" />
      <input type="hidden" name="custnamess" id="custnamess" />
      <input type="hidden" name="simstatuss" id="simstatuss" />
    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
</html>
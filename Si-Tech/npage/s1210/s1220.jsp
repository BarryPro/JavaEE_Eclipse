<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.09.18
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
  request.setCharacterEncoding("GBK");
  HashMap hm=new HashMap();
  hm.put("1","没有客户ID！");
  hm.put("3","密码错误！");
  hm.put("4","手续费不确定，您不能进行任何操作！");
  
  hm.put("2","未取到数据1，请核查数据或咨询系统管理员！");
  hm.put("10","未取到数据2，请核查数据或咨询系统管理员！");
  hm.put("11","未取到数据3，请核查数据或咨询系统管理员！");
  hm.put("12","未取到错误信息！"); 
  hm.put("13","未取到数据5，请核查数据或咨询系统管理员！");
  hm.put("14","未取到数据6，请核查数据或咨询系统管理员！");

  String op_name="";
  String op_code = request.getParameter("op_code");
  if(op_code.equals("1220")){
    op_name="换卡变更";
    op_code="1220";
  }
  else if(op_code.equals("1217"))
    op_name="预销恢复";
  else if(op_code.equals("1260"))
    op_name="预拆恢复";
%>

<html>
<head>
<title><%=op_name%></title>
<%
	String opCode = op_code;
	String opName = op_name;
	String work_no =(String)session.getAttribute("workNo");
	String loginName =(String)session.getAttribute("workName");
	String org_Code = (String)session.getAttribute("orgCode");
	String regionCode = org_Code.substring(0,2);
  
	String phone="";
	phone = request.getParameter("activePhone");
	if(null==phone||phone.equals("")){
	  phone = request.getParameter("phone_no");
	}
  
	 ArrayList initArr = new ArrayList();
    ArrayList groupArr = new ArrayList();

	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));

	String dirtPage=request.getParameter("dirtPage");
%>

<script language=javascript>
  onload=function()
  {


<%
	
	if(ReqPageName.equals("s1220Main"))
	{
	  String retMsg=WtcUtil.repNull(request.getParameter("retMsg"));
 	  if(!retMsg.equals("100") && !retMsg.equals("101"))
	  {        
%>   	 
	    rdShowMessageDialog("<%=(String)(hm.get(retMsg))%>");	 
	    parent.removeTab("<%=opCode%>");
<%
	  }
	  else if(retMsg.equals("100"))
	  {
%>
    	rdShowMessageDialog('帐户<%=WtcUtil.repNull(request.getParameter("oweAccount"))%>已欠费<%=WtcUtil.repNull(request.getParameter("oweFee"))%>元，不能办理业务！');	    
<%
	  }
      else if(retMsg.equals("101"))
	  {
%>
        rdShowMessageDialog('错误<%=WtcUtil.repNull(request.getParameter("errCode"))%>：<%=WtcUtil.repStr(request.getParameter("errMsg"),WtcUtil.repNull(request.getParameter("errCode")))%>');
<%
	  }
	}
%>
  }


//----------------验证及提交函数-----------------

function doCfm()
{


  if(!forMobil(frm.srv_no)) return false; //验证手机号码格式，增加对固话的校验
      frm.action="s1220Main.jsp";
	  frm.submit();	
  
}



//-------------------------------------------------------
function doProcess(packet)
 {
    var errCode=packet.data.findValueByName("errCode");
	var errMsg=packet.data.findValueByName("errMsg");
	var verifyType = packet.data.findValueByName("verifyType");
	var smCode=packet.data.findValueByName("smCode");
 	self.status="";	  
 	
 }
</script>
</head>
<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">
	
<form name="frm" method="POST"  onKeyUp="chgFocus(frm)">
	
	
	   <%@ include file="/npage/include/header.jsp" %>   
  	
					<div class="title">
						<div id="title_zi"><%=op_name%></div>
					</div>
  <input type="hidden" name="ReqPageName" id="ReqPageName" value="s1220">
  <input type="hidden" name="smCode" id="smCode" value="gn">
  <input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
  <input type="hidden" name="org_code" id="org_code" value="<%=org_Code%>">
  <input type="hidden" name="work_no" id="work_no" value="<%=work_no%>">
  <input type="hidden" name="passwdFlag" id="passWdFlag" value="1">



        <table cellspacing="0">
          <tr> 
                <td colspan="4"  nowrap>&nbsp;</td>
          </tr>
          <tr> 
	            <td width="16%" nowrap class="blue"> 
	              <div align="left">服务号码</div>
	            </td>
                <td nowrap width="84%" colspan="3"> 
		              <div align="left"> <font color="red">
            		    <input class="InputGrey"  value="<%=phone%>" type="text" size="12" name="srv_no" id="srv_no" v_must=0 v_maxlength=16 v_type=mobphone  v_name="服务号码" maxlength="11" readonly> * </font></div>
                </td>
	           
            </tr>
          <tr> 
      			 <td class=Lable  nowrap colspan="4">&nbsp;</td>
          </tr>
          <tr> 
			            <td colspan="5" id="footer"> 
			              <div align="center"> 
			                <input class="b_foot" type=button name=qryPage value="确认" onClick="doCfm()"  >    
					          <input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
							   <input class="b_foot" type=button name=shut value="关闭" onClick="removeCurrentTab();"  >
			        		</div>
			      		</td>
         </tr>
  </table>
   <%@ include file="/npage/include/footer_simple.jsp" %>   
   </form>
</body>
</html>


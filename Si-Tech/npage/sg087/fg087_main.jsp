<%
    /*************************************
    * 功  能: 一点支付成员清单查询 g087
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-9-13
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  response.setHeader("Pragma","No-Cache");
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
%>
<%
	String opCode=request.getParameter("opCode");
  String opName=request.getParameter("opName");
%>  
<HTML>
<HEAD>
    <TITLE>一点支付成员清单查询</TITLE>
</HEAD>
<body>
<SCRIPT language="JavaScript">
    function queryInfo(){
    		var markDiv=$("#intablediv"); 
        markDiv.empty();
        
        var ECCustNo = $("#ECCustNo").val();
        var unitId = $("#unitId").val();
        var custPhoneNo = $("#custPhoneNo").val();
        var monthList = $("#monthList").val();
        if(!forDate(document.frmg087.monthList)){
          return false;
        }
        if(ECCustNo==""&&unitId==""&&custPhoneNo==""){
          rdShowMessageDialog("请在EC集团客户编码、集团编码、成员手机号中，至少输入一个查询条件！",1);
          return false;
        }
        if(custPhoneNo!=""){
          $("#custPhoneNo").attr("v_type",'mobphone');
        }else{
           $("#custPhoneNo").removeAttr("v_type");
        }
        if(!check(frmg087)) return false;
        var myPacket = new AJAXPacket("fg087_ajax_queryInfo.jsp","正在获取信息，请稍候......");
	    	myPacket.data.add("opCode","<%=opCode%>");
	    	myPacket.data.add("opName","<%=opName%>");
	    	myPacket.data.add("ECCustNo",ECCustNo);
	    	myPacket.data.add("unitId",unitId);
	    	myPacket.data.add("custPhoneNo",custPhoneNo);
	    	core.ajax.sendPacketHtml(myPacket,doQueryInfo);
	    	myPacket=null; 
    }
    
    function doQueryInfo(data){
    		//找到添加表格的div
				var markDiv=$("#intablediv"); 
				markDiv.empty();
    		markDiv.append(data);
        var retCode = $("#retCode").val();
        var retMsg = $("#retMsg").val();
        if(retCode!="000000"){
             rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
             window.location.href="fe087_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
        }
    }
    
    function showDetailInfo(obj){
      /*var a = window.showModalDialog(
     		'fg087_showDetailInfo.jsp',,'dialogHeight:650px; dialogWidth:850px;scrollbars:yes;resizable:no;location:no;status:no'
      );*/   
     var idNo = obj.v_idNo;
     var accountNo = obj.v_accountNo;
     var monthList = $("#monthList").val();
     var qryPhoneNo = obj.v_qryPhoneNo;
      window.open ('fg087_showDetailInfo.jsp?opCode=<%=opCode%>&opName=<%=opName%>&idNo='+idNo+'&accountNo='+accountNo+'&monthList='+monthList+'&qryPhoneNo='+qryPhoneNo,'','height=250,width=1000,top=250,left=190,scrollbars=yes'); 
  
    }
</SCRIPT>
<form name="frmg087" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
         	<input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
		        <div id="title_zi">查询信息</div>
	        </div>
            <table cellspacing="0">
            	<tr>
            		<td class="blue" nowrap>EC集团客户编码</td>
            	    <td>
            	    	<input type="text" name="ECCustNo" id="ECCustNo" value="" size="20" />
            	    </td>
            		  <td class="blue" nowrap>集团编号</td>
            	    <td >
            	    	<input type="text" name="unitId" id="unitId" value="" size="20" />
            	    </td>
            	</tr>
            	<tr>
            		<td class="blue"  nowrap>成员手机号</td>
            	    <td >
            	    	<input type="text" name="custPhoneNo" id="custPhoneNo" value="" size="20" />
            	    </td>
            	    	<td class="blue"  nowrap>月份</td>
            	    <td >
            	    	<input  type="text" name="monthList" id="monthList" value="" size="20" v_format="yyyyMM" v_must="1" />
            	    	<font color="orange">* ( 输入格式：yyyyMM )</font>
            	    </td>
            	</tr>
            	 <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="queryBtn" name="queryBtn" class="b_foot" value="查询" onClick="queryInfo()" />   
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
          <div id="intablediv"></div>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
</BODY>
</HTML>


<%
    /********************
     * @ OpCode    :  7421
     * @ OpName    :  动力100业务包订购
     * @ CopyRight :  si-tech
     * @ Author    :  qidp
     * @ Date      :  2009-10-28
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);

	String opName = "选择客户";
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
    String iCustId = WtcUtil.repNull((String)request.getParameter("custId"));
    /*chendx added unit_id*/
    String iUnitId = WtcUtil.repNull((String)request.getParameter("unitId"));
    String iSmCode = WtcUtil.repNull((String)request.getParameter("smCode"));
    String iBizCode = WtcUtil.repNull((String)request.getParameter("bizCode"));
    String iBtnId = WtcUtil.repNull((String)request.getParameter("btnId"));
    String iLoginAccept = WtcUtil.repNull((String)request.getParameter("loginAccept"));
    String iChildAccept = WtcUtil.repNull((String)request.getParameter("childAccept"));
    /*chendx added Bbossflag*/
    String iBbossFlag = WtcUtil.repNull((String)request.getParameter("BbossFlag"));
    String[][] custInfo = new String[][]{};
    System.out.println("************iBbossFlag="+iBbossFlag);
    
    String btnId = WtcUtil.repNull((String)request.getParameter("btnId")); //yuanqs add 2010/9/2 16:35:14
    System.out.println("====================yuanqs==========" + btnId);
    /*chendx added 如果是全网业务，要求输出商品级信息
    请注意全网业务中包前订购的商品品iBbossFlag已经设置为N，所以还要判断是否为包前订购的商品*/
    try{
        String sqlStr = "";
        if("AD".equals(iSmCode) || "ML".equals(iSmCode)){
            sqlStr = "select a.cust_id,a.id_no,a.sm_code,a.product_code,c.offer_name from dgrpusermsg a,dgrpusermsgadd b,product_offer c "
                + " where a.cust_id = '"+iCustId+"' and a.sm_code = '"+iSmCode+"' and a.id_no = b.id_no and b.FIELD_CODE = 'YWDM0' "
                + " and b.FIELD_VALUE = '"+iBizCode+"' and a.run_code = 'A' and a.region_code = '"+regionCode+"' and a.product_code = c.OFFER_ID";
        }else{
		        if("Y".equals(iBbossFlag)){sqlStr = "SELECT c.cust_id ,c.id_no ,c.sm_code,c.product_code, e.offer_name FROM DPOSPECINFO A, DPOORDERINFO B,dgrpusermsg c,product_offer e "
		        		       + "  WHERE B.CUSTOMER_ID = '"+iUnitId+"' AND A.POSPEC_NUMBER = B.POSPEC_NUMBER AND b.id_no=c.id_no "
		        		       + "  AND c.SM_CODE = '"+iSmCode+"' AND c.RUN_CODE = 'A' AND C.REGION_CODE = '"+regionCode+"' AND C.PRODUCT_CODE = E.OFFER_ID AND b.guidang_status = '1' ";
		        }
		        else{
		        	  if("M4".equals(iSmCode)){sqlStr = "SELECT c.cust_id ,c.id_no ,c.sm_code,c.product_code, e.offer_name FROM DPOSPECINFO A, DPOORDERINFO B,dgrpusermsg c,product_offer e "
		        		       + "  WHERE B.CUSTOMER_ID = '"+iUnitId+"' AND A.POSPEC_NUMBER = B.POSPEC_NUMBER AND b.id_no=c.id_no "
		        		       + "  AND c.SM_CODE = '"+iSmCode+"' AND c.RUN_CODE = 'A' AND C.REGION_CODE = '"+regionCode+"' AND C.PRODUCT_CODE = E.OFFER_ID AND b.guidang_status = '1' ";		        	  
		        	  }
		            else sqlStr = "select a.cust_id,a.id_no,a.sm_code,a.product_code,b.offer_name from dgrpusermsg a,product_offer b where a.cust_id = '"+iCustId+"' and a.sm_code = '"+iSmCode+"' and a.run_code = 'A' and a.region_code = '"+regionCode+"' and a.product_code = b.offer_id";
		        }
        }
     System.out.println("sqlStr="+sqlStr);
    %>
        <wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="5" routerKey="region" routerValue="<%=regionCode%>">
        	<wtc:sql><%=sqlStr%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="retArr" scope="end"/>
    <%
        if("000000".equals(retCode) && retArr.length>0){
            custInfo = retArr;
        }else{
        %>
            <script type=text/javascript>
                rdShowMessageDialog("查询集团客户信息失败！<br/>错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
                window.close();
            </script>
        <%
        }
    }catch(Exception e){
        %>
            <script type=text/javascript>
                rdShowMessageDialog("查询集团客户信息失败！",0);
                window.close();
            </script>
        <%
        e.printStackTrace();
    }
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=opName%></TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<SCRIPT type=text/javascript>
var openFlag = 0; //yuanqs add 2010/9/30 11:12:50
    function saveTo(){
    	  openFlag = 1; //yuanqs add 2010/9/30 14:50:38
        var len = document.all.custRadio.length;
        if(len != undefined){ // 有两条以上数据
            for(var i=0;i<len;i++){
                if(document.all.custRadio[i].checked){
                    var vIdNo = document.all.custRadio[i].value;
                    window.opener.doSelectCust("Y","<%=iBtnId%>",vIdNo,"<%=iLoginAccept%>","<%=iChildAccept%>");
                    window.close();
                    return true;
                }
            }
            var confirmFlag = rdShowConfirmDialog("是否确定不选择任何客户？");
            if (confirmFlag == 1){
            	window.opener.doSelectCust("N","<%=iBtnId%>","","<%=iLoginAccept%>","<%=iChildAccept%>");
    	        window.close();
            }
        }else{ // 只有一条数据
            if(document.all.custRadio.checked){ // 选中时
                var vIdNo = document.all.custRadio.value;
                window.opener.doSelectCust("Y","<%=iBtnId%>",vIdNo,"<%=iLoginAccept%>","<%=iChildAccept%>");
                window.close();
                return true;
            }else{ // 未选择
                var confirmFlag = rdShowConfirmDialog("是否确定不选择任何客户？");
                if (confirmFlag == 1){
                	window.opener.doSelectCust("N","<%=iBtnId%>","","<%=iLoginAccept%>","<%=iChildAccept%>");
        	        window.close();
                }
            }
        }
	}
	
		//yuanqs add 2010/9/3 16:08:31 
	function doResume() {
		if(openFlag == 0) {//yuanqs add 2010/9/30 11:13:59
			var v_btnId = "<%=btnId%>";
    	opener.document.getElementById(v_btnId).disabled = false; //yuanqs add 2010-9-2 17:14:17
			window.close();
		}
	}
	
	function doClose(){
	    var confirmFlag = rdShowConfirmDialog("是否确定不选择任何客户？");
        if (confirmFlag == 1){
        	doResume(); //yuanqs add 2010/9/3 16:09:02
        	window.opener.doSelectCust("N","<%=iBtnId%>","","<%=iLoginAccept%>","<%=iChildAccept%>");
	        window.close();
        }
	}
	

</SCRIPT>
</HEAD>
<!-- yuanqs add 2010/9/3 15:58:15 添加-->
<BODY onUnload="doResume()">
<FORM method=post name="fPubSimpSel">
<%@ include file="/npage/include/header_pop.jsp" %>
<div class="title">
	<div id="title_zi">选择客户</div>
</div>    	
<table cellspacing="0">
    <tr>
        <th nowrap>选择</th>
        <th nowrap>客户ID</th>
        <th nowrap>集团用户ID</th>
        <th nowrap>品牌代码</th>
        <th nowrap>产品代码</th>
        <th nowrap>产品名称</th>
    </tr>
    <%
        for(int i=0;i<custInfo.length;i++){
            String tdClass = "";
            if (i%2 != 0){
                tdClass = "Grey";
            }
    %>
    <tr>
            <td class='<%=tdClass%>'><input type='radio' id='custRadio' name='custRadio' value='<%=custInfo[i][1]%>' /></td>
            <td class='<%=tdClass%>'><%=custInfo[i][0]%></td>
            <td class='<%=tdClass%>'><%=custInfo[i][1]%></td>
            <td class='<%=tdClass%>'><%=custInfo[i][2]%></td>
            <td class='<%=tdClass%>'><%=custInfo[i][3]%></td>
            <td class='<%=tdClass%>'><%=custInfo[i][4]%></td>
    </tr>
    <%
        }
    %>
</table>
<table cellspacing=0>
    <tr id="footer">
        <td>
            <input type='button' id='bSure' name='bSure' class='b_foot' value='确定' onClick='saveTo()' />
            <input type='button' id='bClose' name='bClose' class='b_foot' value='关闭' onClick='doClose()' />
        </td>
    </tr>
</table>

<%@ include file="/npage/include/footer_pop.jsp" %> 
</FORM>
</BODY>
</HTML>    

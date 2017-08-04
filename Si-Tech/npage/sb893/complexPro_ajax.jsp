<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
        String orgCode = (String)session.getAttribute("orgCode");
        String regionCode = orgCode.substring(0,2);
        
        String dateStr =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
        
        String ret_code  = "";				//错误代码 
        String ret_message  = "";      		//错误消息    
        String effStr = "";
        String exiStr = "";
             
	    String showStatu = "xingou";
	    String nodeId = request.getParameter("nodeId");
	    String nodeName = request.getParameter("nodeName");
	    String etFlag = request.getParameter("etFlag");
	    String servId = "13008467744";
	    System.out.println("# nodeId = "+nodeId);
	    String proEff = "";
		String proExi = "";
	    
	    System.out.println("------------------------------#############################--nodeId-------------------------------"+nodeId);
	    System.out.println("--------------------------------servId-------------------------------"+servId);
	    try
        {
                String sqlStr2 = "select to_char(eff_date,'yyyymmdd'),to_char(exp_date,'yyyymmdd') from serv_product where product_id = '"+nodeId+"' and serv_id = '"+servId+"'";
            System.out.println("# sqlStr2 = "+sqlStr2);
            %>
            <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2"  outnum="2">
                <wtc:sql><%=sqlStr2%></wtc:sql>
            </wtc:pubselect>
            <wtc:array id="retVal2" scope="end" />
            <%
                if(retCode2.equals("000000") && retVal2.length>0){
                    proEff = retVal2[0][0];
                    proExi = retVal2[0][1];
                    ret_code = retCode2;
                    ret_message = retMsg2;
                }
        }catch(Exception e){
            ret_code = "999999";
            ret_message = "complexPro_ajax.jsp -> 调用服务失败！";
        }
	    
		String flag = "0";
		
		if("1".equals(flag)){
		    effStr = proEff;
		    exiStr = proExi;
		}else{
		    effStr = dateStr;
		    exiStr = "20501231";
		}
		
		
	    String startDateFlag = "N";
	    String stopDateFlag = "N";
        try
        {
        				
                String sqlStr ="select attr_value　from product_attr where attr_seq = 1100001 and product_id = '"+nodeId+"'";
                
                System.out.println("-------------------sqlStr------------------"+sqlStr);
            %>
            <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg"  outnum="1">
                <wtc:sql><%=sqlStr%></wtc:sql>
            </wtc:pubselect>
            <wtc:array id="retVal" scope="end" />
            <%
                if(retCode.equals("000000") && retVal.length>0){
                    if("1".equals(retVal[0][0])){
                        startDateFlag = "Y";
                    }else if("2".equals(retVal[0][0])){
                        stopDateFlag = "Y";
                    }else if("3".equals(retVal[0][0])){
                        startDateFlag = "Y";
                        stopDateFlag = "Y";
                    }else{
                    }
                    ret_code = retCode;
                    ret_message = retMsg;
                }
        }catch(Exception e){
            ret_code = "999999";
            ret_message = "complexPro_ajax.jsp -> 调用服务失败！";
        }
%>

var startStr = "";
//weigp展示每个产品子项都是不可更改
//if("<%=startDateFlag%>" == "N" || "<%=etFlag%>" == "0"){
    startStr = " readOnly class='InputGrey' ";
//}

var stopStr = "";
//if("<%=stopDateFlag%>" == "N" || "<%=etFlag%>" == "0"){
    stopStr = " readOnly class='InputGrey' ";
//}

var showStatu="<%=showStatu%>";
var startDateFlag="<%=startDateFlag%>";
var stopDateFlag="<%=stopDateFlag%>";
$("#tab_pro").append("<tr id='pro_detail_"+"<%=nodeId%>"+"'><td id='tab_td_"+"<%=nodeId%>"+"'>"+"<%=nodeName%>"+"</td><td><input type='text' name='startDate_"+"<%=nodeId%>"+"' id='startDate_"+"<%=nodeId%>"+"' value='<%=effStr%>' size='8' "+startStr+" v_format='yyyyMMdd' maxlength='8' v_type='0_9' onBlur='if(!forDate(this)){return false;}' /></td><td><input type='text' name='stopDate_"+"<%=nodeId%>"+"' id='stopDate_"+"<%=nodeId%>"+"' value='<%=exiStr%>' size='8' "+stopStr+" v_format='yyyyMMdd' maxlength='8' v_type='0_9' onBlur='if(!forDate(this)){return false;}' /></td><td><input type='button' class='b_text' value='报停' id='stop_"+"<%=nodeId%>"+"' onclick=chkStop('"+"<%=nodeId%>"+"') style='display:none' ><input type='button' class='b_text' id='ret_"+"<%=nodeId%>"+"' onclick=returnStop('"+"<%=nodeId%>"+"') value='恢复' style='display:none' ><input type='hidden' id='proAttr_"+"<%=nodeId%>"+"'><input type='hidden' id='newFlag_"+"<%=nodeId%>"+"'></td></tr>");

var retArr=chkLimit1("<%=nodeId%>","1").split("@");
retCo=retArr[0].trim();
retMg=retArr[1];

if(retCo=="0")
{
    var arrClassValue = new Array();
    arrClassValue.push("<%=nodeId%>");
    getMidPrompt("10431",arrClassValue,"tab_td_"+"<%=nodeId%>");
}

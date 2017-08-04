<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
System.out.println("---------------------complexPro_ajax.jsp------------------"+new Date());
        String orgCode = (String)session.getAttribute("orgCode");
        String regionCode = orgCode.substring(0,2);
        
        String dateStr =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
        
        String ret_code  = "";				//错误代码 
        String ret_message  = "";      		//错误消息    
        String effStr = "";
        String exiStr = "";
             
	    //String node = request.getParameter("node");
	    String showStatu = request.getParameter("showStatu");
	    String nodeId = request.getParameter("nodeId");
	    String servId = request.getParameter("servId");
	    String effTime = request.getParameter("effTime");
	    String expTime = request.getParameter("expTime");
	    
	    String effTimeh = effTime;
	    String expTimeh = expTime;
	    
	    
	    String cccTime= new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	    String cccTimeh= new java.text.SimpleDateFormat("yyyyMMddHH24mmss").format(new java.util.Date());
	    if(!effTime.equals(null)&&!effTime.equals("")){
			
			effTime = effTime.substring(0,8);
			expTime = expTime.substring(0,8); 
			   
      }else{
	  	effTime = cccTime;
	  	expTime = "20500101";
	  	effTimeh = cccTimeh;
	  	}
	    
	    
 
	    String proEff = "";
		  String proExi = "";
	    
	    

	    
		String flag = (String)request.getParameter("flag");
		
		String startFlag = (String)request.getParameter("startFlag");
		
		
		
	    String startDateFlag = "N";
	    String stopDateFlag = "N";
        try
        {
                String sqlStr ="select attr_value　from product_attr where attr_seq = 1100001 and product_id = '"+nodeId+"'";
                
                //System.out.println("sqlStr|||"+sqlStr);
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
        
//System.out.println("----------------effTime.compareTo(cccTime)------------------"+effTime.compareTo(cccTime));

//System.out.println("----------------startDateFlag------------------"+startDateFlag);
%>

var startStr = "";



if("<%=startDateFlag%>" == "N" || "<%=startFlag%>" == "0" || "<%=startFlag%>" == "1" || "<%=startFlag%>" == "2" ){
    startStr = " readOnly class='InputGrey' ";
}
<%if(effTime.compareTo(cccTime)>0){%>
startStr = "";
<%}%>

if("<%=effStr%>" > "<%=dateStr%>"){
    startStr = "";
}

var stopStr = "";
if("<%=stopDateFlag%>" == "N" || "<%=startFlag%>" == "0"){
    stopStr = " readOnly class='InputGrey' modFlag='false' ";
}else{
    stopStr = " modFlag='true' ";
}

var node = node2;
var showStatu="<%=showStatu%>";
var startDateFlag="<%=startDateFlag%>";
var stopDateFlag="<%=stopDateFlag%>";
        
$("#tab_pro").append("<tr id='pro_detail_"+node.getId()+"'><td id='pro_detail_td_"+node.getId()+"'>"+node.getName()+"</td><td><input type='text' name='startDate_"+node.getId()+"' id='startDate_"+node.getId()+"' value='<%=effTime%>' size='8' "+startStr+" v_format='yyyyMMdd' maxlength='8' v_type='0_9' onBlur='if(!forDate(this)){return false;}' /><input type='hidden' name='startDateSave_"+node.getId()+"' id='startDateSave_"+node.getId()+"' value='<%=effTimeh%>' /></td><td><input type='text' name='stopDate_"+node.getId()+"' id='stopDate_"+node.getId()+"' value='<%=expTime%>' size='8' "+stopStr+" v_format='yyyyMMdd' maxlength='8' v_type='0_9' onBlur='if(!forDate(this)){return false;}' /><input type='hidden' name='stopDateSave_"+node.getId()+"' id='stopDateSave_"+node.getId()+"' value='<%=expTimeh%>' /></td><td id='proName_"+node.getId()+"'>"+showStatu+"</td><td style=\"display:none\">"+node.getId()+"</td><td><input type='button' class='b_text' value='报停' id='stop_"+node.getId()+"' onclick=chkStop('"+node.getId()+"') style='display:none' ><input type='button' class='b_text' id='ret_"+node.getId()+"' onclick=returnStop('"+node.getId()+"') value='恢复' style='display:none' ><input type='hidden' id='proAttr_"+node.getId()+"'><input type='hidden' id='newFlag_"+node.getId()+"'></td></tr>");
if(node.haveAttr==1){
	$("#pro_detail_"+node.getId()+" td:eq(3)").append("&nbsp;<input  type='button' name='offe_"+node.getName()+"' value='设置属性' id='att_"+node.getId()+"' class='b_text' onclick=setAttr2('"+node.getId()+"','"+showStatu+"') />");
}
if(showStatu=="新购")
{
		$("#stop_"+node.getId()).attr("disabled",true);
		$("#ret_"+node.getId()).attr("disabled",true);
}


<%
System.out.println("---------------------complexPro_ajax.jsp------------------"+new Date());
%>
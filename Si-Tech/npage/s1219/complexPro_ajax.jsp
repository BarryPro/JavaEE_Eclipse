<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<%
System.out.println("---------------------complexPro_ajax.jsp------------------"+new Date());
        String orgCode = (String)session.getAttribute("orgCode");
        String regionCode = orgCode.substring(0,2);
        
        String dateStr =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
        
        String ret_code  = "";				//������� 
        String ret_message  = "";      		//������Ϣ    
        String effStr = "";
        String exiStr = "";
             
	    //String node = request.getParameter("node");
	    String showStatu = request.getParameter("showStatu");
	    String nodeId = request.getParameter("nodeId");
	    String servId = request.getParameter("servId");
	    String effTime = request.getParameter("effTime");
	    String expTime = request.getParameter("expTime");
	    String smCode = request.getParameter("smCode");
	    String com_pro_intId = request.getParameter("com_pro_intId");
	    
	    
	    String effTimeh = effTime;
	    String expTimeh = expTime;
	    
	    String expTime1 = "";
	    String expTime2 = "";
	    String expTime3 = "";
	    
	    
	    
	    String cccTime= new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	    String cccTimeh= new java.text.SimpleDateFormat("yyyyMMddHH24mmss").format(new java.util.Date());
		if(!effTime.equals(null)&&!effTime.equals("")){
			effTime = effTime.substring(0,8);
			expTime = expTime.substring(0,8); 
			System.out.println("gaopeng--------------��ʼʱ���ǣ�"+effTime+"----����ʱ���ǣ�"+expTime);
      }else{
		  	effTime = cccTime;
		  	expTime = "20500101";
		  	effTimeh = cccTimeh;
		  	System.out.println("========n==== " + nodeId);
		  	if("1027".equals(nodeId)){
		  		Calendar c = Calendar.getInstance();
		  		long time1 = 61*24*60*30*1000l;
		  		long time2 = 61*24*60*180*1000l;
				long birthday = c.getTimeInMillis();
				long result1 = time1 + birthday;
				long result2 = time2 + birthday;
				DateFormat df = new SimpleDateFormat("yyyyMMdd");
				c.setTimeInMillis(result1);
				expTime1 = df.format(c.getTime());
				c.setTimeInMillis(result2);
				expTime2 = df.format(c.getTime());
				expTime3 = "2090"+effTime.substring(4);
				System.out.println("gaopeng2222222222--------------��ʼʱ���ǣ�"+effTime+"----����ʱ���ǣ�"+expTime3);
		  	}
		  	/*gaopeng 2013/4/18 ������ 14:48:29 ȫ��ͨ����������Σ�������Ȼ��*/
		  	/*
		  	if("1027".equals(nodeId) && "gn".equals(smCode)){
		  		Calendar c = Calendar.getInstance();
				//c.set(Calendar.YEAR,2013);//�������
				//c.set(Calendar.MONTH,2);//�����·�
				//c.set(Calendar.DATE,28);//�����·�
					c.add(c.MONTH,3);
					c.setTimeInMillis(c.getTimeInMillis());
					DateFormat df = new SimpleDateFormat("yyyyMMdd");
					expTime = df.format(c.getTime()).substring(0, 6)+"01";
				  System.out.println("gaopeng3333333333--------------��ʼʱ���ǣ�"+effTime+"----����ʱ���ǣ�"+expTime);
		  	}*/
	  	}
	    
	    /* ningtn ���������ʷ���н���ʱ��*/
	    String expTimeHis = "";
	    if("1025".equals(nodeId) || 
	    	"1026".equals(nodeId) ||
	    	"1027".equals(nodeId) ||
	    	"2042".equals(nodeId) ){
		    String getHisTimeSql = "SELECT TO_CHAR (exp_date, 'yyyymmdd') FROM (SELECT   exp_date FROM serv_product_his WHERE serv_id = " 
		    		+ com_pro_intId + " AND product_id = " 
		    		+ nodeId + " AND his_type = '2' AND SYSDATE BETWEEN eff_date AND exp_date  ORDER BY his_time DESC) WHERE ROWNUM < 2";
			System.out.println("gaopengSeeLOg===78"+getHisTimeSql);
%>
		    <wtc:pubselect name="sPubSelect" routerKey="region" 
		    	 routerValue="<%=regionCode%>" retcode="retCode3" retmsg="retMsg3" outnum="1">
            <wtc:sql><%=getHisTimeSql%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="hisTimeResult" scope="end" />
<%
		    if(retCode3.equals("000000") && hisTimeResult.length>0){
		    	expTimeHis = hisTimeResult[0][0];
		    }
		    System.out.println("=============gaopengexpTimeHis=============" + com_pro_intId + "|" + nodeId + "|" + expTimeHis);
	    }
	    /* ningtn ���������ʷ���н���ʱ��*/
 
	    String proEff = "";
		  String proExi = "";
	    
	    

	    
		String flag = (String)request.getParameter("flag");
		
		String startFlag = (String)request.getParameter("startFlag");
		
		
		
	    String startDateFlag = "N";
	    String stopDateFlag = "N";
        try
        {
                String sqlStr ="select attr_value��from product_attr where attr_seq = 1100001 and product_id = '"+nodeId+"'";
                
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
            ret_message = "complexPro_ajax.jsp -> ���÷���ʧ�ܣ�";
        }
        
//System.out.println("----------------effTime.compareTo(cccTime)------------------"+effTime.compareTo(cccTime));

System.out.println("-1111111--startDateFlag---"+startDateFlag + "|" + startFlag);
%>

var startStr = "";



if("<%=startDateFlag%>" == "N" || "<%=startFlag%>" == "0" || "<%=startFlag%>" == "1" || "<%=startFlag%>" == "2" ){
    startStr = " readOnly class='InputGrey' ";
}
<%if(effTime.compareTo(cccTime)>0&&(!startFlag.equals("0"))){%>
startStr = "";
<%}%>

if("<%=effStr%>" > "<%=dateStr%>"&&"<%=startFlag%>"!="0"){
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
$("#tab_pro").append("<tr id='pro_detail_"+node.getId()+"'>"
	+"<td id='pro_detail_td_"+node.getId()+"'>"+node.getName()+"</td>"
	+"<td>"
		+"<input type='text' name='startDate_"+node.getId()+"' id='startDate_"+node.getId()+"' value='<%=effTime%>' size='8'   "+startStr+" v_format='yyyyMMdd' maxlength='8' v_type='0_9' onBlur='if(!forDate(this)){ return  false }; chgStartDate(this);' />"
		+"<input type='hidden' name='startFlag_"+node.getId()+"' id='startFlag_"+node.getId()+"' value='<%=startFlag%>' >"
		+"<input type='hidden' name='startDateSave_"+node.getId()+"' id='startDateSave_"+node.getId()+"' value='<%=effTimeh%>' />"
	+"</td>"
	+"<td>"
	<%if(nodeId.equals("1027")){%>
		+"<input type='text' name='stopDate_"+node.getId()+"' id='stopDate_"+node.getId()+"' value='<%=expTime1%>' size='8' "+stopStr+" v_format='yyyyMMdd' maxlength='8' v_type='0_9' onBlur='if(!forDate(this)){return false;}' />"
		+"<input type='hidden' name='stopDateSave_"+node.getId()+"' id='stopDateSave_"+node.getId()+"' value='<%=expTime1+"000000"%>' />"
		+"<select style='width:60px' id='select_"+node.getId()+"' name='select_"+node.getId()+"' onchange='change1027Date("+node.getId()+")'><option value='<%=expTime1%>' selected>30��</option><option value='<%=expTime2%>'>180��</option><option value='<%=expTime3%>'>����</option></select>"
	<%}else{%>
		+"<input type='text' name='stopDate_"+node.getId()+"' id='stopDate_"+node.getId()+"' value='<%=expTime%>' size='8' "+stopStr+" v_format='yyyyMMdd' maxlength='8' v_type='0_9' onBlur='if(!forDate(this)){return false;}' />"
		+"<input type='hidden' name='stopDateSave_"+node.getId()+"' id='stopDateSave_"+node.getId()+"' value='<%=expTimeh%>' />"
	<%}%>
	+"</td>"
	+"<td id='proName_"+node.getId()+"'>"+showStatu+"</td>"
	+"<td style=\"display:none\">"+node.getId()+"</td>"
	+"<td>"
	+"<input type='button' class='b_text' value='��ͣ' id='stop_"+node.getId()+"' onclick=chkStop('"+node.getId()+"') style='display:none' >"
	+"<input type='button' class='b_text' id='ret_"+node.getId()+"' onclick=returnStop('"+node.getId()+"') value='�ָ�' style='display:none' >"
	+"<input type='hidden' id='proAttr_"+node.getId()+"'>"
	+"<input type='hidden' id='newFlag_"+node.getId()+"'>"
	+"<input type='hidden' id='expTimeHis_"+node.getId()+"' value='<%=expTimeHis%>'>"
	+"</td>"
	+"</tr>");
if(node.haveAttr==1){
	$("#pro_detail_"+node.getId()+" td:eq(3)").append("<input  type='button' name='offe_"+node.getName()+"' value='��������' id='att_"+node.getId()+"' class='b_text' onclick=setAttr2('"+node.getId()+"','"+showStatu+"') />");
}
if(showStatu=="�¹�")
{
		/*zhangyan add ����������������*/
		if ("<%=nodeId%>"=="1027")
		{
				$("#proAttr_"+node.getId()).val("60002~5,");
				$("#newFlag_"+node.getId()).val("1");
				$("#expTimeHis_"+node.getId()).val("<%=expTimeHis%>");						
		}
		$("#stop_"+node.getId()).attr("disabled",true);
		$("#ret_"+node.getId()).attr("disabled",true);
}
//alert($("#tab_pro").html());
<%
System.out.println("---------------------complexPro_ajax.jsp------------------"+new Date());
%>
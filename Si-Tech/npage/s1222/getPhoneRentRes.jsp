<%
/********************
 *version v2.0
 *开发商: si-tech
 *update by qidp @ 2008-12-25
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%


    String countryCode = request.getParameter("countryCode");
    String region_code = request.getParameter("region_code");
    String owner_code = request.getParameter("owner_code");
    String roam_type = request.getParameter("roam_type");
    String prov_code = request.getParameter("prov_code");
    
    System.out.println("owner_code=" + owner_code);
    /*
    ArrayList arr = F1222Wrapper.getPhoneNo(countryCode,owner_code,roam_type,prov_code,region_code);
    */


    StringBuffer sq1 = new StringBuffer();

    //四川0082境外取机时只能选'99'地市漫游号
    if (("2800").equals(prov_code) && ("0082").equals(countryCode) && ("1").equals(roam_type)){
        sq1.append(" select a.phone_rent,a.mach_code,a.mach_iccid,b.machine_name,");
        sq1.append(" c.machbody_fee,c.batteries_fee,c.charger_fee,c.fujian_fee");
        sq1.append(" from dcustrentres a,smachcode b,sownermach c");
        sq1.append(" where a.country_code=");
        sq1.append(":countryCode");
        sq1.append(" and a.rent_flag='0' and a.mach_code=b.machine_code");
        sq1.append(" and b.machine_code=c.mach_code ");
        sq1.append(" and a.region_code=b.region_code ");
        sq1.append(" and b.region_code=c.region_code and a.region_code='99'");
        sq1.append(" and not trim(a.phone_rent) is null");
        System.out.println(sq1);
    }
    else{
        sq1.append(" select a.phone_rent,a.mach_code,a.mach_iccid,b.machine_name,");
        sq1.append(" c.machbody_fee,c.batteries_fee,c.charger_fee,c.fujian_fee");
        sq1.append(" from dcustrentres a,smachcode b,sownermach c");
        sq1.append(" where a.country_code=");
        sq1.append(":countryCode");
        sq1.append(" and a.rent_flag='0' and a.mach_code=b.machine_code");
        sq1.append(" and b.machine_code=c.mach_code ");
        sq1.append(" and a.region_code=b.region_code ");
        sq1.append(" and b.region_code=c.region_code and a.region_code=");
        sq1.append(":region_code");
        sq1.append(" and not trim(a.phone_rent) is null");
    	System.out.println(sq1);
    }
	
	System.out.println("sql=== "+sq1.toString());
	
	String [] paraIn = new String[2];
    paraIn[0] = sq1.toString();    
    paraIn[1]="countryCode="+countryCode+",region_code="+region_code;

	System.out.println("!!!!!!!@@@@@@@@@@@@========="+sq1.toString()+"++++++++"+paraIn[1]);
	//SPubCallSvrImpl impl=new SPubCallSvrImpl();
    //ArrayList al = impl.sPubSelect("8",sq1.toString());
%>
    <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_code%>" outnum="8" >
        <wtc:param value="<%=paraIn[0]%>"/>
        <wtc:param value="<%=paraIn[1]%>"/> 
    </wtc:service>
    <wtc:array id="feeInfo" scope="end"/>
<%
    //String[][] feeInfo = (String[][])al.get(0);
    for(int i = 0 ; i < feeInfo.length ; i ++){
    	for(int j = 0 ; j < feeInfo[0].length ; j ++){
    		System.out.println(feeInfo[i][j]);
    	}
    }       
    if(feeInfo.length==0){

%>
        var response = new AJAXPacket();
        
        response.guid = '<%= request.getParameter("guid") %>';
        
        
        response.data.add("backString","");
        
        response.data.add("flag","2");
        
        
        core.ajax.receivePacket(response);                                                         
  




                                                      
<%    
    }else{                                                    
        String strArray = CreatePlanerArray.createArray("feeInfo",feeInfo.length);
                                                          
%>                                                        
        <%=strArray%>                                           
<%                                                      
                                                        
        for(int i = 0 ; i < feeInfo.length ; i ++){            
            for(int j = 0 ; j < feeInfo[0].length; j ++){
                                                                
                                                        
%>                                                      
                                                        
                feeInfo[<%=i%>][<%=j%>] = "<%=feeInfo[i][j].trim()%>" ;
<%                                                      
            }
        }                                                       
%>
    var response = new AJAXPacket();
    
    response.guid = '<%= request.getParameter("guid") %>';
    
    response.data.add("backString",feeInfo);
    response.data.add("flag","2");
    
    
    core.ajax.receivePacket(response);
<%}%>

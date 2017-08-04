<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.08.26
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
        //得到输入参数
        //Logger logger = Logger.getLogger("fgetsimran_1104.jsp");
        //ArrayList retArray = new ArrayList();
       // String[][] result = new String[][]{};
 		//comImpl co=new comImpl();
	    //--------------------------
	    String retType = request.getParameter("retType");
	    String phone_no = request.getParameter("phone_no");
 	    String region_code = request.getParameter("region_code");
 	    String sim_type = request.getParameter("sim_type");

	    //返回值定义
        //String retCode = "";
        //String retMessage = "";
		String sim_no = "";
		String sq1="";
		String sqln="";
		String hlrcode="";
		String no_type = "";
        //System.out.println(phone_no.substring(0,3)+"phone_no.substring(0,3)");
		sqln="select hlr_code from shlrcode WHERE PHONENO_HEAD = SUBSTR('"+phone_no+"', 1, 7) and region_code='"+region_code+"'";
		String sqlnod = "select  NO_TYPE  from DCUSTRES where phone_no = '"+phone_no+"'";  //+"' and resource_code = '0'"
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>"  retcode="retCode" retmsg="retMessage" outnum="1">
		<wtc:sql><%=sqln%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />

		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>"  retcode="retCode1" retmsg="retMessage1" outnum="1">
		<wtc:sql><%=sqlnod%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="resultn" scope="end" />

		<%
		if(resultn.length!=0){
			no_type = resultn[0][0];
		}else{
			retCode="000008";
		    retMessage="查询号码NO_TYPE信息错误！";
		}
		if(retCode.equals("0")||retCode.equals("000000"))
		{
			retCode="000000";
 			if(result.length!=0)
 			{

 			   	hlrcode=result[0][0];
 				System.out.println("hlrcodehlrcode="+hlrcode);

				//查询语句
				if(!no_type.equals("0000h")){
					sq1="select a.sim_no FROM DBRESADM.DBLKCARDDATA A ,DBCUSTADM.SHLRCODE B  where  A.PHONENO_HEAD=B.PHONENO_HEAD  "+
						" and A.SIM_STATUS = '0'  and  B.hlr_code='"+hlrcode+"' and B.region_code='"+region_code+"'  "+
						" and a.sim_type !=any('10052','10053','10057','10080','10081','10082')   and rownum=1 ";

						System.out.println(sq1);
				}
				else if(no_type.equals("0000h"))
				{
					sq1="  select a.sim_no FROM DBRESADM.DBLKCARDDATA A,DBCUSTADM.SHLRCODE B  where "+
                        "   (a.sim_type ='10053' or a.sim_type ='10052') "+
                        "  and      not exists (select 1 from dsimres f where f.imsi_no = A.imsi_no) and     A.SIM_STATUS= '0'  and A.PHONENO_HEAD=B.PHONENO_HEAD "+
                        " AND B.HLR_CODE= '"+hlrcode+"' "+
                        " and b.region_code='"+region_code+"' "+
                        " where rownum <2 ";


				}//add by sungq 关于支撑182号段的需求

%>
   				<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>"  retcode="retCode" retmsg="retMessage" outnum="4">
				<wtc:sql><%=sq1%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="result" scope="end" />


<%
				if(retCode.equals("0")||retCode.equals("000000"))
				{
 			   		retCode="000000";
 			   		if(result.length!=0){

 			     		sim_no=result[0][0];
 			   		}else{
 			  			System.out.println("result.length==0_____________________________________________");
 			   			retCode="000008";
 			    		retMessage="无可用sim卡资源，请联系管理员！";
 			   		}

 				}
 		}
 		else
 		{
 			  	System.out.println("result.length==0_____________________________________________");
 			   	retCode="000008";
 			    retMessage="查询号码HLR信息错误！";
 		}
 	}
 	System.out.println("result.length==0_____________________________________________"+retMessage);
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var sim_no="";


retType = "<%=retType%>";
retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";
sim_no="<%=sim_no%>";

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("sim_no",sim_no);
core.ajax.receivePacket(response);


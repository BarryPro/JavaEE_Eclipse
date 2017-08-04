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
				if(phone_no.substring(0,3).equals("134") ||phone_no.substring(0,3).equals("135")||phone_no.substring(0,3).equals("136")
					|| phone_no.substring(0,3).equals("137") || phone_no.substring(0,3).equals("138")|| phone_no.substring(0,3).equals("183")
					|| phone_no.substring(0,3).equals("139")|| phone_no.substring(0,3).equals("158")|| phone_no.substring(0,3).equals("150")
					|| phone_no.substring(0,3).equals("159")|| phone_no.substring(0,3).equals("151")|| phone_no.substring(0,3).equals("152")
					|| phone_no.substring(0,3).equals("188")|| phone_no.substring(0,3).equals("187")|| phone_no.substring(0,3).equals("182")
					|| phone_no.substring(0,3).equals("184")
					|| phone_no.substring(0,3).equals("178")
					|| (phone_no.substring(0,3).equals("147")&&!no_type.equals("0000h"))){
					//sq1="select a.sim_no FROM DBRESADM.DBLKCARDDATA A where exists (select 1 from DBCUSTADM.SHLRCODE B where B.hlr_code='"+hlrcode+"' and B.region_code='"+region_code+"' and A.PHONENO_HEAD=B.PHONENO_HEAD) "+
					//	" and A.SIM_STATUS = '0'  and rownum=1  "+
					//	" and a.sim_type !='10053' and a.sim_type !='10052'  AND A.head_type='Y' ";
					sq1="select a.sim_no FROM DBRESADM.DBLKCARDDATA A,sHlrCode b where "+
						"A.SIM_STATUS = '0' and A.head_type='Y' and A.PHONENO_HEAD=B.PHONENO_HEAD "+
						"and B.hlr_code='"+hlrcode+"' and B.region_code='"+region_code+"' "+
						"and a.sim_type !='10053' and a.sim_type !='10052'  AND rownum=1 ";

						System.out.println(sq1);
				}
				else if((phone_no.substring(0,3).equals("147")&&no_type.equals("0000h"))
						||phone_no.substring(0,3).equals("451") ||phone_no.substring(0,3).equals("045")
						||phone_no.substring(0,3).equals("046")||phone_no.substring(0,3).equals("157"))
				{
					sq1="  select sim_no from ( "+
                        "  select a.sim_no FROM DBRESADM.DBLKCARDDATA A,DBCUSTADM.SHLRCODE B  where "+
                        "  SUBSTR(a.SIM_NO,7,1) = 'A' "+
                        "  SUBSTR(a.SIM_NO,6,1) != '2' "+
                        "  and         A.SIM_STATUS= '0'  and A.PHONENO_HEAD=B.PHONENO_HEAD "+
                        "  AND B.HLR_CODE= '"+hlrcode+"' "+
                        "  and b.region_code='"+region_code+"' "+
                        "  union all "+
                        "  select a.sim_no FROM DBRESADM.DBLKCARDDATA A,DBCUSTADM.SHLRCODE B  where "+
                        "  ( SUBSTR(a.SIM_NO,7,1) ='D' and (a.sim_type ='10053' or a.sim_type ='10052')) "+
                        "  and         A.SIM_STATUS= '0'  and A.PHONENO_HEAD=B.PHONENO_HEAD "+
                        " AND B.HLR_CODE= '"+hlrcode+"' "+
                        " and b.region_code='"+region_code+"' "+
                        " ) "+
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
 			    		retMessage="没有此服务号码！";
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


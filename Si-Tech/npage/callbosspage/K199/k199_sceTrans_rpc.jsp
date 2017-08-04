<%
  /*
   * 功能: 客服中心运营指标体系
　 * 版本: 1.0.0
　 * 日期: 2009/08/09
　 * 作者: yinzx
　 * 版权: sitech
   * 
　 */
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2); 
  String strSql="";
  String addvalxin = "";
  String sceid="";
  String message="";
  String[] sqlArr = new String[1];
	String retType = WtcUtil.repNull(request.getParameter("retType"));
  addvalxin = (String)request.getParameter("addvalxin");
  sceid = (String)request.getParameter("sceid");
   
  String[] addvalxnew=addvalxin.split(",",-1);
  
  
   
    if (retType.equals("addsceTrans"))
    {
     strSql = "insert into difoperational(SERIALNO,datetime,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24,c25,c26,c27,c28,c29,c30,c31,c32,c33,c34,c35,c36,c37,c38,c39,c40,c41,c42,c43,c44,c45,c46,c47,c48,c49,c50,c51,c52,c53,c54,c55,c56,c57,c58,c59,c60,c61,c62,c63,c64,c65,c66,c67,c68,c69,c70,c71,c72,c73,c74,c75,c76,c77,c78,c79,c80,c81,c82) values(to_char(sysdate,'yyyymmddhh24miss')";
    strSql += ",to_date(:v1, 'yyyymmdd hh24:mi:ss'),:v2,:v3,:v4,:v5,:v6,:v7,:v8,:v9,:v10,:v11,:v12,:v13,:v14,:v15,:v16,:v17,:v18,:v19,:v20,:v21,:v22,:v23,:v24,:v25,:v26,:v27,:v28,:v29,:v30,:v31,:v32,:v33,:v34,:v35,:v36,:v37,:v38,:v39,:v40,:v41,:v42,:v43,:v44,:v45,:v46,:v47,:v48,:v49,:v50,:v51,:v52,:v53,:v54,:v55,:v56,:v57,:v58,:v59,:v60,:v61,:v62,:v63,:v64,:v65,:v66,:v67,:v68,:v69,:v70,:v71,:v72,:v73,:v74,:v75,:v76,:v77,:v78,:v79,:v80,:v81,:v82,:v83 )"  ;
    
    strSql += "&&"+addvalxnew[82]+"^"+addvalxnew[0]+"^"+addvalxnew[1]+"^"+addvalxnew[2]+"^"+addvalxnew[3]+"^"+addvalxnew[4]+"^"+addvalxnew[5]+"^"+addvalxnew[6]+"^"+addvalxnew[7]+"^"+addvalxnew[8]+"^"+addvalxnew[9]+"^"+addvalxnew[10]+"^"+addvalxnew[11]+"^"+addvalxnew[12]+"^"+addvalxnew[13]+"^"+addvalxnew[14]+"^"+addvalxnew[15]+"^"+addvalxnew[16]+"^"+addvalxnew[17]+"^"+addvalxnew[18]+"^"+addvalxnew[19]+"^"+addvalxnew[20]+"^"+addvalxnew[21]+"^"+addvalxnew[22]+"^"+addvalxnew[23]+"^"+addvalxnew[24]+"^"+addvalxnew[25]+"^"+addvalxnew[26]+"^"+addvalxnew[27]+"^"+addvalxnew[28]+"^"+addvalxnew[29]+"^"+addvalxnew[30]+"^"+addvalxnew[31]+"^"+addvalxnew[32]+"^"+addvalxnew[33]+"^"+addvalxnew[34]+"^"+addvalxnew[35]+"^"+addvalxnew[36]+"^"+addvalxnew[37]+"^"+addvalxnew[38]+"^"+addvalxnew[39]+"^"+addvalxnew[40]+"^"+addvalxnew[41]+"^"+addvalxnew[42]+"^"+addvalxnew[43]+"^"+addvalxnew[44]+"^"+addvalxnew[45]+"^"+addvalxnew[46]+"^"+addvalxnew[47]+"^"+addvalxnew[48]+"^"+addvalxnew[49]+"^"+addvalxnew[50]+"^"+addvalxnew[51]+"^"+addvalxnew[52]+"^"+addvalxnew[53]+"^"+addvalxnew[54]+"^"+addvalxnew[55]+"^"+addvalxnew[56]+"^"+addvalxnew[57]+"^"+addvalxnew[58]+"^"+addvalxnew[59]+"^"+addvalxnew[60]+"^"+addvalxnew[61]+"^"+addvalxnew[62]+"^"+addvalxnew[63]+"^"+addvalxnew[64]+"^"+addvalxnew[65]+"^"+addvalxnew[66]+"^"+addvalxnew[67]+"^"+addvalxnew[68]+"^"+addvalxnew[69]+"^"+addvalxnew[70]+"^"+addvalxnew[71]+"^"+addvalxnew[72]+"^"+addvalxnew[73]+"^"+addvalxnew[74]+"^"+addvalxnew[75]+"^"+addvalxnew[76]+"^"+addvalxnew[77]+"^"+addvalxnew[78]+"^"+addvalxnew[79]+"^"+addvalxnew[80]+"^"+addvalxnew[81];  
 
	  }else if(retType.equals("modifysceTrans"))
	  {
	         strSql = "update difoperational set datetime = ";
    strSql += "to_date(:v1, 'yyyy-mm-dd hh24:mi:ss'),c1 =:v2,c2 =:v3,c3 =:v4,c4 =:v5,c5 =:v6,c6 =:v7,c7 =:v8,c8 =:v9,c9 =:v10,c10 =:v11,c11 =:v12,c12 =:v13,c13 =:v14,c14 =:v15,c15 =:v16,c16 =:v17,c17 =:v18,c18 =:v19,c19 =:v20,c20 =:v21,c21 =:v22,c22 =:v23,c23 =:v24,c24 =:v25,c25 =:v26,c26 =:v27,c27 =:v28,c28 =:v29,c29 =:v30,c30 =:v31,c31 =:v32,c32 =:v33,c33 =:v34,c34 =:v35,c35 =:v36,c36 =:v37,c37 =:v38,c38 =:v39,c39 =:v40,c40 =:v41,c41 =:v42,c42 =:v43,c43 =:v44,c44 =:v45,c45 =:v46,c46 =:v47,c47 =:v48,c48 =:v49,c49 =:v50,c50 =:v51,c51 =:v52,c52 =:v53,c53 =:v54,c54 =:v55,c55 =:v56,c56 =:v57,c57 =:v58,c58 =:v59,c59 =:v60,c60 =:v61,c61 =:v62,c62 =:v63,c63 =:v64,c64 =:v65,c65 =:v66,c66 =:v67,c67 =:v68,c68 =:v69,c69 =:v70,c70 =:v71,c71 =:v72,c72 =:v73,c73 =:v74,c74 =:v75,c75 =:v76,c76 =:v77,c77 =:v78,c78 =:v79,c79 =:v80,c80 =:v81,c81 =:v82,c82 =:v83 where SerialNo = :v83";
           
    strSql += "&&" + addvalxnew[82]+"^"+addvalxnew[1-1]+"^"+addvalxnew[2-1]+"^"+addvalxnew[3-1]+"^"+addvalxnew[4-1]+"^"+addvalxnew[5-1]+"^"+addvalxnew[6-1]+"^"+addvalxnew[7-1]+"^"+addvalxnew[8-1]+"^"+addvalxnew[9-1]+"^"+addvalxnew[10-1]+"^"+addvalxnew[11-1]+"^"+addvalxnew[12-1]+"^"+addvalxnew[13-1]+"^"+addvalxnew[14-1]+"^"+addvalxnew[15-1]+"^"+addvalxnew[16-1]+"^"+addvalxnew[17-1]+"^"+addvalxnew[18-1]+"^"+addvalxnew[19-1]+"^"+addvalxnew[20-1]+"^"+addvalxnew[21-1]+"^"+addvalxnew[22-1]+"^"+addvalxnew[23-1]+"^"+addvalxnew[24-1]+"^"+addvalxnew[25-1]+"^"+addvalxnew[26-1]+"^"+addvalxnew[27-1]+"^"+addvalxnew[28-1]+"^"+addvalxnew[29-1]+"^"+addvalxnew[30-1]+"^"+addvalxnew[31-1]+"^"+addvalxnew[32-1]+"^"+addvalxnew[33-1]+"^"+addvalxnew[34-1]+"^"+addvalxnew[35-1]+"^"+addvalxnew[36-1]+"^"+addvalxnew[37-1]+"^"+addvalxnew[38-1]+"^"+addvalxnew[39-1]+"^"+addvalxnew[40-1]+"^"+addvalxnew[41-1]+"^"+addvalxnew[42-1]+"^"+addvalxnew[43-1]+"^"+addvalxnew[44-1]+"^"+addvalxnew[45-1]+"^"+addvalxnew[46-1]+"^"+addvalxnew[47-1]+"^"+addvalxnew[48-1]+"^"+addvalxnew[49-1]+"^"+addvalxnew[50-1]+"^"+addvalxnew[51-1]+"^"+addvalxnew[52-1]+"^"+addvalxnew[53-1]+"^"+addvalxnew[54-1]+"^"+addvalxnew[55-1]+"^"+addvalxnew[56-1]+"^"+addvalxnew[57-1]+"^"+addvalxnew[58-1]+"^"+addvalxnew[59-1]+"^"+addvalxnew[60-1]+"^"+addvalxnew[61-1]+"^"+addvalxnew[62-1]+"^"+addvalxnew[63-1]+"^"+addvalxnew[64-1]+"^"+addvalxnew[65-1]+"^"+addvalxnew[66-1]+"^"+addvalxnew[67-1]+"^"+addvalxnew[68-1]+"^"+addvalxnew[69-1]+"^"+addvalxnew[70-1]+"^"+addvalxnew[71-1]+"^"+addvalxnew[72-1]+"^"+addvalxnew[73-1]+"^"+addvalxnew[74-1]+"^"+addvalxnew[75-1]+"^"+addvalxnew[76-1]+"^"+addvalxnew[77-1]+"^"+addvalxnew[78-1]+"^"+addvalxnew[79-1]+"^"+addvalxnew[80-1]+"^"+addvalxnew[81-1]+"^"+addvalxnew[82-1]+"^"+sceid;		
	  }
	  
	  sqlArr[0] =  strSql;
	  System.out.println(strSql);
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	 <wtc:param value=""/>
   <wtc:param value="dbchange"/>
   <wtc:params value="<%=sqlArr%>"/>	
</wtc:service>
<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retType","<%=retType%>");
core.ajax.receivePacket(response);
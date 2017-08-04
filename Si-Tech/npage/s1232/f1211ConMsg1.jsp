<%
  /*
   * 功能: 账户密码修改
   * 版本: 1.0
   * 日期: 2009/1/19
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%
	String regionCode = (String)session.getAttribute("regCode");
	String conID = request.getParameter("pContractNo");
	String vEnConPaswd = request.getParameter("vConPaswd");
	vEnConPaswd = Encrypt.encrypt(vEnConPaswd);
	String vConPaswdFlag = "0";
	StringBuffer sqlBuffer= new StringBuffer();
	sqlBuffer.append("select  CONTRACT_PASSWD, BANK_CUST,ODDMENT, PREPAY_FEE, ");
	sqlBuffer.append("DEPOSIT, MIN_YM, OWE_FEE, ACCOUNT_MARK,");
	sqlBuffer.append("ACCOUNT_LIMIT, PAY_CODE, BANK_CODE, POST_BANK_CODE,");
	sqlBuffer.append("ACCOUNT_NO,ACCOUNT_TYPE,STATUS ");
	sqlBuffer.append(" FROM dConMsg WHERE contract_no =");
	sqlBuffer.append(conID);
	StringBuffer sqlBuffer2= new StringBuffer();
	sqlBuffer2.append("SELECT POST_FLAG,POST_TYPE,POST_ADDRESS,POST_ZIP,FAX_NO,MAIL_ADDRESS  FROM dCustPost where contract_no=");
	sqlBuffer2.append(conID);
	
	StringBuffer sqlBuffer3= new StringBuffer();
	sqlBuffer3.append("select m.card_name,n.grp_name from dCustMsg a, dConMsg  b , sbigCardCode m,sgrpbigflag n where b.con_cust_id = a.cust_id ");
	sqlBuffer3.append("and b.contract_no =");
	sqlBuffer3.append(conID);
	sqlBuffer3.append("  and  substr(a.attr_code,2,2) = m.card_type and  substr(a.attr_code,5,1) = n.grp_flag");
	
//	SPubCallSvrImpl implSel=new SPubCallSvrImpl();
//	ArrayList tmpSelList = implSel.sPubSelect("15",sqlBuffer.toString());
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="15" retcode="retCode" retmsg="retMsg">
		<wtc:sql><%=sqlBuffer.toString()%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="tri_metaData" scope="end" />
<%

//	String [][] tri_metaData = new String[][]{};
//	String [][] tri_metaData2 = new String[][]{};
//	String [][] tri_metaData3 = new String[][]{};
	
		if(tri_metaData.length != 0)
		{	
			if(tri_metaData[0].length != 0)
			{
				if(0==Encrypt.checkpwd2((tri_metaData[0][0]),vEnConPaswd))
				{
					vConPaswdFlag = "1";
				}
			}
		}
	String tri_metaDataStr =CreatePlanerArray.createArray("js_tri_metaDataStr",tri_metaData.length);
	
//	ArrayList tmpSelList2 = implSel.sPubSelect("6",sqlBuffer2.toString());
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="6" retcode="retCode2" retmsg="retMsg2">
		<wtc:sql><%=sqlBuffer2.toString()%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="tri_metaData2" scope="end" />
<%

	String tri_metaDataStr2 = CreatePlanerArray.createArray("js_tri_metaDataStr2",tri_metaData2.length);
//	ArrayList tmpSelList3 = implSel.sPubSelect("2",sqlBuffer3.toString());
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode3" retmsg="retMsg3">
		<wtc:sql><%=sqlBuffer3.toString()%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="tri_metaData3" scope="end" />
<%	
	String sGrpName = "";
	String sCardName = "";
		if(tri_metaData3.length != 0)
		{
			 if(tri_metaData3[0].length == 2)
			{
				sCardName = tri_metaData3[0][0];
				sGrpName = tri_metaData3[0][1];
				//System.out.println(" sGrpName = " + sGrpName);
				//System.out.println(" sCardName = " + sCardName);
			}
		}
		
%>


<%=tri_metaDataStr%>
<%   
  for(int p=0;p<tri_metaData.length;p++)
  {       
	  for(int q=0;q<tri_metaData[p].length;q++)
	  {  //System.out.println("tri_metaData = " + tri_metaData[p][q]);
%>
        
        js_tri_metaDataStr[<%=p%>][<%=q%>]="<%=tri_metaData[p][q]%>";
<%
	  }
  }
%>

<%=tri_metaDataStr2%>
<%   
  for(int m=0;m<tri_metaData2.length;m++)
  {       
	  for(int n=0;n<tri_metaData2[m].length;n++)
	  {  //System.out.println("tri_metaData2 = " + tri_metaData[m][n]);
%>
        
        js_tri_metaDataStr2[<%=m%>][<%=n%>]="<%=tri_metaData2[m][n]%>";
<%
	  }
  }
%>

	var response = new AJAXPacket();
	response.data.add("rpc_page","f1211ConMsg");
	response.data.add("ConMsg",js_tri_metaDataStr);
	response.data.add("grpName","<%=sGrpName%>");
	response.data.add("cardName","<%=sCardName%>");
	response.data.add("ConPostMsg",js_tri_metaDataStr2);
	response.data.add("vConPaswdFlag","<%=vConPaswdFlag%>");
	core.ajax.receivePacket(response);




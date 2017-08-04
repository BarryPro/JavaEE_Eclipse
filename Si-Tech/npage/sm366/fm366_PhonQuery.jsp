<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) -------------------
 
 -------------------------后台人员：--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.csp.bsf.pwm.util.*"%>
	var retArray = new Array();//定义返回数组
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String id_typess      = WtcUtil.repNull(request.getParameter("id_typess"));
	String idIccid        = WtcUtil.repNull(request.getParameter("idIccid"));	
	
	
	System.out.println("-------hejwa-------MD5前-----------idIccid-------->"+idIccid);
	
	MD5 md5 = new MD5();
	String idIccid_md5str  = md5.encode(idIccid); /*加密 loginPass 为加密前的密码，即密码明文*/
		                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	String phoneQryNum    = "";


	//通过sql查询出满足规则的流水，新建序列SEQ_PHONEQUERY_ID
	/*B）省BOSS的编码规则－3位省代码+14位组包时间YYYYMMDDHH24MMSS+6位流水号（定长），序号从000001开始，增量步长为1。*/
	String seq_sql = "select to_char(trim('451'||to_char(sysdate,'yyyyMMddHH24miss'))||trim(to_char(DBCUSTADM.SEQ_PHONEQUERY_SEQ.NEXTVAL,'000000'))) as seq from dual";
	String seq_str = "";
	
%>

      	 
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=seq_sql%>" />
	</wtc:service>
	<wtc:array id="result_Seq" scope="end"   />

<%
	if(result_Seq.length>0){
			seq_str = result_Seq[0][0];
	}
	
	/*编码组成为：全网标识编码（1位）+地域编码（8位）+渠道形式编码（1位）+序列号（5位）。*/
	/*地域编码（8位）具体规则为：省编码（3位）+地市编码（3位）+县区编码（2位）*/
	

	String channelId_sql =  "	select to_char('2' || '451' || "+
												  "    (select trim(to_char(a.toll_no)) as toll_no "+
												  "       from sregioncode a "+
												  "      where a.region_code = :loginRegion) || '00' || '1' || "+
												  "  trim(to_char(DBCUSTADM.SEQ_PHONEQUERY_SEQ.NEXTVAL, '00000'))) as ChannelId "+
												  "	 from dual";
	String channelId_sql_parm = "loginRegion="+regionCode;											  
	String channelId_str = "";

%>

  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=channelId_sql%>" />
		<wtc:param value="<%=channelId_sql_parm%>" />
	</wtc:service>
	<wtc:array id="result_channelId" scope="end"   />
		
<%
	if(result_channelId.length>0){
		channelId_str = result_channelId[0][0];
	}
	
	//7个标准化入参
	String paraAray[] = new String[8];                                                                                                                                                    
	                                                                                                                                                                                      
	paraAray[0] = "P0000013";                                                 // 0	"业务代码（bipCode）"	字符串	8	P0000012	                                                                
	paraAray[1] = "S0000013";                                                 // 1	交易代码（transCode）	字符串	8	S0000012	                                                                
	paraAray[2] = (String)session.getAttribute("workNo");   //工号            // 2	工号（loginNo ）	字符串	V60		                                                                          
	paraAray[3] = (String)session.getAttribute("orgCode");                    // 3	工号OrgCode(orgCode )	字符串			                                                                        
	paraAray[4] = seq_str;                                                    // 4	操作流水号（Seq）		V32		填写格式见7.5 操作流水号                                                        
	paraAray[5] = id_typess;                                                  // 6	证件类型(IDCardType)	字符串	F2		参见客户证件类型编码                                                  
	paraAray[6] = idIccid_md5str;                                             // 7	证件号码(IDCardNum)	字符串	V32		该字段需要MD5加密：省公司通过MD5加密之后上传，平台收到后解密            
	paraAray[7] = channelId_str;                                              // 8	渠道编号(ChannelId)	字符串	V32		各省的渠道标识，遵照全网渠道统一编码规则，详见附录7.6。                 
	                                                                                                                                                                                      
	String serverName = "sTSNPubSnd";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="8" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----hejwa-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="result_t"     scope="end" start="0"  length="1"  />
		<wtc:array id="serverResult" scope="end" start="1"  length="7" />
<%
	retCode = code;
	retMsg = msg;
	
	if(result_t.length>0){
		phoneQryNum = result_t[0][0];
	}
	
	//拼装返回数组
	for(int i=0;i<serverResult.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<serverResult[i].length;j++){
				System.out.println("--hejwa--------------------------------------------出参------serverName=["+serverName+"]--------serverResult["+i+"]["+j+"]------->"+serverResult[i][j]);
		
%>
		    retArray[<%=i%>][<%=j%>] = "<%=serverResult[i][j]%>";
<%		
		}
	}
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}


	System.out.println("--hejwa--------retCode-----serverName=["+serverName+"]---------"+retCode);
	System.out.println("--hejwa--------retMsg------serverName=["+serverName+"]---------"+retMsg);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("phoneQryNum","<%=phoneQryNum%>");

response.data.add("retArray",retArray);
core.ajax.receivePacket(response);

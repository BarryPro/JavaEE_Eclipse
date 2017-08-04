<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*,com.sitech.crmpd.core.wtc.util.*,com.sitech.crmpd.kf.ejb.client.KFEjbClient" %>
<%
    /*midify by yinzx 20091113 公共查询服务替换*/
  String myParams="";
  String org_code = (String)session.getAttribute("orgCode");
  String regionCode = org_code.substring(0,2);
  String callcause_id = (null == request.getParameter("callcause_id")?"":request.getParameter("callcause_id"));
  String caption = (null == request.getParameter("caption")?"":request.getParameter("caption"));
  String service_ids= (null == request.getParameter("service_ids")?"":request.getParameter("service_ids"));
  String voice_ids = (null == request.getParameter("voice_ids")?"":request.getParameter("voice_ids"));
  String remove_ids = (null == request.getParameter("remove_ids")?"":request.getParameter("remove_ids"));
  String ret = "000000";
  String tablename = "";
  String[] ivr_ids = new String[]{};
	Map pMap = new HashMap();
	pMap.put("callcause_id",callcause_id);
	pMap.put("caption",caption);

	if(service_ids != null && !"".equals(service_ids.trim())){
		  tablename = "DSCETRANSFERTAB";
			ivr_ids = service_ids.split(",");
			pMap.put("ivr_ids",ivr_ids);
			pMap.put("flag","0");
			pMap.put("tablename",tablename);
			try{
				KFEjbClient.insert("insert_k171_ivr",pMap);
			}catch(Exception e){
				new Exception("关联来电原因与业务办理出现错误",e).printStackTrace();
				ret = "999999";
			}
	}
	
	if(voice_ids != null && !"".equals(voice_ids.trim())){
		pMap.remove("ivr_ids");
		pMap.remove("tablename");
		pMap.remove("flag");
		tablename = "DZXSCETRANSFERTAB";
		ivr_ids = voice_ids.split(",");
		pMap.put("ivr_ids",ivr_ids);
		pMap.put("tablename",tablename);
		pMap.put("flag","1");
		try{
			KFEjbClient.insert("insert_k171_ivr",pMap);
		}catch(Exception e){
			new Exception("关联来电原因与语音咨询出现错误",e).printStackTrace();
			ret = "999999";
		}
	}
	
	if(remove_ids != null && !"".equals(remove_ids.trim())){
		pMap.remove("ivr_ids");
		pMap.remove("tablename");
		pMap.remove("flag");
		pMap.remove("caption");
		ivr_ids = remove_ids.split(",");
		pMap.put("ivr_ids",ivr_ids);
		try{
			KFEjbClient.delete("delete_k171_ivr",pMap);
		}catch(Exception e){
			new Exception("删除来电原因与ivr关联出现错误",e).printStackTrace();
			ret = "999999";
		}
	}
%>
var response = new AJAXPacket();
response.data.add("ret","<%=ret%>");
core.ajax.receivePacket(response);